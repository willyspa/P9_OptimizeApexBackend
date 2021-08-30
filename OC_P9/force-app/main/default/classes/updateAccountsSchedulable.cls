global class updateAccountsSchedulable implements Schedulable {

    global void execute(SchedulableContext SC){
        UpdateAccountsBatchable uAb = new UpdateAccountsBatchable();
        Database.executeBatch(uAb, 200);
    }
}