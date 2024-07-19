import { LightningElement,api } from 'lwc';

export default class RelatedAddressChildCompo extends LightningElement 
{
    @api applicantAddressList;
    // showTableFlag=false;
    // totalAddresses=0;
    draftValues=[];
    columns = [  
        { label:'Country', fieldName:'Country__c', editable:true },
        { label:'State', fieldName:'State__c', editable:true },
        { label:'City', fieldName:'City__c', editable:true } 
    ];
   
   // objAddress = {'sObjectType' : 'Address__c'};
   
   //columns=columns;

}