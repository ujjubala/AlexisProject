import { LightningElement,wire,api,track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

export default class GetRecordDemoWithWire extends LightningElement 
{
   @api recordId;
   @track record;
   @track error;
   dt;
   @wire(getRecord, { recordId : "$recordId", fields:["Account.Name", "Account.Rating","Account.Type","Account.CreatedDate"]})
   wiredRecord({data,error})
   {
     if(data)
     {
       this.record = data;
       this.error  = undefined;
     }
     else if(error)
     {
        this.record = undefined;
        this.error  = error;
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
   get cDate()
   {
     return this.record.fields.CreatedDate.value;
    }
}