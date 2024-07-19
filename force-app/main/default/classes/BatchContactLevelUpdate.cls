global class BatchContactLevelUpdate implements Database.Batchable<sObject>, Database.Stateful
{
   Set<String> successIdSet = new Set<String>();
   Set<String> failedIDSet  = new Set<String>();
   global Database.QueryLocator start(Database.BatchableContext BC)
   {
      return Database.getQueryLocator('select Id, FirstName, LastName, LeadSource, Level__c from Contact');
   }
   global void execute(Database.BatchableContext BC, List<Contact> conList)
   {
     if(!conList.isEmpty())
     {
       for(Contact objCon : conList)
          objCon.LeadSource = 'Web';
     }
       
     Database.SaveResult [] result = Database.update(conList, false);
     integer index=0;
     for(Database.SaveResult sr : result)
     {
       if(sr.isSuccess())
       {
          successIdSet.add(conList[index].FirstName + ' ' +conList[index].LastName);
          index++;
       }
       else 
       {
         failedIdSet.add(conList[index].FirstName + ' ' +conList[index].LastName);
         index++;
       }
     }
     System.debug('#Success Record ID' +successIdSet);
     System.debug('#Failed Record ID' +failedIdSet);
   }
   global void finish(Database.BatchableContext BC)
   {
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     mail.setToAddresses(new String[] {'kumbhalkar.ujjwala5@gmail.com'});
     mail.setSenderDisplayName('Alexis Limited');
     mail.setSubject('Contact Updation List');
     mail.setPlainTextBody('Success' +successIdSet + '\n Failed =' +failedIdSet);
     messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
 }