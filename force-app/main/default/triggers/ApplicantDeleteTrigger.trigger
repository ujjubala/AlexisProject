trigger ApplicantDeleteTrigger on Applicant__c (after delete) 
{
   if(trigger.isAfter && trigger.isDelete)
   {
     List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
     for(Applicant__c objApp : trigger.old)
     {
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       mail.setToAddresses(new String[] {objApp.Email_ID__c});
       mail.setSenderDisplayName('Alexis Limited');
       mail.setSubject('Record Deleted');
       mail.setPlainTextBody('Hi ' +objApp.First_Name__c + '\n your Record has been deleted. \n Team Alexis');
       mailList.add(mail);
     }
       if(!mailList.isEmpty())
           Messaging.sendEmail(mailList);
   }
}