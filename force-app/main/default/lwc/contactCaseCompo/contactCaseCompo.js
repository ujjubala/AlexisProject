import { LightningElement,wire,track } from 'lwc';
import CASECHANNEL from '@salesforce/messageChannel/CaseDataChannel__c';
import {publish,MessageContext } from 'lightning/messageService';
import getRelatedCasesForContact from '@salesforce/apex/AccountProvider.getRelatedCasesForContact';
export default class ContactCaseCompo extends LightningElement
{
    @wire(MessageContext)
    context;
    objCon = {'sObjectType' : 'Contact'};
    firstAndLastName;
    conFirstName;
    conLastName;
    @track caseList;
    firstNameHandler(event)
    {
      this.objCon.FirstName = event.target.value;
    }
    lastNameHandler(event)
    {
       this.objCon.LastName = event.target.value;
    }
    sendButtonHandler()
    {
       this.firstAndLastName = this.objCon.FirstName+ ' ' + this.objCon.LastName;
       this.conFirstName = this.objCon.FirstName;
       this.conLastName  = this.objCon.LastName;
       console.log('Contact Name:' +this.firstAndLastName);
       getRelatedCasesForContact({'contactName' : this.firstAndLastName})
       .then(result=>{
        console.log('Success...');
        this.caseList = result;
        const message  = {
            caseListLMS:{
                value : this.caseList
            },
            firstNameLMS:{
                value : this.conFirstName
            },
            lastNameLMS:{
                value : this.conLastName
            }
          }
          publish(this.context,CASECHANNEL,message);
       })
       .catch(error=>{
        console.log('Something went wrong....' +JSON.stringify(error));
       })
    }
}