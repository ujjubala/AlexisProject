trigger OppoBackupTrigger on Opportunity (before delete) 
{
  List<Opportunity_Backup__c> oppoBackList = new List<Opportunity_Backup__c>();
  if(trigger.isBefore && trigger.isDelete)
  {    
    for(Opportunity objOppo : trigger.old)
    {
       if(objOppo.StageName == 'Prospecting')
           objOppo.addError('This Opportunity can not be deleted');
       else
       {
           Opportunity_Backup__c objOppoBack = new Opportunity_Backup__c();
           objOppoBack.Oppo_Backup_Name__c   = objOppo.Name;
           objOppoBack.OppoBackAmt__c        = objOppo.Amount;
           oppoBackList.add(objOppoBack);
       }
     }
  }
    if(!oppoBackList.isEmpty())
       Database.insert(oppoBackList,False);
}