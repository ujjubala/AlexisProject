public class BatchApplicantBirthdayEmail implements Database.Batchable<sObject>
{
   public Database.QueryLocator start(Database.BatchableContext BC)
   {
     return Database.getQueryLocator('select Id, First_Name__c, Last_Name__c, DOB__c,Email_ID__c from Applicant__c where DOB__c!=null and Email_ID__c!=null ');
   }
   public void execute(Database.BatchableContext BC,List<Applicant__c> appList)
   {
     List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
     if(!appList.isEmpty())
     {
       for(Applicant__c objApp : appList)
       {
         Integer birthDay = objApp.DOB__c.day();
         Integer todayDay = System.today().day();
         if(birthDay==todayDay)
         {
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           mail.setToAddresses(new String[] {objApp.Email_ID__c});
           mail.setSenderDisplayName('Alexis Limited');
           mail.setSubject('Birthday Wishes');
           mail.setPlainTextBody('Hi' + objApp.First_Name__c + ' , \n Happy Birthday to you. \n Team \n Alexis Ltd');
           mailList.add(mail);
          }
       }
       if(!mailList.isEmpty())
         Messaging.sendEmail(mailList);   
     }
   }
    public void finish(Database.BatchableContext BC)
    {
      System.debug('#finish');
    }
}