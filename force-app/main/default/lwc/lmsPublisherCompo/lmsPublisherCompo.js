import { LightningElement, track, wire } from 'lwc';
import {publish, MessageContext} from "lightning/messageService";
import MYCHANNEL from "@salesforce/messageChannel/ContactDataChannel__c";
import getRelatedContactRecords from '@salesforce/apex/AccountProvider.getRelatedContactRecords';

export default class LmsPublisherCompo extends LightningElement 
{
   @track objAcc= {'sObjectType' :'Account'};
   conList;
   @wire(MessageContext)
   context
   nameHandler(event){
        this.objAcc.Name = event.target.value; //Cinemax
    }
    sendDataHandler()
    {
        getRelatedContactRecords({'objAccount' : this.objAcc})
        .then(result=>{
            this.conList = result;
            console.log('Result is:' +JSON.stringify(this.conList));
     
            const message={
            contactListLms:{
            value:this.conList
            }
        }
        publish(this.context, MYCHANNEL, message);
      })
    .catch(error=>{
        console.log(JSON.stringify(error));
    })
  }
}