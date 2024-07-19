trigger PassportTrigger on Passport__c (after insert, after update) 
{
  Set<Id> appIdSet = new Set<Id>();
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    for(Passport__c objPass : trigger.new)
    {
      if(objPass.Applicant__c!=null)
      {
        if(trigger.isInsert)
            appIdSet.add(objPass.Applicant__c);
        if(trigger.isUpdate)
        {
          if(objPass.Applicant__c != trigger.oldMap.get(objPass.id).Applicant__c || objPass.Status__c!= trigger.oldMap.get(objPass.id).Status__c)
            appIdSet.add(objPass.Applicant__c);          
        }
      }
    }
  }
  Map<id, Applicant__c> appMap = new Map<id, Applicant__c>();
  if(!appIdSet.isEmpty())
  {
    for(Applicant__c objApp : [select Id, Police_Verification__c from Applicant__c where Id in : appIdSet])
    {
      appMap.put(objApp.id, objApp);
    }
  }
  if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
  {
    for(Passport__c objPass : trigger.new)
    {
      if(appMap.containsKey(objPass.Applicant__c))
      {
        if(objPass.Status__c == 'Rejected')
            appMap.get(objPass.Applicant__c).Police_Verification__c = true;
        else
            appMap.get(objPass.Applicant__c).Police_Verification__c = false;
      }
    }
  }
  Database.update(appMap.values(), false);
}