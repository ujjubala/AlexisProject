trigger ContactToAccountSelfTrigger on Contact (before insert, before update)
{
   Set<Id> accIdSet = new Set<Id>();
   System.debug('#1');
   if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
   {
     for(Contact objCon : trigger.new)
     {
       if(objCon.AccountId!=null)
       {
         if(trigger.isInsert)
           accIdSet.add(objCon.AccountId);
         if(trigger.isUpdate)
         {
           if(objCon.AccountId != trigger.oldMap.get(objCon.Id).AccountId)
             accIdSet.add(objCon.AccountId);
         }
       }                  
     }
   }
     System.debug('#2');
     Map<Id, Account> accMap = new Map<Id, Account>();
     if(!accIdSet.isEmpty())
     {
       for(Account objAcc : [select Id, Rating from Account where Id IN : accIdSet])
         accMap.put(objAcc.ID, objAcc);
     }
     if(!accMap.isEmpty())
     {
       if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
       {
         for(Contact objCon : trigger.new)
         {
            if(accMap.containsKey(objCon.AccountId))
            {
              if(accMap.get(objCon.AccountId).Rating == 'Hot')
              {
                 System.debug('updating Level of Contact');
                 objCon.Level__c = 'Primary';
              }
             }
         }
      }
   }
}