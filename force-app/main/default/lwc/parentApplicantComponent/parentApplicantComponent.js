import { LightningElement ,track } from 'lwc';
import getRelatedAddressRecords from '@salesforce/apex/AccountProvider.getRelatedAddressRecords';
export default class ParentApplicantComponent extends LightningElement 
{
   @track objApplicant ={'sObjectType' : 'Applicant__c'}
   relatedAddressList;
   objAppName;
  // idApplicant;
     nameHandler(event)
   {
    this.objAppName = event.target.value;
    console.log('Applicant ID is:' +this.objAppName);
   }
   showRelatedAddressHandler()
   {
    //debugger;
    console.log('button clicked');
    //this.objApplicant.Name = this.template.querySelector('lightning-input[dataformfield="applicantId"]').value;
    console.log(this.objApplicant.Name);
    getRelatedAddressRecords({'objAppName' : this.objAppName})
    .then(success=>{
        console.log('Successful return');
        console.log('Success ' +JSON.stringify(success));
        this.relatedAddressList=success;
    })
    .catch(error=>{
        console.log('Error '+JSON.stringify(error));
    })
   }
}