import { LightningElement ,wire} from 'lwc';
import CASECHANNEL from '@salesforce/messageChannel/CaseDataChannel__c';
import {subscribe,MessageContext,APPLICATION_SCOPE } from 'lightning/messageService';
export default class CaseHealthCompo extends LightningElement
{
    @wire(MessageContext)
    context;
    draftValues = [];
    receivedCaseList;
    firstName;
    lastName;
    caseColumns = [
        { label : 'Case Number', fieldName   : 'CaseNumber', editable : true},
        { label : 'Case Reason', fieldName   : 'Reason' , type : 'text',editable : true},
        { label : 'Case Status', fieldName  : 'Status', type : 'text'},
        { label : 'Case Origin', fieldName : 'Origin', type: 'text',editable: true }
    ];
    connectedCallback()
    {
      subscribe(this.context,CASECHANNEL, (message)=>{this.handleMessage(message)}, {scope :APPLICATION_SCOPE} )    
    }
    handleMessage(message){
      this.receivedCaseList = message.caseListLMS.value
      this.firstName        = message.firstNameLMS.value
      this.lastName         = message.lastNameLMS.value
   }
}