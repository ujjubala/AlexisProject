import { LightningElement, track } from 'lwc';

export default class CommunicationCompoChild extends LightningElement 
{
    @track objAcc= {'sObjectType' :'Account'}; //Object (Non-Primitive Data Type default nature Non-Reactive. To make it reactive @track)

    nameHandler(event){
       console.log(event.target.value);
       this.objAcc.Name=event.target.value ; // Cinemax
    }

    sendDataHandler()
    {
            //Send Data to Parent Component

            this.dispatchEvent(new CustomEvent('eventname', {
                detail: {
                    message:this.objAcc
                }
            }));
    }
}   