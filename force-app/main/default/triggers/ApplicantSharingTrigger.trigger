trigger ApplicantSharingTrigger on Applicant__c (after insert, after update)
{
    List<Applicant__Share> appShareList = new List<Applicant__Share>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        for(Applicant__c objApp : trigger.new)
        {
            Applicant__Share objAppShare    = new Applicant__Share();
            objAppShare.ParentId            = objApp.Id;
            objAppShare.UserOrGroupId       = objApp.User__c;
            objAppShare.AccessLevel         = 'Edit';
            objAppShare.RowCause            = Schema.Applicant__Share.RowCause.Manual;
            if(objApp.Police_Verification__c) 
                appShareList.add(objAppShare);
        }
    }
    if(!appShareList.isEmpty())
        Database.insert(appShareList, false);
}