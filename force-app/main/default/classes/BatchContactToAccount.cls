public class BatchContactToAccount implements Database.Batchable<sObject> 
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
      return Database.getQueryLocator('select Id, LeadSource, FirstName, LastName, Account.Rating, Account.Name from Contact where LeadSource=\'Web\' and Account.Rating!=\'Cold\'  ');
    }
    public void execute(Database.BatchableContext BC, List<Contact> conList)
    {
      Set<Id> accIdSet = new Set<Id> ();
      
      for(Contact objCon : conList)
      {
         if(objCon.AccountId!=null)
            accIdSet.add(objCon.AccountId);
      }
      Map<Id, Account> accMap = new Map<Id, Account>();
      if(!accIdSet.isEmpty())
      {
        for(Account objAcc : [select Id, Name, Rating from Account where Id in : accIdSet])
            accMap.put(objAcc.Id, objAcc);
      }
      if(!accMap.isEmpty())
      {
        for(Contact objCon : conList)
        {
           if(accMap.containsKey(objCon.AccountId))
               accMap.get(objCon.AccountId).Rating = 'Cold';
        }
      } 
      Database.update(accMap.values(), false);
    }
    public void finish(Database.BatchableContext BC)
    {
      System.debug('#fFinsh');
    }
}