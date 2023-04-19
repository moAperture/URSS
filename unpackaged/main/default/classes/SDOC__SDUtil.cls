/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SDUtil {
    @RemoteAction
    @TestVisible
    global static Id SDPDFMerge_insertStitchedPDF(Map<String,String> attachmentData) {
        return null;
    }
    @RemoteAction
    @TestVisible
    global static String SDPDFMerge_loadFiles(String attachmentId) {
        return null;
    }
    global static void convertDOCTemplatesToDOCNEW() {

    }
    global static void convertDOCTemplatesToDOCNEW(String whereClause) {

    }
    @RemoteAction
    global static String createPDFStitchAttachments(String create_file, String create_attachment, String attachment_name, String base_object, String owner_id, String sdoc_id, String parent_id, String preview, String template_id, String base64Body) {
        return null;
    }
    global static void disableSDTemplateTrigger() {

    }
    global static void enableSDTemplateTrigger() {

    }
    global static String getPageHeaderFooterDiv(String divId, String dataXML) {
        return null;
    }
    global static Messaging.SingleEmailMessage getSingleEmailMessage(String sdocId) {
        return null;
    }
    @RemoteAction
    global static String handlePDFStitchAttachments(String templateId, String base64Body) {
        return null;
    }
    @RemoteAction
    global static String preparePDFPreview(String sdocId, String base64Body) {
        return null;
    }
    global static Boolean renderEval(String expression) {
        return null;
    }
    global static String replaceMergeFields(String text, Blob password) {
        return null;
    }
    global static String replaceMergeFields(String text, String objectName, String objectID, Blob password) {
        return null;
    }
    global static String replaceMergeFields(String text, String objectName, String objectID, Blob password, String preExistingRecordDataXML) {
        return null;
    }
    global static Boolean sdtemplateTriggerIsDisabled() {
        return null;
    }
    @RemoteAction
    @TestVisible
    global static void updateFileChunks(Id fileId, String base64Chunk, Integer chunkNum) {

    }
global class SDocSettings {
    global SDocSettings(String deprecated) {

    }
    global String getSetting(String deprecated) {
        return null;
    }
}
global class SDocTable {
    global List<SDOC.SDUtil.SDocTableRow> rows;
    global SDocTable() {

    }
}
global class SDocTableCell {
    global String name;
    global String value;
    global SDocTableCell(String name, String value) {

    }
}
global class SDocTableRow {
    global List<SDOC.SDUtil.SDocTableCell> cells;
    global SDocTableRow() {

    }
}
global class XMLSerializer {
    global XMLSerializer() {

    }
    global String jsonToXML(String jsonString) {
        return null;
    }
    global String jsonToXML(String jsonString, Boolean suppressNulls) {
        return null;
    }
    global String serialize(Object objectToSerialize) {
        return null;
    }
    global String serialize(Object objectToSerialize, Boolean suppressApexObjectNulls, String addRootElementName) {
        return null;
    }
}
}
