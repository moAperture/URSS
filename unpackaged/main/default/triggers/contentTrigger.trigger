trigger contentTrigger on ContentDocument (before insert) {
    for(ContentDocument contentDoc : Trigger.new){
        if(ContentManagerService.cantUploadFiles()){
            contentDoc.addError('You do not have permission to upload files.');
        }
    }
}