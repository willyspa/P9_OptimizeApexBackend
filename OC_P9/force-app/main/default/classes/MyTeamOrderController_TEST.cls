@isTest
public with sharing class MyTeamOrderController_TEST {
	
	Map<String,List<Order>> ownerXOrders = new Map<String,List<Order>>();   
    
    @TestSetup
    static void makeData(){
        
        List<Account> accts = TestDataFactory.createAccounts(1);
        insert accts;
        
        System.debug('Number of pricebook: '+[select id from Pricebook2 where isStandard=true].size());
        Order order = TestDataFactory.createOrders(1, accts[0], Test.getStandardPricebookId())[0];
        insert order;
        
        Pricebook2 book = TestDataFactory.createPricebook2(1)[0];
        insert book;
        List<Product2> products = TestDataFactory.createProduct2(2);
        insert products;
        
        List<PriceBookEntry> bookEntries = TestDataFactory.createPriceBookEntry(Test.getStandardPricebookId(),products);
        insert bookEntries;
        
        List<OrderItem> orderItems = TestDataFactory.createOrderItems(order.Id,bookEntries);
        insert orderItems;
        
        order.Status = 'ordered';
        update order;
    }
    
    @isTest
    static void testData(){			
		System.assertEquals(1,MyTeamOrdersController.getOrders().size());         
    }
}