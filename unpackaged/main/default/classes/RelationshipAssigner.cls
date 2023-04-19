public with sharing class RelationshipAssigner {

    public class FlowInputs {
        @InvocableVariable public String missionId;
    }

    @InvocableMethod(label='Assign Relationships')
    public static void assignRelationships(List<FlowInputs> inputs) {
        List<Traveler__c> travelers = new List<Traveler__c>();
        if(inputs.size() > 0 && inputs[0].missionId != null){
            travelers = [SELECT Id, Traveler__r.Number_of_Family_Members__c, Mission__c, Related_To__c, Family_Group__c, Principal_Applicant_or_Family_Member__c,
                        Number_of_Family_Members__c FROM Traveler__c WHERE Mission__c =: inputs[0].missionId];
        } else {
            return;
        }
        
        Map<String, Traveler__c> principalApplicants = new Map<String, Traveler__c>();
        Map<String, List<Traveler__c>> familyMembers = new Map<String, List<Traveler__c>>();
        
        String familyGroup;
        String app;
        for(Traveler__c con : travelers){
            familyGroup = con.Family_Group__c;
            app = con.Principal_Applicant_or_Family_Member__c;
            if(app == 'Principal Applicant'){
                if(!principalApplicants.containsKey(familyGroup)){
                    principalApplicants.put(familyGroup, con);
                }
            } else if(app != '' && app != null){
                if(!familyMembers.containsKey(familyGroup)){
                    List<Traveler__c> familyGroupList = new List<Traveler__c>();
                    familyGroupList.add(con);
                    familyMembers.put(familyGroup, familyGroupList);
                } else {
                    familyMembers.get(familyGroup).add(con);
                }
            } 
        }

        List<Traveler__c> toUpdate = new List<Traveler__c>();
        List<Contact> toUpdateCon = new List<Contact>();
        for(String groupNum : principalApplicants.keySet()){
            if(familyMembers.containsKey(groupNum)){
                Traveler__c principal = principalApplicants.get(groupNum);
                List<Traveler__c> family = familyMembers.get(groupNum);
                for(Traveler__c member : family){
                    if(member.Related_To__c != principal.Id){
                        member.Related_To__c = principal.Id;
                        Contact con = member.Traveler__r;
                        con.Number_of_Family_Members__c = family.size();
                        toUpdate.add(member);
                        toUpdateCon.add(con);
                    }
                }
                Contact con = principal.Traveler__r;
                con.Number_of_Family_Members__c = family.size();
                toUpdateCon.add(con);
            }
        }

        if(!toUpdate.isEmpty()){
            update toUpdate;
        }
        if(!toUpdateCon.isEmpty()){
            update toUpdateCon;
        }
        
    }
}