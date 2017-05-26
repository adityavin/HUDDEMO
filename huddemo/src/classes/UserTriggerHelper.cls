public class UserTriggerHelper {
	
	private List<User> newItems;
    private Map<Id,User> newMap;    
    private List<User> oldItems;
    private Map<Id,User> oldMap;
    
    public UserTriggerHelper(List<User> newItems,Map<Id,User> newMap, List<User> oldItems, Map<Id,User> oldMap){
        this.newItems = newItems;
        this.newMap = newMap;
        this.oldItems = oldItems;
        this.oldMap = oldMap;
    }
    
    public void CreateAccountSharingForPortalUsers(){
    	
        List<Id> lsUserFeed = new list<Id>();
        for(User currentUser : newItems){
        		lsUserFeed.add(currentUser.Id);
        }        
        
        CreateMapsForAccountShareCreation(lsUserFeed);
    }
    
    @future
    public static void CreateMapsForAccountShareCreation(List<Id> lsUserFeed){
    	Map<String, Set<String>> mapAccountToPartnerUsers = new Map<String, Set<String>>();
 
		for(user currentUser : [SELECT Contact.AccountId,Id FROM User WHERE Id in : lsUserFeed AND isActive = true AND IsPortalEnabled = true]){
			Set<String> setPartnerUsers = new Set<String>();
		 	String currentPartnerAccountId =  String.valueOf(currentUser.Contact.AccountId).substring(0, 15);
		 	
		 	if(currentPartnerAccountId != null){
		 		setPartnerUsers = mapAccountToPartnerUsers.get(currentPartnerAccountId);
		 		if(setPartnerUsers != null){
			 		setPartnerUsers.add(currentUser.Id);
		 		}
		 		else{
		 			mapAccountToPartnerUsers.put(currentPartnerAccountId, new Set<String>{currentUser.Id});
		 		}
		 	}
		 }
		 
		 System.Debug(mapAccountToPartnerUsers);
		 System.Debug(mapAccountToPartnerUsers.keyset());
		 
		 List<Account> lsAccountdelete = [SELECT Id, Name, Parent_PHA_Id__c FROM Account WHERE Parent_PHA_Id__c  IN : mapAccountToPartnerUsers.keyset()];
		 
		 Map<String, Set<String>> mapPartnerAccountToBuildings = new Map<String, Set<String>>();
		 
		 for(Account currentAccount :  [SELECT Id, Name, Parent_PHA_Id__c FROM Account WHERE Parent_PHA_Id__c  IN : mapAccountToPartnerUsers.keyset()]){
		 	Set<String> setBuildingsAndUnits = new Set<String>();
		 	setBuildingsAndUnits = mapPartnerAccountToBuildings.get(currentAccount.Parent_PHA_Id__c);
		 	if(setBuildingsAndUnits !=null){
		 		setBuildingsAndUnits.add(currentAccount.Id);
		 	}
		 	else{
		 		mapPartnerAccountToBuildings.put(currentAccount.Parent_PHA_Id__c, new Set<String>{currentAccount.Id});
		 	}
		 }
		 
		 PortalUserAccountSharingHelper.CreateAccountShares(mapPartnerAccountToBuildings, mapAccountToPartnerUsers);
		 
   }
		    
}