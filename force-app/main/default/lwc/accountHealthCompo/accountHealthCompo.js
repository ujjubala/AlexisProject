import { LightningElement ,wire,track } from 'lwc';
import getRelatedContactRecords from '@salesforce/apex/AccountProvider.getRelatedContactRecords';
import getRelatedOpportunities from '@salesforce/apex/AccountProvider.getRelatedOpportunities';
import getRelatedCases from '@salesforce/apex/AccountProvider.getRelatedCases';
import OPPORTUNITYCHANNEL from '@salesforce/messageChannel/OpportunityDataChannel__c';
import CASECHANNEL from '@salesforce/messageChannel/CaseDataChannel__c';
import {publish,MessageContext } from 'lightning/messageService';
export default class AccountHealthCompo extends LightningElement 
{
  @wire(MessageContext)
  context;
  objAcc = {'sObjectType' : 'Account'};
  @track contactList;
  @track oppoList;
  @track caseList;
  nameHandler(event)
  {
    this.objAcc.Name = event.target.value;
  }
  async searchButtonHandler()
  {
    const result = await getRelatedContactRecords({objAccount : this.objAcc});
    this.contactList = result;
    const result1 = await getRelatedOpportunities({objAccount : this.objAcc});
    this.oppoList = result1;
    const message  = {
     oppoListLMS:{
          value : this.oppoList
      }
    }
    publish(this.context,OPPORTUNITYCHANNEL,message);
    const result2 = await getRelatedCases({objAccount : this.objAcc});
    this.caseList = result2;
     const message1  = {
        caseListLMS:{
            value : this.caseList
        }
      }
      publish(this.context,CASECHANNEL,message1);
    }
}
   
      
     
   
   
    
