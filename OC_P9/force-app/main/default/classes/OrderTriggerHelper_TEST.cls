@isTest
public with sharing class OrderTriggerHelper_TEST {
    
    @TestSetup
    static void makeData(){
        Account acct = TestDataFactory.createAccounts(1)[0];
        insert acct;
        List<Order> orders = TestDataFactory.createOrders(2, acct, Test.getStandardPricebookId());
        insert orders;
        Pricebook2 book = TestDataFactory.createPricebook2(1)[0];
        insert book;
        List<Product2> products = TestDataFactory.createProduct2(2);
        insert products;
        List<PriceBookEntry> bookEntries = TestDataFactory.createPriceBookEntry(Test.getStandardPricebookId(),products);
        insert bookEntries;
        List<OrderItem> orderItems = TestDataFactory.createOrderItems(orders[0].Id,bookEntries);
        insert orderItems;
        orderItems = TestDataFactory.createOrderItems(orders[1].Id,bookEntries);
        insert orderItems;
        
    }
    
    @isTest
    static void testData(){
        
        List<Order> orders = [SELECT Id,TotalAmount__c ,Status FROM Order];
        
        orders[1].TotalAmount__c  = 10000; 
        orders[0].TotalAmount__c  = 10000;        
        orders[0].Status = 'ordered';
        orders[1].Status = 'draft';
        
        update orders;
        
        System.AssertEquals(2,[SELECT Id FROM Order].size());
        System.AssertEquals(10000,[SELECT Id,turnover__c FROM Account LIMIT 1].turnover__c);        
    }
}