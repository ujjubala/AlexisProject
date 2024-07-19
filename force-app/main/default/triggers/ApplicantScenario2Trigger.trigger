trigger ApplicantScenario2Trigger on Applicant__c (before insert, before update)
{
  if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
  {
    for(Applicant__c objApp : trigger.new)
    {
      if(objApp.Gender__c == 'Male' && !objApp.First_Name__c.startswith('Mr.'))
      {
          objApp.First_Name__c = objApp.First_Name__c.remove('Ms.');
          objApp.First_Name__c = 'Mr.' + objApp.First_Name__c;
      }
      if(objApp.Gender__c == 'Female' && !objApp.First_Name__c.startsWith('Ms.'))
      {
          objApp.First_Name__c = objApp.First_Name__c.remove('Mr.');
          objApp.First_Name__c = 'Ms.' + objApp.First_Name__c;
      }
      if(objApp.Gender__c == 'Transgender')
          objApp.addError('Currently this applicant is not Eligible');
    }
  }
}