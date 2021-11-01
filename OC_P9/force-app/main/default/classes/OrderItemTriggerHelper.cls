public with sharing class OrderItemTriggerHelper {
    //Update the total Amount of the related Order
    public static void totalAmountUpdate(List<OrderItem> orderItems) {
	
        Set<Id> orderIds = new Set<Id>();
        List<Order> orders = new List<Order>();
        List<OrderItem> relatedOrderItems = new List<OrderItem>();
        Map<Id,Double> orderIdsXTotalAmount = new Map<Id,Double>();
		//Create an id Set with the Trigger.New List and a Map with each Order related to his TotalAmount
        for(OrderItem item:orderItems){
           orderIds.add(item.OrderId);
           orderIdsXTotalAmount.put(item.OrderId,0);
        }
		
        orders = [SELECT Id, TotalAmount FROM Order WHERE Id IN :orderIds];
        relatedOrderItems = [SELECT Id, TotalPrice, OrderId FROM OrderItem WHERE OrderId IN :orderIds];
		 //Sum the total price and associate it to the right order
         for(OrderItem item:relatedOrderItems){
            
                orderIdsXTotalAmount.put(item.OrderId,orderIdsXTotalAmount.get(item.OrderId)+item.Totalprice);
				System.debug('total amount:'+orderIdsXTotalAmount.get(item.OrderId));
             	System.debug('total price:'+ item.TotalPrice);
         }

         for(Order order:orders){
            order.TotalAmount__c = orderIdsXTotalAmount.get(order.Id);
         }

         update orders;

    }
    /*
	//Substract to the Order total Amount any delete of order Item
    public static void totalAmountDelete(List<OrderItem> orderItems){

        Set<Id> orderIds = new Set<Id>();
        List<Order> orders = new List<Order>();
        Map<Id, Double> orderIdsXOrderItem = new Map<Id, Double>();
		//Sum the total of the deleted orderItems and associate it to the related Order
        for(OrderItem item:orderItems){
            orderIds.add(item.OrderId);
            orderIdsXOrderItem.put(item.OrderId,item.TotalPrice);
         }
		 
         orders = [SELECT Id, TotalAmount__c FROM Order WHERE Id IN :orderIds];
		 //Calculate the Amount to remove from the order total price
         for(Order order:orders){
             order.TotalAmount__c = order.TotalAmount__c - orderIdsXOrderItem.get(order.Id);
         }

         update orders;
    }  */
}