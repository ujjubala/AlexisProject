public class BatchCaseUpdate implements Database.Batchable<sObject>
{
   public Database.QueryLocator start(Database.BatchableContext BC)
   {
     return Database.getQueryLocator('select Id, Account.Type, Status, Account.Rating,CaseNumber from Case where Account.Type= \'Prospect\' and Status= \'Escalated\' and Account.Rating!= \'Hot\'  ');
   }
   public void execute(Database.BatchableContext BC, List<Case> caseList)
   {
     Set<Id> accIdSet = new Set<Id>();
     if(!caseList.isEmpty())
     {
       for(Case objCase : caseList)
       {
         if(objCase.AccountId!=null)
             accIdSet.add(objCase.AccountId);
       }
     }
     Map<Id, Account> accMap = new Map<Id, Account>();
      
     if(!accIdSet.isEmpty())
     {
       for(Account objAcc : [select Id, Name, Description, Rating from Account where Id in : accIdSet])
          accMap.put(objAcc.Id, objAcc);
     }  
     for(Case objCase : caseList)
     {
       if(!accMap.isEmpty())
       {
         if(accMap.containsKey(objCase.AccountId))
         {
           accMap.get(objCase.AccountId).Rating      = 'Hot';
           accMap.get(objCase.AccountId).Description =  objCase.CaseNumber;
         }
       }
     }
     Database.update(accMap.values(), False);
   }
   public void finish(Database.BatchableContext BC)
   {
     System.debug('#Finish');
   }
 }