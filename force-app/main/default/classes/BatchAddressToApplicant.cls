public class BatchAddressToApplicant implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
     return Database.getQueryLocator('select Id, Name, PinCode__c, City__c, Applicant__r.Gender__c, Applicant__r.Police_Verification__c from Address__c where City__c = \'Pune\' and PinCode__c like \'44%\' and Applicant__r.Gender__c=\'Male\' and Applicant__r.Police_Verification__c=false');
    }
    
    public void execute(Database.BatchableContext BC, List<Address__c> adrList)
    {
      Set<Id> appIdSet = new Set<Id>();
      if(!adrList.isEmpty())
      {
        for(Address__c objAdr : adrList)
        {
          if(objAdr.Applicant__c!=null)
             appIdSet.add(objAdr.Applicant__c);
        }
      }
      Map<Id, Applicant__c> appMap = new Map<Id, Applicant__c>();
      if(!appIdSet.isEmpty())
      {
        for(Applicant__c objApp : [select Id, Gender__c, Police_Verification__c from Applicant__c where Id in : appIdSet])
            appMap.put(objApp.Id, objApp);
      }
      for(Address__c objAdr : adrList)
      {
        if(!appMap.isEmpty())
        {
          if(appMap.containsKey(objAdr.Applicant__c))
              appMap.get(objAdr.Applicant__c).Police_Verification__c = true;
        }
      }
      Database.update(appMap.values(), false);
    }
      public void finish(Database.BatchableContext BC)
      {
        System.debug('#Finish');
      } 
}