package Logics.Exercise.BrazilCarnival
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TBrazilCarnivalColorEgg extends TBaseActivity
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FStatus:int;
      
      public function TBrazilCarnivalColorEgg()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>(BOX_COUNT);
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
   }
}

