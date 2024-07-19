public class AccountUpdateBatch implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
      String query = 'select Id, Name, Type from Account where Type= \'Prospect\' and Rating!= \'Cold\' ';
      return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Account> accList)
    {
      if(!accList.isEmpty())
      {
        for(Account objAcc : accList)
            objAcc.Rating = 'Cold';
      }
      Database.update(accList, false);
    }
    public void finish(Database.BatchableContext BC)
    {
        System.debug('#Finish');
    }
}