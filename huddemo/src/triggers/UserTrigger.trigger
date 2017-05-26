trigger UserTrigger on User (after insert) {
	
	UserTriggerHelper helper = new UserTriggerHelper(Trigger.new,Trigger.newMap,Trigger.old,Trigger.oldMap);
	
	if(Trigger.isAfter && (Trigger.isInsert)){
		helper.CreateAccountSharingForPortalUsers();
	}
    
}