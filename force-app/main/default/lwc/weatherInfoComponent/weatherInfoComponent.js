import { LightningElement } from 'lwc';


export default class WeatherInfoComponent extends LightningElement 
{
  cityName;
  apiKey = '1b7db95407d348a74a817e5fb0d20eee';
  endPoint = 'https://api.openweathermap.org/data/2.5/weather?q=';
  
  
  showWeatherDetailsFlag = false;
  weatherDetails = [];
  nameHandler(event)
  {
    this.cityName = event.target.value;
  }
  async handleWeatherDetails()
  {
    console.log('Button Clicked....calling api');
    try
    {
      const response = await fetch(this.endPoint + this.cityName + '&units=metric' + '&APPID=' +this.apiKey);
      if(response.status==200)
      {
         const data = await response.json();
         this.weatherDetails = data.main;
         this.showWeatherDetailsFlag=true;
         //window.location.reload();
      }
      else
         {
            this.showWeatherDetailsFlag = false;
            console.error('Network response was not ok:', response.status);
             throw newError('Network response was not ok: '+response.status);
         }
    }
    catch(error)
    {
      console.log('opps....something went wrong');
      window.location.reload();
    }
  }
}