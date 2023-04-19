trigger travelerTrigger on Traveler__c (before insert, before update, after insert, after update) {
    if(Trigger.isBefore && Trigger.isInsert){
        List<Traveler__c> travelers = new List<Traveler__c>();
    
        List<Id> contacts = new List<Id>();
        List<Id> missions = new List<Id>();
    
        for(Traveler__c traveler : Trigger.new){
            if(traveler.Traveler__c != null && traveler.Mission__c != null){
                contacts.add(traveler.Traveler__c);
                missions.add(traveler.Mission__c);
            }
        }
        List<Contact> cons = [SELECT Name, Id, Passport_Number__c FROM Contact WHERE Id =: contacts];

        List<Traveler__c> duplicates = [SELECT Id, Traveler__c, Mission__c FROM Traveler__c WHERE Traveler__c =: contacts AND Mission__c =: missions];
        for(Traveler__c traveler : Trigger.new){
            for(Traveler__c duplicate : duplicates){
                if(traveler.Id != duplicate.Id){
                    if(traveler.Traveler__c == duplicate.Traveler__c && traveler.Mission__c == duplicate.Mission__c){
                        traveler.Traveler__c.adderror('That traveler is already on the mission ' + traveler.Traveler__c + ':' + traveler.Mission__c);
                    }
                }
            }
            for(Contact con : cons){
                if(con.Id == traveler.Traveler__c){
                    traveler.Search_Name__c = con.Name;
                    traveler.Search_Passport_Number__c = con.Passport_Number__c;
                }
            }
        }
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Traveler__c> updateFamily = new List<Traveler__c>();
        for(Traveler__c traveler : Trigger.new){
            if(traveler.Principal_Applicant_or_Family_Member__c == 'Principal Applicant'){
                List<Traveler__c> family = [SELECT Id, Relocation_Status__c, Family_Group__c, Principal_Applicant_or_Family_Member__c FROM Traveler__c 
                                WHERE Family_Group__c =: traveler.Family_Group__c AND Principal_Applicant_or_Family_Member__c != 'Principal Applicant'];

                if(!family.isEmpty()){
                    for(Traveler__c member : family){
                        if(member.Relocation_Status__c != traveler.Relocation_Status__c){
                            member.Relocation_Status__c = traveler.Relocation_Status__c;
                            updateFamily.add(member);
                        }
                    }
                }
            }
            if(traveler.Covid_19_Result__c == 'Positive'){
                List<Traveler__c> family = [SELECT Id, Covid_19_Result__c, Family_Group__c FROM Traveler__c WHERE Family_Group__c =: traveler.Family_Group__c];
                if(!family.isEmpty()){
                    for(Traveler__c member : family){
                        if(member.Covid_19_Result__c != 'Positive' && member.Covid_19_Result__c != 'Family Member Positive' && member.Id != traveler.Id){
                            member.Covid_19_Result__c = 'Family Member Positive';
                            updateFamily.add(member);
                        }
                    }
                }
            }
        }
        if(!updateFamily.isEmpty()){
            update updateFamily;
        }
    }
}