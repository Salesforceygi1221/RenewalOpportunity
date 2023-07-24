public class RecordTypeOpportunityHandler {
    public static void createRenewalOpportunities(List<Opportunity> Opportunities) {
        try{
            //list of Renewal Opportunity record type records
            List<Opportunity> renewalOpportunities = new List<Opportunity>();
            
            RecordType rectypeId = [SELECT Id FROM RecordType WHERE DeveloperName ='Renewal_Opportunity'];
            
            RecordType rectypeId1 = [SELECT Id FROM RecordType WHERE DeveloperName ='Business'];
            for (Opportunity opp : Opportunities) {
                
                if (opp.RecordTypeId == rectypeId1.Id && opp.StageName == 'Closed Won') {
                    Opportunity renewalOpp = new Opportunity();

                    // Set the fields for the Renewal Opportunity
                    renewalOpp.RecordTypeId = rectypeId.Id;
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
