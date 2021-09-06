@isTest
public with sharing class UpdateAccounts_TEST {
    
    @TestSetup
    static void makeData(){
        List<Account> accts = TestDataFactory.createAccounts(2);
        insert accts;
        Contract ctr = TestDataFactory.createContracts(1,accts[0].Id)[0];
        insert ctr;
        Contract ctr2 = TestDataFactory.createContracts(1,accts[1].Id)[0];
        insert ctr2;
        List<Order> orders = TestDataFactory.createOrders(2, accts[0].Id,ctr,Test.getStandardPricebookId());
        insert orders;
        List<Order> orders2 = TestDataFactory.createOrders(1, accts[1].Id,ctr2,Test.getStandardPricebookId());
        insert orders2;
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
        List<OrderItem> orderItems2 = TestDataFactory.createOrderItems(orders2[0].Id,bookEntries);
        insert orderItems2;       
    }
    @isTest
    static void testData(){
        
        List<Order> orders = [SELECT Id,TotalAmount__c ,Status FROM Order];
        Integer count = 0;
        for(Order o:orders){
            if(count<3){
                o.TotalAmount__c = 3000;
                o.Status = 'ordered';
            }               
			count++;
        }       
        
        update orders;
        
        UpdateAccountsBatchable uAb = new UpdateAccountsBatchable();
        Database.executeBatch(uAb, 200);
        
        System.AssertEquals(3,[SELECT Id FROM Order].size());
        System.AssertEquals(6000,[SELECT Id,turnover__c FROM Account LIMIT 1].turnover__c);        
    }
}