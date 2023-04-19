// Tests for MassDeleteExtension
@isTest
private class MassDeleteExtensionTest {
    @isTest
    private static void testDeleteRecords() {
        List<Lead> leads = new List<Lead>();
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(leads);
        MassDeleteExtension extension = new MassDeleteExtension(sc);

        System.assertNotEquals(null, extension.deleteRecords());
        System.debug(extension.error);
    }

    @isTest
    private static void testSelectedSize() {
        List<Lead> leads = new List<Lead>();
        leads.add(new Lead(LastName='test'));

        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(leads);
        sc.setSelected(leads);
        MassDeleteExtension extension = new MassDeleteExtension(sc);

        System.assertEquals('1', extension.getMySelectedSize());
    }
}