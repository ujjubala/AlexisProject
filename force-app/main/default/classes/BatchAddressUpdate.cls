global class BatchAddressUpdate implements database.Batchable<sObject>
{
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
     return Database.getQueryLocator('select Id, State__c, City__c,Applicant__r.Police_Verification__c from Address__c where Applicant__r.Police_Verification__c=false ');
   }
   global void execute(Database.BatchableContext BC, List<Address__c> adrList)
   {
     if(!adrList.isEmpty())
     {
       for(Address__c objAdr : adrList)
       {
         if(objAdr.State__c=='Maharashtra' && objAdr.City__c!='Pune')
             objAdr.City__c = 'Pune';
       }
       Database.update(adrList,false);
     }
   }
     global void finish(Database.BatchableContext BC)
     {
       System.debug('#Finish');
     }
  }