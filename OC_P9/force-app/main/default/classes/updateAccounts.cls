public with sharing class updateAccounts {
    public static void turnover(List<Account> accounts) {
      
        List<Order> relatedOrders = new List<Order>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Double> AccountIdXTurnover = new Map<Id,Double>();

        for(Account acct:accounts){
            accountIds.add(acct.Id);
            AccountIdXTurnover.put(acct.Id,0);
        }

        relatedOrders = [SELECT Id, TotalAmount__c, Accountid FROM Order WHERE Accountid IN :accountIds];

        for(Order order:relatedOrders){
            AccountIdXTurnover.put(order.AccountId,AccountIdXTurnover.get(order.AccountId)+order.TotalAmount__c );
        }

        for(Account acct:accounts){
            acct.Turnover__c = AccountIdXTurnover.get(acct.Id);
        }
        
        update accounts;
    }
}
