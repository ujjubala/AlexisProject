trigger AccountToContactTrigger on Account (after update)
{
    Map<Id, Account> accMap = new Map<Id, Account>();
    if(trigger.isAfter && trigger.isUpdate)
    {
        for(Account objAcc : trigger.new)
        {
            if(objAcc.Phone != trigger.oldMap.get(objAcc.Id).Phone)
                accMap.put(objAcc.Id, objAcc);
        }
    }
    List <Contact> conList = new List<Contact>();
    if(!accMap.isEmpty())
    {
        for(Contact objCon : [select Id, AccountId, MobilePhone from Contact where AccountId In : accMap.keySet()])
            conList.add(objCon);
    }
    if(!conList.isEmpty())
    {
        for(Contact objConList : conList)
        {
            if(accMap.containsKey(objConList.AccountId))
                objConList.MobilePhone = accMap.get(objConList.AccountId).Phone;
        }
    }
    Database.update(conList, false);
}