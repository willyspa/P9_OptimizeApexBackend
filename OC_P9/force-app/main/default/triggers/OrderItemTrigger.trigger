trigger OrderItemTrigger on OrderItem (after insert,after update,after delete) {

    if(Trigger.isInsert || Trigger.isUpdate){
        OrderItemTriggerHelper.totalAmountUpdate(Trigger.new);
    }
    if(Trigger.isDelete){
       OrderItemTriggerHelper.totalAmountDelete(Trigger.old); 
    }

}