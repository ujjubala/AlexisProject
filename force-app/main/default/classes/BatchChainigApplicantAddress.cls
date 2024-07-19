global class BatchChainigApplicantAddress implements Database.Batchable<sObject>
{
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
     return Database.getQueryLocator('select Id, Gender__c, Police_Verification__c from Applicant__c' );
   }
   global void execute(Database.BatchableContext BC, List<Applicant__c> appList)
   {
    if(!appList.isEmpty())
    {
      for(Applicant__c objApp : appList )
      {
        if(objApp.Gender__c=='Female' || objApp.Gender__c == 'Transgender')
            objApp.Police_Verification__c = false;
      }
      Database.update(appList, false);
    }
  }
  global void finish(Database.BatchableContext BC)
  {
    Database.executeBatch(new BatchAddressUpdate(),100);
  }
}