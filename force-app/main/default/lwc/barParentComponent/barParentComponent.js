import { LightningElement } from 'lwc';

export default class BarParentComponent extends LightningElement 
{
    changeColorHandler()
    {
       this.template.querySelector('c-bar-child-component').changeBarColor();
    }
}