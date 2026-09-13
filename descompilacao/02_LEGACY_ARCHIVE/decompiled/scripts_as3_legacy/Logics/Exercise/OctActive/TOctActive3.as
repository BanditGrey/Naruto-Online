package Logics.Exercise.OctActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TOctActive3 extends TBaseActivity
   {
      
      protected var FScore:int;
      
      protected var FHero:TBaseBox;
      
      protected var FExchangeItems:Vector.<TBaseBox>;
      
      public function TOctActive3()
      {
         super();
         this.FExchangeItems = new Vector.<TBaseBox>();
      }
      
      public function get Hero() : TBaseBox
      {
         return this.FHero;
      }
      
      public function set Hero(param1:TBaseBox) : void
      {
         this.FHero = param1;
      }
      
      public function get ExchangeItems() : Vector.<TBaseBox>
      {
         return this.FExchangeItems;
      }
      
      public function set ExchangeItems(param1:Vector.<TBaseBox>) : void
      {
         this.FExchangeItems = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

