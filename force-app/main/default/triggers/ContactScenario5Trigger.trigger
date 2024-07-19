trigger ContactScenario5Trigger on Contact (after insert)
{
   Set<Id> accIdSet = new Set<Id>();
   if(trigger.isAfter && trigger.isInsert)
   {
     for(Contact objCon : trigger.new)
     {
       if(objCon.AccountId!=null)
       {
         if(trigger.isInsert)  
           accIdSet.add(objCon.AccountId);
       }
     }
   }
   Map<Id, Account> accMap = new Map<Id, Account>();
   if(!accIdSet.isEmpty())
   {
     for(Account objAcc : [select Id, Phone from Account where Id in : accIdSet])
         accMap.put(objAcc.Id, objAcc);
   }
   if(trigger.isAfter && trigger.isInsert)
   {
     for(Contact objCon : trigger.new)
     {
       if(!accMap.isEmpty())
       {
         if(accMap.containsKey(objCon.AccountId))
            accMap.get(objCon.AccountId).Phone = objCon.Phone;  
       }
     }
   }
   Database.update(accMap.values(), false);
}