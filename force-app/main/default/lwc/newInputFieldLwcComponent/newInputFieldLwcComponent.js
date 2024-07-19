import { LightningElement } from 'lwc';
import searchAccountDateRange from '@salesforce/apex/AccountRecordSearch.searchAccountDateRange';

export default class NewInputFieldLwcComponent extends LightningElement 
{
    accColumns= [  
        { label:'Name', fieldName:'Name', editable:true },
        { label:'Type', fieldName:'Type', editable:true },
        { label:'Created Date', fieldName:'CreatedDate', editable:true },
        { label:'SLA', fieldName:'SLA__c', editable:true }
      ];
    draftValues=[];
    objAcc = {'sObjectType' : 'Account'};
    accList;
    showTableFlag=false;
    dateFrom;
    dateTo;
    recordsFound=0;
    newFromDateHandler(event)
    {
       this.dateFrom = event.target.value;
       console.log('From Date' +this.dateFrom);
    }
    newToDateHandler(event)
    {
        this.dateTo = event.target.value;
        console.log('To Date' +this.dateTo);
    }
    typeHandler(event)
    {
      this.objAcc.Type = event.target.value;
      console.log(this.objAcc.Type);
       searchAccountDateRange({'objAcc' : this.objAcc, 'date1' : this.dateFrom, 'date2' : this.dateTo})
       .then(result=>{
         console.log('Result '+JSON.stringify(result));
         this.accList=result;
         this.recordsFound=result.length;
         if(result.length>=1)
           this.showTableFlag=true;
         else
             this.showTableFlag=false;
         })
     .catch(error=>{
         console.log('Error '+error);
         this.showTableFlag=false;
     })
      
    }
}