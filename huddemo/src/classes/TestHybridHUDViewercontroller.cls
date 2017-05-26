@isTest
public Class TestHybridHUDViewercontroller{
    public Static testMethod void testMethodForHybridHUDViewercontroller(){
        PageReference pageRef = Page.HybridHUDViewer;
        Test.setCurrentPage(pageRef);

        Account acc = new Account(Name = 'Test 1');
        Insert acc;
        
        ApexPages.currentPage().getParameters().put('id',acc.Id);
        ExAM__IssueRequest_Life_Cycle__c assignManager = new ExAM__IssueRequest_Life_Cycle__c(ExAM__Facility_Name__c = acc.Id, ExAM__Status__c = 'Open');
        Insert assignManager;
        
        
        ExAM__Main_questionaire__c assessment = new ExAM__Main_questionaire__c(ExAM__Account__c = acc.Id,ExAM__Assignment_ID_Name__c = assignManager.Id, ExAM__Template_External_Id__c = 'HUD_InspectionChecklist');
        Insert assessment;
        
        ExAM__Section_Template__c section = new ExAM__Section_Template__c(ExAM__Questionnaire_Section__c = assessment.Id, ExAM__Section_label__c = 'Test Label');
        Insert section;
        
        ExAM__Section_Group__c SG = new ExAM__Section_Group__c();
        insert SG;        
        
        ExAM__Section_Group_Section_Relation__c SGSR = new ExAM__Section_Group_Section_Relation__c( ExAM__Section_Template__c = section.id, ExAM__Section_Group__c = SG.id, ExAM__Section_Active__c = true );
        insert SGSR;
        
        ExAM__Question_Template__c question = new ExAM__Question_Template__c(ExAM__Section_Question__c = section.Id,ExAM__Question_Label__c = 'Test is working',ExAM__Subquestion_Label__c = 'Test class for Hybrid',ExAM__Question_Order_No__c = 1);
        Insert question;
        
        ExAM__Questionnaire_Response__c answer = new ExAM__Questionnaire_Response__c(Reason_for_Discrepancy__c = 'Confirm',ExAM__Response__c = 'YES',External_Response__c = 'hi',ExAM__Question_Template__c = question.Id,ExAM__Issue_Request__c = assignManager.Id,ExAM__Account_to_Response__c = acc.Id);
        Insert answer;
        
        String res = '{"getFor":"item","Id":"'+question.Id+'","acctId":"'+acc.Id+'","assignManagerId":"'+assignManager.Id+'","inStatus":"Open"}';
        String response ='{"getFor":"test","item":"'+question.Id+'","acctId":"'+acc.Id+'","assignManagerId":"'+assignManager.Id+'","inStatus":"Open"}';
        
        ApexPages.currentPage().getParameters().put('id',assignManager.Id);
        HybridHUDViewercontroller hybridHUD = new HybridHUDViewercontroller();
        HybridHUDViewercontroller.getQuestions(section.Id);
        HybridHUDViewercontroller.submitInspection(assignManager.Id);
        HybridHUDViewercontroller.getAnswers(res);
        HybridHUDViewercontroller.saveAnswers(response);
        HybridHUDViewercontroller.answerRec ansRec = new HybridHUDViewercontroller.answerRec();
        HybridHUDViewercontroller.ansSettings ansSet = new HybridHUDViewercontroller.ansSettings();
        //HybridHUDViewercontroller.AnswerRecord ansRecord = new HybridHUDViewercontroller.AnswerRecord();
        //HybridHUDViewercontroller.questionRecord quesRec = new HybridHUDViewercontroller.questionRecord();
        
    }
}