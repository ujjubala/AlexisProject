trigger AccountSharingTrigger on Account (after insert, after update)
{
  List<AccountShare> accShareList = new List<AccountShare>();
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    for(Account objAcc : trigger.new)
    {
      AccountShare objAccShare              = new AccountShare();
      objAccShare.AccountId                 = objAcc.Id;
      objAccShare.UserOrGroupId             = objAcc.Select_User__c;
      objAccShare.AccountAccessLevel        = 'Read';
      objAccShare.CaseAccessLevel           = 'Read';
      objAccShare.OpportunityAccessLevel    = 'Read';
      accShareList.add(objAccShare);
    }
  }
  if(!accShareList.isEmpty())
      Database.insert(accShareList, false);
}