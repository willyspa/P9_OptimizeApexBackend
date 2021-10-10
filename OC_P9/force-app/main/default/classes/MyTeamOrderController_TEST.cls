@isTest
public with sharing class MyTeamOrderController_TEST {
    @TestSetup
    static void makeData(){
        
        List<Account> accts = TestDataFactory.createAccounts(1);
        insert accts;
        
        Order order = TestDataFactory.createOrders(4, accts[0], Test.getStandardPricebookId())[0];
        insert order;            
    }
    @isTest
    static void testData(){

        System.AssertEquals(1,[SELECT Id FROM Account].size());        
        System.AssertEquals(4,[SELECT Id FROM Order].size());        
    
    }
}





