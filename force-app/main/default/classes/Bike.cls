public class Bike
{
   integer y=200;
   
   
   public void add()
   {
      integer sum=0;
      Car c = new Car(); 
      sum = c.x + y;
      System.debug('My new sum is:' + sum);
   }
}