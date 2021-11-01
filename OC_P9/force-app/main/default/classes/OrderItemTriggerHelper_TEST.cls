@isTest
public with sharing class OrderItemTriggerHelper_TEST {
    //Create data using the data factory
    @TestSetup
    static void makeData(){
        Account acct = TestDataFactory.createAccounts(1)[0];
        insert acct;
        List<Order> orders = TestDataFactory.createOrders(1, acct, Test.getStandardPricebookId(),null);
        insert orders;
        Pricebook2 book = TestDataFactory.createPricebook2(1)[0];
        insert book;
        List<Product2> products = TestDataFactory.createProduct2(200);
        insert products;
        List<PriceBookEntry> bookEntries = TestDataFactory.createPriceBookEntry(Test.getStandardPricebookId(),products);
        insert bookEntries;
        List<OrderItem> orderItems = TestDataFactory.createOrderItems(orders[0].Id,bookEntries);
        insert orderItems;
    }
    
    @isTest
    static void testData(){
        
        Test.startTest();
        //check if the right number of orderItem was inserted in the database
        System.AssertEquals(200,[SELECT Id FROM OrderItem].size());
        //Net Amount must be set to 9000 => 2 OrderItem at 5000 minus the shipmentCost 1000
        System.AssertEquals(999000,[SELECT NetAmount__c FROM Order][0].NetAmount__c);
        
        delete [SELECT Id FROM OrderItem LIMIT 100];
        
        //check if the right number of data was deleted in the database
        System.AssertEquals(100,[SELECT Id FROM OrderItem].size());
        //Net Amount must be set to 4000 => 1 OrderItem at 5000 minus the shipmentCost 1000
        System.AssertEquals(499000,[SELECT NetAmount__c FROM Order][0].NetAmount__c);
        
        Test.stopTest();
    }
        

}