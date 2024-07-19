import { LightningElement, track } from 'lwc';

export default class CommunicationCompoParent extends LightningElement 
{
    @track objAccReceived = {'sObjectType' :'Account'};

    parentJSMethodHandler(event)
    {
        this.objAccReceived =  event.detail.message; //Account Object
        console.log('Received = '+this.objAccReceived.Name);
    }

}