import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getOpportunities from '@salesforce/apex/AccountProvider.getOpportunities';
export default class PopupParentAccount extends LightningElement 
{
  objAcc = {'sObjectType' : 'Account'};
  parentOppoList;
  parentName;
  totalRecordsFound = 0;

  nameHandler(event)
  {
    this.objAcc.Name = event.target.value;
    this.parentName  = this.objAcc.Name;
  }
  ratingHandler(event)
  {
    this.objAcc.Rating = event.target.value;
  }
  buttonHandler()
  {
     getOpportunities({'objAcc' : this.objAcc})
    .then(result=>{
        console.log('Success.....');
        if(result.length > 0)
        {
        this.parentOppoList = result;
        this.totalRecordsFound = result.length;
        this.template.querySelector('c-popup-oppo-child').openModal();
        this.successToastMsg();      
        }
        else
        {
          this.showInfo();
        }
    })
    .catch(error=>{
        console.log('Something went wrong...' + JSON.stringify(error));
        this.popupModalFlag = false;
    })
  }
  successToastMsg()
  {
    const evt= new ShowToastEvent({
        title:  'Opportunity Records',
        message:'Records fetched',
        variant:'success',
    });
    this.dispatchEvent(evt);
  }
  showInfo()
  {
    constvevt = new ShowToastEvent({
        title: 'Info',
        message: 'No Record Found',
        variant: 'info',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
}

}