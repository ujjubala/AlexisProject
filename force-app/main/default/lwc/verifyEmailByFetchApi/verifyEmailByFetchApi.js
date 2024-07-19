import { LightningElement } from 'lwc';
import verifyMobileNumber from '@salesforce/apex/VeriphoneRequestAPI.verifyMobileNumber';
export default class VerifyEmailByFetchApi extends LightningElement 
{
  email = 'kumbhalkar.ujjwala5@gmail.com';
  endPoint = 'https://emailvalidation.abstractapi.com/v1/?api_key=9fe46f3a97fe4fa1b129b3437bb2d0e4&email=';
  verifyEmailId()
  {
    console.log(this.endPoint);
        fetch(this.endPoint+this.email, { method:'GET'})
        .then(response=> { 
            console.log('Raw Response:', response);

            if (response.ok) 
                return response.json()
            else
             {
                console.error('Network response was not ok:', response.status);
                throw new Error('Network response was not ok: '+response.status);
            }
        })
        .then(data=> {
            console.log('Data received:', data);

            if (data.deliverability==='DELIVERABLE')
                console.log('Email is deliverable'); })
}
}