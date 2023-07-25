public class RecordTypeOpportunityHandler {
    public static void createRenewalOpportunities(List<Opportunity> opportunities) {
        try{
            //list of Renewal Opportunity record type records
            List<Opportunity> renewalOpportunities = new List<Opportunity>();
            
            Id rectypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Renewal Opportunity').getRecordTypeId();
            
            Id rectypeId1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Business').getRecordTypeId();
            for (Opportunity opp : opportunities) {
                
                if (opp.RecordTypeId == rectypeId1 && opp.StageName == 'Closed Won') {
                    Opportunity renewalOpp = new Opportunity();

                    // Set the fields for the Renewal Opportunity
                    renewalOpp.RecordTypeId = rectypeId;
                    renewalOpp.Name = opp.Name + ' - Renewal';
                    renewalOpp.CloseDate = System.today() + 30;
                    renewalOpp.StageName = 'Renewal Ready';
                    renewalOpp.OpportunityBusinessRT__c = opp.Id;
                    
                    renewalOpportunities.add(renewalOpp);
                }
            }
            
            // Insert the new Renewal Opportunities
            if(!renewalOpportunities.isEmpty()){
                Database.insert(renewalOpportunities);
            }
        }
        catch(Exception e){
            System.debug('Exception is:'+e.getMessage());
        }
    }
}
