import { LightningElement,api } from 'lwc';

export default class ContactHealthCompo extends LightningElement 
{
  @api receivedContactList;
  draftValues = [];
  columns = [
    { label :  'First Name', fieldName : 'FirstName', type : 'text'},
    { label :  'Last Name', fieldName : 'LastName',  type : 'text'},           
    { label  :  'Email ID', fieldName : 'Email', type: 'email'  }
  ];

}