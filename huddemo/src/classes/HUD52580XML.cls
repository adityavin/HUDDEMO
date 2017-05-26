public class HUD52580XML{
    
    Transient public String inspection_ID;
    Transient public String reviewer_ID;
    Transient public String reviewer_Name;
    Transient public String contractor;
    Transient public String PHA_Inspector_Name;
    Transient public String PHA_Employee;
    Transient public String PHA_Code;
    Transient public String tenant_ID_Number;
    Transient public Date date_of_Request;
    Transient public Date date_Last_Inspection;
    Transient public Datetime date_of_Inspection;
    Transient public Date date_of_PHA_HQS_Inspection;
    Transient public Date date_of_Contractor_Review;
    Transient public String neighborhood_Census_Tract;
    Transient public String type_of_Inspection;
    Transient public String HQS_Review_Type;
    Transient public String project_Number;
    Transient public String unit_Street_Address;
    Transient public String unit_City;
    Transient public String unit_County;
    Transient public String unit_State;
    Transient public String unit_Zip;
    Transient public String name_of_Family;
    Transient public String current_Street_Address;
    Transient public String current_City;
    Transient public String current_County;
    Transient public String current_State;
    Transient public String current_Zip;
    Transient public String housing_Type;
    Transient public String housing_Type_Other_Comment;
    Transient public Integer number_of_Children_in_Family_Under_6;
    Transient public String name_of_Owner_or_Agent_Authorized_to_Lease_Unit_Inspected;
    Transient public String telephone_of_Owner_or_Agent;
    Transient public String address_of_Owner_or_Agent;
    Transient public String summary_Decision_on_the_Unit;
    Transient public Integer unit_Size;
    Transient public Integer year_Constructed;
    Transient public Integer number_of_Sleeping_Rooms;
    Transient public Datetime unit_Start_Time;
    Transient public Datetime unit_End_Time;
    Transient public String PHA_HQS_Result;
    
    Transient public String contractor_QC_Present;
    Transient public String contractor_QC_Name;
    Transient public String REAC_QA_Present;
    Transient public String REAC_QA_Name;
    Transient public Blob general_Photo;
    
    public class HQSItemDetails{
    
        Transient public String item_ID;
        Transient public Integer answer_Inspection_ID;
        Transient public Integer HQS_Section_Number;
        Transient public String HQS_Section_Title;
        Transient public Integer HQS_line_Item_Number;
        Transient public String HQS_Deficiency_Category;
        Transient public String contractor_HQS_Decision;
        Transient public String contractor_HQS_Details;
        Transient public String LT_Deficiency;
        Transient public String PHA_Decision;
        Transient public String PHA_Details;
        Transient public String HQS_Category_ID;
        Transient public String federal_Decision;
        Transient public String federal_Details;
        Transient public String LQA_Category;
        Transient public String local_PHA_Decision;
        Transient public String local_PHA_Details;
        Transient public String room_Location_1;
        Transient public String room_Location_2;
        Transient public Integer floor_Level;
        Transient public String room_Code;
        Transient public String other_Room_Code_Description;
        Transient public String deficiency_Location;
        Transient public String deficiency_Comments;
        Transient public Datetime time_of_Deficiency;
        Transient public Blob photo;
        
        Transient List<photo> attachPhotoList = new List<photo>();
        
    }
    
    public class photo{
    
        Transient public blob fileData;
        Transient public String fileFlags;
        Transient public String fileName;
        Transient public String fileTimeStamp;
        Transient public String fileType;
        Transient public String fileURL;
    }
    
    public class ComparisonExplanationPhoto{
    
        Transient public String comparison_Result;
        Transient public String explanation_of_Differences;
        Transient public Datetime time_stamp;
    }
    
    public class PHAPdf{
    
        Transient public String mimetype;
        Transient public String filename;
        Transient public Blob content;
    }
}