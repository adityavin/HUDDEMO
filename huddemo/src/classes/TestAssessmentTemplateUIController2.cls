@isTest
public Class TestAssessmentTemplateUIController2 {

    public static testMethod void AssessmentTemplateUI2_Test()
    {
        //Test converage for the visualforce page
        //PageReference pageRef = Page.AssessmentTemplateUI;
        //Test.setCurrentPageReference(pageRef);
        Test.startTest();
        ExAM__Main_questionaire__c maintest=new ExAM__Main_questionaire__c (ExAM__Template_name__c ='test');
        upsert maintest;
        ExAM__Main_questionaire__c[] accountList = [SELECT id,ExAM__Template_name__c FROM ExAM__Main_questionaire__c];
        System.debug('----INTEST'+accountList );
        ExAM__Section_Group__c maintestg=new ExAM__Section_Group__c(ExAM__Group_Name__c ='test');
        //upsert maintestg;
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(accountList);
        AssessmentTemplateUIController2 d= new AssessmentTemplateUIController2(); 
        d.grpObj=maintestg;d.saveMulti();
        //When its null
        ExAM__Main_questionaire__c maint=d.templateObj;
        d.save();
        System.assert(d.templateObj!=null,'template is not null and created');
        //When not null
        ExAM__Main_questionaire__c maint2=new ExAM__Main_questionaire__c (ExAM__Template_name__c ='test');
        upsert maint2;
        d.templateObj=maint2;
        System.currentPageReference().getParameters().put('templateid', accountList[0].id);
        d.EditSurvey();
        d.Accountname=null;
        d.save();
        
        d.Accountname='testdata';
        d.save();
        System.assert(d.EditSurvey()!=null,'survey is not null and edited');
        d.selectedAccountId=null;
        d.save();
        Account newAccount = new Account (name='XYZ Organization');
        insert newAccount;
        Account newAccount2 = new Account (name='XYZ2 Organization');
        insert newAccount2;
        d.selectedAccountId=newAccount.id;
        d.save();
        List<SelectOption> AccList = d.AccountList;
        d.allaccounts=[SELECT id,name,parentid FROM Account];
        d.save();
        ApexPages.StandardSetController scc = new ApexPages.StandardSetController(d.allaccounts);
        
        d.cancel();
        System.assert(d.save()!=null,'save completed properly');
        
        Account acc = new Account(Name = 'Test 1');
        Insert acc;
        ExAM__IssueRequest_Life_Cycle__c assignManager = new ExAM__IssueRequest_Life_Cycle__c(ExAM__Facility_Name__c = acc.Id, ExAM__Status__c = 'Open');
        Insert assignManager;
        ExAM__Main_questionaire__c assessment = new ExAM__Main_questionaire__c(ExAM__Account__c = acc.Id,ExAM__Assignment_ID_Name__c = assignManager.Id, ExAM__Template_External_Id__c = 'HUD_InspectionChecklist');
        Insert assessment;
        ExAM__Section_Template__c section = new ExAM__Section_Template__c(ExAM__Questionnaire_Section__c = assessment.Id, ExAM__Section_label__c = 'Test Label');
        Insert section;
        ExAM__Question_Template__c question = new ExAM__Question_Template__c(ExAM__Section_Question__c = section.Id,ExAM__Question_Label__c = 'Test is working',ExAM__Subquestion_Label__c = 'Test class for Hybrid',ExAM__Question_Order_No__c = 1);
        Insert question;
        ExAM__Questionnaire_Response__c answer = new ExAM__Questionnaire_Response__c(Reason_for_Discrepancy__c = 'Confirm',ExAM__Response__c = 'YES',External_Response__c = 'hi',ExAM__Question_Template__c = question.Id,ExAM__Issue_Request__c = assignManager.Id,ExAM__Account_to_Response__c = acc.Id);
        Insert answer;
        
        apexPages.currentPage().getParameters().put('templateid',assessment.Id);
        
        PageReference pageRef = d.cloneTemp();

        List<ExAM__Section_Group__c> secGroupList = d.getsecgrouplist();
        d.AccName = 'test';
        d.myFlag = true;
        d.myFlagmulti = true;
        d.groupList = new List<ExAM__Section_Group__c>();
        AssessmentTemplateUIController2 d2= new AssessmentTemplateUIController2(sc); 
        Test.stopTest();
         
         //assert results
        

    }
}