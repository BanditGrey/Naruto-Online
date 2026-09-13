package Logics.Exercise.VipShop
{
   import Logics.Characters.TCharacter;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   
   public class TVipBox
   {
      
      protected var FIdentify:int;
      
      protected var FVipLevel:int;
      
      protected var FBoxCount:int;
      
      protected var FBuyCount:int;
      
      protected var FPrice:int;
      
      protected var FDiscountPrice:int;
      
      protected var FInventories:TInventories;
      
      protected var FStatus:int;
      
      public function TVipBox()
      {
         super();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get BoxCount() : int
      {
         return this.FBoxCount;
      }
      
      public function set BoxCount(param1:int) : void
      {
         this.FBoxCount = param1;
      }
      
      public function get BuyCount() : int
      {
         return this.FBuyCount;
      }
      
      public function set BuyCount(param1:int) : void
      {
         this.FBuyCount = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get DiscountPrice() : int
      {
         return this.FDiscountPrice;
      }
      
      public function set DiscountPrice(param1:int) : void
      {
         this.FDiscountPrice = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get VipLevel() : int
      {
         return this.FVipLevel;
      }
      
      public function set VipLevel(param1:int) : void
      {
         this.FVipLevel = param1;
      }
      
      public function CheckVipLevel() : Boolean
      {
         var _loc1_:TCharacter = null;
         var _loc2_:int = 0;
         _loc2_ = int(SLogicsCore.Character.VipLevel);
         if(_loc2_ >= this.FVipLevel)
         {
            return true;
         }
         return false;
      }
   }
}

