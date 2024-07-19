trigger AccountRUpdateTrigger on Account (before update)
{
  if(trigger.isBefore && trigger.isUpdate)
  {
    for(Account objAcc : trigger.new)
    {
      if(objAcc.Rating == 'Hot' && trigger.oldMap.get(objAcc.Id).Rating == 'Warm')
          objAcc.addError('Rating can not be Hot from Warm');
    }
  }
}