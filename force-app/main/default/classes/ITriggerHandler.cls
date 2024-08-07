public interface ITriggerHandler 
{
    Boolean isDisabled();
    void beforeInsert(List<sObject>newList);
    void afterInsert(List<sObject>newList, Map<Id, sObject>newMap);
    void beforeUpdate(List<sObject>newList, Map<Id, sObject>newMap,  List<sObject>oldList, Map<Id, sObject>oldMap);
    void afterUpdate(List<sObject>newList, Map<Id, sObject>newMap,  List<sObject>oldList, Map<Id, sObject>oldMap);
    void beforeDelete(List<sObject>oldList , Map<Id, sObject>oldMap);
    void afterDelete(List<sObject>oldList , Map<Id, sObject>oldMap);
    void afterUnDelete(List<sObject>newList, Map<Id, sObject>newMap);   
}