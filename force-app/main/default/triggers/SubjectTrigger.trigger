trigger SubjectTrigger on Subject__c (before insert, before update, after unDelete)
{
  Set<Id> studIdSet = new Set<Id>();
  if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || trigger.isAfter && trigger.isUndelete)
  {
    for(Subject__c objSub : trigger.new)
    {
      if(objSub.Student__c != null)
      {
        if(trigger.isInsert || trigger.isUndelete)
           studIdSet.add(objSub.Student__c);
      }
      if(trigger.isUpdate)
      {
        if(objSub.Student__c != trigger.oldMap.get(objSub.Id).Student__c)
           studIdSet.add(objSub.Student__c);
      }
    }
  }
  Map<Id, Student__c> studMap = new Map<Id, Student__c>();
  if(!studIdSet.isEmpty())
  {
    for(Student__c objStud : [select Id, (select Id, Select_Subject__c from Subjects__r) from Student__c where Id in : studIdSet])
        studMap.put(objStud.Id, objStud);
  }
  if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) || trigger.isAfter && trigger.isUndelete)
  {
    if(!studMap.isEmpty())
    {
      for(Subject__c objSub : trigger.new)
      {
         if(studMap.containsKey(objSub.Student__c))
         {
           List<Subject__c> subList = studMap.get(objSub.Student__c).Subjects__r;
           for(Subject__c objSubList : subList)
           {
             if(objSub.Select_Subject__c == objSubList.Select_Subject__c) 
             {
               if(objSub.Select_Subject__c=='Marathi' || objSub.Select_Subject__c == 'Hindi' || objSub.Select_Subject__c == 'English')
                   objSub.addError('Can not add this subject....already there');
             }
           }
         }
      }   
    }
  }
}