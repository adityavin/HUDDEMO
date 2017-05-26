Public class HUDXMLUploadController{
     
    Transient Blob xMLFile = NULL;
    Transient String xmlContent = '';
    List<Account> accId = new List<Account>();
    public Attachment attach{get;set;}
    List<Attachment> attachList = new List<Attachment>();
    Set<String> sectionItemSet = new Set<String>{'1.9', '2.9', '3.9', '4.9', '6.6', '8.11'};    
    Integer i=0;
    Boolean ContractorHQSDecision = True;
    String otherRoomCode = '';
    Map<String,Map<String,List<String>>> secLineMap = new Map<String,Map<String,List<String>>>();
    Map<String,Map<String,String>> queryMap = new Map<String,Map<String,String>>();
    HUD52580XML XMLInstance = new HUD52580XML();
    List<HUD52580XML.HQSItemDetails> XMLICInstanceList = new List<HUD52580XML.HQSItemDetails>();
    List<HUD52580XML.photo> XMLICPhotoInstanceList = new List<HUD52580XML.photo>();
    Map<String,HUD52580XML.ComparisonExplanationPhoto> comparisonMap = new Map<String,HUD52580XML.ComparisonExplanationPhoto>();
    HUD52580XML.PHAPdf pdfFile = new HUD52580XML.PHAPdf();
    String errorMsg = '';
    public String testClassString ='';
    
    public HUDXMLUploadController() {
        
        attach = new Attachment();  
        attachList = new List<Attachment>();      
    }
    
    public pagereference uploadxml() {
        
        if ( attach != null ) {
            
            xMLFile = attach.Body; 
            attach = new Attachment();
        }
        
        if(Test.isRunningTest()){
        
            xmlContent = testClassString;
        }else if ( xMLFile != NULL ) {
          
            xmlContent = xMLFile.toString();
        }
        
        for ( ExAM__Question_Template__c qtem : [SELECT Id,ExAM__Question_External_Id__c,ExAM__Section_Question__r.ExAM__Section_External_Id__c
                                                FROM ExAM__Question_Template__c 
                                                WHERE ExAM__Section_Question__r.ExAM__Questionnaire_Section__r.ExAM__Template_External_Id__c = 'HUD_InspectionChecklist']) {
            
            if ( queryMap.get(qtem.ExAM__Section_Question__r.ExAM__Section_External_Id__c) == NULL )
                queryMap.put(qtem.ExAM__Section_Question__r.ExAM__Section_External_Id__c, new Map<String,String>());
            
                queryMap.get(qtem.ExAM__Section_Question__r.ExAM__Section_External_Id__c).put(qtem.ExAM__Question_External_Id__c,qtem.Id);
        }
        
        //List<String> phaDesList = new List<String>();
        if ( xmlContent != NULL && xmlContent != '' ) {
            DOM.Document xmlDoc = new DOM.Document();
            xmlDoc.load(xmlContent);
            //System.debug('xmlDoc::::'+xmlDoc);
            DOM.XMLNode rootElement = xmlDoc.getRootElement();
            String secTitle = '';
            Map<String,HUD52580XML.photo> map1 = new Map<String,HUD52580XML.photo>();
            HUD52580XML.photo photo_Instance = new HUD52580XML.photo();
            HUD52580XML.ComparisonExplanationPhoto compInstance = new HUD52580XML.ComparisonExplanationPhoto();
            
            for( Dom.XMLNode rootNodeChild : rootElement.getChildElements() ) {
    
                if( rootNodeChild.getName() == 'tbl_HQS_52580_Data' ) {
                    
                    for( DOM.XMLNode cn1 : rootNodeChild.getChildElements() ) {
                        
                        //System.debug('childnode CN1'+cn1.getName());
                        if( cn1.getName() == 'Inspection_ID' ) XMLInstance.inspection_ID = cn1.getText(); 
                        if( cn1.getName() == 'Reviewer_ID' ) XMLInstance.reviewer_ID = cn1.getText();
                        if( cn1.getName() == 'Reviewer_Name' ) XMLInstance.reviewer_Name = cn1.getText();
                        if( cn1.getName() == 'Contractor' ) XMLInstance.contractor = cn1.getText(); 
                        if( cn1.getName() == 'PHA_Inspector_Name' ) XMLInstance.PHA_Inspector_Name = cn1.getText();
                        if( cn1.getName() == 'PHA_Employee' ) XMLInstance.PHA_Employee = cn1.getText();
                        if( cn1.getName() == 'PHA_Code' ) XMLInstance.PHA_Code = cn1.getText();
                        if( cn1.getName() == 'Tenant_ID_Number' ) XMLInstance.tenant_ID_Number = cn1.getText();
                        if( cn1.getName() == 'Date_of_Request' ) XMLInstance.date_of_Request = Date.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Date_Last_Inspection' ) XMLInstance.date_Last_Inspection = Date.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Date_of_Inspection' ) XMLInstance.date_of_Inspection = Datetime.ValueOf(cn1.getText().replace('T', ' '));
                        if( cn1.getName() == 'Date_of_PHA_HQS_Inspection' ) XMLInstance.date_of_PHA_HQS_Inspection = Date.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Date_of_Contractor_Review' ) XMLInstance.date_of_Contractor_Review = Date.ValueOf(cn1.getText().replace('T', ' '));
                        if( cn1.getName() == 'Neighborhood_Census_Tract' ) XMLInstance.neighborhood_Census_Tract = cn1.getText();
                        if( cn1.getName() == 'Type_of_Inspection' ) XMLInstance.type_of_Inspection = cn1.getText();
                        if( cn1.getName() == 'HQS_Review_Type' ) XMLInstance.HQS_Review_Type = cn1.getText();
                        if( cn1.getName() == 'Project_Number' ) XMLInstance.project_Number = cn1.getText();
                        if( cn1.getName() == 'Unit_Street_Address' ) XMLInstance.unit_Street_Address = cn1.getText();
                        if( cn1.getName() == 'Unit_City' ) XMLInstance.unit_City = cn1.getText();
                        if( cn1.getName() == 'Unit_County' ) XMLInstance.unit_County = cn1.getText();
                        if( cn1.getName() == 'Unit_State' ) XMLInstance.unit_State = cn1.getText();
                        if( cn1.getName() == 'Unit_Zip' ) XMLInstance.unit_Zip = cn1.getText();
                        if( cn1.getName() == 'Name_of_Family' ) XMLInstance.name_of_Family = cn1.getText();
                        if( cn1.getName() == 'Current_Street_Address' ) XMLInstance.current_Street_Address = cn1.getText();
                        if( cn1.getName() == 'Current_City' ) XMLInstance.current_City = cn1.getText();
                        if( cn1.getName() == 'Current_County' ) XMLInstance.current_County = cn1.getText();
                        if( cn1.getName() == 'Current_State' ) XMLInstance.current_State = cn1.getText();
                        if( cn1.getName() == 'Current_Zip' ) XMLInstance.current_Zip = cn1.getText();
                        if( cn1.getName() == 'Housing_Type' ) XMLInstance.housing_Type = cn1.getText();
                        if( cn1.getName() == 'Housing_Type_Other_Comment' ) XMLInstance.housing_Type_Other_Comment = cn1.getText();
                        if( cn1.getName() == 'Number_of_Children_in_Family_Under_6' ) XMLInstance.number_of_Children_in_Family_Under_6 = Integer.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Name_of_Owner_or_Agent_Authorized_to_Lease_Unit_Inspected' ) XMLInstance.name_of_Owner_or_Agent_Authorized_to_Lease_Unit_Inspected = cn1.getText();
                        if( cn1.getName() == 'Telephone_of_Owner_or_Agent' ) XMLInstance.telephone_of_Owner_or_Agent = cn1.getText();
                        if( cn1.getName() == 'Address_of_Owner_or_Agent' ) XMLInstance.address_of_Owner_or_Agent = cn1.getText();
                        if( cn1.getName() == 'Summary_Decision_on_the_Unit' ) XMLInstance.summary_Decision_on_the_Unit = cn1.getText();
                        if( cn1.getName() == 'Unit_Size' ) XMLInstance.unit_Size = Integer.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Year_Constructed' ) XMLInstance.year_Constructed = Integer.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Number_of_Sleeping_Rooms' ) XMLInstance.number_of_Sleeping_Rooms = Integer.ValueOf(cn1.getText());
                        if( cn1.getName() == 'Unit_Start_Time' ) XMLInstance.unit_Start_Time = Datetime.ValueOf(cn1.getText().replace('T', ' '));
                        if( cn1.getName() == 'Unit_End_Time' ) XMLInstance.unit_End_Time = Datetime.ValueOf(cn1.getText().replace('T', ' '));
                        if( cn1.getName() == 'PHA_HQS_Result' ) XMLInstance.PHA_HQS_Result = cn1.getText();
                        if( cn1.getName() == 'Contractor_QC_Present' ) XMLInstance.contractor_QC_Present= cn1.getText();
                        if( cn1.getName() == 'Contractor_QC_Name' ) XMLInstance.contractor_QC_Name = cn1.getText(); 
                        if( cn1.getName() == 'REAC_QA_Present' ) XMLInstance.REAC_QA_Present = cn1.getText();
                        if ( cn1.getName() == 'REAC_QA_Name' ) XMLInstance.REAC_QA_Name = cn1.getText(); 
                        if( cn1.getName() == 'General_Photo' ) XMLInstance.general_Photo =  EncodingUtil.base64Decode(cn1.getText());    
                             
                        //system.debug('cn1.getChildElements()'+cn1.getChildElements());
                        if ( cn1.getName() == 'tbl_PHA_Pdf' ) {
                            
                            for ( DOM.XMLNode pdfchild : cn1.getChildElements() ) {
                                
                                if(pdfchild.getName() == 'mimetype') pdfFile.mimetype = pdfchild.getText();
                                if(pdfchild.getName() == 'filename') pdfFile.filename = pdfchild.getText();
                                if(pdfchild.getName() == 'content') pdfFile.content = EncodingUtil.base64Decode(pdfchild.getText());
                            }
                        }
                        
                        if(cn1.getName() == 'tbl_HQS_Item_Details'){
                            
                            HUD52580XML.HQSItemDetails Answer_Instance = new HUD52580XML.HQSItemDetails();
                            
                            for ( DOM.XMLNode cn2 : cn1.getChildElements() ) {
                                
                                if ( cn2.getName() == 'Item_ID' ) {
                                    
                                    Answer_Instance.item_ID = cn2.getText();
                                    //System.debug('Answer_Instance.item_ID::::'+Answer_Instance.item_ID);
                                }
                                
                                if ( cn2.getName() == 'Inspection_ID' ) {
                                    
                                    Answer_Instance.answer_Inspection_ID = Integer.ValueOf(cn2.getText());
                                    //System.debug('Answer_Instance.answer_Inspection_ID::::'+Answer_Instance.answer_Inspection_ID);
                                }
                                
                                if ( cn2.getName() == 'HQS_Section_Number' ) {
                                    
                                    Answer_Instance.HQS_Section_Number = Integer.ValueOf(cn2.getText());
                                }
                                
                                if ( cn2.getName() == 'HQS_Section_Title' ) {
                                    
                                    Answer_Instance.HQS_Section_Title = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'HQS_line_Item_Number' ) {
                                    
                                    Answer_Instance.HQS_line_Item_Number = Integer.ValueOf(cn2.getText());
                                }
                                
                                if ( cn2.getName() == 'HQS_Deficiency_Category' ) {
                                    
                                    Answer_Instance.HQS_Deficiency_Category = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Contractor_HQS_Decision' ) {
                                    if( cn2.getText() == 'Fail' || cn2.getText() == 'Inconclusive' )
                                    ContractorHQSDecision = False;
                                    Answer_Instance.contractor_HQS_Decision = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Contractor_HQS_Details' ) {
                                    
                                    Answer_Instance.contractor_HQS_Details = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'LT_Deficiency' ) {
                                    Answer_Instance.LT_Deficiency = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'PHA_Decision') {
                                    Answer_Instance.PHA_Decision = cn2.getText();
                                    
                                }
                                
                                if ( cn2.getName() == 'PHA_Details' ) {
                                    
                                    Answer_Instance.PHA_Details = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'HQS_Category_ID' ) {
                                    Answer_Instance.HQS_Category_ID = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'LQA_Category' ) {
                                    Answer_Instance.LQA_Category = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Local_PHA_Decision' ) {
                                    Answer_Instance.local_PHA_Decision = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Local_PHA_Details' ) {
                                    Answer_Instance.local_PHA_Details = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Room_Location_1' ) {
                                    
                                    Answer_Instance.room_Location_1 = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Room_Location_2' ) {
                                    
                                    Answer_Instance.room_Location_2 = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Floor_Level' ) {
                                    
                                    Answer_Instance.floor_Level = Integer.ValueOf(cn2.getText());
                                }
                                
                                if ( cn2.getName() == 'Room_Code' ) {
                                    
                                    Answer_Instance.room_Code = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Other_Room_Code_Description' ) {
                                    
                                    Answer_Instance.other_Room_Code_Description = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Deficiency_Location' ) {
                                    
                                    Answer_Instance.deficiency_Location = cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Deficiency_Comments' ) {
                                    
                                    Answer_Instance.deficiency_Comments= cn2.getText();
                                }
                                
                                if ( cn2.getName() == 'Time_of_Deficiency' ) {
                                    
                                    Answer_Instance.time_of_Deficiency = Datetime.ValueOf(cn2.getText().replace('T',' '));
                                }
                                
                                if ( cn2.getName() == 'Photo' ) {
                                    
                                    for( DOM.XMLNode cn3 : cn2.getChildElements() ) {
                                        
                                        if( cn3.getName() == 'FileData' ) photo_Instance.fileData = EncodingUtil.base64Decode(cn3.getText());
                                        if( cn3.getName() == 'FileName' ) photo_Instance.fileName = cn3.getText();
                                        if( cn3.getName() == 'FileTimeStamp' ) photo_Instance.fileTimeStamp= cn3.getText();
                                        if( cn3.getName() == 'FileType' ) if(cn3.getText() == 'jpg') photo_Instance.fileType= 'image/jpg';
                                        if( cn3.getName() == 'FileFlags' ) photo_Instance.fileFlags= cn3.getText();
                                        if( cn3.getName() == 'FileURL' ) photo_Instance.fileURL= cn3.getText();
                                    }
                                    XMLICPhotoInstanceList.add(photo_Instance);
                                    
                                }
                                if ( cn2.getName() == 'tbl_comparison_explaination_photo' ) {
                                
                                    for( DOM.XMLNode cn3 : cn2.getChildElements() ) {
                                        
                                        if( cn3.getName() == 'Comparison_Result' ) compInstance.comparison_Result = cn3.getText();
                                        if( cn3.getName() == 'Time_stamp' ) compInstance.time_stamp = Datetime.ValueOf(cn3.getText().replace('T',' '));
                                        if( cn3.getName() == 'Explanation_of_Differences' ) compInstance.explanation_of_Differences = cn3.getText();
                                    }
                                    if( compInstance.comparison_Result == 'Same' && compInstance.explanation_of_Differences == NULL) {
                                        errorMsg = errorMsg+'Explanation_of_Differences is Missing in Item_Id '+Answer_Instance.item_ID+'<br/>';
                                    }
                                }
                                
                            }
                            
                            if( (Answer_Instance.contractor_HQS_Decision == 'Fail' || Answer_Instance.contractor_HQS_Decision == 'Inconclusive') && Answer_Instance.PHA_Decision == 'Pass') 
                                errorMsg = errorMsg +'Contractor_HQS_Decision is not Pass hence PHA_Decision cannot be Pass for the Item_Id '+Answer_Instance.item_ID+'<br/>';
                            
                            if( Answer_Instance.other_Room_Code_Description != NULL && Answer_Instance.other_Room_Code_Description != otherRoomCode ) {
                                
                                otherRoomCode = Answer_Instance.other_Room_Code_Description;
                                i++;
                                //System.Debug('Value of i'+i);
                                //System.debug('Answer_Instance.other_Room_Code_Description'+Answer_Instance.other_Room_Code_Description);
                            }
                            
                            if((Answer_Instance.PHA_Decision == 'Fail' || Answer_Instance.PHA_Decision == 'Inconclusive') && Answer_Instance.PHA_Details == NULL ) 
                                errorMsg = errorMsg+'PHA_Details is Missing for the Item_Id '+Answer_Instance.item_ID+'<br/>';
                                
                            if ( Answer_Instance.HQS_Section_Title == 'Other Rooms Used for Living and Halls' ) {
                                
                                Answer_Instance.HQS_Section_Title = '4.'+i+'.'+Answer_Instance.HQS_Section_Title;
                                
                                if ( Answer_Instance.room_Location_1 == NULL )
                                    errorMsg = errorMsg+'Room_Location_1 is Missing for Item_Id '+Answer_Instance.item_ID+'<br/>';
                                if ( Answer_Instance.room_Location_2 == NULL )
                                    errorMsg = errorMsg+'Room_Location_2 is Missing for Item_Id '+Answer_Instance.item_ID+'<br/>';
                                if ( Answer_Instance.floor_Level == NULL )
                                    errorMsg = errorMsg+'Floor_Level is Missing for Item_Id '+Answer_Instance.item_ID+'<br/>';
                                if ( Answer_Instance.room_Code == NULL )
                                    errorMsg = errorMsg+'Room_Code is Missing for Item_Id '+Answer_Instance.item_ID+'<br/>';
                                if ( Answer_Instance.other_Room_Code_Description == NULL )
                                    errorMsg = errorMsg+'other_Room_Code_Description is Missing for Item_Id '+Answer_Instance.item_ID+'<br/>';
                            }
                            //System.debug('Answer_Instance::::::'+Answer_Instance);
                            
                            if ( photo_Instance != NULL && photo_Instance.fileData != NULL && Answer_Instance.item_ID != NULL ) {
                                
                                map1.put(Answer_Instance.item_ID,photo_Instance);
                                photo_Instance = new HUD52580XML.photo();
                            }
                            
                            if( compInstance != NULL && compInstance.comparison_Result != NULL && Answer_Instance.item_ID != NULL) {
                               
                                comparisonMap.put(Answer_Instance.item_ID, compInstance);
                                compInstance = new HUD52580XML.ComparisonExplanationPhoto();
                            }
                            //System.debug('Size of map1::::'+map1);
                            XMLICInstanceList.add(Answer_Instance);
                        }
                    }
                    
                    if ( !ContractorHQSDecision  && XMLInstance.Summary_Decision_on_the_Unit == 'Pass' ) {
                        
                        errorMsg = errorMsg +'Summary Decision on the Unit Cannot be Pass when Contractor HQS Decsion is Fail or Inconclusive'+'<br/>';
                    }
    
                    if (XMLInstance.housing_Type != NULL && XMLInstance.housing_Type == 'Other' && XMLInstance.housing_Type_Other_Comment == NULL) {
                        
                        errorMsg = errorMsg+'When Housing_Type is Other Housing_Type_Other_Comment is Required'+'<br/>';
                    }
                        
                    if (XMLInstance.contractor_QC_Present != NULL && XMLInstance.Contractor_QC_Present == 'true' && XMLInstance.contractor_QC_Name == NULL) {
                        
                        errorMsg = errorMsg+'contractor_QC_Name is Required'+'<br/>';
                    } 
                           
                    if (XMLInstance.REAC_QA_Present != NULL && XMLInstance.REAC_QA_Present == 'true' && XMLInstance.REAC_QA_Name == NULL) {
                            
                        errorMsg = errorMsg+'REAC_QA_Name is Required'+'<br/>';
                    }  
                           
                    //break;
                }
                
            }
            //System.Debug('errorMsg:::::::'+errorMsg);
            //xmlContent = NULL;
            //if ( errorMsg == '' ) {
            Savepoint sp = Database.setSavepoint();
            try {
                Account acc;
                Contact con;
                Id acctId;
                accId = [SELECT id FROM Account WHERE Name =:XMLInstance.Unit_Street_Address Limit 1]; 
            
                if( accId.size() > 0 ) { 
                    
                    //System.debug('Inside the Account available if ');
                    acctId = accId[0].Id;
                    acc = new Account(Id = acctId, name = XMLInstance.Unit_Street_Address,Number_of_Sleeping_Rooms__c = XMLInstance.number_of_Sleeping_Rooms, ShippingStreet = XMLInstance.Unit_Street_Address, ShippingCity = XMLInstance.unit_City,ShippingCountry = XMLInstance.unit_County,ShippingState = XMLInstance.unit_State,ShippingPostalCode = XMLInstance.unit_Zip, PHA_Code__c = XMLInstance.PHA_Code, Unit_Size__c = XMLInstance.unit_Size, Year_Constructed__c = XMLInstance.year_Constructed );
                    update acc;
                } else {
                    
                    //System.debug('Inside the else');
                    acc = new Account(name = XMLInstance.Unit_Street_Address,Number_of_Sleeping_Rooms__c = XMLInstance.number_of_Sleeping_Rooms, ShippingStreet = XMLInstance.Unit_Street_Address, ShippingCity = XMLInstance.unit_City,ShippingCountry = XMLInstance.unit_County,ShippingState = XMLInstance.unit_State,ShippingPostalCode = XMLInstance.unit_Zip, PHA_Code__c = XMLInstance.PHA_Code, Unit_Size__c = XMLInstance.unit_Size, Year_Constructed__c = XMLInstance.year_Constructed );
                    Insert acc;
                    acctId = acc.Id;
                }
            
                List<Contact> ownerCon = [SELECT Id FROM Contact WHERE LastName =: XMLInstance.name_of_Owner_or_Agent_Authorized_to_Lease_Unit_Inspected AND AccountId =: acctId LIMIT 1];
                
                List<Contact> familyCon = [SELECT Id FROM Contact WHERE LastName =: XMLInstance.name_of_Family AND AccountId =: acctId LIMIT 1];
                
                Id ownerConId;
          
                if( ownerCon.size() > 0 ) {
                    
                    ownerConId = ownerCon[0].Id;
                    con = new Contact(Id=ownerConId, LastName = XMLInstance.name_of_Owner_or_Agent_Authorized_to_Lease_Unit_Inspected, AccountId = acctId, Phone = XMLInstance.telephone_of_Owner_or_Agent, MailingStreet =XMLInstance.address_of_Owner_or_Agent);
                    Update con;
                } else {
                
                    con = new Contact(LastName = XMLInstance.name_of_Owner_or_Agent_Authorized_to_Lease_Unit_Inspected, AccountId = acctId, Phone = XMLInstance.telephone_of_Owner_or_Agent, MailingStreet =XMLInstance.address_of_Owner_or_Agent);
                    Insert con;
                    ownerConId = con.Id;
                }
            
                Id familyConId;
                if( familyCon.size() > 0 ) {
                    
                    familyConId = familyCon[0].Id;
                    con = new Contact(Id=familyConId,LastName=XMLInstance.name_of_Family, AccountId = acctId ,OtherPostalCode = XMLInstance.current_Zip, OtherStreet = XMLInstance.current_Street_Address, OtherState = XMLInstance.current_State, OtherCountry = XMLInstance.current_County, OtherCity = XMLInstance.current_City);
                    Update con;
                } else {
                    
                    con = new Contact(LastName=XMLInstance.name_of_Family, AccountId = acctId ,OtherPostalCode = XMLInstance.current_Zip, OtherStreet = XMLInstance.current_Street_Address, OtherState = XMLInstance.current_State, OtherCountry = XMLInstance.current_County, OtherCity = XMLInstance.current_City);
                    Insert con;
                    familyConId = con.Id;
                }
            
                //if(con != null)
                //Insert con;
                List<ExAM__IssueRequest_Life_Cycle__c> IRLCList = new List<ExAM__IssueRequest_Life_Cycle__c>();
                
                ExAM__IssueRequest_Life_Cycle__c IRLC = new ExAM__IssueRequest_Life_Cycle__c();
                IRLC.ExAM__Facility_Name__c = acctId;
                IRLC.ExAM__Assignment_External_Id__c = XMLInstance.inspection_ID;//
                IRLC.Reviewer_ID__c = XMLInstance.reviewer_ID;
                IRLC.Reviewer_Name__c = XMLInstance.reviewer_Name;
                IRLC.Contractor__c = XMLInstance.Contractor;
                IRLC.PHA_Inspector_Name__c = XMLInstance.PHA_Inspector_Name;
                IRLC.PHA_Employee__c = XMLInstance.PHA_Employee;//
                IRLC.Tenant_ID_Number__c = XMLInstance.Tenant_ID_Number;
                IRLC.Date_of_Request__c = XMLInstance.Date_of_Request;
                IRLC.Date_Last_Inspection__c = XMLInstance.Date_Last_Inspection;
                IRLC.Date_of_Inspection__c = XMLInstance.Date_of_Inspection;
                IRLC.Date_of_PHA_HQS_Inspection__c = XMLInstance.Date_of_PHA_HQS_Inspection;
                IRLC.Date_of_Contractor_Review__c = XMLInstance.Date_of_Contractor_Review;
                IRLC.Neighborhood_Census_Tract__c = XMLInstance.Neighborhood_Census_Tract;
                IRLC.Inspection_Type__c = XMLInstance.Type_of_Inspection;
                IRLC.HQS_Review_Type__c = XMLInstance.HQS_Review_Type;
                IRLC.Project_Number__c = XMLInstance.Project_Number;
                IRLC.Summary_Decision_on_the_Unit__c = XMLInstance.Summary_Decision_on_the_Unit;
                IRLC.Number_of_Sleeping_Rooms__c = XMLInstance.Number_of_Sleeping_Rooms;
                IRLC.ExAM__Field_Start_Time__c = XMLInstance.Unit_Start_Time;
                IRLC.ExAM__Field_End_Time__c = XMLInstance.Unit_End_Time;
                IRLC.Contractor_QC_Present__c = XMLInstance.Contractor_QC_Present;
                IRLC.Contractor_QC_Name__c = XMLInstance.Contractor_QC_Name;
                IRLC.REAC_QA_Present__c = XMLInstance.REAC_QA_Present;
                IRLC.REAC_QA_Name__c = XMLInstance.REAC_QA_Name;
                IRLC.ExAM__Location__c = XMLInstance.housing_Type;
                IRLC.Number_of_Children_in_Family_Under_6__c = XMLInstance.number_of_Children_in_Family_Under_6;
                IRLC.ExAM__Site_Contact__c = ownerConId;
                IRLC.Unit_Size__c = XMLInstance.unit_Size;
                IRLC.PHA_HQS_Result__c = XMLInstance.PHA_HQS_Result;
                IRLC.Name_of_Family__c = familyConId;
                if(IRLC != NULL)
                IRLCList.add(IRLC);
                //Insert IRLC;
                    List<DataBase.UpsertResult> upsertResults = DataBase.upsert(IRLCList, ExAM__IssueRequest_Life_Cycle__c.Fields.ExAM__Assignment_External_Id__c, true);
                        
                List<Attachment> attachToDel = [SELECT Id FROM Attachment WHERE Parentid=: IRLC.Id];
                if(attachToDel.size() > 0)
                    Delete attachToDel;
                
                If(XMLInstance.general_Photo != NULL){
                    
                    Attachment photoAttach = new Attachment(Parentid = IRLC.Id, Body = XMLInstance.general_Photo, Name = 'Picture',ContentType = 'image/png');
                    attachList.add(photoAttach);
                    //insert photoAttach;
                }
            
                if( pdfFile != NULL ){
                    
                    Attachment pdfAttach = new Attachment();
                    pdfAttach.Parentid = IRLC.Id;
                    if ( pdfFile.content != NULL ) pdfAttach.Body = pdfFile.content;
                    if ( pdfFile.filename != NULL ) {
                        
                         pdfAttach.Name = pdfFile.filename;
                    } else {
                     
                        pdfAttach.Name = 'PDF attachment';    
                    }
                    if ( pdfFile.mimetype!= NULL ) pdfAttach.ContentType = pdfFile.mimetype;
                    
                    attachList.add(pdfAttach);
                    //insert pdfAttach;
                }
            
                if ( attachList.size() > 0 ) {
                    
                    Insert attachList;
                    attachList = new List<Attachment>();
                }
                
                Map<String,String> innerMap = new Map<String,String>();
                String innerString = '';
                List<ExAM__Questionnaire_Response__c> answerList = new List<ExAM__Questionnaire_Response__c>();
                Map<String,ExAM__Questionnaire_Response__c> map2 = new Map<String,ExAM__Questionnaire_Response__c>();
                
                List<ExAM__Question_Template__c> questionList = new List<ExAM__Question_Template__c>();
                //To get the Id of the section
                
                Map<String,String> sectionIdMap = new Map<String,String>();
                for(ExAM__Section_Template__c sec : [SELECT Id,ExAM__Section_External_Id__c FROM ExAM__Section_Template__c WHERE ExAM__Section_External_Id__c IN: queryMap.keySet() ]){
                    
                    sectionIdMap.put(sec.ExAM__Section_External_Id__c,sec.Id);
                }
                // To Insert Questions for the new answers
                for( HUD52580XML.HQSItemDetails XMLIL : XMLICInstanceList ) {
                    
                    innerMap = queryMap.get(XMLIL.HQS_Section_Title);
                    if( innerMap  != NULL ) {
                        
                        if(!(innerMap.ContainsKey(XMLIL.HQS_Deficiency_Category))){
                            ExAM__Question_Template__c question = new ExAM__Question_Template__c();
                            question.ExAM__Question_Label__c = XMLIL.HQS_Deficiency_Category;
                            question.ExAM__Question_External_Id__c = XMLIL.HQS_Deficiency_Category;
                            question.ExAM__Section_Question__c = sectionIdMap.get(XMLIL.HQS_Section_Title);
                            question.ExAM__Subquestion_Label__c = 'Pass~Fail';
                            question.ExAM__Question_Type__c = 'RadioPicklist';
                            questionList.add(question);
                        }
                    }
                }
                if(questionList.Size() > 0 )
                Insert questionList;
                
                Set<String> quesIdList = new Set<String>();
                for(ExAM__Question_Template__c ques : questionList){
                    
                    quesIdList.add(ques.Id);
                    //System.debug('AddedMap'+queryMap.get(ques.ExAM__Section_Question__r.ExAM__Section_External_Id__c));
                    //queryMap.get(ques.ExAM__Section_Question__r.ExAM__Section_External_Id__c).put(ques.ExAM__Question_External_Id__c,ques.Id);
                    
                }
                
                for(ExAM__Question_Template__c  question: [SELECT Id,ExAM__Section_Question__r.ExAM__Section_External_Id__c,ExAM__Question_External_Id__c FROM ExAM__Question_Template__c WHERE Id IN:quesIdList]) {
                    //System.debug('Section Id::::'+question.ExAM__Section_Question__r.ExAM__Section_External_Id__c);
                    queryMap.get(question.ExAM__Section_Question__r.ExAM__Section_External_Id__c).put(question.ExAM__Question_External_Id__c,question.Id);
                }
                
                for( HUD52580XML.HQSItemDetails XMLIL : XMLICInstanceList ) {
                   
                    innerMap = queryMap.get(XMLIL.HQS_Section_Title);
                    if( innerMap  != NULL ) {
                        
                        innerString = innerMap.get(XMLIL.HQS_Deficiency_Category);
                        if( innerString != NULL && innerString != '') {
                            
                            ExAM__Questionnaire_Response__c newAnswer = new ExAM__Questionnaire_Response__c();
                            newAnswer.ExAM__Account_to_Response__c    = acctId; 
                            newAnswer.ExAM__Issue_Request__c          = IRLC.Id; 
                            newAnswer.ExAM__Question_Template__c      = innerString; 
                            newAnswer.ExAM__Answer_External_Id__c     = XMLIL.item_ID;
                            if(XMLIL.contractor_HQS_Decision == 'N/A' && sectionItemSet.contains(XMLIL.HQS_Section_Number+'.'+XMLIL.HQS_line_Item_Number)) {
                            
                                newAnswer.External_Response__c            = 'Pass';
                            } else {
                                
                                newAnswer.External_Response__c            = XMLIL.contractor_HQS_Decision;
                            }
                            newAnswer.QA_Comments__c                  = XMLIL.contractor_HQS_Details;
                            newAnswer.LT_Deficiency__c                = XMLIL.LT_Deficiency;
                            newAnswer.ExAM__Response__c               = XMLIL.PHA_Decision;
                            newAnswer.Response_Comments__c            = XMLIL.PHA_Details;
                            newAnswer.HQS_Category_ID__c              = XMLIL.HQS_Category_ID;
                            newAnswer.Audit_Response__c               = XMLIL.federal_Decision;
                            newAnswer.Audit_Comments__c               = XMLIL.federal_Details;
                            newAnswer.LQA_Category__c                 = XMLIL.LQA_Category;
                            newAnswer.Local_PHA_Decision__c           = XMLIL.local_PHA_Decision;
                            newAnswer.Local_PHA_Details__c            = XMLIL.local_PHA_Details;
                            newAnswer.Room_Location_1__c              = XMLIL.room_Location_1;
                            newAnswer.Room_Location_2__c              = XMLIL.room_Location_2;
                            newAnswer.Floor_Level__c                  = XMLIL.floor_Level;
                            newAnswer.Room_Code__c                    = XMLIL.room_Code;
                            newAnswer.Other_Room_Code_Description__c  = XMLIL.other_Room_Code_Description;
                            newAnswer.Deficiency_Location__c          = XMLIL.deficiency_Location;
                            newAnswer.Deficiency_Comments__c          = XMLIL.deficiency_Comments;
                            if(XMLIL.Time_of_Deficiency != null && XMLIL.Time_of_Deficiency.year() >= 1700){
                                
                                newAnswer.Time_of_Deficiency__c       = XMLIL.time_of_Deficiency;
                            }
                            if(comparisonMap.get(XMLIL.item_ID) != NULL) {
                                 //System.debug('Item Id for Reason for dis'+XMLIL.item_ID);
                                newAnswer.Reason_for_Discrepancy__c       = comparisonMap.get(XMLIL.item_ID).comparison_Result;
                            }
                            answerList.add(newAnswer);
                            map2.put(newAnswer.ExAM__Answer_External_Id__c,newAnswer);
                        }
                    }
                }
                if( answerList.size() > 0 ) {
                    
                    //Insert answerList;
                    //DataBase.UpsertResult[] upsertAnswerResults = connection.upsert('ExAM__Answer_External_Id__c', answerList);
                    //System.debug('answerList::::::'+answerList);
                    List<DataBase.UpsertResult> upsertAnswerResults = DataBase.upsert(answerList, ExAM__Questionnaire_Response__c.Fields.ExAM__Answer_External_Id__c, true);
                }
                List<Attachment>  ansPhotoAttachList = new List<Attachment>();
                
                Set<Id> answerAttachId = new Set<Id>();
                
                for( String s1 : map1.KeySet() ) {
                    
                    if( map2.get(s1) != NULL ) {
                        answerAttachId.add(map2.get(s1).id);
                        //System.debug('answerAttachId::::::'+answerAttachId);
                        Attachment ansPhotoAttach = new Attachment();
                        ansPhotoAttach.Parentid = map2.get(s1).id;
                        ansPhotoAttach.Name = map1.get(s1).fileName;
                        ansPhotoAttach.Body = map1.get(s1).fileData;
                        ansPhotoAttach.ContentType = map1.get(s1).fileType;
                        ansPhotoAttachList.add(ansPhotoAttach);
                        //System.debug('Id for the Answer:::::'+ansPhotoAttach);
                    }
                }
                List<Attachment> ansAttachDel = new List<Attachment>(); 
                ansAttachDel = [SELECT Id FROM Attachment WHERE Parentid IN: answerAttachId];
                //System.debug('ansAttachDel:::::'+ansAttachDel);
                if(ansAttachDel.size() > 0){
                    //System.debug('Inside delete');
                    Delete ansAttachDel;
                }
                
                if( ansPhotoAttachList.size() > 0 ) {
                    //System.debug('Size of ansPhotoAttachList::::'+ansPhotoAttachList.size());
                    Insert ansPhotoAttachList;
                }
                ansPhotoAttachList = new List<Attachment>();
                //System.debug('Size of the list'+XMLICInstanceList.size());
            //} else {
                //ApexPages.Message myMsg = new  ApexPages.Message(ApexPages.Severity.ERROR, errorMsg);
                //ApexPages.addMessage(myMsg);
            //}
            } catch (Exception e) {
                Database.rollback(sp);
                ApexPages.addMessages(e);
    
            }
        }
        return null;
    }
}