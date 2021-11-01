global  class UpdateAccountsBatchable implements Database.batchable<sObject>, Database.Stateful{
/*	
    global void execute(SchedulableContext sc) {
        Database.executeBatch(this, 200); 
	}
*/    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, Turnover__c FROM Account ORDER BY Name';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, list<Account> scope){       
        system.debug('scope = ' + scope);       
        UpdateAccounts.turnover(scope);
    }

    public void finish(Database.BatchableContext BC){
       
    }


}