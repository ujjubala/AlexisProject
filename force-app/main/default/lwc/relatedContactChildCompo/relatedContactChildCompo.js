import { LightningElement, api, track} from 'lwc';

export default class RelatedContactChildCompo extends LightningElement 
{
  @api contactListChild; //By Default Private. So to make it publicly exposed, use @api decorator

draftValues=[];
columns= [
 { label:'First Name', fieldName:'FirstName', editable:true },
 { label:'Last Name', fieldName:'LastName', editable:true }
];

closeButtonHandler()
{
  this.dispatchEvent(new CustomEvent('closemypopupmodalevent', {
      detail: {
          message:false
      }
  }));
}
 constructor()
 {
    super();
    console.log('From Constructor');
 }
  connectedCallback()
  {
    console.log('From Connected CallBack');
  }
  renderedCallback()
  {
    console.log('From Rendered CallBack');
    //throw new error('Opps....');
  }
  disconnectedCallback()
  {
   console.log('From Disconnected Callback');
   alert('oye');
  }

}