@isTest
public with sharing class TestDataFactory_TEST {
	
    @TestSetup
    static void makeData(){
        Account acct = TestDataFactory.createAccounts(1)[0];
        insert acct;
        Contract ctr = TestDataFactory.createContracts(1,acct.Id)[0];
        insert ctr;
        System.debug('Number of pricebook: '+[select id from Pricebook2 where isStandard=true].size());
        Order order = TestDataFactory.createOrders(1, acct.Id, ctr, Test.getStandardPricebookId())[0];
        insert order;
        Pricebook2 book = TestDataFactory.createPricebook2(1)[0];
        insert book;
        List<Product2> products = TestDataFactory.createProduct2(2);
        insert products;
        List<PriceBookEntry> bookEntries = TestDataFactory.createPriceBookEntry(Test.getStandardPricebookId(),products);
        insert bookEntries;
        List<OrderItem> orderItems = TestDataFactory.createOrderItems(order.Id,bookEntries);
        insert orderItems;
    }
    
    @isTest
    static void testData(){
        System.debug([SELECT Id FROM Account].size());
        System.AssertEquals(1,[SELECT Id FROM Account].size());
        System.AssertEquals(1,[SELECT Id FROM Contract].size());
        System.AssertEquals(1,[SELECT Id FROM Order].size());
        System.AssertEquals(1,[SELECT Id FROM PriceBook2].size());
        System.AssertEquals(2,[SELECT Id FROM Product2].size());
        System.AssertEquals(2,[SELECT Id FROM PriceBookEntry].size());
        System.AssertEquals(2,[SELECT Id FROM PriceBookEntry].size());        
    }
}