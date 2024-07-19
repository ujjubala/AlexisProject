import { LightningElement } from 'lwc';
import searchAccountDateRange from '@salesforce/apex/AccountRecordSearch.searchAccountDateRange';
export default class InputFieldQuerySelectorComponent extends LightningElement 
{
    objAccount= {'sObjectType' :'Account'};
    accList;
    showTableFlag=false;
    totalRecords=0;
    fromDate1;
    toDate1;

    draftValues=[];
    accColumns= [  
  { label:'Name', fieldName:'Name', editable:true },
  { label:'Type', fieldName:'Type', editable:true },
  { label:'SLA', fieldName:'SLA__c', editable:true },
  { label:'Created Date', fieldName:'CreatedDate', editable:true }
];
    typeHandler(event)
    {
       this.fromDate1 = this.template.querySelector('lightning-input[dataformfield="fromDate1"]'.value);
       this.toDate1   = this.template.querySelector('lightning-input[dataformfield="toDate1"]'.value);
       console.log('from Date' + this.fromDate1);
       console.log('to Date' + this.toDate1);
       this.objAccount.Type=event.target.value;        
       
        //Calling Apex Controller Method
        searchAccountDateRange({'objAcc' :this.objAccount , 'date1' :this.fromDate1, 'date2' :this.toDate1})
        .then(result=>{
            console.log(result);
            this.accList=result;

            if(result.length>0){
                this.showTableFlag=true;
                this.totalRecords=result.length;
            }
            else{
                this.showTableFlag=false;
                this.totalRecords=0;
            }
        })
        .catch(error=>{
            console.log(error);
            this.showTableFlag=false;
            this.totalRecords=0;
        })
    }

}