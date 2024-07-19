public with sharing class VeriphoneRequestAPI 
{
   @AuraEnabled
   public static Boolean verifyMobileNumber(Contact contactObj)
   {
    Boolean phoneValid;
    Contact objCon = [select Id,FirstName,LastName,MobilePhone from Contact where FirstName =: contactObj.FirstName and LastName = : contactObj.LastName limit 1];
    //String mobileNum = objCon.MobilePhone;
    Id conId = objCon.Id;
    System.debug('#Mobile Number:' +objCon.MobilePhone);
    System.debug('#Id :'+conId);
    
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://phonevalidation.abstractapi.com/v1/?api_key=c344aa64de3f4559866069331147ff1b&phone='+objCon.MobilePhone);
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    if(response.getStatusCode()==200)
       System.debug('#Response' + response.getBody());

    MobileNumberVerificationAPIWrapper wrapObject = new MobileNumberVerificationAPIWrapper();
    MobileNumberVerificationAPIWrapper wrapObj = wrapObject.parse(response.getBody());
    //Contact obj = new Contact(Id = conId);
    phoneValid = wrapObj.valid;
    if(wrapObj.valid)
    {
      objCon.Mobile_Active__c           = wrapObj.valid;
      objCon.Mobile_Verified__c         = true;
      objCon.Mobile_Service_Provider__c = wrapObj.carrier;
    }
    else
    {
      objCon.Mobile_Active__c           = wrapObj.valid;
      objCon.Mobile_Verified__c         = false;
      objCon.Mobile_Service_Provider__c = ' ';
    }
    update objCon;
    return phoneValid;
    }
   public class MobileNumberVerificationAPIWrapper 
   {
	  public Boolean valid;
     public String carrier;

	  public MobileNumberVerificationAPIWrapper parse(String json) 
    {
		return (MobileNumberVerificationAPIWrapper) System.JSON.deserialize(json, MobileNumberVerificationAPIWrapper.class);
	 }
  }
}