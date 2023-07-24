@isTest
public class TestRecordTypeOpportunityHandler {
    @isTest 
    static void testcreateRenewalOpportunities(){
        // Create a list of opportunities
        List<Opportunity> opplist = new List<Opportunity>();
        Opportunity opp1 = new Opportunity();
        opp1.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Business').getRecordTypeId();
        opp1.StageName = 'Closed Won';
        opplist.add(opp1);

        Opportunity opp2 = new Opportunity();
        opp2.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Business').getRecordTypeId();
        opp2.StageName = 'Closed Lost';
        opplist.add(opp2);

        
        test.startTest();
        RecordTypeOpportunityHandler.createRenewalOpportunities(opplist);
        test.stopTest();
    }
}