import { LightningElement } from 'lwc';
import optionA from './optionA.html';
import optionB from './optionB.html';


export default class MultipleHtmlCompo extends LightningElement
{
     displayData = false;
    render()
    {
        console.log('In render Method');
        return this.displayData ? optionA : optionB;
    }
    toggleOptions()
    {
        console.log('Button Clicked');
        console.log(this.displayData);
        this.displayData = !this.displayData;
    }
 }