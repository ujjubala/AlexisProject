trigger OpportunityPreventDuplicate on Opportunity (before insert, before update, after undelete)
{
  Set<Decimal> oppoAmtSet = new Set<Decimal>();
  if((trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) || (trigger.isAfter && trigger.isUndelete))
  {
    for(Opportunity objOppo : trigger.new)
    {
      if(objOppo.Amount!=null)
         oppoAmtSet.add(objOppo.Amount);
    }
    Map<Decimal, Opportunity> oppoMap = new Map<Decimal, Opportunity>();
    if(!oppoAmtSet.isEmpty())
    {
      for(Opportunity objOppo : [select Id, Amount from Opportunity where Amount IN : oppoAmtSet])
          oppoMap.put(objOppo.Amount, objOppo);
    }
    if(!oppoMap.isEmpty())
    {
      for(Opportunity objOppo : trigger.new)
      {
        if(oppoMap.containsKey(objOppo.Amount))
            objOppo.addError('Oppo with same Amount already exists');
      }
    }
  }
}