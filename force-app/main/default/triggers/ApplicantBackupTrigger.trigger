trigger ApplicantBackupTrigger on Applicant__c (before delete)
{
 List <Applicant_Backup__c> appBackList = new List<Applicant_Backup__c>();
 if(trigger.isBefore && trigger.isDelete)
 {
   for(Applicant__c objApp : trigger.old)
   {
     Applicant_Backup__c objBackApp = new Applicant_Backup__c(); 
     if(objApp.Police_Verification__c && objApp.Gender__c=='Male' && (objApp.DOB__c.year()) < 1990)
     {
       objBackApp.First_Name_Backup__c    = objApp.First_Name__c;
       objBackApp.Last_Name_Backup__c     = objApp.Last_Name__c;
       objBackApp.Gender_Backup__c        = objApp.Gender__c;
       objBackApp.Date_Of_Birth_Backup__c = objApp.DOB__c;
       appBackList.add(objBackApp);
     }   
   }
   if(!appBackList.isEmpty())
       Database.insert(appBackList,false);
 }
}