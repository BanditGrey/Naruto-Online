package Logics.Exercise.BossTreasure
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TBossTreasure extends TBaseActivity
   {
      
      public var Equiplist:Vector.<TBaseBox>;
      
      public var Accessorylist:Vector.<TBaseBox>;
      
      public var Itemlist:Vector.<TBaseBox>;
      
      public var Giftlist:Vector.<TBaseBox>;
      
      public var Discount:Vector.<int>;
      
      public var CurConsumeGold:int;
      
      public function TBossTreasure()
      {
         super();
         this.Discount = new Vector.<int>();
         this.Equiplist = new Vector.<TBaseBox>();
         this.Accessorylist = new Vector.<TBaseBox>();
         this.Itemlist = new Vector.<TBaseBox>();
         this.Giftlist = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function get CurDiscount() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.Discount.length)
         {
            if(this.CurConsumeGold < this.Discount[_loc1_])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
      }
   }
}

