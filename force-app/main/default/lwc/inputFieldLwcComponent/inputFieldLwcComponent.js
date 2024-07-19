import { LightningElement }   from 'lwc';
import searchAccountDateRange from '@salesforce/apex/AccountRecordSearch.searchAccountDateRange';



export default class InputFieldLwcComponent extends LightningElement
{
  
   objAcc = {'sObjectType' : 'Account'};
   accList;
   showTableFlag = false;
   totalRecordsFound = 0;
   fromDate;
   toDate;
   columns= [  
    { label:'Name', fieldName:'Name', editable:true },
    { label:'Type', fieldName:'Type', editable:true },
    { label:'Created Date', fieldName:'CreatedDate', editable:true },
    { label:'SLA', fieldName:'SLA__c', editable:true }
  ];
  draftValues = [];
   selectFromDateHandler(event)
   {
    this.fromDate = event.target.value;
    console.log('From Date:' +this.fromDate);
   }
   selectToDateHandler(event)
   {
    debugger;
    this.toDate = event.target.value;
    console.log('To Date:' +this.toDate);
   }
   typeHandler(event)
   {
    this.objAcc.Type = event.target.value;
    searchAccountDateRange({'objAcc' : this.objAcc, 'fromDate' : this.fromDate, 'toDate' : this.toDate})
    .then(result=>{
        console.log('Result '+JSON.stringify(result));
        this.accList=result;
        this.totalRecordsFound=result.length;
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