import { LightningElement } from 'lwc';

export default class CustomValidityCompo extends LightningElement 
{
    dateHandler(event)
    {
        // var validRegex = /^(1[ -]?)?(\()?\d{3}(\))?[ -]?[0-9]{3}[ -]?[0-9]{4}$/;
       // var validReg1 = /^(\()?\d{3}(\))?$/;
        let d1 = this.template.querySelector(".dateCmp");
        let dateObj = new Date(d1.value);
        var month = dateObj.getMonth();
        if(month==7)
              d1.setCustomValidity('Not a valid Date..Month can not be August');
        else
              d1.setCustomValidity(" ");
        d1.reportValidity();
       }
 }
