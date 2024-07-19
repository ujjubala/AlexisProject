public class BatchOpportunity  implements Database.Batchable<sObject>
{
  public Database.QueryLocator start(Database.BatchableContext BC)
  {
     return Database.getQueryLocator('select Id, StageName, Amount, Description, Account.Sic from Opportunity where StageName!= \'Closed Won\' and Amount >5000 ' );
  }
  public void execute(Database.BatchableContext BC, List<Opportunity> oppList)
  {
    if(!oppList.isEmpty())
    {
      for(Opportunity objOpp : oppList)
      {
        objOpp.StageName    = 'Closed Won';
        objOpp.Description  =  objOpp.Account.Sic;
      }
    }
    Database.update(oppList, False);
  }
   public void finish(Database.BatchableContext BC)
   {
     System.debug('#Finish');
   }
}