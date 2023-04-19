public with sharing class TravelerImagesController {

    @AuraEnabled(cacheable=true)
    public static String getContentDetails(String recordId) {
        Traveler__c traveler = [SELECT Id, Traveler__c FROM Traveler__c WHERE Id =: recordId LIMIT 1];

        List<ContentDocumentLink> contentDocumentList = [SELECT ContentDocumentId, LinkedEntityId 
                                                        FROM ContentDocumentLink 
                                                        WHERE LinkedEntityId =: traveler.Traveler__c];

                                                        
        Set<Id> contentDocumentId = new Set<Id>();
            
        for(ContentDocumentLink cdl : contentDocumentList){
            contentDocumentId.add(cdl.ContentDocumentId);
        }
            
        List<ContentVersion> contentVersionList = [SELECT Id, VersionData, FileType, Title, FileExtension,
                                                ContentDocument.CreatedBy.Name, CreatedDate, ContentDocumentId,
                                                ContentDocument.FileType 
                                                FROM ContentVersion 
                                                WHERE  ContentDocumentId IN : contentDocumentId LIMIT 10];

        return JSON.serialize(contentVersionList);
    }

}