trigger ContactTrigger15Nov on Contact (after insert) {
Set<ID> accIdSet = new Set<ID>();
    if(trigger.isInsert && trigger.isAfter)
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
      for(Account objAcc : [select Id, Description from Account where Id in : accIdSet])
        accMap.put(objAcc.Id, objAcc);
    }
    System.debug('Updating Description field');
    if(!accMap.isEmpty())
    {
      if(trigger.isInsert && trigger.isAfter)
      {
        for(Contact objCon : trigger.new)
        {
           if(accMap.containsKey(objCon.AccountId))
              accMap.get(objCon.AccountId).Description = objCon.FirstName + ' ' + objCon.LastName;
        }
     }
     System.debug('Database operation');
     Database.update(accMap.values(), false);
   }
}