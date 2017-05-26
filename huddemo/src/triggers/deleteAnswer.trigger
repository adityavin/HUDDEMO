trigger deleteAnswer on ExAM__IssueRequest_Life_Cycle__c (before delete) {
    Set<Id> AssignIdSet = new Set<Id>();
    List<ExAM__Questionnaire_Response__c> answerList = new List<ExAM__Questionnaire_Response__c>();
    for( ExAM__IssueRequest_Life_Cycle__c IR : Trigger.Old ){
        AssignIdSet.add(IR.Id);   
    }
    System.Debug('AssignIdSet::::::'+AssignIdSet);
    System.Debug('AssignIdSet::::::'+AssignIdSet.size());
    if( AssignIdSet.size() > 0 ){
        for(ExAM__Questionnaire_Response__c ans :[SELECT Id FROM ExAM__Questionnaire_Response__c WHERE ExAM__Issue_Request__r.Id IN : AssignIdSet]){
            answerList.add(ans);
        }
    }
    System.Debug('answerList::::::::::'+answerList.Size());
    if(answerList.Size() > 0){
        delete answerList;
    }
}