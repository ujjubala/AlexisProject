import { LightningElement } from 'lwc';
import { ShowToastEvent   } from 'lightning/platformShowToastEvent';

import CONTACT_OBJECT       from '@salesforce/schema/Contact';
import FIRST_NAME_FIELD     from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD      from '@salesforce/schema/Contact.LastName';
import PARENT_FIELD         from '@salesforce/schema/Contact.AccountId';
import SALUTATION_FIELD     from '@salesforce/schema/Contact.Salutation';

export default class NewContact extends LightningElement 
{
  objContact        =   CONTACT_OBJECT;
  firstName         =   FIRST_NAME_FIELD;
  lastName          =   LAST_NAME_FIELD;
  parenetAccount    =   PARENT_FIELD;
  salutation        =   SALUTATION_FIELD;
  successToastMessage()
  {
    const evt = new ShowToastEvent({
           title  : 'New Contact created',
           message: 'Record has been created',
           variant: 'success',
       });
       this.dispatchEvent(evt);
  }
}