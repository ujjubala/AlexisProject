public class Child extends Parent
{
   public integer chx = 1000;
   public void display()
   {
       System.debug('Child x value =' +chx);
       System.debug('Parent x value =' +px);
       System.debug('Super Parent x value =' +spx);
   }
 }