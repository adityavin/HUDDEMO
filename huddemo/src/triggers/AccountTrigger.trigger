trigger AccountTrigger on Account (after insert, after update) {    
    AccountTriggerHelper helper = new AccountTriggerHelper(Trigger.new,Trigger.newMap,Trigger.old,Trigger.oldMap);
	
	if(Trigger.isAfter && (Trigger.isInsert)){
		helper.CreateAccountSharingForPortalAccountUsers();
	}
    
    	if(Trigger.isAfter && (Trigger.isUpdate)){
		helper.UpdateAccountSharingForPortalAccountUsers();
	}
    
}