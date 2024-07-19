import { LightningElement,wire } from 'lwc';
import MYCHANNEL from "@salesforce/messageChannel/ContactDataChannel__c";
import {subscribe, MessageContext,APPLICATION_SCOPE} from "lightning/messageService";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LmsSubscriberCompo extends LightningElement 
{
    conList;
    showTableFlag=false;
    @wire(MessageContext)
    context    
    draftValues=[];
    columns= [
      { label:'First Name', fieldName:'FirstName', editable:true },
      { label:'Last Name', fieldName:'LastName', editable:true }
    ];
    connectedCallback()
    {
     subscribe(this.context, MYCHANNEL, (message)=>{this.handleMessage(message)}, {scope :APPLICATION_SCOPE} )
   }
   handleMessage(message)
   {
    this.conList  = message.contactListLms.value; //Received Obj from LMS
    this.showTableFlag = true;
    this.showInfo();
    //console.log('Received = '+this.conList);
   }
   showInfo()
   {
    const evt = new ShowToastEvent({
        title: 'Success',
        message: 'Contact List Delivered',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
   }
}



