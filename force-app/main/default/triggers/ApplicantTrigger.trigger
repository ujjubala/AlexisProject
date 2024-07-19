trigger ApplicantTrigger on Applicant__c (before insert) 
{
   for(Applicant__c objApp : trigger.new)
   {
     if(String.isBlank(objApp.PAN_Card__c))
         objApp.PAN_Card__c.addError('Pan Card should not be blank');
   }
}