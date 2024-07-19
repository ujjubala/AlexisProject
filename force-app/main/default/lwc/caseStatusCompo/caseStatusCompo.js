import { LightningElement,wire,api } from 'lwc';
import { getRecord,updateRecord } from 'lightning/uiRecordApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import CASE_STATUS from '@salesforce/schema/Case.Status';
import CASE_DESCRIPTION from '@salesforce/schema/Case.Description';

export default class CaseStatusCompo extends LightningElement 
{
  @api recordId;
  caseStatus;
  caseDesc;
  
  componentClass1 = 'hide';
  componentClass2 = 'hide';
  

  @wire(getRecord, {recordId : '$recordId', fields : [CASE_STATUS,CASE_DESCRIPTION]})
  wiredCase({data,error})
  {
    if(data)
    {
       if(data.fields.Status.value=='Escalated')
        {
         this.componentClass1 = 'show';
         this.componentClass2 =  'hide'
        }
        else if(data.fields.Status.value=='Working')
        {
           this.componentClass1 = 'hide';
           this.componentClass2 = 'show';
        }
        this.caseDesc = data.fields.Description.value;
    }
    if(error)
    {
      this.caseRecord = undefined;
      this.caseError  = error;
    }
  }
  
  reopenCaseHandler()
  {
    this.updateCaseStatusToNew();
  }
  updateCaseStatusToNew()
  {
    const fields = 
    {
        'Id'          :  this.recordId,
        'Status'      : 'New', 
        
    }
        const recordInput = { fields };

        updateRecord(recordInput);
  }
  escalateCaseHandler()
  {
    this.updateCaseStatusToEscalated();
  }
  updateCaseStatusToEscalated()
  {
    const fields = 
    {
        'Id'          :  this.recordId,
        'Status'      : 'Escalated', 
        
    }
        const recordInput = { fields };

        updateRecord(recordInput); 
  }
 /* handleDescriptionChange(event)
  {
    this.caseDesc = 'Updating Case Status';
  }*/
}