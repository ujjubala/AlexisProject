import { LightningElement, api } from 'lwc';

export default class WireChildCompo extends LightningElement 
{
   @api childContactList;
   draftValues=[];
    columns = [
        { label: 'Id', fieldName: 'Id'},
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'Last Name', fieldName: 'LastName'}      
    ];
   
}