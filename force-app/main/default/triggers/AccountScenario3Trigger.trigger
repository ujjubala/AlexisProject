trigger AccountScenario3Trigger on Account (before insert) 
{
   Map<String, Account> accMap = new Map<String, Account>();
   List<Account> accList   = [select Id, Name,(select Id from Contacts) from Account];  
   if(!accList.isEmpty())
   {
     for(Account objAcc : accList)
     {
       accMap.put(objAcc.Name, objAcc);
     }
   }
   List<Contact> conList = new List<Contact>();
   List<Account> newList = new List<Account>();
   if(trigger.isBefore && trigger.isInsert)
   {
     for(Account objAcc : trigger.new)
     {
       if(accMap.containsKey(objAcc.Name))
       {
         System.debug('Inside Delete');
         conList = accMap.get(objAcc.Name).Contacts;
         newList.add(accMap.get(objAcc.Name));
         System.debug('Work done');
       }
     }
   }
   if(!newList.isEmpty())
       Database.delete(newList, False);
      
   if(!conList.isEmpty())
       Database.delete(conList, False);
    
   Database.update(accMap.values(), false);
}