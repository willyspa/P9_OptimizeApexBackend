@isTest
public with sharing class TestDataFactory_TEST {
	//Create data using the data factory
    @TestSetup
    static void makeData(){
        
        List<Account> accts = TestDataFactory.createAccounts(1);
        insert accts;
        
		List<Contract> ctrs = TestDataFactory.createContracts(1,accts[0]);
		insert ctrs;
        
        System.debug('Number of pricebook: '+[select id from Pricebook2 where isStandard=true].size());
        Order order = TestDataFactory.createOrders(1, accts[0], Test.getStandardPricebookId(),null)[0];
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
    //check if the right number of data was inserted in the database
    @isTest
    static void testData(){
        
        Test.startTest();
        
        System.debug([SELECT Id FROM Account].size());
        System.AssertEquals(1,[SELECT Id FROM Account].size());        
        System.AssertEquals(1,[SELECT Id FROM Order].size());        
        System.AssertEquals(1,[SELECT Id FROM PriceBook2].size());
        System.AssertEquals(2,[SELECT Id FROM Product2].size());        
        System.AssertEquals(2,[SELECT Id FROM PriceBookEntry].size());
        System.AssertEquals(2,[SELECT Id FROM PriceBookEntry].size());
        
        Test.stopTest();
		
    }
}