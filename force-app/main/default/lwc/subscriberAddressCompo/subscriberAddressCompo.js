import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class SubscriberAddressCompo extends LightningElement 
{
    draftValues=[];
    applicantAddressList;
    showTableFlag = false;
    columns = [  
        { label:'Country', fieldName:'Country__c', editable:true },
        { label:'State', fieldName:'State__c', editable:true },
        { label:'City', fieldName:'City__c', editable:true } 
    ];
    connectedCallback()
    {
      pubsub.subscribe("eventName" , (message) => {
            this.applicantAddressList = message;
            this.showTableFlag = true;
            JSON.stringify(message);
         });
    }
}