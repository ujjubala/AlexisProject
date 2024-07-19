import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement 
{
    name; //undefined
    firstName           = 'Silver'
    lastName            = 'Microsystems'
    phone               = '9822224249'
    emailId             = 'sfdc@gmail.com'
    age                 =  20
    salary              =  50000.00
    panCardVerification =  false
    currentDate         =  new Date();
    objAcc              =  {'sObjectType' : 'Account'}
    objAcc              =  {'Name' : 'Cinemax', 'Rating' : 'Hot'}
    empList             =  ['Ram', 'Shyam', 'Bunty', 'Bubli']
   
    display()
    {
       console.log('I am from display Method');
    }
    get calculation()
    {
       this.display();
       console.log('I am from calculation JS method');
       return 'Bubli';
    }


}