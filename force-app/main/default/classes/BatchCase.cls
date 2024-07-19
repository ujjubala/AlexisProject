public class BatchCase implements Database.Batchable<sObject>
{
   public Database.QueryLocator start(Database.BatchableContext BC)
   {
     return Database.getQueryLocator('select Id, Status from Case where Status!= \'Escalated\' and CreatedDate = Last_n_Days:120');
   }
   public void execute(Database.BatchableContext BC, List<Case> caseList)
   {
     if(!caseList.isEmpty())
     {
       for(Case objCase : caseList)
          objCase.Status = 'Escalated';
     }
     Database.update(caseList, false);
   }
   public void finish(Database.BatchableContext BC)
   {
     System.debug('#Finish');
   }
}