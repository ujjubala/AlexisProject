import { LightningElement, api} from 'lwc';

export default class Child extends LightningElement 
{
   @api childX ;
    // childHandler()
    // {
    //   this.dispatchEvent(new CustomEvent('notification', {
    //         detail: {
    //             message:this.childX
               
    //         }
    //     }));
    // }

}