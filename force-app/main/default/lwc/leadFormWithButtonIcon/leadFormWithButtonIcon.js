import { LightningElement } from 'lwc';
import verifyEmail from '@salesforce/apex/VerifyEmailForLead.verifyEmail';
export default class LeadFormWithButtonIcon extends LightningElement 
{
    validFlag;
    objLead = {'sObjectType' : 'Lead'};
    
    firstNameHandler(event)
    {
      this.objLead.FirstName = event.target.value;
    }
    lastNameHandler(event)
    {
      this.objLead.LastName = event.target.value;  
    }
    companyHandler(event)
    {
      this.objLead.Company = event.target.value;
    }
    statusHandler(event)
    {
      this.objLead.Status = event.target.value;
    }
    emailHandler(event)
    {
      this.objLead.Email = event.target.value;
    }
    buttonHandler()
    {
      verifyEmail({'objLead' : this.objLead})
      .then(result=>{
        console.log('Success.....')
        if(result=='DELIVERABLE')
            this.validFlag = true;  
        else
            this.validFlag = false;
        })
      .catch(error=>{
        console.log('Somrthing Went Wrong:'+JSON.stringify(error));
      })
    }
}