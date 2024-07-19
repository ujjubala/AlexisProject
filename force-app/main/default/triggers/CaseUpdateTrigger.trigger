trigger CaseUpdateTrigger on Case (before insert, before update) 
{
  if(trigger.isBefore  && (trigger.isUpdate || trigger.isInsert))
  {
    for(Case objCase : trigger.new)
    {
       if(objCase.Priority=='High')
           objCase.SLAViolation__c = 'Yes';
    }
  }
}