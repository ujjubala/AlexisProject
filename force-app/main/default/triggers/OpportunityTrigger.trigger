trigger OpportunityTrigger on Opportunity (after insert, after update)
{
  Set<id> accIdSet = new Set<id>();
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    for(Opportunity objOppo : trigger.new)
    {
      if(objOppo.AccountId!=null)
      {
        System.debug('#1');
        if(trigger.isInsert)
            accIdSet.add(objOppo.AccountId);
        if(trigger.isUpdate)
        {
          if(objOppo.AccountId!= trigger.oldMap.get(objOppo.id).AccountId)
            accIdSet.add(objOppo.AccountId); 
        }
      }
    }
  }
  System.debug('#2');
  Map<Id,Account> accMap = new Map<id, Account>();
  if(!accIdSet.isEmpty())
  {
    for(Account objAcc : [select Id, SLA__c from Account where Id in : accIdSet])
      accMap.put(objAcc.Id, objAcc);
  }
  System.debug('#3');
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    for(Opportunity objOppo : trigger.new)
    {
      if(accMap.containsKey(objOppo.AccountId))
      {
        System.debug('#4');
        if(objOppo.Amount <= 8000 && objOppo.StageName == 'Closed Lost')
        {
          accMap.get(objOppo.AccountId).SLA__c = 'Silver';
          System.debug('SLA updated to Silver');
        }
        else
           accMap.get(objOppo.AccountId).SLA__c = ' ';
      }
    }
  }
    System.debug('#5');
    Database.update(accMap.values(),false);
    System.debug('#6');
}