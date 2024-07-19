public without sharing class VerifyEmailForLead 
{
  @AuraEnabled
  public static string verifyEmail(Lead objLead)
  {
    String deliverable;
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://emailvalidation.abstractapi.com/v1/?api_key=9fe46f3a97fe4fa1b129b3437bb2d0e4&email='+objLead.Email);

    request.setMethod('GET');
    HttpResponse response = http.send(request);
    if(response.getStatusCode()==200)
       System.debug('#Response' + response.getBody());

       EmailVerificationAPIWrapper objWrap = new EmailVerificationAPIWrapper().parse(response.getBody());
       deliverable = objWrap.deliverability;
       Lead obj = new Lead();
       if(objWrap.deliverability=='DELIVERABLE')
       {
        obj.FirstName            = objLead.FirstName;
        obj.LastName             = objLead.LastName;
        obj.Company              = objLead.Company;
        obj.Status               = objLead.Status;
        obj.Email                = objLead.Email;
        obj.is_Email_Id_Valid__c = true;
       }
       else
       {
        obj.FirstName            = objLead.FirstName;
        obj.LastName             = objLead.LastName;
        obj.Company              = objLead.Company;
        obj.Status               = objLead.Status;
        obj.Email                = objLead.Email;
        obj.is_Email_Id_Valid__c = false;
       }
       insert obj;
       return deliverable;
  }
  public class EmailVerificationAPIWrapper
  {
      public String email;
      public String autocorrect;
      public String deliverability;
      public String quality_score;
   
     public  EmailVerificationAPIWrapper parse(String json) 
    {
     return (EmailVerificationAPIWrapper) System.JSON.deserialize(json, EmailVerificationAPIWrapper.class);
    }
  }
}