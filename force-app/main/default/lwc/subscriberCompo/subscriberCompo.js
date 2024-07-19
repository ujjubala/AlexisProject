import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class SubscriberCompo extends LightningElement 
{
    contactListChild;
    showTableFlag=false;
    draftValues=[];
    columns= [
      { label:'First Name', fieldName:'FirstName', editable:true },
      { label:'Last Name', fieldName:'LastName', editable:true }
    ];

    connectedCallback()
    {
        pubsub.subscribe("eventName" , (message) => {
        this.contactListChild = message
        this.showTableFlag = true;
        console.log('Received '+JSON.stringify(message));
         });
    }
}