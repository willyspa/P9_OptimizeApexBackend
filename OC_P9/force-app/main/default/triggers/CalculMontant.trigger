trigger CalculMontant on Order (before update) {
	
	Order newOrder= trigger.new[0];
	newOrder.NetAmount = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}