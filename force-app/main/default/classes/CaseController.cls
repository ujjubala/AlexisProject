public with sharing class CaseController
 {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(Integer pageSize, Integer pageNumber) 
    {
        Integer offset = (pageNumber - 1) * pageSize;
        return [SELECT Id, CaseNumber,Priority,Status,Origin FROM Case ORDER BY CreatedDate DESC LIMIT :pageSize OFFSET : offset];
    }
        
    @AuraEnabled(cacheable=true)
    public static Integer getCaseCount() 
    {
        return [SELECT COUNT() FROM Case];
    }
}
    

   
