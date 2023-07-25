@isTest
public class TestRecordTypeOpportunityHandler {
    private static List<Opportunity> oppList;
    @testSetup
    static void setUpRecords() {
        // Create a list of opportunities
        oppList = new List<Opportunity>();
        
        // Add an opportunity with the RecordTypeId of 'Business'
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'sample1';
        opp1.CloseDate = System.today();
        opp1.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Business').getRecordTypeId();
        opp1.StageName = 'Closed Won';
        oppList.add(opp1);
        
        // Add an opportunity with the RecordTypeId of 'Business'
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'sample2';
        opp2.CloseDate = System.today();
        opp2.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Business').getRecordTypeId();
        opp2.StageName = 'Closed Lost';
        oppList.add(opp2);
        
        Database.insert(oppList, false);
    }
    
    @isTest
    static void testCreateRenewalOpportunities() {
        
        // Start the test
        test.startTest();
        // Call the createRenewalOpportunities() method on the RecordTypeOpportunityHandler class
        RecordTypeOpportunityHandler.createRenewalOpportunities(oppList);
        test.stopTest(); 
        // Get the list of renewal opportunities
        List<Opportunity> renewalOpportunities = [
            select Id, Name, CloseDate, StageName
            from Opportunity
            where RecordTypeId =: Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Renewal Opportunity').getRecordTypeId()
        ];
        
        System.assertEquals(1, renewalOpportunities.size());
        System.assertEquals('sample1 - Renewal', renewalOpportunities[0].Name);
        System.assertEquals(System.today() + 30, renewalOpportunities[0].CloseDate );
        System.assertEquals('Renewal Ready', renewalOpportunities[0].StageName);
    }
}
