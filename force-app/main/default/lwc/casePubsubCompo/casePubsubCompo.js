import { LightningElement} from 'lwc';
import pubsub from 'c/pubsub';

export default class CasePubsubCompo extends LightningElement
{
    showTableFlag = false;
    receivedCaseList;
    firstName;
    lastName;
    draftValues = [];
    caseColumns = [
        { label : 'Case Number', fieldName   : 'CaseNumber', editable : true},
        { label : 'Case Reason', fieldName   : 'Reason' , type : 'text',editable : true},
        { label : 'Case Status', fieldName  : 'Status', type : 'text'},
        { label : 'Case Origin', fieldName : 'Origin', type: 'text',editable: true }
    ];
    connectedCallback()
    {
        pubsub.subscribe('eventName', (payload)=>{
            this.receivedCaseList    = payload.var1;
            this.firstName           = payload.var2;
            this.lastName            = payload.var3;   
        });
        this.showTableFlag = true;
    }
}
