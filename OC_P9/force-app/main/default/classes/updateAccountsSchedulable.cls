global class UpdateAccountsSchedulable implements schedulable {
   		
     global void execute(SchedulableContext ctx) {  
        UpdateAccountsBatchable uAb = new UpdateAccountsBatchable();
		Database.executeBatch(uAb, 200);
    }	
}