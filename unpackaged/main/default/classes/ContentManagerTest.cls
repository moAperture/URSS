@isTest
private class ContentManagerTest {
    
    @TestSetup
    static void makeData(){
        Account testAcc = new Account(Name = 'Testing Account');
        Database.insert(testAcc);

        Contact con = new Contact(AccountId = testAcc.Id, LastName = 'Test');
        con.Principal_Applicant_or_Family_Member__c = 'Principal Applicant';
        Database.insert(con);

        Profile outreach = [SELECT Id, Name FROM Profile WHERE Name = 'Outreach Officer'];
        User outreachUser = new User(FirstName = 'Outreach', LastName = 'User', ProfileId = outreach.Id,
                                Email = 'outreachUser@test.com', Username = 'outreachUser@test.com.bancroft',
                                Alias = 'OU', CommunityNickname = 'out' , TimeZoneSidKey = 'America/New_York', 
                                LocaleSidKey = 'en_US', EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US'
        );
        Database.insert(outreachUser);
        Profile management = [SELECT Id, Name FROM Profile WHERE Name = 'Management'];
        User manager = new User(FirstName = 'Management', LastName = 'User', ProfileId = management.Id,
                                Email = 'manager@test.com', Username = 'manager@test.com.bancroft',
                                Alias = 'MU', CommunityNickname = 'man' , TimeZoneSidKey = 'America/New_York',
                                LocaleSidKey = 'en_US', EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US'
        );
        Database.insert(manager);
    }

    @isTest 
    private static void testContentDocuments(){
        User outreachUser = [SELECT Id, Name FROM User WHERE Username =: 'outreachUser@test.com.bancroft' LIMIT 1];
        Contact con = [SELECT Id, Name FROM Contact LIMIT 1];
        Test.startTest();
        System.runAs(outreachUser){
            try {
                ContentVersion contentVersion = new ContentVersion(Title = '', PathOnClient = 'Pic.jpg', VersionData = Blob.valueOf('Test Content'), IsMajorVersion = true);
                insert contentVersion; 
            } catch(Exception ex){
                System.debug('Exception Caught!');
                System.debug(ex);
            }
        }
        User manager = [SELECT Id, Name FROM User WHERE Username =: 'manager@test.com.bancroft' LIMIT 1];
        System.runAs(manager){
            try {
                ContentVersion contentVersion = new ContentVersion(Title = '', PathOnClient = 'Pic.jpg', VersionData = Blob.valueOf('Test Content'), IsMajorVersion = true,Document_Type__c ='Passport');
                insert contentVersion; 

                ContentManagerService.deleteContentDocument(contentVersion.Id);
            } catch(Exception ex){
                System.debug('Exception Caught!');
                System.debug(ex);
            }
        }

        ContentVersion contentVersion = new ContentVersion(Title = '', PathOnClient = 'Pic.jpg', VersionData = Blob.valueOf('Test Content'), IsMajorVersion = true,Document_Type__c ='Passport');
        insert contentVersion; 
        List<ContentDocument> documents = [SELECT Id, Title FROM ContentDocument];

        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = con.id;
        cdl.ContentDocumentId = documents[0].Id;
        insert cdl;

        String contentDetails = ContentManagerService.getContentDetails(con.Id);

        System.debug(contentDetails);
        Test.stopTest();
    }

    @isTest 
    private static void testContentType(){
        System.assertEquals(ContentManagerService.ContentType('docx'), 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
        System.assertEquals(ContentManagerService.ContentType('csv'), 'application/vnd.ms-excel');
        System.assertEquals(ContentManagerService.ContentType('wav'), 'audio/wav');
        System.assertEquals(ContentManagerService.ContentType('wmv'), 'video/x-ms-wmv');
        System.assertEquals(ContentManagerService.ContentType('mp3'), 'audio/mpeg');
        System.assertEquals(ContentManagerService.ContentType('mp4'), 'video/mp4');
        System.assertEquals(ContentManagerService.ContentType('png'), 'image/png');
        System.assertEquals(ContentManagerService.ContentType('pdf'), 'application/pdf');
        System.assertEquals(ContentManagerService.ContentType('jpg'), 'image/jpeg');
    }

    @isTest 
    private static void testLogin(){
        User testUser = [SELECT Id, Name, ContactId FROM User WHERE Username =: 'manager@test.com.bancroft' LIMIT 1];
        Contact con = [SELECT Id, Name FROM Contact LIMIT 1];
        System.runAs(testUser){
            String loginUrl = ContentManagerService.getLoginURL();
            System.debug(loginUrl);
            try {
                String expUrl = ContentManagerService.getExperienceURL();
                System.debug(expUrl);
            } catch (Exception ex){
                System.debug('Exception Caught!');
                System.debug(ex);
            } 
        }
    }

    @isTest 
    private static void testCanUploadAndDelete(){
        User outreach = [SELECT Id, Name FROM User WHERE Username =: 'outreachUser@test.com.bancroft' LIMIT 1];
        User management = [SELECT Id, Name, ContactId FROM User WHERE Username =: 'manager@test.com.bancroft' LIMIT 1];

        Test.startTest();
        System.runAs(outreach){
            System.assertEquals(ContentManagerService.canDeleteFiles(), false);
            System.assertEquals(ContentManagerService.cantUploadFiles(), true);
        }
        System.runAs(management){
            System.assertEquals(ContentManagerService.canDeleteFiles(), true);
            System.assertEquals(ContentManagerService.cantUploadFiles(), false);
        }
        Test.stopTest();
    }
}