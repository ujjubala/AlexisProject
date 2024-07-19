import { LightningElement,api } from 'lwc';
import verifyMobileNumber from '@salesforce/apex/VeriphoneRequestAPI.verifyMobileNumber';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import MOBILE_NUMBER from '@salesforce/schema/Contact.MobilePhone';
export default class ContactButtonWithIcon extends LightningElement 
{
  objCon     = {'sObjectType' : 'Contact'};
  @api recordId;
  objContact = CONTACT_OBJECT;
  firstName  = FIRST_NAME;
  lastName   = LAST_NAME;
  mobileNum  = MOBILE_NUMBER;
  validFlag;
  
  firstNameHandler(event)
  {
    this.objCon.FirstName = event.target.value;
    console.log('First Name' +this.objCon.FirstName);
  }
  lastNameHandler(event)
  {
    this.objCon.LastName = event.target.value;
    console.log('Last Name' +this.objCon.LastName);
  }
  mobileNumHandler(event)
  {
    this.objCon.MobilePhone = event.target.value;
  }
  verifyButtonHandler()
  {
    verifyMobileNumber({'contactObj' : this.objCon})
    .then(result=>{
        console.log('Success......'+JSON.stringify(result));
        if(result==true)
          this.validFlag = true;
        else
          this.validFlag = false;
    })
    .catch(error=>{
        console.log('Something went wrong.....');
        console.log('Error:' +JSON.stringify(error));
        this.validFlag = false;
    })
  }
}