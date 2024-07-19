import { LightningElement } from 'lwc';
import method1 from '@salesforce/apex/TestPromiseChaining.method1';
import method2 from '@salesforce/apex/TestPromiseChaining.method2';

export default class DemoAsyncAwait extends LightningElement 
{
  output = "Waiting....";
  connectedCallback(){}
  
  /*async asyncCall(Event)
    {
        this.output = 'Waiting...';
        this.output = await method1();
        this.output = await method2({param : this.output});
    }*/
    promiseCall(Event)
    {
        this.output = "waiting...";
        method1()
        .then((result)=>((this.output = result), method2({param : result})))
        .then((result)=> (this.output = result));
    }
  }