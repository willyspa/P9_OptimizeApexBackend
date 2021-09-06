public class TestDataFactory {
    
    public static List<Account> createAccounts(Integer numAccts) {
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            
            Account acc = new Account();
            acc.Name = 'Test Account' + i;
            acc.BillingStreet = 'rue de paris';
            acc.BillingPostalCode = '77144';
            acc.BillingCity = 'Paris';
            accts.add(acc);
        }
        
        return accts;
    }
    
    public static List<Contract> createContracts(Integer numCtrs,Id acct) {
        
        List<Contract> ctrs = new List<Contract>();
        
        for(Integer i=0;i<numCtrs;i++) {
            
            Contract contract = New Contract(AccountId = acct,
                                            ContractTerm = i+1, 
                                            Status = 'Draft',
                                            StartDate = system.today()+1);
                                            
            ctrs.add(contract);
        }
        
        return ctrs;
    }

    public static List<Order> createOrders(Integer numOrders,Id acct,Contract ctr,Id pricebookId) {
        
        List<Order> orders = new List<Order>();
        ctr.Status  = 'Activated';
        update ctr;
        
        for(Integer i=0;i<numOrders;i++) {
            
            Order order = New Order(AccountId = acct,
                                    ContractId = ctr.Id,
                                    EffectiveDate = system.today()+2,
                                    Status='Draft',
                                    ShipmentCost__c= 1000,
                                   	Pricebook2Id = pricebookId);

                                            
            orders.add(order);
        }
        
        return orders;
    }
    public static List<Pricebook2> createPricebook2(Integer numBooks) {

        List<Pricebook2> priceBooks = new List<Pricebook2>();
        
        for(Integer i=0;i<numBooks;i++) {
            
            Pricebook2 book = New Pricebook2(Name = 'book test',
                                    	     isActive = true);
                                            
            PriceBooks.add(book);
        }
        
        return PriceBooks;
    }

    public static List<Product2> createProduct2(Integer numProducts) {

        List<Product2> products = new List<Product2>();

        for(Integer i=0;i<numProducts;i++) {
            
            Product2 product = New Product2(Name = 'test product '+i,
                                            isActive = true);
            
            products.add(product);
        }
        
        return products;
    }
    public static List<PriceBookEntry> createPriceBookEntry(Id Book,List<Product2> products) {

        List<PriceBookEntry> bookEntries = new List<PriceBookEntry>();
		Set<Id> productIds = new Set<Id>();
        
        for(Product2 p:products){
        	productIds.add(p.Id); 	   
        }
        
        for(Integer i=0;i<products.size();i++) {
            
            PriceBookEntry bookEntry = New PriceBookEntry(Pricebook2Id = Book,
                                                          UnitPrice = 3000.00,
                                            			  Product2Id  = products[i].Id,
                                                          UseStandardPrice = false,
                                            		      isActive = true);                                           
            bookEntries.add(bookEntry);
        }
        
        return bookEntries;
    }
    
    public static List<OrderItem> createOrderItems(Id order,List<PriceBookEntry> pbes) {

        List<OrderItem> orderItems = new List<OrderItem>();    

        for(Integer i=0;i<pbes.size();i++) {
            
            OrderItem orderItem = New OrderItem(Product2Id = pbes[i].Product2Id ,
                                    			OrderId = order,
                                    			Quantity  = 1,
                                    			UnitPrice  = 5000,
                                                PricebookEntryId =pbes[i].Id);                                            
            orderItems.add(orderItem);
        }
        
        return orderItems;
    }
    
    

    
}