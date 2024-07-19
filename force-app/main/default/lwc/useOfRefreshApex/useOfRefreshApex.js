import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/AccountProvider.getAccounts';
import deleteAccount from '@salesforce/apex/AccountProvider.deleteAccount';
export default class UseOfRefreshApex extends LightningElement 
{
    accounts;
    error;
    wiredAccountResult;
    @wire(getAccounts)
    wiredAccounts( result ) 
    {
        this. wiredAccountResult=result;
        if (result.data) 
        {
            this.accounts = result.data;
            this.error = undefined;
        } else if (result.error) 
        {
            this.accounts = undefined;
            this.error = result.error;
        }
    }
    handleDelete(event) 
    {
        const accountId= event.target.dataset.accountId;
        deleteAccount({ accountId })
            .then(() => {
                    this.dispatchEvent(new ShowToastEvent({
                    title   : 'deleted',
                    message : 'Record deleted successfully',
                    variant : 'success'}));
                refreshApex(this. wiredAccountResult);
            })
            .catch((error) => {
                // Handle the error if deletion fails
            })
    }
}