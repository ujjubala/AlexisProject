trigger LeadUpdateTrigger on Lead (before update)
{
  if(trigger.isBefore && trigger.isUpdate)
  {
     for(Lead objLead : trigger.new)
     {
       if(objLead.LeadSource == 'Web' && trigger.oldMap.get(objLead.ID).LeadSource == 'Phone Inquiry')
       {
         if(objLead.Industry == 'Banking' || objLead.Industry == 'Education')
             objLead.Rating = 'Hot';
       }
       else
            objLead.Rating = ' ';
       }
     }
   }