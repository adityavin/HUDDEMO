/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CreateAMAndAnswersController {
    global static String makeError(String message, String errorCode) {
        return null;
    }
    @RemoteAction
    global static String query(String soql) {
        return null;
    }
    @RemoteAction
    global static String returnSectionAndQuestionTemplate(String assessmentTemplateId, Boolean isSingleQuestionMode) {
        return null;
    }
    @RemoteAction
    global static String saveAnswerRecords(List<ExAM.CreateAMAndAnswersController.AnswerRecordClass> answerList, Map<Id,Map<String,String>> responseFile, String tempId, String assessibleObjId, String assessibleFieldApiName, String amReqdStatus, String assessibleObjReferenceForAnsCreation, String amId, String publicAssessmentId, String ipAddress, List<ExAM__Questionnaire_Response__c> resultQuestionAnswers, String startTimeStr, Map<String,ExAM.CreateAMAndAnswersController.CaseRecordClass> caseRec, Map<String,String> decisionTreeQuesIdAnsId) {
        return null;
    }
    @RemoteAction
    global static String saveAttachments(List<ExAM.CreateAMAndAnswersController.AttachmentDetails> attDtlObj) {
        return null;
    }
    @RemoteAction
    global static String saveDecisionTreeAnswerRecords(List<ExAM__Questionnaire_Response__c> decisionTreeAnsList, String tempId, String assessibleObjId, String assessibleFieldApiName, String amReqdStatus, String assessibleObjReferenceForAnsCreation, String createdAMId) {
        return null;
    }
global class AnswerRecordClass {
    global AnswerRecordClass() {

    }
}
global class AttachmentDetails {
    global AttachmentDetails() {

    }
}
global class CaseRecordClass {
    global CaseRecordClass() {

    }
}
}
