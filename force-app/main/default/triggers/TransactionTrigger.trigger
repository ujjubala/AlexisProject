trigger TransactionTrigger on Transaction__c (after insert)
{
  Set<Id> custIdSet = new Set<Id>();
  if(trigger.isAfter && trigger.isInsert)
  {
     for(Transaction__c objTrans : trigger.new)
     {
       if(objTrans.Customer__c != null)
       {
         if(trigger.isInsert)
                custIdSet.add(objTrans.Customer__c);
       }
     }
  }
  Map<Id, Customer__c> custMap = new Map<Id, Customer__c>();
  if(!custIdSet.isEmpty())
  {
     for(Customer__c objCust : [select Id, Total_Balance__c from Customer__c where Id in : custIdSet])
         custMap.put(objCust.Id, objCust);
  }
  if(trigger.isAfter && trigger.isInsert)
  {
    for(Transaction__c objTrans : trigger.new)
    {
       if(custMap.containsKey(objTrans.Customer__c))
       {
         if(objTrans.Transaction_Type__c == 'Deposit')
             custMap.get(objTrans.Customer__c).Total_Balance__c = custMap.get(objTrans.Customer__c).Total_Balance__c + objTrans.Amount__c;
         else if(objTrans.Transaction_Type__c == 'Withdraw')
         {
             if(custMap.get(objTrans.Customer__c).Total_Balance__c >= objTrans.Amount__c)
                 custMap.get(objTrans.Customer__c).Total_Balance__c = custMap.get(objTrans.Customer__c).Total_Balance__c - objTrans.Amount__c;
             else
                 objTrans.addError('Insufficient Balance ....can not perform withdraw operation');
         }
      }
    }
  }
   Database.update(custMap.values(), false);
 }