import { LightningElement,api } from 'lwc';

export default class OfficeTaskChild extends LightningElement
{
   @api childCaseList;
   draftValues = [];
   columns = [
    { label : 'Number', fieldName   : 'CaseNumber', editable : true},
    { label : 'Reason', fieldName   : 'Reason' , type : 'text',editable : true},
    { label : 'Status', fieldName  : 'Status', type : 'text'},
    { label : 'Origin', fieldName : 'Origin', type: 'text',editable: true }
   ];
   closeButtonHandler()
   {
    this.dispatchEvent(new CustomEvent('closedatatableevent',{detail : {
        message : false
    }}));
   }
}
