trigger CustomerUpdateTrigger on Customer__c (before update)
{
   List<Customer_History__c> custHistList = new List<Customer_History__c>();
   if(trigger.isBefore && trigger.isUpdate)
   {
     for(Customer__c objCust : trigger.old)
     {
        Customer_History__c objCustHistory 	= new Customer_History__c();
        objCustHistory.Cust_First_Name__c 	= objCust.First_Name__c;
        objCustHistory.Cust_Last_Name__c 	= objCust.Last_Name__c;
        objCustHistory.Cust_Total_Bal__c 	= objCust.Total_Balance__c;
        custHistList.add(objCustHistory);
      }
   }    
    if(!custHistList.isEmpty())
        Database.insert(custHistList, false);
}