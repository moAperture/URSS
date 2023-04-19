public without sharing class ContentManagerService {
    
    @AuraEnabled
    public static String getContentDetails(String recordId) {
        List<ContentDocumentLink> contentDocumentList = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink 
                                                         WHERE LinkedEntityId =: recordId];
        Set<Id> contentDocumentId = new Set<Id>();
            
        for(ContentDocumentLink cdl : contentDocumentList){
            contentDocumentId.add(cdl.ContentDocumentId);
        }
            
        List<ContentVersion> contentVersionList = [SELECT Id, VersionData, FileType, Title, FileExtension, ContentDocument.CreatedBy.Name, 
                                                    ContentDocument.ContentSize, CreatedDate, ContentDocumentId, ContentDocument.FileType
                                                    FROM ContentVersion WHERE ContentDocumentId IN : contentDocumentId];
        return JSON.serialize(contentVersionList);
    }

    @AuraEnabled
    public static void deleteContentDocument(String recordId) {
        Database.delete(recordId);
    }

    public static string ContentType(String fileType) {
        switch on fileType.toLowerCase(){
            when 'docx' {
                return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            }
            when 'csv' {
                return 'application/vnd.ms-excel';
            }
            when 'wav' {
                return 'audio/wav';
            }
            when 'wmv' {
                return 'video/x-ms-wmv';
            }
            when 'mp3' {
                return 'audio/mpeg';
            }
            when 'mp4' {
                return 'video/mp4';
            }
            when 'png' {
                return 'image/png'; 
            }
            when 'pdf' {
                return 'application/pdf';
            }
            when else {
                return 'image/jpeg';
            }
        }
    }

    @AuraEnabled(cacheable=true)
    public static String getLoginURL(){
        String baseURL = System.URL.getSalesforceBaseUrl().toExternalForm();
        User userRecord = [SELECT Id, AccountId, ContactId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        if(userRecord.ContactId != null){
            baseUrl = getExperienceURL();
        }
        return baseUrl;
    }

    public static String getExperienceURL(){
        String baseUrl = Network.getLoginUrl(Network.getNetworkId());
        baseURL =  baseURL.replace('/s/login', '');
        baseURL =  baseURL.replace('/s/Login', '');
        baseURL =  baseURL.replace('/login', '');
        baseURL =  baseURL.replace('/Login', '');
        return baseURL;
    }

    @AuraEnabled(cacheable=true)
    public static User getUserInfo() {
        return [SELECT Id, Name, Profile.Name, Email From User WHERE Id =: UserInfo.getUserId() LIMIT 1];
    }

    @AuraEnabled(cacheable=true)
    public static Boolean canDeleteFiles(){
        User user = getUserInfo();
        String profileName = user.Profile.Name;
        List<Delete_File_Profile__mdt> profiles = Delete_File_Profile__mdt.getAll().values();
        for(Delete_File_Profile__mdt profile : profiles){
            if(profileName == profile.Label){
                return true;
            }
        }
        return false;
    }

    @AuraEnabled(cacheable=true)
    public static Boolean cantUploadFiles(){
        User user = getUserInfo();
        String profileName = user.Profile.Name;
        List<Upload_File_Profile__mdt> profiles = Upload_File_Profile__mdt.getAll().values();
        for(Upload_File_Profile__mdt profile : profiles){
            if(profileName == profile.Label){
                return true;
            }
        }
        return false;
    }

}