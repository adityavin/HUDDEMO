public class AccountTriggerHelper { 	
     private List<Account> newItems;
     private Map<Id,Account> newMap;    
     private List<Account> oldItems;
     private Map<Id,Account> oldMap;
     
     public AccountTriggerHelper(List<Account> newItems,Map<Id,Account> newMap, List<Account> oldItems, Map<Id,Account> oldMap){
         this.newItems = newItems;
         this.newMap = newMap;
         this.oldItems = oldItems;
         this.oldMap = oldMap;
     }
     
     /*Handles the creation of account sharing rules for the users belonging to PHA. 
       Identifies the account's PHA Id. Creates a map of PHA Id and list of new accounts.
       Creates a map of PHA Id and a list of user ids. Use the above two maps to create the sharing rules*/
     public void CreateAccountSharingForPortalAccountUsers(){     	
		 Map<String,Set<String>> mapPartnertoAccountIds = new Map<String, Set<String>>(); 
		 for(Account curAct : newItems){
			Set<String> lsPHA = mapPartnertoAccountIds.get(curAct.Parent_PHA_Id__c);
			if(lsPHA !=null){
				lsPHA.add(curAct.Id);
			}
			else{
				mapPartnertoAccountIds.put(curAct.Parent_PHA_Id__c, new Set<String>{curAct.Id});	
			}
		 }   
		 
		 if(mapPartnertoAccountIds.size() > 0)
		 	CreateMapsForAccountShareCreation(mapPartnertoAccountIds);
     }
     
    /*Handles the creation of account sharing rules for the users belonging to PHA. 
      Identifies the account's PHA Id. Creates a map of PHA Id and list of new accounts if the account's PHA has been updated.
       Creates a map of PHA Id and a list of user ids. Use the above two maps to create the sharing rules       
       Delete the existing shares*/
       
	public void UpdateAccountSharingForPortalAccountUsers(){     	
		 Map<String,Set<String>> mapPartnertoAccountIds = new Map<String, Set<String>>(); 
		 Set<Id> IdsOfAccountSharesToBeDeleted = new Set<Id>(); 
		 for(Account curAct : newItems){
		 	String newParentPHAId = curAct.Parent_PHA_Id__c;
		 	String oldParentPHAId = oldMap.get(curAct.Id).Parent_PHA_Id__c;		 	
		 	if(oldParentPHAId != newParentPHAId){			 		
		 		IdsOfAccountSharesToBeDeleted.add(curAct.Id);	 	
				Set<String> lsPHA = mapPartnertoAccountIds.get(curAct.Parent_PHA_Id__c);
				if(lsPHA !=null){
					lsPHA.add(curAct.Id);
				}
				else{
					mapPartnertoAccountIds.put(curAct.Parent_PHA_Id__c, new Set<String>{curAct.Id});	
				}
		 	}
		 }   
		 
		 if(IdsOfAccountSharesToBeDeleted.size() > 0){		
	        List<AccountShare> lsDeleteShare = [SELECT Id, AccountId, UserorGroupId from AccountShare WHERE AccountId in : IdsOfAccountSharesToBeDeleted];
	        if(lsDeleteShare != null){
	            if(lsDeleteShare.size() > 0){
	                 Database.Delete(lsDeleteShare, false);           
	            } 		
		 	}
		 }
		 
		 if(mapPartnertoAccountIds.size() > 0)
		 	CreateMapsForAccountShareCreation(mapPartnertoAccountIds);
     }
     
     
     
     
     public void CreateMapsForAccountShareCreation(Map<String,Set<String>> mapAccount){
     	Map<string, Set<String>> mapAccountToPartnerUsers = new Map<String, Set<String>>();                
     	for(User curUser : [SELECT Contact.AccountId,Id FROM User WHERE isActive = true AND IsPortalEnabled = true AND Contact.AccountId IN : mapAccount.keyset()]){
     		Set<String> setPHAs = new Set<String>();
     		String currentPartnerAccountId =  String.valueOf(curUser.Contact.AccountId).substring(0, 15);
     		setPHAs = mapAccountToPartnerUsers.get(currentPartnerAccountId);
			if(setPHAs !=null){
				setPHAs.add(curUser.Id);
			}
			else{
				mapAccountToPartnerUsers.put(currentPartnerAccountId, new Set<String>{curUser.Id});
			}
     	}
    	 PortalUserAccountSharingHelper.CreateAccountShares(mapAccount, mapAccountToPartnerUsers);     		 
    }
 }