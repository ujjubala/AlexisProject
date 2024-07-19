import { LightningElement } from 'lwc';

export default class MockTestChild extends LightningElement 
{
    name;
    /*nameHandler(event)
    {
       this.name = event.target.value;
    }*/
   
    sendDataHandler()
    {
        this.name = this.template.querySelector('lightning-input[data-formfield="name"]').value;
        this.dispatchEvent(new CustomEvent('senddataevent',{
        detail  : {
        message : this.name } }));
    }
}