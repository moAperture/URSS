@isTest
private class TravelerImagesControllerTest {
    
    @TestSetup
    static void makeData(){
        Mission__c mission = new Mission__c(Name = 'Test Mission');
        insert mission;

        Account testAcc = new Account(Name = 'Testing Account');
        insert testAcc;
        

        Contact con = new Contact(AccountId = testAcc.Id, LastName = 'Test', Mission__c = mission.Name);
        con.Principal_Applicant_or_Family_Member__c = 'Principal Applicant';
        insert con; 

        ContentVersion contentVersion = new ContentVersion(Title = '', PathOnClient = 'Pic.jpg', VersionData = Blob.valueOf('Test Content'), IsMajorVersion = true,Document_Type__c ='Passport');
        insert contentVersion; 
        List<ContentDocument> documents = [SELECT Id, Title FROM ContentDocument];

        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = con.id;
        cdl.ContentDocumentId = documents[0].Id;
        insert cdl;
    }

    @isTest 
    private static void testImagesController(){
        Traveler__c traveler = [SELECT Id, Traveler__c, Mission__c FROM Traveler__c WHERE Mission__r.Name =: 'Test Mission' LIMIT 1];

        String contentDetails = TravelerImagesController.getContentDetails(traveler.Id);

        System.debug(contentDetails);
    }

}