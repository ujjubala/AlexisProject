public class BatchAccountToOpportunity implements Database.Batchable<sObject>
{
  public Database.QueryLocator start(Database.BatchableContext BC)
  {
    String query = 'select Id, Rating from Account';
    return Database.getQueryLocator(query);
  }
  public void execute(Database.BatchableContext BC, List<Account> accList)
  {
    Map<Id, Account> accMap   = new Map<Id, Account>(accList);
    
    List<Opportunity> oppList = new List<Opportunity>();
    
    if(!accMap.isEmpty())
    {
      for(Opportunity objOpp : [select Id, AccountId, DeliveryInstallationStatus__c from Opportunity where AccountId in : accMap.keySet()])
         oppList.add(objOpp);
    }
    if(!oppList.isEmpty())
    {
      for(Opportunity objOpp : oppList)
      {
        if(accMap.containsKey(objOpp.AccountId))
        {
           String rtng = accMap.get(objOpp.AccountId).Rating;
           if(rtng == 'Hot')
               objOpp.DeliveryInstallationStatus__c = 'Completed';
           else if (rtng == 'Cold' || rtng == 'Warm')
               objOpp.DeliveryInstallationStatus__c = 'In progress';
           else
               objOpp.DeliveryInstallationStatus__c = 'Yet to begin';
        }        
      }
      Database.update(oppList, false);
   }
 }
   public void finish(Database.BatchableContext BC)
   {
     System.debug('#Finish');
   }
}