public class BatchApplicantToAddress implements Database.Batchable<sObject>
{
   public Database.QueryLocator start(Database.BatchableContext BC)
   {
     String query = 'select Id, First_Name__c, Last_Name__c, Gender__c, Police_Verification__c from Applicant__c where Police_Verification__c = true';
     return Database.getQueryLocator(query);
   }
   public void execute(Database.BatchableContext BC, List<Applicant__c> appList)
   {
     Map<Id, Applicant__c> appMap = new Map<Id, Applicant__c>(appList);
     List<Address__c> adrList     = new List<Address__c>();
     for(Address__c objAdr : [select Id, Applicant__c, Country__c, State__c, City__c from Address__c where Applicant__c in : appMap.keySet()])
         adrList.add(objAdr);
     if(!adrList.isEmpty())
     {
       for(Address__c objAdr : adrList)
       {
         if(appMap.containsKey(objAdr.Applicant__c))
         {
           if(appMap.get(objAdr.Applicant__c).Gender__c == 'Male')
           {
             objAdr.Country__c = 'Bharat';
             objAdr.State__c   = 'Maharashtra';
             objAdr.City__c    =  'Pune';
           }
           else if(appMap.get(objAdr.Applicant__c).Gender__c == 'Female')
            {
             objAdr.Country__c = 'Bharat';
             objAdr.State__c   = 'Maharashtra';
             objAdr.City__c    = 'Nagpur';
           }
           else    
               objAdr.City__c    = ' ';
          }
        }
        Database.update(adrList, false);
     }
   }
   public void finish(Database.BatchableContext BC)
   {
     System.debug('#Finish');
   }
 }