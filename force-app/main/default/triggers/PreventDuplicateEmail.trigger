trigger PreventDuplicateEmail on Contact (before insert, before update, after undelete) {
    Set<String> emailIdSet = new Set<String>();
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete))
    {
        for(Contact objCon : trigger.new)
            emailIdSet.add(objCon.Email);
    }
    Map<String, Contact> emailIdMap = new Map<String, Contact>();
    if(!emailIdSet.isEmpty())
    {
        for(Contact objCon : [select Id, Email from Contact where Email in : emailIdSet])
            emailIdMap.put(objCon.Email, objCon);
    }
    if(!emailIdMap.isEmpty())
    {
        for(Contact objCon : trigger.new)
        {
            if(emailIdMap.containsKey(objCon.Email))
                objCon.addError('Choose another Email Id');
        }
    }
}