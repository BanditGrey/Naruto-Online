package Logics.Exercise.CrossServerSale
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TCrossServerSale extends TBaseActivity
   {
      
      public static const BOX_COUNT:uint = 3;
      
      protected var FBoxVect:Vector.<TBaseBox>;
      
      public function TCrossServerSale()
      {
         super();
         this.FBoxVect = new Vector.<TBaseBox>(BOX_COUNT);
      }
      
      public function get BoxVect() : Vector.<TBaseBox>
      {
         return this.FBoxVect;
      }
      
      public function set BoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxVect = param1;
      }
   }
}

