/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class PublicAssessmentCreationController {
    global PublicAssessmentCreationController() {

    }
    @RemoteAction
    global static String createPublicAssessments(String selectedObj, String createPAForWhichEntity, String selectedTemplate, String expDateStr, Map<String,String> agjAssessibleObjectApiNameMap, Map<String,String> paAssessibleObjectApiNameMap) {
        return null;
    }
    @RemoteAction
    global static ExAM.PublicAssessmentCreationController.AssessibleObjectAndTemplateClass getAssessibleObjectAndTemplates() {
        return null;
    }
    @RemoteAction
    global static List<ExAM.PublicAssessmentCreationController.AssessmentGroupDetails> onAssessibleObjectChange(String selectedObj) {
        return null;
    }
global class AssessibleObjectAndTemplateClass {
    global Map<String,String> agjAssessibleObjectApiNameMap {
        get;
        set;
    }
    global List<ExAM.PublicAssessmentCreationController.AssessibleObjectDetails> assessibleObjs {
        get;
        set;
    }
    global List<ExAM.PublicAssessmentCreationController.AssessmentTemplateDetails> assessmentTemplates {
        get;
        set;
    }
    global Map<String,String> paAssessibleObjectApiNameMap {
        get;
        set;
    }
    global AssessibleObjectAndTemplateClass() {

    }
}
global class AssessibleObjectDetails {
    global String objApiName {
        get;
        set;
    }
    global String objLabel {
        get;
        set;
    }
    global AssessibleObjectDetails(String apiName, String label) {

    }
}
global class AssessmentGroupDetails {
    global String objApiName {
        get;
        set;
    }
    global String objLabel {
        get;
        set;
    }
    global AssessmentGroupDetails(String apiName, String label) {

    }
}
global class AssessmentTemplateDetails {
    global String recId {
        get;
        set;
    }
    global String templateName {
        get;
        set;
    }
    global AssessmentTemplateDetails(String recordId, String templateNameStr) {

    }
}
global class ErrorClass {
    global String errMsg {
        get;
        set;
    }
    global String errType {
        get;
        set;
    }
    global ErrorClass(String etype, String eMsg) {

    }
}
global class SuccessClass {
    global String code {
        get;
        set;
    }
    global String msg {
        get;
        set;
    }
    global SuccessClass(String sCode, String sMsg) {

    }
}
}
