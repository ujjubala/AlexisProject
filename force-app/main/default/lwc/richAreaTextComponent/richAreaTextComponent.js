import { LightningElement,api } from 'lwc';
import {
    FlowAttributeChangeEvent,
    FlowNavigationNextEvent,
} from 'lightning/flowSupport';
export default class RichAreaTextComponent extends LightningElement
 {
    @api placeHolder;
    @api myLabel;
    @api myValue;
    @api reqd;
    
 }