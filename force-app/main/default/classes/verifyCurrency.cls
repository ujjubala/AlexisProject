public with sharing class verifyCurrency 
{
  @AuraEnabled
  public static String getExchangeRate(String currencyFrom,String currencyTo,Decimal amount)
  {
    String convertedAmt;
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://anyapi.io/api/v1/exchange/convert?base=' + currencyFrom + '&to=' + currencyTo + '&amount=' + amount + '&apiKey=hddfk9if6io0php6th5e9o8en4r79eoiggml2j06flcouq7bko8lfao');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    if(response.getStatusCode()==200)
       System.debug('#Response' + response.getBody());

    CurrencyVerificationAPIWrapper wrapObject = new CurrencyVerificationAPIWrapper();
    CurrencyVerificationAPIWrapper wrapObj = wrapObject.parse(response.getBody());
    convertedAmt = wrapObj.converted;
    return convertedAmt;
    }
    public class CurrencyVerificationAPIWrapper 
   {
	  
     public String converted;

	  public CurrencyVerificationAPIWrapper parse(String json) 
    {
		return (CurrencyVerificationAPIWrapper) System.JSON.deserialize(json, CurrencyVerificationAPIWrapper.class);
	 }
  }
  }

    
