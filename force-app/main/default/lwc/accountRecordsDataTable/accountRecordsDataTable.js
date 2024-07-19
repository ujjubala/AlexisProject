import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import latestAccountRecords from '@salesforce/apex/AccountRecordSearch.latestAccountRecords';


export default class AccountRecordsDataTable extends LightningElement 
{
    objAcc = {'sObjectType' : 'Account'};
    totalRecordsFound = 0;
    showTableFlag = false;
    accList;
    draftValues=[];
    columns= [  
     { label:'Name', fieldName:'Name', editable:true },
     { label:'Created Date', fieldName:'CreatedDate', Type:'Date',
        typeAttributes:{day: '2-digit', month: '2-digit', year: 'numeric'} },
     { label:'Type', fieldName:'Type', editable:true },
     { label:'Rating', fieldName:'Rating', editable:true },
     { label:'SLA', fieldName:'SLA__c', editable:true }
     
     ];
     latestAccountRecordsButtonHandler()
    {
      //this.objAcc.Type = event.target.value;
      latestAccountRecords({'objAcc' : this.objAcc})
        .then(success=>{
         //console.log('Result' + JSON.stringify(success));
         this.accList = success;
         this.totalRecordsFound = success.length;
         if(success.length>=1)
             this.showTableFlag = true;
         else
             this.showTableFlag = false;
         
        })
        .catch(error=>{
         console.log('Error' + error);
         this.showTableFlag = false;
        })
    }    
}
