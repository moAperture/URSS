@isTest
private class SDAddToMassMergeTest {
    @isTest
    private static void SDAddToMassMergeTest() {
        Integer numJobsToCreate = 20;
        List<Opportunity> selectedOpportunities = [
            SELECT Id, Name
            FROM Opportunity
            LIMIT :numJobsToCreate
        ];
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(selectedOpportunities);
        ssc.setSelected(selectedOpportunities);                                                                
        SDAddToMassMerge sdatmm = new SDAddToMassMerge(ssc);
        String objectNameTest = '[SDAddToMassMerge Test]';
        sdatmm.createMassMergeJobs();
        Integer numJobsCreated = Database.countQuery(
            'SELECT COUNT() '
            + 'FROM SDOC__SDJob__c '
            + 'WHERE SDOC__ObjApiName__c=\'' + objectNameTest + '\''
        );
        // System.assert(numJobsCreated == numJobsToCreate);
    }
}