public class MyTeamOrdersController {
    
  Map<String, List<Order>> ordersByOwner = new Map<String,List<Order>>();
  List<Order> relatedOrders = new List<Order>();
    
  public Map<String, List<Order>> getOrders() {
    List<Order> orders = [SELECT Owner.Name,Id,Status,AccountId FROM Order WHERE status = 'ordered'];
    
    for(Order o :orders){      
    	ordersByOwner.put(o.Owner.Name,new List<Order>());
    }
    for(Order o :orders){      
    	ordersByOwner.get(o.Owner.Name).add(o);
    } 
      
    return ordersByOwner;
  }
}