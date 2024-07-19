trigger AccountPreventDuplicate on Account (before insert, before update, after undelete )
{
  Set<String> accNameSet = new Set<String>();
  if((trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) || (trigger.isAfter && trigger.isUndelete))
  {
    for(Account objAcc : trigger.new)
        accNameSet.add(objAcc.Name);
    
    Map<String, Account> accMap = new Map<String, Account>();
    if(!accNameSet.isEmpty())
    {
      for(Account objAcc : [select Id, Name from Account where Name IN : accNameSet])
          accMap.put(objAcc.Name, objAcc);
    }
    if(!accMap.isEmpty())
    {
      for(Account objAcc : trigger.new)
      {
        if(accMap.containsKey(objAcc.Name))
            objAcc.addError(objAcc.Name + 'Already exists');
      }
    }
  }
}