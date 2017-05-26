public class PortalUserAccountSharingHelper {
	public static void CreateAccountShares(Map<String,Set<String>> mapPartnerAccountToBuildings, Map<String, Set<String>> mapAccountToPartnerUsers){
		List<AccountShare> lsInsertShare = new List<AccountShare>();
		 for(String  partActId : mapPartnerAccountToBuildings.keyset()){
		 	Set<String> setUserList = mapAccountToPartnerUsers.get(partActId);
		 	Set<String> setChildAccounts = mapPartnerAccountToBuildings.get(partActId);
		 	if(setUserList != null && setUserList.size() > 0 && setChildAccounts !=null && setChildAccounts.size() > 0){ 	
				for(String  childAccountId : setChildAccounts){
					 for(String  userId :setUserList){
						 AccountShare accShare = new AccountShare();
						 accShare.AccountId = childAccountId;
						 accShare.UserOrGroupId = userId;              
					     accShare.AccountAccessLevel = 'Read';
					     accShare.OpportunityAccessLevel = 'Read';
					     lsInsertShare.add(accShare);     
					 }
			      }
		 	}
	    }
		 
	   if(lsInsertShare.size() > 0){
          Database.Insert(lsInsertShare, true);           
	   }		
	}    
}