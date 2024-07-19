trigger ApplicantTrigger1 on Applicant__c (before insert, before update)
{
   for(Applicant__c objApp : trigger.new)
   {
     if(objApp.Gender__c == 'Male' && !objApp.First_Name__c.startsWith('Mr.'))
     {
       objApp.First_Name__c = objApp.First_Name__c.remove('Ms.');
       objApp.First_Name__c = 'Mr.' + objApp.First_Name__c;
     }
     else if(objApp.Gender__c == 'Female' && !objApp.First_Name__c.startsWith('Ms.'))
       {
          objApp.First_Name__c = objApp.First_Name__c.remove('Mr.');
          objApp.First_Name__c = 'Ms.' + objApp.First_Name__c;
       }
      else if(objApp.Gender__c == 'Transgender')
         objApp.Gender__c.addError('This Applicant is cuurerntly not allowed');
     }
   }