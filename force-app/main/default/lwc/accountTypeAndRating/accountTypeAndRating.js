import { LightningElement } from 'lwc';
import searchAccountDateRange from '@salesforce/apex/AccountRecordSearch.searchAccountDateRange';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountTypeAndRating extends LightningElement
{
    objAcc = {'sObjectType' : 'Account'};
    columns = [
        {label : 'Name', fieldName : 'Name', type : 'text'},
        {label : 'Rating' , fieldName : 'Rating' ,editable : true},
        {label : 'Type' , fieldName : 'Type', editable : true},
        {label : 'Created Date', fieldName : 'CreatedDate' , type : 'date'}
    ];
    draftValues = [];
    accList;
    totalRecordsFound = 0;
    showTableFlag     = false;
    showSpinnerFlag   = false;
    fromDate;
    toDate;
    ratingHandler(event)
    {
      this.objAcc.Rating = event.target.value;
    }
    typeHandler(event)
    {
       this.objAcc.Type = event.target.value;
    }
    dateHandler(event)
    {
      let d1 = this.template.querySelector('lightning-input[data-formfield ="fromDate"]').value; 
      
      let date1 = new Date(d1);
      console.log('Date1:' +date1);
      let d2 = this.template.querySelector(".dateCmp");
      let date2 = new Date(d2.value);
      console.log('Date2:' +date2);
      //let date2 = new Date('2024/05/28');
      if(date1.getFullYear()==date2.getFullYear())
      {
        if(date1.getMonth() > date2.getMonth() || (date1.getMonth()==date2.getMonth() && date1.getDate()>date2.getDate()))
        {
          console.log(' dates not valid');  
          d2.setCustomValidity('From Date should not be greater than to date..');
        }
      }
        else
        {
          console.log('Two dates are not equal');  
          d2.setCustomValidity(" ");
          this.fromDate = date1;
          this.toDate = date2;
        }
        d2.reportValidity();
       }
    searchButtonHandler()
    { 
       this.showSpinnerFlag = true;
       searchAccountDateRange({'objAcc' : this.objAcc,'date1' : this.fromDate, 'date2' : this.toDate})
       .then(result=>{
        this.showSpinnerFlag = false;
        console.log('Success....');
        this.accList = result;
        this.totalRecordsFound = result.length;
        if(result.length > 0)
        {
          this.showTableFlag = true;
          this.successToastMessage();
        }
        else
        {
           this.showTableFlag = false;
        }
       })
       .catch(error=>{
        console.log('Erorr..' +JSON.stringify(result));
        this.showError();
       })
    }
    successToastMessage()
    {
        const evt= new ShowToastEvent({
           title:  'Account Records',
           message:'Account Records are fetched',
           variant:'success',
       });
       this.dispatchEvent(evt);
    }
    showError()
    {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'There is some error',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}
