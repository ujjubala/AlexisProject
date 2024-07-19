public class OpportunityTriggerHandler implements ITriggerHandler
{
    Set<ID>accIdSet = new Set<ID>();

    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;

    //check if the trigger is disabled from transaction
    public Boolean isDisabled()
    {
        return TriggerDisabled;
    }

    public void beforeInsert(List<sObject>newList) 
    {
        if(!newList.isEmpty())
        {
            for(sObject sObj : newList)
            {
                Opportunity objOpp = (Opportunity) sObj;
                accIdSet.add(objOpp.AccountId);
            }
        }
    
    Map<ID,Account> accMap = new Map<ID,Account>();
    if(!accIdSet.isEmpty())
    {
     for(Account objAcc : [select ID, Rating from Account where ID IN :accIdSet])
       accMap.put(objAcc.Id, objAcc);
    }
    if(!newList.isEmpty())
    {
       for(sObject sObj : newList)
       {
          Opportunity objOpp = (Opportunity) sObj;
          if(accMap.containsKey(objOpp.AccountId))
          {
             if(accMap.get(objOpp.AccountId).Rating =='Hot')
               objOpp.addError('Can not create this Opp as Account Rating is Hot');
                    
          }
       }
   }
 }

    public void afterInsert(List<sObject>newList , Map<Id, sObject>newMap) 
    {

    }

    public void beforeUpdate(List<sObject>newList, Map<Id, sObject>newMap, List<sObject>oldList, Map<Id, sObject>oldMap) 
    {

    }

    public void afterUpdate(List<sObject>newList, Map<Id, sObject>newMap,  List<sObject>oldList, Map<Id, sObject>oldMap) 
    {

    }

    public void beforeDelete(List<sObject>oldList , Map<Id, sObject>oldMap) 
    {

    }

    public void afterDelete(List<sObject>oldList , Map<Id, sObject>oldMap) 
    {

    }

    public void afterUnDelete(List<sObject>newList, Map<Id, sObject>newMap) 
    {

    }
}