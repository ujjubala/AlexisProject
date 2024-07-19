import { LightningElement,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Contact.Name',
    'Contact.Email',
    'Contact.MobilePhone'
];
export default class GetRecordWithoutWire extends LightningElement 
{
    @api recordId;
    contact;
    connectedCallback() 
    {
        this.loadContact();
    }

    loadContact()
     {
        getRecord({ recordId: this.recordId, fields: FIELDS })
        .then(record => {
                this.contact = record.fields;
            })
        .catch(error => {
                console.error('Error fetching contact record: ', error);
            });
    }
}

