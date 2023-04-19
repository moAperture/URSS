/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SDMigrateController {
    @RemoteAction
    global static void clearAttachmentsOnSDTemplate(String sdocsTemplateOrgAgnosticID) {

    }
    @RemoteAction
    global static void createSDMigrateSettings(String settings) {

    }
    global static String getFileDataForExport(Id recordId, String sdocsTemplateOrgAgnosticID) {
        return null;
    }
    @RemoteAction
    global static String getFileDataForExport(Id recordId, String sdocsTemplateOrgAgnosticID, String fieldsToExclude) {
        return null;
    }
    @RemoteAction
    global static List<String> getIgnoredFields(String fileBodyBase64, String writeableFields) {
        return null;
    }
    @RemoteAction
    global static String getTemplateIdAndName(String filename, String fileBodyBase64, String sdocsTemplateOrgAgnosticId, String objName) {
        return null;
    }
    @RemoteAction
    global static void insertAttachmentOnSDTemplate(String filename, String fileBodyBase64, String sdocsTemplateOrgAgnosticID) {

    }
    global static void upsertSDTemplate(String filename, String fileBodyBase64, String sdocsTemplateOrgAgnosticID) {

    }
    @RemoteAction
    global static void upsertSDTemplate(String filename, String fileBodyBase64, String sdocsTemplateOrgAgnosticID, Map<String,String> valuesToSet) {

    }
    @RemoteAction
    global static void upsertSSTemplate(String filename, String fileBodyBase64, String sdocsTemplateOrgAgnosticID) {

    }
}
