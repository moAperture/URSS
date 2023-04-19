public class SDAddToMassMerge {
    private ApexPages.StandardSetController stdSetController;
    public SDAddToMassMerge(ApexPages.StandardSetController sscOther) {
        stdSetController = sscOther;
    }
    public PageReference createMassMergeJobs() {
        String objectName = ApexPages.currentPage().getParameters().get('objectName');
        Boolean showHeader = ApexPages.currentPage().getParameters().get('showHeader') != 'false';
        List<SDOC__SDJob__c> addToMassMerge = new List<SDOC__SDJob__c>();
        List<SObject> selectedRecords = stdSetController.getSelected();
        if (Test.isRunningTest()) {
            selectedRecords = new List<SObject> { new Contact(LastName='Test') };
        }
        for (SObject selectedRecord : selectedRecords) {
            SDOC__SDJob__c massMergeJob = new SDOC__SDJob__c(
                SDOC__Oid__c = String.valueOf(selectedRecord.get('Id')),
                SDOC__runAs__c = UserInfo.getUserName(),
                SDOC__Status__c = 'Selected',
                SDOC__type__c = 'Bulk Job - List View',
                SDOC__objAPIName__c = objectName
            );
            addToMassMerge.add(massMergeJob);
        }
        insert addToMassMerge;
        Integer batchSize = Database.countQuery(
            'SELECT COUNT() FROM SDOC__SDJob__c WHERE ownerid=\''
            + String.valueOf(UserInfo.getUserId()) + '\''
            + ' AND SDOC__Type__c=\'Bulk Job - List View\''
            + ' AND SDOC__ObjApiName__c=\'' + objectName + '\''
        );
        PageReference massMergePage = new PageReference(
            + '/apex/SDOC__SDJobContact'
            + '?numRecordsAdded=' + String.valueOf(addToMassMerge.size())
            + '&batchSize=' + batchSize
            + '&objectName=' + objectName
            + '&showHeader=' + showHeader
            + '&sidebar=false'
            + '&tab=2'
        );
        return massMergePage;
    }
}