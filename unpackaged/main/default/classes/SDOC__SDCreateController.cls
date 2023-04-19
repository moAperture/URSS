/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SDCreateController {
    global List<SDOC__SDoc__c> sdocsCreated;
    global SDCreateController(Map<String,String> constructorParamsIn) {

    }
    global static String getDocxContentPreprocessor(String sdocId, String sitePrefix) {
        return null;
    }
    global static Map<String,String> getDocxContent(String sdocId, String preprocessedContent) {
        return null;
    }
    @RemoteAction
    global static Map<String,String> getDocxFileMap(String sdocId, String sitePrefix, String javaScriptProcessedContent) {
        return null;
    }
    @RemoteAction
    global static String getDocxMergedContent(String sdocId, String sitePrefix) {
        return null;
    }
    global static List<String> getDocxSDocIDs() {
        return null;
    }
    global void initializeDocumentGeneration() {

    }
    @RemoteAction
    global static void updateDocxAttachment(String sdocId, String zipBodyBase64Chunk, Integer chunkNum) {

    }
    global static void updateSDocStatuses() {

    }
    @RemoteAction
    global static void updateSDocStatusesPreview(List<String> sdocIds, String previewFirst) {

    }
    @RemoteAction
    global static void updateSDocStatuses(List<String> sdocIds) {

    }
    @RemoteAction
    global static Map<String,String> uploadImageAndReturn(String name, String body) {
        return null;
    }
}
