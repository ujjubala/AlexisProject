import { LightningElement,api,track } from 'lwc';

export default class PopupOppoChild extends LightningElement
{
  @api receivedParentName;
  @api childOppoList;
  @api totalRecords;
  @track isModalOpen = false;  
  draftValues = [];
  columns = [
    {label : 'Oppo Name',fieldName : 'Name' , editable : true},
    {label : 'Stage Name',fieldName : 'StageName' , editable : true},
    {label : 'Close Date',fieldName : 'CloseDate' , type : 'date' , editable : true},
    {label : 'Amount',fieldName : 'Amount' , type : 'currency' , editable : true},
];
@api openModal()
{
    this.isModalOpen = true;
}

closeModal() 
{
    this.isModalOpen = false;
}
}