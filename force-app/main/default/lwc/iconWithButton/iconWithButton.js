import { LightningElement } from 'lwc';
import verifyMobileNumber from '@salesforce/apex/VeriphoneRequestAPI.verifyMobileNumber';

export default class IconWithButton extends LightningElement
{
  objCon =  {'sObjectType' : 'Contact'};
  validFlag ;
  
  firstNameHandler(event)
  {
    this.objCon.FirstName = event.target.value;
    console.log('FirstName:' +this.objCon.FirstName);
  }
  lastNameHandler(event)
  {
    this.objCon.LastName = event.target.value;
  }
  mobilePhoneHandler(event)
  {
    this.objCon.MobilePhone = event.target.value;
    console.log('Mobile Num:' +this.objCon.MobilePhone);
  }
   verifyButtonHandler()
  {
    verifyMobileNumber({'objContact' : this.objCon})
    .then(result=>{
      console.log('Success.............');
      if(result)
         this.validFlag = true;
      else
         this.validFlag = false;
     })
    .catch(error=>{
      //this.validFlag = false;
      console.log('Something went wrong..........');
      console.log('Error:' +JSON.stringify(error));
     
    })
  }
}

 