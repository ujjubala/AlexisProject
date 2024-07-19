import { LightningElement, track } from 'lwc';
import getRelatedContactRecords from  '@salesforce/apex/AccountProvider.getRelatedContactRecords';  
import pubsub from 'c/pubsub';

export default class AccountPublisherCompo extends LightningElement 
{
   @track objAcc = {'sObjectType': 'Account'};
   conList;
   accountNameHandler(event)
   {
    //console.log('In Name Handler');
    this.objAcc.Name = event.target.value;
    console.log(this.objAcc.Name);
   }
   sendDataHandler()
   {
    console.log('Button Clicked');
    getRelatedContactRecords({'objAccount': this.objAcc})
   .then(result=>{
        this.conList = result;
        console.log(JSON.stringify(result));
        pubsub.publish('eventName', this.conList);
   })
   .catch(error=>{
        console.log(JSON.stringify(error));
   })     
 }
}