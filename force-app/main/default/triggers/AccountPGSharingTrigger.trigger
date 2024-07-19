trigger AccountPGSharingTrigger on Account (after insert, after update)
{
  Set<String> publicGroupSet = new Set<String>();
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    for(Account objAcc : trigger.new)
    {
      if(String.isNotBlank(objAcc.Select_Public_Group__c))
          publicGroupSet.add(objAcc.Select_Public_Group__c);
    }
  }
  Map<String, Group> groupMap = new Map<String, Group>();
  
  for(Group objGroup : [select Id, Name from Group where Name in :publicGroupSet])
     groupMap.put(objGroup.Name, objGroup);
  
  List<AccountShare> accShareList = new List<AccountShare>();
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    System.debug('#1');
    for(Account objAcc: trigger.new)
    {
      System.debug('#2');
      if(groupMap.containsKey(objAcc.Select_Public_Group__c))
      {
        System.debug('#3');
        AccountShare accShare           = new AccountShare();
        accShare.AccountId              = objAcc.Id;
        accShare.UserOrGroupId          = groupMap.get(objAcc.Select_Public_Group__c).Id;
        System.debug('!!!!!!!!!!!!!!!!');
        System.debug('Group Id is :' + accShare.UserOrGroupId);
        System.debug('Id got');
        accShare.AccountAccessLevel     = 'Read';
        accShare.CaseAccessLevel        = 'Read';
        accShare.OpportunityAccessLevel = 'Read';
        accShareList.add(accShare);
      }
    }
  }
  if(!accShareList.isEmpty())
     Database.insert(accShareList, False);
}