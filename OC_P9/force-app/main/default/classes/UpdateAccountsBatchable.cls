public  class UpdateAccountsBatchable implements Database.batchable<sObject>, Database.Stateful{

    public static Set<String> setRomes = new Set<String>();
    List<String> romesList = new List<String>();

    public Database.QueryLocator start(Database.BatchableContext bc) {
        romesList = new List<String>();
        String query = 'SELECT Id,Name FROM CodeRome__c ORDER BY Name';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, list<CodeRome__c> scope){
        
        system.debug('scope = ' +  scope);
        system.debug('setRomes = ' + setRomes);
        String parameters;
        List<String> codeRomes = new List<String>();

        for(CodeRome__c cr:scope){
          codeRomes.add(cr.Name);
        }
        parameters = String.join(codeRomes,',');
        FillFormation.getFormation(parameters);
    }


    public void finish(Database.BatchableContext BC){
        
    }
    /*
    public String parametersWS (String origin, String param) {
        System.debug('origin = ' + origin);
        System.debug('param = ' + param);
        if (origin == null)
            return param;
        else {
            return origin + ',' + param;
        }
    }
    */


}

    

