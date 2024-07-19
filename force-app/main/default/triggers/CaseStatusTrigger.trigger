trigger CaseStatusTrigger on Case (before update)
{
  if(trigger.isBefore && trigger.isUpdate)
  {
    for(Case objCase : trigger.new)
    {
      if(objCase.Status == 'Escalated' && trigger.oldMap.get(objCase.ID).Status == 'Working')
         objCase.SLAViolation__c = 'Yes';
      else
         objCase.SLAViolation__c = ' ';
     }
  }
}