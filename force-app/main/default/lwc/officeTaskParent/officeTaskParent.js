import { LightningElement } from 'lwc';
import getRelatedCases from '@salesforce/apex/AccountProvider.getRelatedCases';
export default class OfficeTaskParent extends LightningElement 
{
  objAcc = {'sObjectType' : 'Account'};
  parentCaseList;
  showTableFlag=false;
  nameHandler(event)
  {
    this.objAcc.Name = event.target.value;
  }  
  sendButtonHandler()
  {
    getRelatedCases({'objAccount' : this.objAcc})
    .then(result=>{
        console.log('Success.....');
        this.parentCaseList = result;
        this.showTableFlag  = true;
    })
    .catch(error=>{
        console.log('something went wrong....' + JSON.stringify(error));
        this.showTableFlag = false;
    })
  }
  closeButtonHandler(event)
  {
    this.showTableFlag = event.detail.message;
  }
}