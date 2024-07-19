import { LightningElement } from 'lwc';

export default class CreateLeadForm extends LightningElement 
{
  
  leadStatus;
  leadIndustry;
  leadSource;
  
  statusHandler(event)
  {
    this.leadStatus  = event.target.value;
    console.log('status : ' +this.leadStatus);
    this.setFields(); 
    this.setLeadSource();
  }
  setFields()
  {
    if(this.leadStatus == 'Open - Not Contacted')
    {
      const ind   = this.template.querySelector('.indField');
      const ldsrc = this.template.querySelector('.leadField');
      ind.disabled = !indField.disabled;
      ldsrc.disabled = !leadField.disabled;
    }
    else
    {
    if(this.leadStatus == 'Working - Contacted')
    {
        this.leadIndustry = 'Banking';
        this.leadSource   = 'Web';
    }
    else if(this.leadStatus == 'Closed - Converted')
    {
      this.leadIndustry = 'Communications';
      this.leadSource   = 'Purchased List';
    }
    else if(this.leadStatus == 'Closed - Not Converted')
    {
        this.leadIndustry = 'Energy';
        this.leadSource  = 'Partner Referral';
    }
  } 
    
  }
  setLeadSource()
  {
    if(this.leadIndustry == 'Engineering')
      this.leadSource = 'Phone Inquiry';
  }
}
