@isTest
public Class TestHUDXMLUploadController{
    public Static testMethod void testMethodForHUDXMLUploadController(){
        //HUDTestXML.Test3rdXMLContent = HUDTestXML.TestXMLContent;
        HUDXMLUploadController HUD = new HUDXMLUploadController();
        HUD.testClassString = HUDTestXML.TestXMLContent;
        HUD.uploadxml();
        HUD52580XML XML = new HUD52580XML();
        HUD52580XML.HQSItemDetails XML1 = new HUD52580XML.HQSItemDetails();
        HUD52580XML.photo XML2 = new HUD52580XML.photo();
        HUD52580XML.ComparisonExplanationPhoto XML3 = new HUD52580XML.ComparisonExplanationPhoto();
        HUD52580XML.PHAPdf XML4 = new HUD52580XML.PHAPdf();
    } 
    public Static testMethod void testMethodForErrorHUDXMLUploadController(){
        //HUDTestXML.Test3rdXMLContent = HUDTestXML.TestErrorXMLContent;  
        HUDXMLUploadController HUD = new HUDXMLUploadController();
        HUD.testClassString = HUDTestXML.TestErrorXMLContent;
        HUD.uploadxml();
        HUD52580XML XML = new HUD52580XML();
        HUD52580XML.HQSItemDetails XML1 = new HUD52580XML.HQSItemDetails();
        HUD52580XML.photo XML2 = new HUD52580XML.photo();
        HUD52580XML.ComparisonExplanationPhoto XML3 = new HUD52580XML.ComparisonExplanationPhoto();
        HUD52580XML.PHAPdf XML4 = new HUD52580XML.PHAPdf();
    } 
}