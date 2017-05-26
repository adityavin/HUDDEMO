public with sharing class AssessmentTemplateUIController2
 {
    public String AccName { get; set; }
         
    public String templateId{get;set;}
    public Boolean myFlag{get;set;}
     public Boolean myFlagmulti{get;set;}
    public List<Account> allaccounts=new List<Account>();
    public String selectedAccountId {set;get;}
    public String Accountname{set;get;}
    public List<ExAM__Section_Group__c> groupList { get; set; }
  
    public AssessmentTemplateUIController2(ApexPages.StandardSetController controller) {
            myFlag=false;myFlagmulti=false;
    }
    public AssessmentTemplateUIController2() {
           
    }
    public List<ExAM__Section_Group__c> getsecgrouplist()
    {
    groupList =[Select Id, Name,ExAM__Group_Name__c from ExAM__Section_Group__c order by ExAM__Group_Name__c];
    return groupList;
    }
    
    public ExAM__Section_Group__c grpObj
    {

         get{

                    if(grpObj==null)
                        {
                         grpObj= new ExAM__Section_Group__c ();
                        }
                    return grpObj;

          }

          set;

    }
    public ExAM__Main_questionaire__c templateObj
    {

         get{

                    if(templateObj==null)
                        {
                         templateObj= new ExAM__Main_questionaire__c();
                        }
                    return templateObj;

          }

          set;

    }
   
   public List<SelectOption> AccountList
    {
     
       get
        {
            allaccounts=[SELECT id,name,parentid,ExAM__Create_Survey__c,ExAM__Main_Questionnaire_Template__c From Account where (ExAM__Create_Survey__c=:null OR ExAM__Create_Survey__c=:false) AND (ExAM__Main_Questionnaire_Template__c=:NULL) order by name];
            List<SelectOption> AccountList = new List<SelectOption>();
            AccountList.add(new SelectOption('None','None'));
            for(Account temp : allaccounts)
            {
                AccountList.add(new SelectOption(temp.Id, temp.Name));
            }
            return AccountList;
        }
        set;
    }
    
    /*public AssessmentTemplateUIController(ApexPages.standardController con)
        {
         templateObj=new Main_questionaire__c();
         templateObj=(Main_questionaire__c)con.getRecord();
         System.debug('222values in CONSTRUCTIRes'+templateObj.Template_name__c);
        }*/
 
    public PageReference EditSurvey()
        {
           templateId=System.currentPageReference().getParameters().get('templateid');
           System.debug('assesmmnst wizard:'+templateId);
           
           String urlform='/'+this.templateId;
           PageReference saveClicked=new PageReference(urlform);
           saveClicked.setRedirect(true);
           return saveClicked;
           //return null;
          
        }
     public PageReference save()
        {
        System.debug('!!!!!!!!!!!vales IN SAVE'+templateObj);
        String templateId;
        try
        {
            if(templateObj!=null)
                {                
                //System.debug('2222222222222222!!!!!!!!!!!vales IN SAVE'+templateObj);
                upsert templateObj;
                templateId=templateObj.Id;
                } 
             Account acc=new Account();
             if(Accountname==null)
             {
                 //This is to create a hierarchy whenever a new  template is craeted we create an account object with the same label or label given by user and associate the parent org with this new template name or account name
                 acc.name= templateObj.ExAM__Template_name__c;
             }
             else
             {                
                 acc.name=Accountname;
                 System.debug('--------acc name:'+acc);
             }
             acc.name= templateObj.ExAM__Template_name__c;
             acc.ExAM__Main_Questionnaire_Template__c= templateId;
             
             if((selectedAccountId==null)||(selectedAccountId.equalsIgnoreCase('none')))
             { 
                 System.debug('no parent acc'+acc);
                 upsert acc;
                 
             }
             else
             {
                 for(Account parentAcc: allaccounts)
                 {
                     String parentId=parentAcc.Id;
                     if(parentId.equalsIgnoreCase(selectedAccountId))
                     {
                         System.debug('parentId:='+parentId+',selectedAccountId='+selectedAccountId);
                         acc.parentid=parentId;
                         System.debug('------'+acc+',,,'+parentAcc);
                         upsert acc;
                         break;
                     }
                 }
             }
         } catch(Exception e) {System.debug('error:'+e);}         
        /*PageReference cancelClicked=new PageReference('/apex/AssessmentTemplateUI');
        cancelClicked.setRedirect(true);
        
        return cancelClicked;  */
        String urlform='/';
           if(templateObj.id!=null)
           {
           urlform=urlform+templateObj.id;
           }
           PageReference saveClicked=new PageReference(urlform);
           saveClicked.setRedirect(true);
           return saveClicked;
        }
        
        
        public PageReference saveMulti()
        {
            System.debug('!!!!!!!!!!!vales IN SAVE'+grpObj);
           
            if(grpObj!=null)
            {
               upsert grpObj;
               String urlform='/';
               if(grpObj.id!=null)
               {
               urlform=urlform+grpObj.id;
               }
               PageReference saveClicked=new PageReference(urlform);
               saveClicked.setRedirect(true);
               return saveClicked;
            }
            return null;
        
        
        }
        
     public PageReference cancel()
        {
         String urlform='/apex/AssessmentTemplateUI2';
           PageReference saveClicked=new PageReference(urlform);
           saveClicked.setRedirect(true);
           return saveClicked;
        }
        public PageReference cloneTemp(){
         Map<String,Id> sectionMap = new Map<String,Id>();
         List<ExAM__Section_Template__c> sectionList = new List<ExAM__Section_Template__c>();
         ExAM__Section_Template__c section = new ExAM__Section_Template__c();
         Set<Id> sectionId = new Set<Id>();
         ExAM__Main_questionaire__c assesTemp = new ExAM__Main_questionaire__c();
         List<ExAM__Question_Template__c> questionList = new List<ExAM__Question_Template__c>();
         ExAM__Question_Template__c question = new ExAM__Question_Template__c();
         templateId=System.currentPageReference().getParameters().get('templateid');
         System.debug('assesmmnst wizard:'+templateId);
         
         if(templateId != NULL){
             
             for (ExAM__Main_questionaire__c asses : [SELECT Id, Name, ExAM__Template_name__c,ExAM__PublishPlace__c FROM ExAM__Main_questionaire__c WHERE Id =:templateId]){
                 assesTemp.ExAM__Template_name__c = asses.ExAM__Template_name__c+'-Clone';
                 assesTemp.ExAM__PublishPlace__c = asses.ExAM__PublishPlace__c;
             }
             System.debug('assesTemp:::::::'+assesTemp);
             Insert assesTemp;
             
             for(ExAM__Section_Template__c sec : [SELECT Id,Name,ExAM__Section_label__c,ExAM__Section_Weight__c,ExAM__Order_No__c FROM ExAM__Section_Template__c WHERE ExAM__Questionnaire_Section__r.Id =:templateId]){
                 sectionId.add(sec.Id);
                 section = new ExAM__Section_Template__c();
                 section.ExAM__Section_label__c = sec.ExAM__Section_label__c;
                 section.ExAM__Section_Weight__c = sec.ExAM__Section_Weight__c;
                 section.ExAM__Order_No__c = sec.ExAM__Order_No__c;
                 section.ExAM__Questionnaire_Section__c = assesTemp.Id;
                 sectionList.add(section);
             }
             System.Debug('sectionList::::::'+sectionList);
             if(sectionList != NULL && sectionList.size() > 0)
             Insert sectionList;
             
             for(ExAM__Section_Template__c  sect : sectionList){
                 sectionMap.put(sect.ExAM__Section_label__c,sect.Id);
             }
             System.Debug('sectionMap::::::::'+sectionMap);
             for(ExAM__Section_Template__c sec : [SELECT Id,ExAM__Section_label__c FROM ExAM__Section_Template__c WHERE Id IN : sectionId]){
                 for(ExAM__Question_Template__c ques : [SELECT Id,Name,ExAM__Question_Order_No__c,ExAM__Question_Label__c,ExAM__Question_Type__c,ExAM__Subquestion_Label__c,ExAM__Weight_Of_Question__c FROM ExAM__Question_Template__c WHERE ExAM__Section_Question__r.Id =:sec.Id]){
                     question = new ExAM__Question_Template__c();
                     question.ExAM__Question_Label__c = ques.ExAM__Question_Label__c;
                     question.ExAM__Question_Type__c = ques.ExAM__Question_Type__c;
                     question.ExAM__Subquestion_Label__c = ques.ExAM__Subquestion_Label__c;
                     question.ExAM__Weight_Of_Question__c = ques.ExAM__Weight_Of_Question__c;
                     question.ExAM__Question_Order_No__c = ques.ExAM__Question_Order_No__c;
                     question.ExAM__Section_Question__c = sectionMap.get(sec.ExAM__Section_label__c );
                     questionList.add(question);
                 }
             }
             
             System.Debug('questionList::::::::'+questionList);
             
             if(questionList != NULL && questionList.size() > 0)
             Insert questionList;
         }
         return NULL;
     }
    /*public PageReference NewSurvey()
        {
          return null; 
        }
   */
     
}