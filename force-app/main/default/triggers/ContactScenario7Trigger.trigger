trigger ContactScenario7Trigger on Contact (after insert)
{
  Set<Id> accIdSet = new Set<Id>();
  if(trigger.isAfter && trigger.isInsert)
  {
    for(Contact objCon : trigger.new)
    {
      if(objCon.AccountId != null)
          accIdSet.add(objCon.AccountId);
    }
  }
  Map<Id, Account> accMap = new Map<Id, Account>();
  if(!accIdSet.isEmpty())
  {
    for(Account objAcc : [select Id, Total_Amount__c from Account where Id in : accIdSet])
        accMap.put(objAcc.Id, objAcc);
  }
  if(trigger.isAfter && trigger.isInsert)
  {
    if(!accMap.isEmpty())
    {
      for(Contact objCon : trigger.new)
      {
        if(accMap.containsKey(objCon.AccountId))
            accMap.get(objCon.AccountId).Total_Amount__c = accMap.get(objCon.AccountId).Total_Amount__c + objCon.Amount__c;
      }
    }
  }
   Database.update(accMap.values(), False);
}