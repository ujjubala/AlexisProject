import { LightningElement } from 'lwc';

export default class MockTestParent extends LightningElement 
{
   parentData;
   parentX=100;
   parentJSDataHandler(event)
   {
    this.parentData = event.detail.message;
   }
}