public with sharing class ContractsDashboardController {
    
    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> getExpiringContracts(){
        // Contracts ending in next 30 days
        Date today = Date.today();
        Date next30 = today.addDays(30);
        
        List<AggregateResult> results = [
            SELECT Status_c__c, COUNT(Id) total
            FROM Contract_c__c
            WHERE End_Date_c__c >= :today AND End_Date_c__c <= :next30
            GROUP BY Status_c__c
        ];
        return results;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> getRenewalValues(){
        // Total Renewal Value per Type
        List<AggregateResult> results = [
            SELECT Renewal_Type__c, SUM(Renewal_Value_c__c) totalValue
            FROM Renewal_c__c
            GROUP BY Renewal_Type__c
        ];
        return results;
    }
}
