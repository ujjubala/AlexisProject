public with sharing class WhetherInfor
 {
    @AuraEnabled
    public static WeatherInfoWrapper getWhetherDetails(String cityName)
    {
       String apiKey    = '1b7db95407d348a74a817e5fb0d20eee';
       String endPoint  = 'api.openweathermap.org/data/2.5/weather';
       Http http        = new Http();
       HttpRequest req  = new HttpRequest();
       req.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q=' +cityName + '&units=metric' + '&APPID=' +apiKey);
       req.setMethod('GET');
       HttpResponse response = http.send(req);
       WeatherInfoWrapper objWrap = new WeatherInfoWrapper(); 
       if(response.getStatusCode()==200)
       {
          System.debug('Response Body:' +response.getBody());
          Map<String,object> weatherMap = (Map<String,object>) JSON.deserializeUntyped(response.getBody());
          objWrap.city = String.valueOf(weatherMap.get('name'));
          Map<String,object> mainResult = (Map<String,object>) (weatherMap.get('main'));
          objWrap.temperature = String.valueOf(mainResult.get('temp'));
          objWrap.pressure  = String.valueOf(mainResult.get('pressure'));
          objWrap.humidity  = String.valueOf(mainResult.get('humidity'));
          ObjWrap.feels_like = String.valueOf(mainResult.get('feels_like'));
          ObjWrap.temp_min = String.valueOf(mainResult.get('temp_min'));
          ObjWrap.temp_max = String.valueOf(mainResult.get('temp_max'));
         }
      return objWrap;
    }
    public class WeatherInfoWrapper
   {
   	@AuraEnabled public String city;
      @AuraEnabled public String temperature;
      @AuraEnabled public String feels_like;
      @AuraEnabled public String temp_min;
      @AuraEnabled public String temp_max;
      @AuraEnabled public String pressure;
      @AuraEnabled public String humidity;
    }
}