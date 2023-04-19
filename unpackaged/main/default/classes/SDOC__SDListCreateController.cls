/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SDListCreateController {
    global Boolean actionPollerToggle {
        get;
        set;
    }
    global String activeTab {
        get;
        set;
    }
    global List<Document> archiveList {
        get;
        set;
    }
    global String commentID {
        get;
        set;
    }
    global String CommentToAdd {
        get;
        set;
    }
    global Integer completedSize {
        get;
        set;
    }
    global String debugSoql {
        get;
        set;
    }
    global List<SDOC__SDoc__c> DocsGenerated {
        get;
        set;
    }
    global List<SDOC.SDTemplateWrapper> docsList {
        get;
        set;
    }
    global Boolean emailSent {
        get;
        set;
    }
    global Integer errorSize {
        get;
        set;
    }
    global Boolean hasCompleted {
        get;
        set;
    }
    global Boolean hasSelectedDocs {
        get;
        set;
    }
    global Boolean includedMassMergePage {
        get;
        set;
    }
    global Boolean isMassMergeDoc {
        get;
        set;
    }
    global Boolean isSummaryDoc {
        get;
        set;
    }
    global Integer listSize {
        get;
        set;
    }
    global List<SDOC.SDListCreateController.SobjWrapper> listWrapper {
        get;
        set;
    }
    global Boolean logActivityHistory {
        get;
        set;
    }
    global String ObjectName {
        get;
        set;
    }
    global List<SDOC.SDListCreateController.SobjWrapper> objWrapper {
        get;
        set;
    }
    global Boolean readyToSendEmail {
        get;
        set;
    }
    global Boolean renderSecondEditLink {
        get;
    }
    global Map<Id,SDOC__SDTemplate__c> sdMap {
        get;
        set;
    }
    global List<SDOC.SDTemplateWrapper> selectedDocs {
        get;
        set;
    }
    global String selectedLabel {
        get;
        set;
    }
    global String selectedTemplate {
        get;
        set;
    }
    global Boolean sidebar {
        get;
        set;
    }
    global String sortDir {
        get;
        set;
    }
    global String sortField {
        get;
        set;
    }
    global List<System.SelectOption> templatelabels {
        get;
        set;
    }
    global List<System.SelectOption> templates {
        get;
        set;
    }
    global SDListCreateController() {

    }
    global SDListCreateController(ApexPages.StandardSetController standardController) {

    }
    global void addComment() {

    }
    global void addDoc() {

    }
    global void addToCMList() {

    }
    global void addToQList() {

    }
    global void clearList() {

    }
    global List<System.SelectOption> getObjectNames() {
        return null;
    }
    global System.PageReference init() {
        return null;
    }
    global void loadSD() {

    }
    global void loadWL() {

    }
    global void objChange() {

    }
    global System.PageReference objChangePR() {
        return null;
    }
    global System.PageReference openMergedDoc() {
        return null;
    }
    global void printDoc() {

    }
    global System.PageReference printDocANDLabels() {
        return null;
    }
    global System.PageReference printLabels() {
        return null;
    }
    global void removeDoc() {

    }
    global void removeRec() {

    }
    global void runSearchCM() {

    }
    global void runSearchO(String name) {

    }
    global void sendEmail() {

    }
    global void setCID() {

    }
    global void showCompletedMessage() {

    }
    global System.PageReference updateobjWrapper() {
        return null;
    }
global class SobjWrapper {
    global Boolean checked {
        get;
        set;
    }
    global SDOC__SDJob__c job {
        get;
        set;
    }
    global SObject obj {
        get;
        set;
    }
    global SobjWrapper(Boolean ck, SObject o) {

    }
    global SobjWrapper(Boolean ck, SObject o, SDOC__SDJob__c j) {

    }
}
}
