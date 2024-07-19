trigger CaseTrigger on Case (before insert, before update)
{
   for(Case objCase : trigger.new)
   {
       if(objCase.Status=='New' && objCase.Origin=='Phone')
           objCase.Product__c = 'GC5020';
       if(objCase.Status =='Working' && objCase.Origin=='Web')
           objCase.Product__c = 'GC1060';
       if(objCase.Status =='Escalated' && objCase.Origin=='Email')
           objCase.addError('This case can not be Escalated') ;
   }
}