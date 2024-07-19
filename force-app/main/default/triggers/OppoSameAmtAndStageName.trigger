trigger OppoSameAmtAndStageName on Opportunity (before insert,before update, after Undelete) {
    Set<Decimal> oppoAmtSet = new Set<Decimal>();
    Set<String> oppoStageNameSet = new Set<String>();
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || (trigger.isAfter && trigger.isUndelete))
    {
        for(Opportunity objOppo : trigger.new)
        {
            oppoAmtSet.add(objOppo.Amount);
            oppoStageNameSet.add(objOppo.StageName);
        }
    }
    Map<Decimal, Opportunity> oppoAmtMap = new Map<Decimal, Opportunity>();
    Map<String, Opportunity> oppoStageNameMap = new Map<String, Opportunity>();
    if(!oppoAmtSet.isEmpty())
    {
        for(Opportunity objOppo : [select Id,Amount,StageName from Opportunity where Amount in : oppoAmtSet and StageName in: oppoStageNameSet])
        {
            oppoAmtMap.put(objOppo.Amount, objOppo);
            oppoStageNameMap.put(objOppo.StageName, objOppo);
        }
    }
    if(!oppoAmtMap.isEmpty())
    {
        for(Opportunity objOppo : trigger.new)
        {
            if(oppoAmtMap.containsKey(objOppo.Amount) && oppoStageNameMap.containsKey(objOppo.StageName))
            {
                objOppo.addError('Opportunity with Amount' + objOppo.Amount + 'And Stage Name' + objOppo.StageName + 'Already Exists');
            }
            
        }
    }
}