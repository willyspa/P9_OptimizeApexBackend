public with sharing class OrderTriggerHelper {

    public static void UpdateAccountCA(List<Order> orders, Map<Id,Order> ordersOldMap) {


        List<Order> relatedOrders = new List<Order>();
        List<Account> accounts = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Double> AccountIdXTurnover = new Map<Id,Double>();

        //collect the orders where the status was updated
        for(Order order:orders){
            
            if(order.status != ordersOldMap.get(order.Id).status && order.status == 'ordered'){
                
                accountIds.add(order.AccountId);
                AccountIdXTurnover.put(order.AccountId,0);
            }
        }
        // penser a verifier l'utilité de la condition
        if(accountIds.size() != 0){

            relatedOrders = [SELECT id, AccountId, TotalAmount__c FROM Order WHERE AccountId IN :accountIds AND TotalAmount__c != NULL];
            accounts = [SELECT Id, Turnover__c FROM Account WHERE Id IN :accountIds];
            //Calculation of the turnover
            for(Order order:relatedOrders){
                AccountIdXTurnover.put(order.AccountId,AccountIdXTurnover.get(order.AccountId)+order.TotalAmount__c );
            }
    
            for(Account acct:accounts){
                acct.Turnover__c = AccountIdXTurnover.get(acct.Id);
            }

            update accounts;
        }
    }
    /*
    public static void UpdateAccountCAOnInsert(List<Order> orders) {

        List<Account> accounts = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Decimal> AccountIdXTurnover= new Map<Id, Decimal>();

        for(Order order:orders){
            if(order.status == 'ordered'){
            	accountIds.add(order.AccountId);
            	AccountIdXTurnover.put(order.AccountId,AccountIdXTurnover.get(order.AccountId)+order.TotalAmount__c);                
            }
        }

        accounts = [SELECT Id, Turnover__c FROM Account WHERE Id IN :accountIds];

        for(Account acct:accounts){
            acct.Turnover__c += AccountIdXTurnover.get(acct.Id);
        }

        update accounts;

    }*/
    /*
    public static void UpdateAccountCAOnDelete(List<Order> orders){

        List<Account> accounts = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id,Decimal> AccountIdXTurnover= new Map<Id, Decimal>();

        for(Order order:orders){
            if(order.status == 'ordered'){
            	accountIds.add(order.AccountId);
            	AccountIdXTurnover.put(order.AccountId,AccountIdXTurnover.get(order.AccountId)+order.TotalAmount__c);                
            }
        }

        accounts = [SELECT Id, Turnover__c FROM Account WHERE Id IN :accountIds];

        for(Account acct:accounts){
            acct.Turnover__c -= AccountIdXTurnover.get(acct.Id);
        }

        update accounts;        
    }
    */
}