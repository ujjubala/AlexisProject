import { LightningElement,wire } from 'lwc';
//import pubsub from 'c/pubsub';
import DATAFILLERCHANNEL from '@salesforce/messageChannel/DataFillerChannel__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { subscribe } from 'lightning/messageService';
import { subscribe,MessageContext,APPLICATION_SCOPE } from 'lightning/messageService';
export default class PersonTable extends LightningElement 
{
  @wire(MessageContext)
  context;
  draftValues = [];
  columns = [
    {label : 'Person Name',fieldName : 'Name', type : 'text'  },
    {label : 'Phone', fieldName : 'Phone', type : 'phone'   },
    {label : 'Country', fieldName : 'Country', type: 'text' }
  ];
  personData;
  //compoData;
  connectedCallback()
  {
       /* pubsub.subscribe('eventName', (message) => {
        this.personData = message });
        //this.showSuccess();*/
        subscribe(this.context,DATAFILLERCHANNEL , (message)=>{this.handleMessage(message)}, {scope :APPLICATION_SCOPE} )    
  }
  /*showSuccess()
  {
      this.dispatchEvent(new ShowToastEvent({
      title   : 'Success',
      message : 'Data Received',
      variant : 'Success'
    }));
  }*/
  handleMessage(message){
    this.personData = message.personListLMS.value
 }
 
 
}