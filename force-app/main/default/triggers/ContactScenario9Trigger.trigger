trigger ContactScenario9Trigger on Contact (before insert, before update, after unDelete) 
{
  Set<Id> accIdSet = new Set<Id>();
  if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete) )
  {
    for(Contact objCon : trigger.new)
    {
      if(objCon.AccountId != null)
      {
        if(trigger.isInsert || trigger.isUndelete)
            accIdSet.add(objCon.AccountId);
      }
    
     if(trigger.isUpdate)
     {
      if(objCon.AccountId != trigger.oldMap.get(objCon.Id).AccountId)
         accIdSet.add(objCon.AccountId);              
     }
    }
  }
     Map<Id, Account> accMap = new Map<Id, Account>();
     if(!accIdSet.isEmpty())
     {
        for(Account objAcc : [select Id, (select Id from Contacts) from Account where Id in : accIdSet])
            accMap.put(objAcc.Id, objAcc);         
     }
     if(!accMap.isEmpty())
     {
       if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete))
       {
          for(Contact objCon : trigger.new)
          {
            if(accMap.containsKey(objCon.AccountId))
            {
              List <Contact> conList = accMap.get(objCon.AccountId).Contacts;
              if(conList.size() >= 1)
                  objCon.addError('Cant insert this Contact....');
            }
         }
      }
   }
}