trigger OrderTrigger on Order (after insert, after update, after delete) {

    if(Trigger.isUpdate && Trigger.isAfter){
        OrderTriggerHelper.UpdateAccountCA(Trigger.New,Trigger.oldMap);
    }
    /*
    if(Trigger.isInsert&& Trigger.isAfter){
        OrderTriggerHelper.UpdateAccountCAOnInsert(Trigger.New);
    }
    if(Trigger.isDelete){
        OrderTriggerHelper.UpdateAccountCAOnDelete(Trigger.old);
    }
    */
}