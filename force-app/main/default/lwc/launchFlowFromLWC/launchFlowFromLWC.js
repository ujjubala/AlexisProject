import { LightningElement } from 'lwc';
import getSingleAccount from '@salesforce/apex/AccountProvider.getSingleAccount';
export default class LaunchFlowFromLWC extends LightningElement
{
  singleAccount;
  connectedCallback()
  {
    getSingleAccount()
    .then((result) => {
       console.log('Result' +result);
    })
    .catch((error)=>{
        console.log('Error' +error);
    })
  }
  get inputVariables()
  {
    return[
        {
            name  : 'account',
            type  : 'sObject',
            value : this.singleAccount
        }
    ];
  }
  handleStatusChange(event)
  {
    console.log('handleStatusChange',event.detail);
  }
}