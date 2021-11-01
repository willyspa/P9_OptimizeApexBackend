@isTest
public with sharing class UpdateAccounts_TEST {
    //Create data for the test
    @TestSetup
    static void makeData(){
        
        List<Account> accts = TestDataFactory.createAccounts(2);
        insert accts;
        List<Contract> ctrs = TestDataFactory.createContracts(1,Accts[0]);
        insert ctrs;
        Contract contract = ctrs[0];
        contract.Status  = 'Activated';
        update contract;
        List<Order> orders = TestDataFactory.createOrders(300, accts[0],Test.getStandardPricebookId(),ctrs[0]);
        insert orders;
        Pricebook2 book = TestDataFactory.createPricebook2(1)[0];
        insert book;
        List<Product2> products = TestDataFactory.createProduct2(2);
        insert products;
        List<PriceBookEntry> bookEntries = TestDataFactory.createPriceBookEntry(Test.getStandardPricebookId(),products);
        insert bookEntries;
              
        List<OrderItem> orderItems= new List<OrderItem>();
        for(Integer i=0; i<orders.size();i++){
            orderItems.addAll(TestDataFactory.createOrderItems(orders[i].Id,bookEntries));
        }
        insert orderItems;
        
    }
    @isTest
    static void testData(){
        
        Test.startTest();
        
        List<Order> orders = [SELECT Id,TotalAmount__c ,Status FROM Order];
        
        for(Order o:orders){
                o.Status = 'ordered';              
        }       
        
        update orders;
        
        UpdateAccountsBatchable uAb = new UpdateAccountsBatchable();
        Database.executeBatch(uAb, 200);
        //Check if the right number of Order was inserted in the database
        System.AssertEquals(300,[SELECT Id FROM Order].size());
        //Check if the related account turnover was updated accordingly
        System.AssertEquals(3000000,[SELECT Id,turnover__c FROM Account LIMIT 1].turnover__c);
        
        Test.stopTest();
    }
}