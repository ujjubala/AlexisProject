trigger AccountScenarioTrigger1 on Account (before insert, before update, after unDelete)
{
   Set <String> accNameSet = new Set<String>();
   if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete)) 
   {
     for(Account objAcc : trigger.new)
         accNameSet.add(objAcc.Name);
   }
 
   Map<String, Account> accMap = new Map<String, Account>();
   
   for(Account objAcc : [select Id, Name from Account where Name in : accNameSet])
       accMap.put(objAcc.Name, objAcc);
   if(!accMap.isEmpty())
   {
     for(Account objAcc: trigger.new)
     {
       if(accMap.containsKey(objAcc.Name))
           objAcc.addError('This Account already exists');
     }
   }
}