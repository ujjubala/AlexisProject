import { LightningElement ,track} from 'lwc';
import getRelatedContactRecords from '@salesforce/apex/AccountProvider.getRelatedContactRecords';
export default class SearchAccountParentCompo extends LightningElement 
{
  @track objAcc = {'sObjectType' : 'Account'}
  contactList;
  showPopupModalFlag=false;
  nameHandler(event)
  {
    this.objAcc.Name = event.target.value;
    console.log(this.objAcc.Name);
  }
  sendAccountNameHandler()
  {
    console.log('Button Clicked');
    getRelatedContactRecords({'objAccount' :this.objAcc})
    .then(success=>{
        console.log('Success '+JSON.stringify(success));
        this.contactList=success;
        this.showPopupModalFlag=true;
        console.log(this.howPopupModalFlag);
    })
    .catch(error=>{
        console.log('Error '+JSON.stringify(error));
        this.showPopupModalFlag=false;
    })
  }
  
  closePopupModalHandler(event)
  {
    this.showPopupModalFlag = event.detail.message ; //false
    
  }
//  errorCallback(error,stack)
//   {
//     alert(' Some Error Occurred....' + error);
//   }
}