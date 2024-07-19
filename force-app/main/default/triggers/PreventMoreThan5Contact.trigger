trigger PreventMoreThan5Contact on Contact (before insert, before update, after undelete)
{
    Set<id> accIdSet = new Set<id>();
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUnDelete))
    {
        for(Contact objCon : trigger.new)
        {
            if(objCon.AccountId != null)
            {
                if(trigger.isInsert)
                    accIdSet.add(objCon.AccountId);
                if(trigger.isUpdate || trigger.isUnDelete)
                {
                  if(objCon.AccountId != trigger.oldMap.get(objCon.Id).AccountId) // || objCon.Level__c!= trigger.oldMap.get(objCon.id).Level__c)
                        accIdSet.add(objCon.AccountId);    
                } 
            }
        }
    }
    Map<Id, Account> accMap = new Map<Id, Account>();
    if(!accIdSet.isEmpty())
    {
        for(Account objAcc: [select Id, Rating , (select Id from Contacts) from Account where Id in : accIdSet])
            accMap.put(objAcc.id, objAcc);
    }
    if(!accMap.isEmpty())
    {
        if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUnDelete))
        {
            for(Contact objCon : trigger.new)
            {
                if(accMap.containsKey(objcon.AccountId))
                {
                    List <Contact> conList = accMap.get(objCon.AccountId).Contacts;
                    if(conList.size()>=5 && accMap.get(objCon.AccountId).Rating=='Hot' && objCon.Level__c == 'Primary')
                        objCon.addError('Only 5 Primary Contact per Account with Hot Rating allowed');
                }
            }
        }
    }
}