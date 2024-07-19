import { LightningElement,wire } from 'lwc';
import OPPORTUNITYCHANNEL from '@salesforce/messageChannel/OpportunityDataChannel__c';
import {subscribe,MessageContext,APPLICATION_SCOPE } from 'lightning/messageService';
export default class OpportunityHealthCompo extends LightningElement
{
    @wire(MessageContext)
    context;
    draftValues = [];
    receivedOppList;
    oppColumns = [
        { label : 'Oppo Name', fieldName   : 'Name', editable : true},
        { label : 'Stage Name', fieldName   : 'StageName' , editable : true},
        { label : 'Closed Date', fieldName  : 'CloseDate', type : 'date'}
       
    ];
    connectedCallback()
    {
      subscribe(this.context,OPPORTUNITYCHANNEL, (message)=>{this.handleMessage(message)}, {scope :APPLICATION_SCOPE} )    
    }
    handleMessage(message){
      this.receivedOppList = message.oppoListLMS.value
   }
}