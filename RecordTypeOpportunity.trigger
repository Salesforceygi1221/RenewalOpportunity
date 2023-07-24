trigger RecordTypeOpportunity on Opportunity (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        RecordTypeOpportunityHandler.createRenewalOpportunities(trigger.new);
    }
}