import { LightningElement } from 'lwc';
import searchAccountRecords from '@salesforce/apex/AccountRecordSearch.searchAccountRecords';

export default class SearchAccountComponent extends LightningElement 
{
    objAcc = {'sObjectType' : 'Account'};
    accList;
    showTableFlag = false;
    totalRecordsFound = 0;
    typeHandler(event)
    {
       //debugger;
       this.objAcc.Type = event.target.value;
    }
    ratingHandler(event)
    {
        this.objAcc.Rating = event.target.value;
        searchAccountRecords({'objAcc' : this.objAcc})
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