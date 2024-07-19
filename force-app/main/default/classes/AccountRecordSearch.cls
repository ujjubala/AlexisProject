public with sharing class AccountRecordSearch 
{
   @AuraEnabled
   public static List<Account> searchAccountRecords(Account objAcc)
   {
      return [select Id, Name, Type, Rating,CreatedDate,SLA__c from Account where Type =: objAcc.Type and Rating =: objAcc.Rating];
   }
   @AuraEnabled
   public static List<Account> searchAccountRecordsType (Account objAcc)
   {
      return [select Id, Name, Type, Rating, SLA__c from Account where Type =: objAcc.Type];     
   }
   @AuraEnabled
   public static List<Account> latestAccountRecords(Account objAcc)
   {
     return [select Id, Name, Type, Rating, CreatedDate, SLA__c from Account   order by CreatedDate desc LIMIT 10];          
   }
   @AuraEnabled
   public static List<Account> searchAccountDateRange(Account objAcc, Date date1, Date date2)
   {
      return [select Id, Name, Type, Rating, CreatedDate, SLA__c from Account where Type = :objAcc.Type and Rating = :objAcc.Rating and CreatedDate >= : date1 and CreatedDate <= : date2];     
   }
   @AuraEnabled
   public static List<Account> deleteSelectedAccountRecords(List<Id> accIdList, Account objAccount, Date fromDate, Date toDate)
   {
       try 
       {
           List<Account> accList = [Select Id from Account where Id IN : accIdList];
           Database.delete(accList ,false);
           //return [select Id, Name, Type, Rating, CreatedDate, SLA__c from Account where Type = :objAccount.Type and CreatedDate >= : fromDate and CreatedDate <= : toDate]; 
           return AccountRecordSearch.searchAccountDateRange(objAccount, fromDate, toDate); //Code Reusability
           
       } catch (Exception e)
        {
          return null;
       }
   }
}
  