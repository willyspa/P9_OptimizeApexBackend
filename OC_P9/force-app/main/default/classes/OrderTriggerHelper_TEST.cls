@isTest
public with sharing class OrderTriggerHelper_TEST {
    //Create data using the data factory
    @TestSetup
    static void makeData(){
        Account acct = TestDataFactory.createAccounts(1)[0];
        insert acct;
        List<Order> orders = TestDataFactory.createOrders(2, acct, Test.getStandardPricebookId(),null);
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
    //Create data using the data factory
    @isTest
    static void testData(){
        
        Test.startTest();
        
        List<Order> orders = [SELECT Id,TotalAmount__c ,Status FROM Order];
        
        orders[1].TotalAmount__c  = 10000; 
        orders[0].TotalAmount__c  = 10000;        
        orders[1].Status = 'draft';
        orders[0].Status = 'ordered';
        
        update orders;
        //Check the number of Orders in the database
        System.AssertEquals(2,[SELECT Id FROM Order].size());
        //Only one order order is validated to the status ordered
        //therefore the turnover of the related Account must be set to 10 000
        System.AssertEquals(10000,[SELECT Id,turnover__c FROM Account LIMIT 1].turnover__c);
		
		Test.stopTest();        
    }
}