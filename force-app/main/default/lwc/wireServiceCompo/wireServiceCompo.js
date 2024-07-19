import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_RATING_FIELD from '@salesforce/schema/Account.Rating';
import ACCOUNT_TYPE_FIELD from '@salesforce/schema/Account.Type';



export default class WireServiceCompo extends LightningElement 
{
    @api recordId;
    @track record;
    @track error;
  
    @wire(getRecord, { recordId:"$recordId", fields: [ACCOUNT_NAME_FIELD,ACCOUNT_RATING_FIELD,ACCOUNT_TYPE_FIELD] })
    wiredAccount({ error, data }) {
      if (data) {
        this.record = data;
        this.error  = undefined;
      } else if (error) {
        this.error  = error;
        this.record = undefined;
      }
    }
    get name()
    {
       return this.record.fields.Name.value;
    }
    get rating()
    {
        return this.record.fields.Rating.value;
    }
    get type()
    {
        return this.record.fields.Type.value;
    }
}