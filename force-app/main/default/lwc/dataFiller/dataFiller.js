import { LightningElement,wire } from 'lwc';
//import pubsub from 'c/pubsub';
import DATAFILLERCHANNEL from '@salesforce/messageChannel/DataFillerChannel__c';
import { publish,MessageContext } from 'lightning/messageService';
export default class DataFiller extends LightningElement
{
    @wire(MessageContext)
    context;
    personName;
    personPhone;
    personCountry;
    personList = [];
    passDataHandler()
    {
       this.personName    = this.template.querySelector('lightning-input[data-formfield="name"]').value;
       this.personPhone   = this.template.querySelector('lightning-input[data-formfield="phone"]').value;
       this.personCountry = this.template.querySelector('lightning-input[data-formfield="country"]').value;
       this.personList = [{
        Id       : 1,
        Name     : this.personName,
        Phone    : this.personPhone,
        Country  : this.personCountry
       }];
       const message  = {
        personListLMS:{
            value : this.personList
        }
       }
       //console.log( 'The Data to be sent:' +this.personList);
       //pubsub.publish('eventName',this.personList);
       publish(this.context,DATAFILLERCHANNEL,message);
    }
}