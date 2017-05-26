global with sharing class HybridHUDViewercontroller {
    public List<SelectOption> sectionOptionLists { get; set; }
    public String templateid{get;set;}
    public List<ExAM__Section_Group_Section_Relation__c> group_sectionlist { get; set; }
    public String aManagerId { get; set; }
    public String acctId { get; set; }
    public String secGrpId { get; set; }
    public String sectionid {get;set;}
    public String inspectionStatus {get;set;}
    public String inspectionType {get;set;}
    public String reasonDiffJson {get;set;}
    public String auditDiffJson {get;set;}
    
    public HybridHUDViewercontroller() {
        aManagerId = ApexPages.currentPage().getParameters().get('id');
        inspectionType = ApexPages.currentPage().getParameters().get('type');
        //acctId = '00117000002TY6V';
        //aManagerId = 'a0617000000KpdP';
        Schema.DescribeSObjectResult r = ExAM__IssueRequest_Life_Cycle__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix();
        system.debug(':::::'+keyprefix);
        
        if( aManagerId != Null && aManagerId != '' && keyPrefix == aManagerId.substring(0,3)){
            ExAM__IssueRequest_Life_Cycle__c aManagerRec = [
                SELECT ExAM__Status__c,Id,ExAM__Facility_Name__c
                FROM ExAM__IssueRequest_Life_Cycle__c
                WHERE Id =:aManagerId];
            
            if(aManagerRec != Null ){    
                acctId = aManagerRec.ExAM__Facility_Name__c;
                inspectionStatus = aManagerRec.ExAM__Status__c;
                setSections();
            }
            DescribeSObjectResult answerMeta = ExAM__Questionnaire_Response__c.sObjectType.getDescribe();    
            Map<String, Schema.SObjectField> fieldsMap = answerMeta.fields.getMap();
    
            List<Schema.PicklistEntry> pickListValues = fieldsMap.get('Reason_for_Discrepancy__c').getDescribe().getPickListValues();
            List<Schema.PicklistEntry> pickListValues1 = fieldsMap.get('Audit_Reason_for_Discrepency__c').getDescribe().getPickListValues();
    
            Map<String,String> storedPickListValues = new Map<string, string>();
            Map<String,String> storedPickListValues1 = new Map<string, string>();
            
            for(integer i=0; i<= pickListValues.size()-1 ;i++){
                
                storedPickListValues.put(string.valueof(i), pickListValues[i].getLabel());
                
            }
            
            for(integer i=0; i<= pickListValues1.size()-1 ;i++){
                
                storedPickListValues1.put(string.valueof(i), pickListValues1[i].getLabel());
                
            }
            reasonDiffJson = JSON.serialize(storedPickListValues);
            auditDiffJson = JSON.serialize(storedPickListValues1);
        }else{
            aManagerId = '';
        }
        
    }
    
    public void setSections(){
        sectionOptionLists =new List<SelectOption>();
        //secGrpId ='a0G17000000BbT0';
        
        ExAM__Section_Group_Section_Relation__c secGroupId = [
                SELECT Id, ExAM__Section_Template__r.ExAM__Questionnaire_Section__r.ExAM__Template_External_Id__c,
                        ExAM__Section_Group__c
                FROM ExAM__Section_Group_Section_Relation__c 
                WHERE ExAM__Section_Template__r.ExAM__Questionnaire_Section__r.ExAM__Template_External_Id__c = 'HUD_InspectionChecklist'
                Limit 1];
        system.debug('secGroupId::::::::::::'+secGroupId);
        //if((templateid!=null)&&(templateid!='None')){
            if(sectionOptionLists!=null){
               sectionOptionLists =new List<SelectOption>();
            }
            group_sectionlist = [
                SELECT id,ExAM__Section_Group__c,
                        ExAM__Default_Section__c,ExAM__Section_Active__c,
                        ExAM__Section_Group__r.id,ExAM__Section_Template__c,
                        ExAM__Section_Template__r.ExAM__Section_label__c,
                        ExAM__Section_Template__r.id 
                FROM ExAM__Section_Group_Section_Relation__c 
                WHERE ExAM__Section_Active__c=true
                AND ExAM__Section_Group__c =:secGroupId.ExAM__Section_Group__c
                ORDER BY ExAM__Section_Template__r.Name ASC ];
                
            sectionOptionLists.add(new SelectOption('None','None'));
            
            for(ExAM__Section_Group_Section_Relation__c  res: group_sectionlist ) {
                sectionOptionLists.add(new SelectOption(res.ExAM__Section_Template__r.id,res.ExAM__Section_Template__r.ExAM__Section_label__c));
                 
            }   
            system.debug('sectionOptionLists:::::'+sectionOptionLists);     
        //}
    }
    
    @RemoteAction
    public static String getQuestions(String secId){       
        List<questionRecord> questionsWrapperLists =new List<questionRecord>();
        
        if(secId!='NULL' && secId!=''){
            for(ExAM__Question_Template__c qRec:[
                SELECT  Id,ExAM__Section_Question__r.id,
                          ExAM__Question_Label__c, ExAM__Subquestion_Label__c 
                FROM    ExAM__Question_Template__c 
                WHERE   ExAM__Section_Question__r.id=:secId AND Display_Mobile_Viewer__c = TRUE
                ORDER BY ExAM__Question_Order_No__c]){
                 
                questionRecord questRec = new questionRecord (qRec.id,qRec.ExAM__Question_Label__c,qRec.ExAM__Subquestion_Label__c);
                questionsWrapperLists.add(questRec);
            }
        }
        system.debug('questionsLists::::::::'+JSON.serialize(questionsWrapperLists));
        return JSON.serialize(questionsWrapperLists);    
    }
    
    @RemoteAction
    public static String autoFillAnswers(String response){       
        List<ExAM__Questionnaire_Response__c> answerToUpdateList = new List<ExAM__Questionnaire_Response__c>();
        
        JSONParser parser = JSON.createParser(response);
        autoFillAnswer obj = (autoFillAnswer)parser.readValueAs(autoFillAnswer.class);
        set<id> ItemIdsSet = new set<id>();
        
        for(string ItemIds : ((obj.itemIds).split(',',-2))){
            ItemIdsSet.add(ItemIds.trim());
        }
        
        
        if(ItemIdsSet.size()>0 && obj.acctId != '' && obj.acctId != 'Null'  ){
            for( ExAM__Questionnaire_Response__c ansRec:[
                                SELECT Id ,Audit_Response__c
                                FROM ExAM__Questionnaire_Response__c
                                WHERE ExAM__Question_Template__c IN  :ItemIdsSet
                                AND ExAM__Account_to_Response__c =:obj.acctId]){
                    
                    ansRec.Audit_Response__c = 'Pass';
                    answerToUpdateList.add(ansRec);               
            }
        }
        
        if( answerToUpdateList.size()>0 ){
            update answerToUpdateList;
            return 'true';
        }
        
        return 'false';    
    }
    
    @RemoteAction
    public static String submitInspection(String assesmentID){
        if( assesmentID != '' && assesmentID != Null){
            ExAM__IssueRequest_Life_Cycle__c AssesmentManager = new ExAM__IssueRequest_Life_Cycle__c(id=assesmentID);
            AssesmentManager.ExAM__Status__c = 'Completed';
            Update AssesmentManager;
            return 'true';
        }
        return 'false';
    }
    
    @RemoteAction
    public static String attachPic(String response){
        
        JSONParser parser = JSON.createParser(response);
        attachVal obj = (attachVal)parser.readValueAs(attachVal.class);
        
        Attachment attachment = new Attachment();
        attachment.Name        = obj.Name;
        attachment.IsPrivate   = false;
        attachment.ContentType = 'image/png';
        attachment.Body        = obj.Body;
        attachment.Description = obj.Description;
        attachment.ParentId    = obj.ParentId;
        
        insert attachment;
        
        return JSON.serialize(attachment);
    }
    
    @RemoteAction
    public static String getAnswers(String response){
        System.Debug('Response get Answers:::::'+response);
        JSONParser parser = JSON.createParser(response);
        ansSettings obj = (ansSettings)parser.readValueAs(ansSettings.class);
           
        List<ExAM__Questionnaire_Response__c> AnswersList =new List<ExAM__Questionnaire_Response__c>();
        List<AnswerRecord> AnswersWrapperList =new List<AnswerRecord>();
        
        String queryString = 'SELECT Name, Reason_for_Discrepancy__c,'
                            +'ExAM__Response__c, External_Response__c, LastModifiedDate,Audit_Response__c,'
                            +'ExAM__Question_Template__r.ExAM__Question_Label__c,createdDate, ExAM__Issue_Request__c,'
                            +'ExAM__Question_Template__r.ExAM__Section_Question__r.ExAM__Section_label__c, Audit_Reason_for_Discrepency__c,'
                            +'Floor_Level__c,Room_Code__c,Room_Location_1__c,Room_Location_2__c,Other_Room_Code_Description__c'
                            +' FROM ExAM__Questionnaire_Response__c'; 
                            
        if( obj.acctId != ''){
            queryString += ' WHERE ExAM__Account_to_Response__c =\''+obj.acctId+'\'';
        }
        if( obj.assignManagerId != ''){
            queryString += ' AND ExAM__Issue_Request__c =\''+obj.assignManagerId+'\'';
        }
        if( obj.getFor == 'section' && obj.Id != 'None'){                   
            
            queryString += ' AND ExAM__Question_Template__r.ExAM__Section_Question__c  =\''+obj.Id+'\'';
        }
        
        if( obj.getFor == 'item' && obj.Id != 'None'){                   
            queryString += ' AND ExAM__Question_Template__c  =\''+obj.Id+'\'';
        }
        system.debug('queryString::::::::'+queryString);
        List <ExAM__Questionnaire_Response__c> queryResults = Database.query(queryString);
        if( queryResults.size() >0 ){
            for( ExAM__Questionnaire_Response__c ansRec :queryResults){
                String action;
                String Name;
                if(obj.inStatus == 'Completed'){
                    Name = ansRec.ExAM__Question_Template__r.ExAM__Section_Question__r.ExAM__Section_label__c+' - '
                                +ansRec.ExAM__Question_Template__r.ExAM__Question_Label__c;
                }else{
                    action = '<a onclick="editAnswer(\''+ansRec.id+'\');" style="cursor: pointer;">Edit</a>';
                    Name = '<a onclick="redirect(\''+ansRec.id+'\',\'tab\')" target="_blank" style="cursor: pointer;">'
                                +ansRec.ExAM__Question_Template__r.ExAM__Section_Question__r.ExAM__Section_label__c+' - '
                                +ansRec.ExAM__Question_Template__r.ExAM__Question_Label__c+'</a>';
                }
                
                Integer fLev = Integer.valueof(ansRec.Floor_Level__c);
                
                AnswerRecord answerWrapper = new AnswerRecord(ansRec.id,action,Name,ansRec.ExAM__Question_Template__r.ExAM__Section_Question__c,
                                                                ansRec.ExAM__Question_Template__c,ansRec.ExAM__Response__c,
                                                                ansRec.External_Response__c,ansRec.Reason_for_Discrepancy__c,
                                                                ansRec.LastModifiedDate,ansRec.Room_Location_1__c,ansRec.Room_Location_2__c,
                                                                ansRec.Other_Room_Code_Description__c,ansRec.Room_Code__c,fLev,
                                                                ansRec.Audit_Response__c,ansRec.Audit_Reason_for_Discrepency__c);
                AnswersWrapperList.add(answerWrapper);
            }
        }
        return JSON.serialize(AnswersWrapperList);    
    }

    @RemoteAction
    public static String saveAnswers(String response){       
        System.Debug('Response:::::'+response);
        JSONParser parser = JSON.createParser(response);
        answerRec obj = (answerRec)parser.readValueAs(answerRec.class);
        
        system.debug('response::::::'+response);
        system.debug('obj.answerId::::::'+obj.answerId);
        
        ExAM__Questionnaire_Response__c AnswersRec = new ExAM__Questionnaire_Response__c();
        if(obj.answerId != null){
            AnswersRec.Id = obj.answerId;
        }else{
            AnswersRec.ExAM__Account_to_Response__c = obj.acctId;
            AnswersRec.ExAM__Question_Template__c = obj.item;
            AnswersRec.ExAM__Issue_Request__c = obj.assignManagerId;
        }
        
        
        
        
        AnswersRec.Floor_Level__c = obj.fLevel;
        AnswersRec.Room_Code__c = obj.rCode;
        AnswersRec.Room_Location_1__c = obj.room1;
        AnswersRec.Room_Location_2__c = obj.room2;
        AnswersRec.Other_Room_Code_Description__c = obj.oRoom;
        
        if( obj.viewType == 'Audit' || obj.viewType == 'DesktopAudit' ){
            AnswersRec.Audit_Response__c = obj.auditSel;
            AnswersRec.Audit_Reason_for_Discrepency__c = obj.diff;
            AnswersRec.Reason_for_Discrepancy__c = obj.auditResonDiff;
            
        }else{
            AnswersRec.Reason_for_Discrepancy__c = obj.diff;
        }
        if(obj.viewType != 'DesktopAudit'){
            AnswersRec.ExAM__Response__c = obj.pha;
        }
        
        if( obj.viewType == 'Audit' ){
            AnswersRec.External_Response__c = obj.fed;
        }
        system.debug('AnswersRec::::::'+AnswersRec);
        
        upsert AnswersRec;
        system.debug('AnswersRec::::::'+AnswersRec.id);
        
        return String.valueof(AnswersRec.id);    
    }
    
    public class answerRec {
        
        public String item;
        public String fed;
        public String pha;
        public String diff;
        public String room1;
        public String room2;
        public String oRoom;
        public String rCode;
        public Integer fLevel;
        public String acctId;
        public String assignManagerId;
        public String answerId;
        public String auditSel;
        public String viewType;
        public String auditResonDiff;
    }
    
    public class ansSettings {
        
        public String getFor;
        public String Id;
        public String acctId;
        public String assignManagerId;
        public String inStatus;
    }
    
    public class attachVal {
        
        public String ParentId;
        public String Name;
        public blob body;
        public String Description;
    }
    
    public class autoFillAnswer {
        
        public String itemIds;
        public String acctId;
    }
    
    global class AnswerRecord {
        public string Id {get; set; } 
        public string Action {get; set; }        
        public string Name {get; set; }
        public string sectionId {get; set; }
        public string itemId {get; set; }
        public string responsePHA {get; set; }
        public string responseFED {get; set; }
        public string reasonForDiff {get; set; }
        public Datetime createdDt {get; set; }
        public String room1 {get; set; }
        public String room2 {get; set; }
        public String oRoom {get; set; }
        public String rCode {get; set; }
        public Integer fLevel {get; set; }
        public String qaDecision {get; set; }
        public String auditResonDiff {get; set; }
        
        public AnswerRecord (string id,string link,string name,string secId,string itemId,
                                string pha,string fed,string reason,Datetime createdDate,
                                string room1,string room2,string oRoom,string rCode,
                                Integer fLevel,string qaDecision,string auditResonDiff){
            this.Id = id;
            this.Action = link;        
            this.Name = name;
            this.sectionId = secId;        
            this.itemId = itemId;
            this.responsePHA = pha;
            this.responseFED = fed;
            this.reasonForDiff = reason; 
            this.createdDt = createdDate;
            this.room1 = room1;
            this.room2 = room2;        
            this.oRoom = oRoom;
            this.rCode = rCode;        
            this.fLevel = fLevel;
            this.qaDecision = qaDecision;
            this.auditResonDiff = auditResonDiff;
        } 
    }
    
    global class questionRecord {
        public string Id {get; set; } 
        public string itemLabel {get; set; }
        public string options {get; set; }
        
        
        public questionRecord (string id,string itemLabel,string ansOptions){
            this.Id = id;
            this.itemLabel = itemLabel;        
            this.options = ansOptions;
        } 
    }
}