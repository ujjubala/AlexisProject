public abstract class ReserveBank
{
    Double balance=0;
    public void deposit(integer amt)
    {
        balance = balance+amt;
        System.debug(amt + 'Amount credited..new balance = ' +balance);
       }
    public void withdrawl(integer amt)
    {
       balance = balance - amt;
       System.debug(amt + 'Amount debited..new balance=' +balance);
    }
    public abstract void calculateEMI();
   }