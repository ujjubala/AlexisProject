public inherited sharing class NewDataProvider
 {  
  @AuraEnabled
  public static List<Account> getAllRecords()
  {
    return[Select Name, Owner_Name__c from Account]; 
  }
}

 
