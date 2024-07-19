trigger ApplicantEmailTrigger on Applicant__c (after update)
{
  List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
  if(trigger.isAfter && trigger.isUpdate)
  {
    for(Applicant__c objApp : trigger.new)
    {
      if(objApp.Police_Verification__c && !trigger.oldMap.get(objApp.ID).Police_Verification__c)
      {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {objApp.Email_ID__c});
        mail.setSenderDisplayName('Alexis Limited');
        mail.setSubject('Eligible for Police Verification');
        mail.setPlainTextBody('Hi..' + objApp.First_Name__c + '\n You are now eligible for Police verification. \n Contact your nearest Police Station. \n Team Alexis');
        mailList.add(mail);  
      }
    }
     if(!mailList.isEmpty())
        Messaging.sendEmail(mailList);
  }
}