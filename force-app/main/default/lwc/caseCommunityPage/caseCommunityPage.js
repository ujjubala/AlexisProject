import { LightningElement } from 'lwc';
import getRelatedCaseFrom from '@salesforce/apex/AccountProvider.getRelatedCaseFrom';
import getRelatedCaseStatus from '@salesforce/apex/AccountProvider.getRelatedCaseStatus';
import getCaseCount from '@salesforce/apex/AccountProvider.getCaseCount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CaseCommunityPage extends LightningElement 
{
    objCase = {'sObjectType' : 'Case'};
    caseList1;
    caseList2;
    page = 1;
    pageSize = 5;
    showSpinnerFlag = false;
    showTableFlag1 = false;
    showTableFlag2 = false;
    totalRecordsFound = 0;
    totalPages;
    draftValues = [];
    columns = [
        { label : 'Number' , fieldName : 'CaseNumber', editable : true},
        { label : 'Status',  fieldName : 'Status',     editable : true}
    ];
    handleCaseNum(event)
    {
      this.objCase.CaseNumber = event.target.value;
    }
    
    statusHandler(event)
    {
      this.objCase.Status = event.target.value;
      getCaseCount({'objCase' : this.objCase})
      .then(result=>{
        console.log('Total Cases:' +result);
        this.totalRecordsFound = result;
        this.totalPages        = Math.ceil(this.totalRecordsFound / this.pageSize);
        console.log('Total Pages:' +this.totalPages);
        this.fetchCases();
      })
      .catch(error=>{
        console.log('Something went wrong.....');
      })
    }
    
    fetchCases()
    {
      getRelatedCaseStatus({'objCase' : this.objCase,'pageSize' : this.pageSize, 'pageNumber' : this.page})
      .then(success=>{
        console.log('Success.....');
        this.caseList2         = success;
        this.showTableFlag2    = true;
        this.showTableFlag1    = false;
      })
      .catch(error=>{
        console.log('Something went wrong.....' +JSON.stringify(error));
      })
    }
    caseButtonHandler()
    {
        this.showSpinnerFlag = true;
        getRelatedCaseFrom({'objCase' : this.objCase})
        .then(result=>{
            console.log('Successs.....');
            console.log('Records :' +result.length);
            this.showSpinnerFlag = false;
            this.caseList1 = result;
            if(result.length > 0)
            {
              this.showTableFlag1 = true;
              this.showTableFlag2 = false;
              this.successToastMsg();
            }
            else
              this.showTableFlag1 = false;
        })
        .catch(error=>{
            console.log('Something went wrong......' +JSON.stringify(error));
        })
    }
    successToastMsg()
    {
      this.dispatchEvent(new ShowToastEvent({
        title   : 'Case Records',
        message : 'Records Fetched',
        variant : 'success'
      }));       
    }
    handleFirst()
    {
      this.page = 1;
      this.fetchCases();
    }
    handleNext() 
    {
        if (this.page < this.totalPages) {
            this.page += 1;
            this.fetchCases();
        }
    }
 
    handlePrevious()
     {
        if (this.page > 1) {
            this.page -= 1;
            this.fetchCases();
        }
    }
    handleLast()
    {
      this.page = this.totalPages;
      this.fetchCases();
    }
    get isFirstPage()
    {
      return this.page === 1;
    }
    get isLastPage()
    {
    return this.page >= this.totalPages;
    }
}