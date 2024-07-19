trigger CaseDeleteTrigger on Case (before delete)
{
  if(trigger.isBefore && trigger.isDelete)
  {
    for(Case objCase : trigger.old)
    {
      if(objCase.Status=='Escalated' && objCase.CreatedDate.month()==8)
          objCase.addError('This Case can not be deleted as its status is Escalated');
    }
  }
}