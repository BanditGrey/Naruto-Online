package Logics.Exercise.NinjaTreasure
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TNinjaTreasure2 extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FSuperSaleBox:TBaseBox;
      
      public function TNinjaTreasure2()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FSuperSaleBox = new TBaseBox();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get SuperSaleBox() : TBaseBox
      {
         return this.FSuperSaleBox;
      }
      
      public function set SuperSaleBox(param1:TBaseBox) : void
      {
         this.FSuperSaleBox = param1;
      }
   }
}

