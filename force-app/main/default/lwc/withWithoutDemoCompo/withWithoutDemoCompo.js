import { LightningElement } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountProvider.getAllAccounts';

export default class WithWithoutDemoCompo extends LightningElement 
{
   accList;
   totalRecords = 0;
   draftValues=[];
   columns = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Created By', fieldName: 'Owner_Name__c', editable: true }
    
   ];

   connectedCallback()
   {
    getAllAccounts()
    .then(result=>{
        this.accList      = result;
        this.totalRecords = result.length;
    })
    .catch(error=>{
        this.accList = null;
    })
   }
}