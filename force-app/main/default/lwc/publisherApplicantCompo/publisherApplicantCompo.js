import { LightningElement, track } from 'lwc';
import getRelatedAddressRecords from '@salesforce/apex/AccountProvider.getRelatedAddressRecords';
import pubsub from 'c/pubsub';

export default class PublisherApplicantCompo extends LightningElement 
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
    console.log(this.objApplicant.Name);
    getRelatedAddressRecords({'objAppName' : this.objAppName})
    .then(success=>{
        this.relatedAddressList = success;
        //console.log('Success ' +JSON.stringify(success));
        pubsub.publish('eventName', this.relatedAddressList);
    })
    .catch(error=>{
        console.log('Error '+JSON.stringify(error));
    })
   }
}