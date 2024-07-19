import { LightningElement,wire } from 'lwc';
//import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllAccountsUsingWire from '@salesforce/apex/AccountProvider.getAllAccountsUsingWire';
import deleteSelectedAccounts from '@salesforce/apex/AccountProvider.deleteSelectedAccounts';

export default class DeleteAccountRecord extends LightningElement
{
  draftValues = [];
  accColumns = [
    { label : 'Name' , fieldName : 'Name', editable : true },
    { label : 'Type' , fieldName : 'Type', editable : true },
    { label : 'Created Date' , fieldName : 'CreatedDate', type : 'date', editable : true },
    { label : 'Rating' , fieldName : 'Rating', editable : true },
  ];
  selectedAccounts = [];
  accounts;
  error;
  totalSelectedRecords = 0;
  wiredAccountList;
  @wire(getAllAccountsUsingWire)
  wiredAccounts(result)
  {
     if(result.data)
     {
        this.wiredAccountList = result;
        this.accounts = result.data;
        this.error    = undefined;
     }
     else if(result.error)
     {
        this.accounts = null;
        this.error    = result.error;
     }
  }
  handleRowSelection(event)
  {
     const selectedRows = event.detail.selectedRows;
     this.totalSelectedRecords = selectedRows.length;
     console.log('Records selected for Delete:' +this.totalSelectedRecords);
     for(let i=0; i<selectedRows.length; i++)
        this.selectedAccounts.push(selectedRows[i].Id);
  }
  handleDelete()
  {
    deleteSelectedAccounts({'accIds' : this.selectedAccounts})
    .then(()=>{
     this.dispatchEvent(new ShowToastEvent({
            title   : 'Delete Record',
            message : 'Account Record Deleted',
            variant : 'success'
        }));
        return refreshApex(this.wiredAccountList);
    })
    .catch((error)=>{
        this.dispatchEvent(new ShowToastEvent({
            title   : 'Error',
            message : 'Cannot delete',
            variant : 'error'
        }));
    })
  }
}