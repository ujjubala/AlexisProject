trigger PreventApplicantDeleteTrigger on Applicant__c (before delete)
{
  Map<Id, Applicant__c> appMap = new Map<Id, Applicant__c>();
  for(Applicant__c objApp : [select Id, (select Id from Addresses__r) from Applicant__c where Id in : trigger.oldMap.keySet()])
         appMap.put(objApp.Id, objApp);
    
  if(trigger.isBefore && trigger.isDelete)
  {
    for(Applicant__c objApp : trigger.old)
    {
      if(!appMap.isEmpty())
      { 
        if(appMap.containsKey(objApp.Id))
        {
          List<Address__c> addrList = appMap.get(objApp.Id).Addresses__r;
          if(addrList.size() > 1)
              objApp.addError('Can not delete this applicant');
        }
      }
    }
  }
}