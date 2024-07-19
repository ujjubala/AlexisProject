trigger OpportunityDeleteTrigger on Opportunity (before delete)
{
  if(trigger.isBefore && trigger.isDelete)
  {
    for(Opportunity objOppo : trigger.old)
    {
      Integer month = objOppo.CloseDate.month();
      if(objOppo.Amount >= 18000 || month == 8 || month == 10 || objOppo.StageName == 'Prospecting' || objOppo.StageName == 'Closed Lost' )
          objOppo.addError('Opportunity Can not be Deleted');    
    }
  }
}