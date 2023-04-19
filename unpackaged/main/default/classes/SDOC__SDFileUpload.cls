/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SDFileUpload {
    @RemoteAction
    global static SDOC__SDTemplate__c createNewSDocTemplate(String docxFilename, String massDocxRelatedToType) {
        return null;
    }
    @RemoteAction
    global static void deleteOldAttachments(String sdocTemplateId) {

    }
    @RemoteAction
    global static AsyncApexJob getJobStatus(Id jobID) {
        return null;
    }
    global static void preprocessDocxTemplate(String str) {

    }
    @RemoteAction
    global static void preprocessDocxTemplate(String sdocTemplateId, Boolean legacySyntax) {

    }
    global static String preprocessDocxTemplateAsync(String str) {
        return null;
    }
    @RemoteAction
    global static String preprocessDocxTemplateAsync(String sdocTemplateId, Boolean legacySyntax) {
        return null;
    }
    @RemoteAction
    global static void uploadFile(String filename, String base64FileBody, String sdocTemplateId) {

    }
    @RemoteAction
    global static void uploadInnerDocxFile(String filename, String base64FileBody, String sdocTemplateId) {

    }
    @RemoteAction
    global static void uploadPDFUploadFile(String base64FileBody, String sdocTemplateId) {

    }
}
