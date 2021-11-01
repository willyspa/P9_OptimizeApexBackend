@isTest
public class UpdateAccountsSchedulable_TEST {
    
    @isTest
    public static void testSchedule(){
        
	Test.startTest();
    
    UpdateAccountsSchedulable scheduleUpdateAcct = new UpdateAccountsSchedulable();
    //Cron expression set to every day at noon
    String sch = '0 0 12 * * ?';
    Id jobId = System.schedule('Update Account Weekly', sch, scheduleUpdateAcct);
    CronTrigger ct = [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId];
    //Check if the cron expression is correct
    System.assertEquals('0 0 12 * * ?', String.valueOf(ct.CronExpression));
	        
    Test.stopTest();
        
    }

}