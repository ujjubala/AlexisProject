import { LightningElement } from 'lwc';
import   createNewAccount  from '@salesforce/apex/AccountProvider.createNewAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class NewAccountComponent extends LightningElement 
{
    objAccount = {'sObjectType': 'Account'};
    msg = 'Waiting';
    nameHandler(event)
    {
      this.objAccount.Name = event.target.value;
      console.log(this.objAccount.Name);
    }
    ratingHandler(event)
    {
      this.objAccount.Rating = event.target.value;
      console.log(this.objAccount.Rating);
    }
    accountNoHandler(event)
    {
       this.objAccount.AccountNumber = event.target.value;
       //console.log(this.objAccount.Name);
    }
    websiteHandler(event)
    {
        this.objAccount.Website = event.target.value;
    }
    sicCodeHandler(event)
    {
        this.objAccount.Sic = event.target.value;
    }
    createAccountButtonHandler()
    {
        console.log('You just clicked the button');
        createNewAccount({'objAcc' : this.objAccount})
        .then(result=>{
           // console.log(result);
           this.msg = result;
           this.showSuccess(result);
        })
        .catch(error=>{
            console.log(error);
        })
    }
    showSuccess(result1)
    {
        console.log('In Toast msg method');
        const evt = new ShowToastEvent({
            title   :'Success',
            message : result1,
            variant :'success'
        });
        this.dispatchEvent(evt);
    }
}