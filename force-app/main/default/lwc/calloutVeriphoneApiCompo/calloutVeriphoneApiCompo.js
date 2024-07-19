import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from'lightning/actions';
import verifyMobileNumber from '@salesforce/apex/VeriphoneRequestAPI.verifyMobileNumber';
export default class CalloutVeriphoneApiCompo extends LightningElement 
{
    @api recordId;
    verifyMobileNumberHandler()
    {
        console.log('Button Clicked');
        console.log('Record Id' +this.recordId);
        verifyMobileNumber({'recordId' : this.recordId})
        .then(result=>{
             this.dispatchEvent(new CloseActionScreenEvent()); //To Close the LWC Component Automatically
             window.location.reload(); //Refresh the Current Page
        })
        .catch(error=>{
          this.dispatchEvent(new CloseActionScreenEvent()); //To Close the LWC Component Automatically
          window.location.reload(); //Refresh the Current Page
        })
    }
}