public class ContactsByAccount_extension {

  Map<String, List<Order>> ordersByOwner = new Map<String, List<Order>>();

  public Map<String, List<Order>> getOrders() {
    List<Order> orders = [SELECT Owner.Name,Id,Status,AccountId FROM Order WHERE status = 'ordered'];
      
    for(Order o :orders){
    	ordersByOwner.put(o.Owner.Name,orders);
    }
    return ordersByOwner;
  }

}