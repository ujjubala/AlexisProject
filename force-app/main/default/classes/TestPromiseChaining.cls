public with sharing class TestPromiseChaining
 {
    @AuraEnabled
    public static string method1()
    {
       return 'Hello';  
        } 
    @AuraEnabled
    public static string method2(String param)
    {
      return param + 'World';
        }
}
