public without sharing class MyTeamOrdersController {
    
    public List<Order> getOrders() {
        
    List<Order> results = Database.query(
        'SELECT Id,Status,OwnerId,EffectiveDate,AccountId ' +
        'FROM Order ' +
        'ORDER BY OwnerId ASC ');
    
        return results;
	}
}