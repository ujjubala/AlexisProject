trigger LeadScenario10Trigger on Lead (before insert) 
{
  List<Contact> conList = [select Id, Email from Contact];
  if(trigger.isBefore && trigger.isInsert)
  {
    for(Lead objLead : trigger.new)
    {
      for(Contact objCon : conList)
      {
        if(objLead.Email == objCon.Email)
            objLead.addError('Can not create this Lead...same contact appears');
      }
    }
  }
}