public  with sharing class AccountProvider 
{
    @AuraEnabled
    public static List<Account> searchAccountRecord(Account  objAcc)
    {
       return [Select Id, Name, Rating, Type, CreatedDate, SLA__c from Account where Name =: objAcc.Name];
    }
   
    @AuraEnabled
    public static List<Contact> getRelatedContactRecords(Account objAccount)
    {
      return[Select Id, FirstName, LastName from Contact where Account.Name = : objAccount.Name];
    }
    @AuraEnabled
    public static List<Opportunity> getRelatedOpportunities(Account objAccount)
    {
      try 
      {
        return[Select Id, Name,StageName,CloseDate,AccountId from Opportunity where Account.Name = : objAccount.Name];  
      }
       catch (Exception e) 
       {
         return null;    
      }
    }
    @AuraEnabled
    public static List<Case> getRelatedCases(Account objAccount)
    {
      try 
      {
        return[Select Id,CaseNumber,Reason,Origin,Status from Case where Account.Name = : objAccount.Name];  
      }
       catch (Exception e) 
       {
         return null;    
      }
    }
    // @AuraEnabled
    // public static List<Address__c> getRelatedAddressRecords(String objAppName)
    // {
    //   System.debug('In Apex Server');
    //   System.debug('Applicant is:' +objAppName);
    //   return[Select Id , Country__c, State__c, City__c from Address__c where Applicant__r.Name = : objAppName];
    // }
    @AuraEnabled
    public static List<Account> searchAccountByChar(Account objAccount)
    {
      try
      {
        return [Select Name,Type,SLA__c,CreatedDate from Account where Name like :  objAccount.Name +'%'];
      }
     catch (Exception e) 
     {
        return null;
     }
   }
   
   @AuraEnabled(cacheable=true)
   public static List<Contact> getAccountDataUsingWire(Id accId)
   {
    try
    {
      return [Select Id, FirstName, LastName from Contact where Account.Id = : accId ];
    }
     catch (Exception e) 
    {
      return null;
    }
   }
   @AuraEnabled(cacheable=true)
   public static List<Account> getAllAccountsUsingWire()
   {
    try
    {
       return [select Id,Name,Rating,Type,CreatedDate from Account where CreatedDate < THIS_MONTH LIMIT 10];  
    } catch (Exception e)
     {
      return null;
    }
   }
   @AuraEnabled
   public static void deleteAccountRecord(Id accId )
   {
    try
    {
       Database.delete([select Id from Account where Id = : accId],false);  
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
   }
   @AuraEnabled
   public static List<Account> getAllAccounts()
   {
      
    return NewDataProvider.getAllRecords();
   }
   @AuraEnabled
   public static List<Address__c> getRelatedAddressRecords(Applicant__c objApplicant)
   {
     Id appId = [select Id,First_Name__c,Last_Name__c from Applicant__c where First_Name__c =: objApplicant.First_Name__c and Last_Name__c =: objApplicant.Last_Name__c].Id;
     return [select Id,Country__c,State__c,City__c from Address__c where Applicant__c = : appId];
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
    return [SELECT Id, Name, Industry, Phone FROM Account LIMIT 10];
  }
    @AuraEnabled
    public static String deleteSelectedAccounts(List<Id> accIds)
    {
     try{
      List<Account> accList = [select Id from Account where Id in : accIds];
      Database.delete(accList,false);
      return 'Records deleted Successfully';
     }
   catch(Exception e)
   {
    return 'Failed to delete Records';
   }
  }
   @AuraEnabled
   public static String getCustomMetadataRecords(String successCode)
   {
    try 
    {
      String msg  = [select Id,Success_Code__c,Message__c from Bank_Info__mdt where Success_Code__c = : successCode].Message__c;
      return msg;
    } catch (Exception e)
    {
      return null;
    }
   }
   @AuraEnabled
   public static Account getSingleAccount()
   {
    try {
      return [select Id,Name,AccountNumber,Industry from Account limit 1];
    } catch (Exception e) {
      return null;
    }
   }
   /*@AuraEnabled
   public static List<Case> getRelatedCasesForContact(String contactName)
   {
      return[select CaseNumber,Reason,Origin,Status from Case where Contact.Name=:contactName];
    }*/
    
   @AuraEnabled
    public static List<Opportunity> getOpportunities(Account objAcc)
    {
      return[SELECT Id, Name, Amount, CloseDate, Account.Name, Account.Rating 
FROM Opportunity WHERE Account.Name = : objAcc.Name AND Account.Rating = : objAcc.Rating];
    }
    @AuraEnabled
    public static List<Case> getRelatedCasesForContact(Contact objContact)
    {
      Id conId = [select Id from Contact where FirstName=:objContact.FirstName and LastName=:objContact.LastName limit 1].Id;
      return [select CaseNumber,Reason,Origin,Status from Case where ContactId=:conId];
    }
    @AuraEnabled
    public static List<Case> getRelatedCaseFrom(Case objCase)
    {
      return [select CaseNumber,Origin,Status,Priority from Case where CaseNumber = : objCase.CaseNumber];
    }
    @AuraEnabled
    public static List<Case> getRelatedCaseStatus(Case objCase, Integer pageSize,Integer pageNumber)
    {
      Integer offset = (pageNumber - 1) * pageSize;
      return [select CaseNumber,Origin,Status,Priority from Case where Status =: objCase.Status  LIMIT :pageSize OFFSET :offset]; 
    }
    @AuraEnabled
    public static Integer getCaseCount(Case objCase)
    {
      return [select COUNT() from Case where Status = : objCase.Status];
    }
  }
  
  
   
   
  
