public class OpportunityUpdateBatch implements Database.Batchable<sObject> 
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
      String query = 'select Id,Amount from Opportunity where StageName= \'Closed Lost\' and Amount < 500 ';
      return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Opportunity> oppoList)
    {
      if(!oppoList.isEmpty())
      {
        System.debug('#1');
        for(Opportunity objOppo : oppoList)
        {
            objOppo.Amount = 0;
            System.debug('#2');
        }
      }
      Database.update(oppoList, false);
    }
    public void finish(Database.BatchableContext BC)
    {
      System.debug('#Finish');
    }
}