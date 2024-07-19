import { LightningElement } from 'lwc';
//import {refreshApex } from '@salesforce/apex';
import searchAccountDateRange from '@salesforce/apex/AccountRecordSearch.searchAccountDateRange';
import deleteSelectedAccountRecords from '@salesforce/apex/AccountRecordSearch.deleteSelectedAccountRecords';

export default class DeleteSelectedAccountRecordsCompo extends LightningElement 
{
    objAccount= {'sObjectType' :'Account'};
    accList;
    showTableFlag=false;
    totalRecord=0;
    fromDate;
    toDate;
    totalSelectedRows=0;
    selectedRecords;  // JS Variable
    showSpinnerFlag=false;
    draftValues=[];
    accColumns= [  
  { label:'Name', fieldName:'Name', editable:true },
  { label:'Type', fieldName:'Type', editable:true },
  { label:'SLA', fieldName:'SLA__c', editable:true },
  { label:'Created Date', fieldName:'CreatedDate', editable:true }
];
    typeHandler(event)
    {
       this.fromDate=this.template.querySelector('lightning-input[data-formfield="fromDate"]').value;
       this.toDate=this.template.querySelector('lightning-input[data-formfield="toDate"]').value;
       console.log(this.fromDate+', '+this.toDate);
       this.objAccount.Type=event.target.value;        
       
        //Calling Apex Controller Method
        searchAccountDateRange({'objAcc' :this.objAccount , 'fromDate' :this.fromDate, 'toDate' :this.toDate})
        .then(result=>{
            console.log(result);
            this.accList=result;

            if(result.length>0){
                this.showTableFlag=true;
                this.totalRecord=result.length;
            }
            else{
                this.showTableFlag=false;
                this.totalRecord=0;
            }
        })
        .catch(error=>{
            console.log(error);
            this.showTableFlag=false;
            this.totalRecord=0;
        })
    }
    selectedRecordsHandler(event)
    {
        const selectedRows  =   event.detail.selectedRows;

        console.log('Selected Rows '+selectedRows);
        this.totalSelectedRows=selectedRows.length;

        let recordsSet = new Set;
        // Getting Selected Record Id
        for (let i=0; i<selectedRows.length; i++) {
            recordsSet.add(selectedRows[i].Id);
        }
        // coverting to array
        this.selectedRecords=Array.from(recordsSet);
    }

    deleteSelectedRecordsHandler()
    {
       this.showSpinnerFlag=true; //Spinner will visible
       deleteSelectedAccountRecords({'accIdList' :this.selectedRecords, 'objAccount' :this.objAccount, 'fromDate' :this.fromDate , 'toDate' :this.toDate})
        .then(success=>{
            console.log(success);
                this.accList=success;
                this.totalRecord=success.length;
                this.showSpinnerFlag=false;
                //refreshApex(this.accList);
        })
         
        .catch(error=>{
            this.accList=null;
            this.showSpinnerFlag=false;
        })
        //searchAccountDateRange({'objAcc' : this.objAccount, 'date1': this.fromDate, 'date2': this.toDate})
    }
}