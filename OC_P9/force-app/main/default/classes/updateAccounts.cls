public with sharing class UpdateAccounts {
    
    //Calculation of the turnOver on the Accounts, Sum of the related Activated Orders Total Amount
    public static void turnover(List<Account> accounts) {
      	
        List<Order> relatedOrders = new List<Order>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Double> AccountIdXTurnover = new Map<Id,Double>();
		//Creation of a Map with each Account id related to their Turnover 
        for(Account acct:accounts){
            accountIds.add(acct.Id);
            AccountIdXTurnover.put(acct.Id,0);
        }

        relatedOrders = [SELECT Id, TotalAmount__c, Accountid FROM Order WHERE Accountid IN :accountIds AND Status = 'ordered'];
		//Sum the Total Amount of orders who are related to the same Account 
        for(Order order:relatedOrders){
            AccountIdXTurnover.put(order.AccountId,AccountIdXTurnover.get(order.AccountId)+order.TotalAmount__c );
        }
		//Assignation of the turnovers to their Accounts 
        for(Account acct:accounts){
            acct.Turnover__c = AccountIdXTurnover.get(acct.Id);
        }
        
        update accounts;
    }
}