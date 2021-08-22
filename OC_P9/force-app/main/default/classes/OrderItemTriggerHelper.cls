public with sharing class OrderItemTriggerHelper {
    
    public static void orderUpdate(List<OrderItem> orderItems) {
		System.debug('helper');
        Set<Id> orderIds = new Set<Id>();
        List<Order> orders = new List<Order>();
        List<OrderItem> relatedOrderItems = new List<OrderItem>();
        Map<Id,List<OrderItem>> orderIdsXOrderItem = new Map<Id,List<OrderItem>>();
        Map<Id,Double> orderIdsXTotalAmount = new Map<Id,Double>();
        Map<Id,Order> orderIdsXOrders = new Map<Id,Order>();

        for(OrderItem item:orderItems){
           orderIds.add(item.OrderId);
           orderIdsXTotalAmount.put(item.OrderId,0);
        }

        orders = [SELECT Id, TotalAmount FROM Order WHERE Id IN :orderIds];
        relatedOrderItems = [SELECT Id, TotalPrice FROM OrderItem WHERE OrderId IN :orderIds];

			
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
}