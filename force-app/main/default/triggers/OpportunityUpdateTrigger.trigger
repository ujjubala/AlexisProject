trigger OpportunityUpdateTrigger on Opportunity (before update)
{
  if(trigger.isBefore && trigger.isUpdate)
  {
    for(Opportunity objOppo : trigger.new)
    {
      if(objOppo.StageName    == 'Closed Won' && trigger.oldMap.get(objOppo.ID).StageName == 'Closed Lost')
          objOppo.Description  = 'Yahoo......!!!!!!';
      else
          objOppo.Description  =  ' ';
    }
  }
}