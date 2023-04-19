/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SDBatch implements Database.Batchable<SObject>, Database.Stateful {
    global static Boolean autoEnqueueFileMaster;
    global Id batchApexJobId;
    global SDOC.SDBatch.BatchJobType batchJobType;
    global Integer batchSize;
    global Integer dataSizeLimit;
    global String distinct;
    global String documentDelimiter;
    global Boolean isSDJobQuery;
    global String query;
    global String templateNameOrId;
    global SDBatch() {

    }
    global static void attachEmail(Map<String,String> params) {

    }
    global static void createS3(String oid) {

    }
    global static void createSDoc(String sid, String url) {

    }
    global static void createSDoc(String sid, String username, String url) {

    }
    @Future(callout=true)
    global static void createSDocCA(String sid, String username, String jids) {

    }
    @Future(callout=true)
    global static void createSDocCA(String sid, String username, String jids, String batchGroupIDStatic) {

    }
    global static void createSDocSYNC(String sid, String username, String url) {

    }
    global static Map<String,String> createSDocs(Map<String,String> params) {
        return null;
    }
    global void executeBatch() {

    }
    global static String generateBatchGroupID() {
        return null;
    }
    global static void writeLineItemDataXML(SDOC__SDJob__c sdjob, String xml) {

    }
    global static void writeRecordDataXML(SDOC__SDJob__c sdjob, String xml) {

    }
global enum BatchJobType {COMBINED_DOC, SEPARATE_DOCS}
global class SDJobBatchNumberer {
    global SDJobBatchNumberer() {

    }
    global void assignBatchNumbering(List<SDOC__SDJob__c> sdjobs, String batchApexClassName) {

    }
    global String getBatchGroupID() {
        return null;
    }
    global Integer getNumJobs() {
        return null;
    }
}
}
