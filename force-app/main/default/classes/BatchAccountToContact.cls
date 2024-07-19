public class BatchAccountToContact implements Database.Batchable<sObject>
{
   public Database.QueryLocator start (Database.BatchableContext BC)
   {
     String query = 'select Id, Type, Rating, Phone from Account where Type = \'Prospect\' ';
     return Database.getQueryLocator(query);
   }
   public void execute(Database.BatchableContext BC, List<Account> accList)
   {
     Map<Id, Account> accMap = new Map<Id, Account>(accList);
     
     List<Contact> conList = new List<contact>();
     for(Contact objCon : [select Id, AccountId, Level__c from Contact where AccountId in : accMap.keySet()])
         conList.add(objCon);
       
     if(!conList.isEmpty())
     {
       for(Contact objCon : conList)
       {
          if(accMap.containsKey(objCon.AccountId))
          {
              objCon.Level__c    = 'Primary';
              objCon.MobilePhone =  accMap.get(objCon.AccountId).Phone;
          }
        }
     }
     
     Database.update(conList, false);    
   }
   public void finish(Database.BatchableContext BC) 
   {
     System.debug('#Finish');
   }
}