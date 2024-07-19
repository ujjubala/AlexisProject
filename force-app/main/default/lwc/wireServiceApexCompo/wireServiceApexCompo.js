import { LightningElement, wire, api } from 'lwc';
import getAccountDataUsingWire from '@salesforce/apex/AccountProvider.getAccountDataUsingWire';

export default class WireServiceApexCompo extends LightningElement 
{
    contactList;
    @api recordId;
    

   @wire (getAccountDataUsingWire,{accId : "$recordId"}) 
   wiredAccounts({data,error}){
        if (data) {
        this.contactList = data;
        console.log(data); 
        } else if (error) {
        console.log(error);
        }
   }
}