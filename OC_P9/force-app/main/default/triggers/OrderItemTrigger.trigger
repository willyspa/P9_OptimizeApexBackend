trigger OrderItemTrigger on OrderItem (after insert,after update,after delete) {

    if(Trigger.isAfter || Trigger.isUpdate){
        OrderItemTriggerHelper.orderUpdate(Trigger.new);
    }
    if(Trigger.isDelete){
        
    }

}