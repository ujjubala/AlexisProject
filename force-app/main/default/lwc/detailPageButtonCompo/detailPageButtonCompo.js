import { LightningElement,api,wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CONTACT_LEVEL from '@salesforce/schema/Contact.Level__c';
import LANGUAGE from '@salesforce/schema/Contact.Languages__c';
export default class DetailPageButtonCompo extends LightningElement 
{
    @api recordId;  
    msg ;
    conLevel;
    conLang;
    componentClass = 'show';
    @wire(getRecord, {recordId : '$recordId', fields : [CONTACT_LEVEL,LANGUAGE]})
    wiredRecord({data,error})
    {
      if(data)
      {
      
        if(data.fields.Languages__c.value == 'English')
            this.componentClass = 'hide';
        else
            this.conLevel = data.fields.Level__c.value;    
        
      }
      else if(error)
      {
        console.log('Something went wrong....'); 
      }
    }
    handleClick()
    {
       if(this.conLevel == 'Primary')
          this.msg = 'Aati kya Khandala';
       else 
          this.msg = 'Jati kya Futala';
    }
}

