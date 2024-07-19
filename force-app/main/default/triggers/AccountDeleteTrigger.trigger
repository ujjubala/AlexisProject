trigger AccountDeleteTrigger on Account (before delete)
{
  for(Account objAcc : trigger.old)
  {
    if(objAcc.Rating=='Hot')
       objAcc.addError('This account can not be deleted as its Rating is Hot');   
  }
}