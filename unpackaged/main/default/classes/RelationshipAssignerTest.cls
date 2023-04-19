@isTest
private class RelationshipAssignerTest {
   
    @TestSetup
    static void makeData(){
        Mission__c mission = new Mission__c(Name = 'Test Mission');
        insert mission;

        Account testAcc = new Account(Name = 'Testing Account');
        insert testAcc;
        
        

        
        Contact principal = new Contact(AccountId = testAcc.Id, LastName = 'Test', Mission__c = mission.Name);
        principal.Principal_Applicant_or_Family_Member__c = 'Principal Applicant';
        Contact familyMember1 = new Contact(AccountId = testAcc.Id, LastName = 'Test', Mission__c = mission.Name);
        familyMember1.Principal_Applicant_or_Family_Member__c = 'Family Member';
        Contact familyMember2 = new Contact(AccountId = testAcc.Id, LastName = 'Test', Mission__c = mission.Name);
        familyMember2.Principal_Applicant_or_Family_Member__c = 'Family Member';
        insert new List<Contact>{principal, familyMember1, familyMember2};

        Traveler__c duplicate = new Traveler__c(Traveler__c = principal.Id, Mission__c = mission.Id);
        try {
            insert duplicate;
        } catch (Exception ex){
            System.debug('Duplicate caught');
        }
    }

    @isTest 
    private static void testRelationshipAssigner(){
        Mission__c mission = [SELECT Id, Name FROM Mission__c WHERE Name =: 'Test Mission'];
        RelationshipAssigner.FlowInputs flowInput = new RelationshipAssigner.FlowInputs();
        flowInput.missionId = mission.Id;
        
        RelationshipAssigner.assignRelationships(new List<RelationshipAssigner.FlowInputs>{flowInput});

        RelationshipAssigner.assignRelationships(new List<RelationshipAssigner.FlowInputs>());
    }

    @isTest
    private static void testTravelerUpdates(){
        Traveler__c traveler = [SELECT Id, Name, Principal_Applicant_or_Family_Member__c, Relocation_Status__c, Covid_19_Result__c FROM Traveler__c 
                                WHERE Principal_Applicant_or_Family_Member__c =: 'Principal Applicant'];

        Test.startTest();
        traveler.Relocation_Status__c = 'Ticketed';
        update traveler;

        traveler.Covid_19_Result__c = 'Positive';
        update traveler;

        Test.stopTest();

        List<Traveler__c> family = [SELECT Id, Name, Principal_Applicant_or_Family_Member__c, Relocation_Status__c, Covid_19_Result__c FROM Traveler__c 
                                    WHERE Principal_Applicant_or_Family_Member__c =: 'Family Member'];
        System.debug(family);

        for(Traveler__c member : family){
            System.assertEquals(member.Relocation_Status__c, 'Ticketed');
            System.assertEquals(member.Covid_19_Result__c, 'Family Member Positive');
        }
    }
}