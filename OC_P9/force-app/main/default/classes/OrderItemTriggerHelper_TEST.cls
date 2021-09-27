@isTest
public with sharing class OrderItemTriggerHelper_TEST {
    
    @TestSetup
    static void makeData(){
        Account acct = TestDataFactory.createAccounts(1)[0];
        insert acct;
        List<Order> orders = TestDataFactory.createOrders(1, acct, Test.getStandardPricebookId());
        insert orders;
        Pricebook2 book = TestDataFactory.createPricebook2(1)[0];
        insert book;
        List<Product2> products = TestDataFactory.createProduct2(2);
        insert products;
        List<PriceBookEntry> bookEntries = TestDataFactory.createPriceBookEntry(Test.getStandardPricebookId(),products);
        insert bookEntries;
        List<OrderItem> orderItems = TestDataFactory.createOrderItems(orders[0].Id,bookEntries);
        insert orderItems;
    }
    
    @isTest
    static void testData(){
        
        System.AssertEquals(2,[SELECT Id FROM OrderItem].size());        
        System.AssertEquals(9000,[SELECT NetAmount__c FROM Order][0].NetAmount__c);
        
        delete [SELECT Id FROM OrderItem][0];
        
        System.AssertEquals(1,[SELECT Id FROM OrderItem].size()); 
        System.AssertEquals(4000,[SELECT NetAmount__c FROM Order][0].NetAmount__c);
    }
        

}