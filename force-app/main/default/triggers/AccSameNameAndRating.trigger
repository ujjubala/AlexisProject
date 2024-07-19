trigger AccSameNameAndRating on Account (before insert, before update, after undelete) {
    Set<String> accNameSet = new Set<String>();
    Set<String> accRatingSet = new Set<String>();
    if((trigger.isBefore && (trigger.isUpdate || trigger.isInsert)) || (trigger.isAfter && trigger.isUndelete))
        for(Account objAcc : trigger.new)
    {
        accNameSet.add(objAcc.Name);
        accRatingSet.add(objAcc.Rating);
    }
    Map<String,Account> accNameMap = new Map<String,Account>();
    Map<String,Account> accRatingMap = new Map<String,Account>();
    if(!accNameSet.isEmpty())
    {
        for(Account objAcc : [select Id, Name, Rating from Account where Name in : accNameSet And Rating in : accRatingSet])
        {
            accNameMap.put(objAcc.Name,objAcc);
            accRatingMap.put(objAcc.Rating,objAcc);
        }
    }
    if(!accNameMap.isEmpty())
    {
        for(Account objAcc : trigger.new)
        {
            if(accNameMap.containsKey(objAcc.Name) && accRatingMap.containsKey(objAcc.Rating))
            {
                objAcc.addError(objAcc.Name + 'This Account Name with Same Rating already exists');
            }
        }
    }
}