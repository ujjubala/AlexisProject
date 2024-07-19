trigger AccountTrigger on Account (before insert, before update)
{
  List <Account> accList = trigger.new;
  if(!accList.isEmpty())
  {
    for(Account objAcc : accList)
    {
      if(objAcc.Type=='Prospect')
          objAcc.Rating='Hot';
    }
  }
}