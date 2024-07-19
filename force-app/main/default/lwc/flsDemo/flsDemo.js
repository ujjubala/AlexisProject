import { LightningElement } from 'lwc';

export default class FlsDemo extends LightningElement 
{
    objAcc = {'sObject' : 'Account'};
    nameHandler(event)
    {
      this.objAcc.Name = event.target.value;
    }
    ratingHandler(event)
    {
      this.objAcc.Rating = event.target.value;
    }
}