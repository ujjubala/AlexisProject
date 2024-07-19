import { LightningElement,track } from 'lwc';
import pubsub from 'c/pubsub';
import getRelatedCasesForContact from '@salesforce/apex/AccountProvider.getRelatedCasesForContact';
export default class ContactPubsubCompo extends LightningElement 
{
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
        getRelatedCasesForContact({'objContact' : this.objCon})
        .then(result=>{
            console.log('Success...');
            this.caseList = result;
            const payload = {
                var1: this.caseList,
                var2: this.objCon.FirstName,
                var3: this.objCon.LastName,
            };
            pubsub.publish('eventName', payload);
        })
        .catch(error=>{
            console.log('Error:' + error);
        })
    }
}