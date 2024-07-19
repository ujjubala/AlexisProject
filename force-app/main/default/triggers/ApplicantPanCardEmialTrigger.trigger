trigger ApplicantPanCardEmialTrigger on Applicant__c (after update)
{
   List <Messaging.SingleEmailMessage> mailList = new List <Messaging.SingleEmailMessage>();
   if(trigger.isAfter && trigger.isUpdate)
   {
     for(Applicant__c objApp : trigger.new)
     {
       if(objApp.PAN_Card__c != trigger.oldMap.get(objApp.ID).PAN_Card__c)
       {
         String newPan = objApp.PAN_Card__c.subString(0,5) + 'XXXXX';
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         mail.setToAddresses(new String[] {objApp.Email_ID__c});
         mail.setSenderDisplayName('Alexis Limited');
         mail.setSubject('Pan Card updated');
         mail.setPlainTextBody('Hi ' + objApp.First_Name__c + 'Your Pan ' + newPan + 'is Updated');
         mailList.add(mail);
       }
     }
     if(!mailList.isEmpty())
        Messaging.sendEmail(mailList);
   }
}