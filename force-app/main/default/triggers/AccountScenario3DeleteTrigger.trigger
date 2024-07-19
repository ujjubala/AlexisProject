trigger AccountScenario3DeleteTrigger on Account (before insert)
{
  //Map<Id, Account> accMap = new Map<Id, Account>();
 
  //for(Account objAcc : [select Id, (select Id from Contacts) from Account] )
    //  accMap.put(objAcc.Id, objAcc);
  List<Contact> conList = new List<Contact>();
  List<Account> accList = new List<Account>();
  if(trigger.isBefore && trigger.isInsert)
  {
    for(Account objAcc : trigger.new)
    {
      if(objAcc.Name == trigger.oldMap.get(objAcc.Id).Name)
        {
           conList = objAcc.Contacts;
           accList.add(objAcc); 
        }
     }
   }
 
    if(!accList.isEmpty())
        Database.delete(accList, False);
    if(!conList.isEmpty())
        Database.delete(conList, False);
}