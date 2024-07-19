trigger AccountTrigger2 on Account (before insert,before update)
{
   for(Account objAcc : trigger.new)
   {
       if(objAcc.SLA__c=='Gold')
           objAcc.Description='Oo Lala';
       else if(objAcc.SLA__c=='Silver')
           objAcc.Description='Yahoo';
       else
           objAcc.Description=' ';
   }
}