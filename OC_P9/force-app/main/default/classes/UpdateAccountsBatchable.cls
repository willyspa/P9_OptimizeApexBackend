public  class UpdateAccountsBatchable implements Database.batchable<sObject>, Database.Stateful{

    public static Set<String> setRomes = new Set<String>();

    public Database.QueryLocator start(Database.BatchableContext bc) {
        romesList = new List<String>();
        String query = 'SELECT Id, Name, Turnover__c FROM Account ORDER BY Name';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, list<Account> scope){
        
        system.debug('scope = ' + scope);
        
        updateAccounts.turnover(scope);
    }


    public void finish(Database.BatchableContext BC){
       
    }


}

    

