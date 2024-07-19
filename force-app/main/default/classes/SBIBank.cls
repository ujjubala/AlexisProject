public class SBIBank implements MyInterface
{
   Double bal=0;
   public void deposit(integer amt)
   {
     bal = bal + amt;
     System.debug(amt + 'credited....new balance = ' +bal);
   }
   public void withdrawl(integer amt)
   {
     bal = bal - amt;
     System.debug(amt + 'Debited...new balance = ' +bal);
   }
   public void calculateEMI()
   {
     System.debug('This is SBI EMI calculate logic');
   }
}