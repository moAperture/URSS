import { api, LightningElement, track, wire } from 'lwc';
import getContentDetails from '@salesforce/apex/ContentManagerService.getContentDetails';
import deleteContentDocument from '@salesforce/apex/ContentManagerService.deleteContentDocument';
import getLoginURL from '@salesforce/apex/ContentManagerService.getLoginURL';
import getUserInfo from '@salesforce/apex/ContentManagerService.getUserInfo';
import canDeleteFiles from '@salesforce/apex/ContentManagerService.canDeleteFiles';
import cantUploadFiles from '@salesforce/apex/ContentManagerService.cantUploadFiles';
import { NavigationMixin } from 'lightning/navigation';

const columns = [
    { label: 'Title', fieldName: 'Title', wrapText : true,
        cellAttributes: { 
            iconName: { fieldName: 'icon' }, iconPosition: 'left' 
        }
    },
    { label: 'Created By', fieldName: 'CREATED_BY',
        cellAttributes: { 
            iconName: 'standard:user', iconPosition: 'left' 
        }
    },
    { label: 'File Size', fieldName: 'Size' },
    { label: 'Preview', type:  'button', typeAttributes: { 
            label: 'Preview',  name: 'Preview',  variant: 'brand-outline',
            iconName: 'utility:preview', iconPosition: 'right'
        } 
    },
    { label: 'Download', type: 'button', typeAttributes: { 
            label: 'Download', name: 'Download', variant: 'brand', iconName: 'action:download', 
            iconPosition: 'right' 
        } 
    },
    { label: 'Delete', type: 'button', typeAttributes: { 
            label: 'Delete',   name: 'Delete', variant: 'destructive', iconName: 'standard:record_delete', 
            iconPosition: 'right' 
        } 
    } 
];

export default class ContentManager extends NavigationMixin(LightningElement) {

    @api title;
    @api showDetails;
    @api showFileUpload;
    @api showsync;
    @api recordId;
    @api usedInCommunity;
    @api showFilters;
    @api accept = '.csv,.doc,.xsl,.pdf,.png,.jpg,.jpeg,.docx,.doc';

    @track dataList;
    @track columnsList;
    @track userProfile;
    @track isUploadDisabled = false;
    @track canDeleteFiles = false;
    isLoading = false;

    wiredFilesResult;

    @wire(getUserInfo, {}) 
    userData({ error, data }) {
        if(data) {
            this.userProfile = data.Profile.Name;
        } else if(error) {
            console.error(error.body.message);
        } 
        if(this.userProfile){
            canDeleteFiles().then(result => {
                this.canDeleteFiles = result;
            }).catch(error => {
                console.error('Error: \n ', error);
            }).finally(() => {
                if(!this.canDeleteFiles){
                    delete columns[5];
                }
                this.columnsList = columns;
            });
            cantUploadFiles().then(result => {
                this.isUploadDisabled = result;
            }).catch(error => {
                console.error('Error: \n ', error);
            });
        }
    }

    connectedCallback() {
        this.handleSync();
    }

    getBaseUrl(){
        let baseUrl = 'https://' + location.host + '/';
        getLoginURL().then(result => {
            baseUrl = result;
        }).catch(error => {
            console.error('Error: \n ', error);
        });
        return baseUrl;
    }

    handleRowAction(event){
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'Preview':
                this.previewFile(row);
                break;
            case 'Download':
                this.downloadFile(row);
                break;
            case 'Delete':
                this.handleDeleteFiles(row);
                break;
            default:
        }
    }

    previewFile(file){
        if(!this.usedInCommunity){
            this[NavigationMixin.Navigate]({
                type: 'standard__namedPage',
                attributes: {
                    pageName: 'filePreview'
                },
                state : {
                    selectedRecordId: file.ContentDocumentId
                }
            });
        } else if(this.usedInCommunity){
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: file.fileUrl
                }
            }, false );
        }
    }

    downloadFile(file){
        this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: file.downloadUrl
                }
            }, false 
        );
    }

    handleDeleteFiles(row){
        this.isLoading = true;

        deleteContentDocument({
            recordId : row.ContentDocumentId
        }).then(() => {
            this.dataList  = this.dataList.filter(item => {
                return item.ContentDocumentId !== row.ContentDocumentId;
            });
        }).catch(error => {
            console.error('**** error **** \n ', error)
        }).finally(() => {
            this.isLoading = false;
        });
    }

    handleSync(){

        let imageExtensions = ['png','jpg','gif'];
        let supportedIconExtensions = ['ai','attachment','audio','box_notes','csv','eps','excel','exe',
                        'flash','folder','gdoc','gdocs','gform','gpres','gsheet','html','image','keynote','library_folder',
                        'link','mp4','overlay','pack','pages','pdf','ppt','psd','quip_doc','quip_sheet','quip_slide',
                        'rtf','slide','stypi','txt','unknown','video','visio','webex','word','xml','zip'];

        this.isLoading = true;
        getContentDetails({
            recordId : this.recordId
        }).then(result => {
            let parsedData = JSON.parse(result);
            let stringifiedData = JSON.stringify(parsedData);
            let finalData = JSON.parse(stringifiedData);
            let baseUrl = this.getBaseUrl();
            finalData.forEach(file => {
                file.downloadUrl = baseUrl + 'sfc/servlet.shepherd/document/download/' + file.ContentDocumentId;
                file.fileUrl     = baseUrl + 'sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=' + file.Id;
                file.CREATED_BY  = file.ContentDocument.CreatedBy.Name;
                file.Size        = this.formatBytes(file.ContentDocument.ContentSize, 2);

                let fileType = file.ContentDocument.FileType.toLowerCase();
                if(imageExtensions.includes(fileType)){
                    file.icon = 'doctype:image';
                } else {
                    if(supportedIconExtensions.includes(fileType)){
                        file.icon = 'doctype:' + fileType;
                    }
                }
            });
            this.dataList = finalData;
        }).catch(error => {
            console.error('**** error **** \n ', error)
        }).finally(()=>{
            this.isLoading = false;
        });
    }

    handleUploadFinished(){
        this.handleSync();
    }
    formatBytes(bytes,decimals) {
        if(bytes == 0) return '0 Bytes';
        var k = 1024,
            dm = decimals || 2,
            sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
            i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    }

    handleSearch(event){
        let value = event.target.value;
        let name  = event.target.name;
        if(name === 'Title'){
            this.dataList = this.dataList.filter(file => {
                return file.Title.toLowerCase().includes(value.toLowerCase());
            });
        } else if(name === 'Created By'){
            this.dataList = this.dataList.filter( file => {
                return file.CREATED_BY.toLowerCase().includes(value.toLowerCase());
            });
        }
    }
}