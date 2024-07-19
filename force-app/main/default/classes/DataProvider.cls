public  with sharing class DataProvider
{
@AuraEnabled
  public static List<Account> getAllRecords()
   {
    return [select Id, Name from Account];
   }
}