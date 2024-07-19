trigger ContactEmailTrigger on Contact (after Delete)
{
  List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
  for(Contact objCon : trigger.old)
  {
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(new String[]{objCon.Email});
    mail.setSenderDisplayName('Alexis Limited');
    mail.setSubject('Record Deleted');
    mail.setPlainTextBody('Hi '+ objCon.FirstName+'\n Your Record has been deleted \n Team Alexis');
    mailList.add(mail);
  }
   if(!mailList.isEmpty())
       Messaging.sendEmail(mailList);
}