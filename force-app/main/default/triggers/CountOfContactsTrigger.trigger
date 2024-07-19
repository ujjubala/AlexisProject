trigger CountOfContactsTrigger on Contact (after insert, after update, after delete, after unDelete) 
{
   Set<Id> accIdSet = new Set<Id>();
   if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete ))
   {
     for(Contact objCon : trigger.new)
     {
       if(objCon.AccountId != null)
       {
         if(trigger.isInsert || trigger.isUnDelete)
            accIdSet.add(objCon.AccountId);
         if(trigger.isUpdate)
         {
           if(objCon.AccountId != trigger.oldMap.get(objCon.Id).AccountId)
              accIdSet.add(objCon.AccountId);
         }
       }
     }
   }
   if(trigger.isAfter && (trigger.isDelete || trigger.isUpdate))
   {
     for(Contact objCon : trigger.old)
         accIdSet.add(objCon.AccountId);
   }
      
   Map <Id, Account> accMap = new Map<Id, Account>();
   if(!accIdSet.isEmpty())
   {
     for(Account objAcc : [select Id,Count_Of_Contacts__c, (select Id from Contacts) from Account where Id in : accIdSet])
     {
       List <Contact> conList        = objAcc.Contacts;
       objAcc.Count_Of_Contacts__c   = conList.size();
       accMap.put(objAcc.Id, objAcc);
     }      
   }
   if(!accMap.isEmpty())
       Database.update(accMap.values(), false);
}