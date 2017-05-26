public with sharing class AccountLookupController2 {
    public List<Account> accList {get;set;}
    public String accName{get; set;}
    public Id LicenseValue{get; set;}
    public Account accObj{get; set;}
    public Boolean error{get; set;}
    public String accNameFieldId{get; set;}
    public String accHiddenFieldId{get; set;}
    
      public AccountLookupController2(ApexPages.StandardController controller) {  
      //public AccountLookup(){
         error = false;
         //accObj = (Account)controller.getRecord();
         accObj = new Account();
         accName = ApexPages.currentPage().getParameters().get('accName');
         accNameFieldId = ApexPages.currentPage().getParameters().get('accNameFieldId');
         accHiddenFieldId = ApexPages.currentPage().getParameters().get('accHiddenField');
         
         if(String.isNotBlank(accName)){
            if(Schema.Sobjecttype.Account.isAccessible()){ 
                
                 accList = [
                     SELECT Id, Name
                     FROM Account
                     WHERE (ExAM__Create_Survey__c=null OR ExAM__Create_Survey__c=false) AND (ExAM__Main_Questionnaire_Template__c=NULL) AND Name =: accName LIMIT 100
                 ];
                 
                 if(accList.size() == 0 && accName.length() > 0){
                     accList = [
                         SELECT Id, Name
                         FROM Account
                         WHERE (ExAM__Create_Survey__c=null OR ExAM__Create_Survey__c=false) AND (ExAM__Main_Questionnaire_Template__c=NULL) AND Name LIKE:  '%'+ accName +'%' LIMIT 100
                     ];
                 }                 
                
            }
                             
         }else{
              accList = [SELECT Id, Name FROM Account WHERE (ExAM__Create_Survey__c=null OR ExAM__Create_Survey__c=false) AND (ExAM__Main_Questionnaire_Template__c=NULL)  LIMIT 100];
              
         }
    }
    /*public PageReference consAction(){
        if(accList.size() == 0){
            String strCmpName;
            if(String.isNotBlank(strCmpName)){  
                Account newAccount = new Account();

                newAccount.Name = strCmpName;
                insert newAccount; 
                searchUsers();                 
            }
            
         }
         return NULL;
    }*/
    public PageReference searchUsers(){
        if(accName != NULL && accName != ''){
            if(Schema.Sobjecttype.User.isAccessible()){
                accList = [
                     SELECT Id, Name
                     FROM Account WHERE (ExAM__Create_Survey__c=null OR ExAM__Create_Survey__c=false) AND (ExAM__Main_Questionnaire_Template__c=NULL) AND Name =: accName LIMIT 100
                 ];
                 
                 if(accList.size() == 0 && accName.length() > 0){
                     accList = [
                         SELECT Id, Name
                         FROM Account
                         WHERE (ExAM__Create_Survey__c=null OR ExAM__Create_Survey__c=false) AND (ExAM__Main_Questionnaire_Template__c=NULL) AND Name LIKE:  '%'+ accName +'%' LIMIT 100
                     ];
                 }
            }
        }else{
            if(Schema.Sobjecttype.User.isAccessible()){
                accList = [SELECT Id, Name FROM Account WHERE (ExAM__Create_Survey__c=null OR ExAM__Create_Survey__c=false) AND (ExAM__Main_Questionnaire_Template__c=NULL) order by name LIMIT 100]; 
            }
        }
        
        return NULL;
    }
    
    /*public PageReference addAccount(){
        Account newAccount = new Account();
        if(String.isNotBlank(accName)){  
                                                
            String strCmpName; 
            if(String.isNotBlank(strCmpName)){  
                newAccount.Name = strCmpName;   

            }else{                         
                newAccount.Name = accName;  
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,accName+' is not valid ticker.'));
                //return NULL;
            }
            insert newAccount;
        }        
        return NULL;
    }*/
    
}