import { LightningElement } from 'lwc';
import { ShowToastEvent   } from 'lightning/platformShowToastEvent';

export default class NewAccountForm extends LightningElement 
{
    successToastMessage()
    {
        const evt = new ShowToastEvent({ 
            title  :    'Account created',
            message:    'Account Record has been created',
            variant:    'success' });
    this.dispatchEvent(evt);
    }
}
