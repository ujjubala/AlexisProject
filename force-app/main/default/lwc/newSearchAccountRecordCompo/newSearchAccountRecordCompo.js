import { LightningElement } from 'lwc';
import searchAccountByChar from '@salesforce/apex/AccountProvider.searchAccountByChar';
export default class NewSearchAccountRecordCompo extends LightningElement 
{
    columns= [  
        { label:'Name', fieldName:'Name', editable:true },
        { label:'Type', fieldName:'Type', editable:true },
        { label:'Created Date', fieldName:'CreatedDate', editable:true },
        { label:'SLA', fieldName:'SLA__c', editable:true }
      ];
    draftValues=[];
    objAccount= {'sObjectType' :'Account'};
    accList;
    showTableFlag=false;
    totalRecordsFound=0; 
    nameHandler(event)
    {
      this.objAccount.Name = event.target.value;
      searchAccountByChar({'objAccount' :this.objAccount})
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