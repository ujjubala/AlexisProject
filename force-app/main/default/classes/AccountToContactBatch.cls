public class AccountToContactBatch implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
      String query = 'select Id, Type from Account where Type= \'Prospect\'  ';
      return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Account> accList)
    {
      Map<Id, Account> accMap = new Map<Id, Account>();
      if(!accList.isEmpty())
      {
        for(Account objAcc : accList)
        {
          accMap.put(objAcc.Id, objAcc);
        }
      }
      
      List<Contact> conList = new List<Contact>();
      
      for(Contact objCon : [select Id, Level__c, AccountId from Contact where AccountId in : accMap.keySet()])
          conList.add(objCon);
      
      for(Contact objCon : conList)
      {
        if(accMap.containsKey(objCon.AccountId))
        {
          objCon.Level__c = 'Primary';
        }
      }
      Database.update(conList, false);
    }
    public void finish(Database.BatchableContext BC)
    {
       System.debug('#Finish');
    }
}