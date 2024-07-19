trigger AccountTrigger1 on Account (before insert,before update) 
{
  for(Account objAcc : trigger.new)
  {
    if(objAcc.Type=='Prospect' && objAcc.Rating=='Hot')
        objAcc.SLA__c='Gold';
    else if(objAcc.Type=='Customer - Direct' && objAcc.Rating=='Cold')
        objAcc.SLA__c='Silver';
    else
        objAcc.SLA__c=' ';
    
  }
}