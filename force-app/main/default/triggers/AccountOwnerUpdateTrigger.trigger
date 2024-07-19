trigger AccountOwnerUpdateTrigger on Account (after update)
{
  List <Contact> conList = new List <Contact>();
  for(Contact objCon : [select Id, AccountId, OwnerId from Contact where AccountId In : trigger.newMap.keySet()])
          conList.add(objCon);
  if(!conList.isEmpty())
  {
    for(Contact objConList : conList)
       objConList.OwnerId = trigger.newMap.get(objConLIst.AccountId).OwnerId;
  }
  Database.update(conList, False);
}