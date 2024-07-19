trigger CaseTrigger1 on Case (before insert) {
    if(trigger.isBefore && trigger.isInsert)
    {
        for(Case objCase : trigger.new)
        {
            if(objCase.Status == 'Escalated' && objCase.Priority == 'High')
                objCase.Description = 'Ab Tera kya Hoga Kaliya';
            else
                objCase.Description = ' ';
        }
    }
}