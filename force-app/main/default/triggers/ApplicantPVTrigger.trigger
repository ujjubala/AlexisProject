trigger ApplicantPVTrigger on Applicant__c (before delete)
{
  if(trigger.isBefore && trigger.isDelete)
  {
    for(Applicant__c objApp : trigger.old)
    {
      if(objApp.Police_Verification__c)
          objApp.addError('Police Verificaton Applicant Record can not be deleted');
    }
  }
}