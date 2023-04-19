import { LightningElement, api, track, wire } from 'lwc';

import getContentDetails from '@salesforce/apex/TravelerImagesController.getContentDetails';
import { NavigationMixin } from 'lightning/navigation';

export default class TravelerImages extends NavigationMixin(LightningElement) {
    @track dataList;

    @api recordId; 
  

    connectedCallback() {
        this.handleSync();
    }

    getBaseUrl(){
        let baseUrl = 'https://' + location.host + '/';
        return baseUrl;
    }

    handleSync(){
        let imageExtensions = ['png','jpg','gif','pdf'];
        getContentDetails({
            recordId : this.recordId
        })
        .then(result => {
            let data = JSON.parse(JSON.stringify(JSON.parse(result)));
            let baseUrl = this.getBaseUrl();
            data.forEach(file => {
                let fileType = file.ContentDocument.FileType.toLowerCase();
                if(fileType == 'pdf'){
                    file.fileUrl = `${baseUrl}sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=${file.Id}`;
                } else {
                    file.fileUrl = `${baseUrl}sfc/servlet.shepherd/version/renditionDownload?rendition=ORIGINAL_${fileType}&versionId=${file.Id}`;
                }
                file.CREATED_BY  = file.ContentDocument.CreatedBy.Name;

                if(imageExtensions.includes(fileType)){
                    file.icon = 'doctype:image';
                }
            });
            this.dataList = data;
        })
        .catch(error => {
            console.error(error)
        })
    }

    previewImage(event){
        var docId = event.target.alt;
        console.log('DOC ID: ' + docId);
        this[NavigationMixin.Navigate]({
            type:'standard__namedPage',
            attributes:{
                pageName:'filePreview',
            },
            state:{
                selectedRecordId: docId
            }
        })
    }
}