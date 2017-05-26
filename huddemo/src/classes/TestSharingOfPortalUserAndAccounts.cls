@isTest(SeeAllData=false)
public class TestSharingOfPortalUserAndAccounts {
    public static Account createTestAccount() {    	
        Account acc = null;
        try {
         acc = [SELECT id,name from Account where name= 'test'];
        }
        catch(Exception e){
                        
        }
        if(acc == null){
             //Create portal account owner
			UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
			Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
			User portalAccountOwner = new User(
				UserRoleId = portalRole.Id,
				ProfileId = profile1.Id,
				Username = System.now().millisecond() + 'test2@test.com',
			   	Alias = 'batman',
				Email='bruce.wayne@wayneenterprises.com',
				EmailEncodingKey='UTF-8',
				Firstname='Bruce',
				Lastname='Wayne',
				LanguageLocaleKey='en_US',
				LocaleSidKey='en_US',
				TimeZoneSidKey='America/Chicago'
			);
			  Database.insert(portalAccountOwner);
			
              acc = new Account();
              acc.NAME = 'test';              
              acc.OwnerId = portalAccountOwner.Id;                  
              insert acc;
              
              Account childAcc = new Account();
              childAcc.Name = 'building 1';
              childAcc.Parent = acc;
              childAcc.OwnerId = portalAccountOwner.Id;
              insert childAcc;
             
      
        }
        return acc;
    }
    

    public static User CreatePortalUser(String userId){
	String uname= userId;
	if(uname.contains('@') == false) {
		uname+='@noemail.com';
	}
	
	Id profileId = [select id from profile where name='PHA Inspector'].id;
	Account ac = createTestAccount();      
	Contact con = new Contact(LastName ='testCon',AccountId = ac.Id);
	insert con;  

	User user = new User(alias = 'test123', email=uname,
				     emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
				     localesidkey='en_US', profileid = profileId ,  IsActive =true,
				     ContactId = con.Id,
				     timezonesidkey='America/Los_Angeles', username=uname);

	System.debug('About to create portal user');
	insert user;
	return user;
           
	}
     @isTest
     public static void CreatePortalUser(){
       User newUser = CreatePortalUser('port');
     }

 
    
}