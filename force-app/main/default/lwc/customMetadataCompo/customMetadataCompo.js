import { LightningElement,wire,track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCustomMetadataRecords from '@salesforce/apex/AccountProvider.getCustomMetadataRecords';
import { getRecord } from 'lightning/uiRecordApi';
import MESSAGE_FIELD from '@salesforce/schema/Bank_Info__mdt.Message__c';
export default class CustomMetadataCompo extends LightningElement
{
  @api recordId;
  @track record;
  @track error;
  sucCode;
  msg = 'Getting';
  /*@wire(getCustomMetadataRecords,{successCode : "$recordId"})
  wiredCustomData({data,error})
  {
     if(data)
     {
       this.record = data;
       this.error  = undefined;
     }
     else if(error)
     {
       this.error   = error;
       this.record  = undefined;
     }
  }
  @wire(getRecord, {recordId : "$recordId", fields :[MESSAGE_FIELD] })
  record;
  
  get message()
  {
    this.msg = record.data.fields.Messsage__c.value;
  }*/
  codeHandler(event)
  {
     this.sucCode = event.target.value;
     getCustomMetadataRecords({'successCode' : this.sucCode})
     .then(result=>{
         this.msg = result;
         //this.showSuccessToast();
       })
     .catch(error=>{
         console.log('Error:' +JSON.stringify(error));
     })
  }  
  showSuccessToast()
  {
    const evt = new ShowToastEvent({
        title   : 'Transaction Record',
        message : 'Record Created',
        variant : 'success'
    });
    this.dispatchEvent(evt);
  }
}