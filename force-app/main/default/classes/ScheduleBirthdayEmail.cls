public class ScheduleBirthdayEmail implements Schedulable
{
   public void execute(SchedulableContext SC)
   {
     Database.executeBatch(new BatchApplicantBirthdayEmail(),100);
   }
}