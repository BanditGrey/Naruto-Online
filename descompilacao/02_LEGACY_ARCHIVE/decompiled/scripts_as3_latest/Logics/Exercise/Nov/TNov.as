package Logics.Exercise.Nov
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TNov extends TBaseActivity
   {
      
      public static const TYPE_FREE:int = 0;
      
      public static const TYPE_COIN:int = 1;
      
      public static const TYPE_GOLD:int = 2;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public var NextTime:int;
      
      public var ClearTimePrice:int;
      
      public var DailyTimes:int;
      
      public var FreeTime:int;
      
      public var LimitTime:int;
      
      public var ToughCost:int;
      
      public var PetLevel:int;
      
      public var PetMin:int;
      
      public var PetMax:int;
      
      public var PetBuff:int;
      
      public var PetNextBuff:int;
      
      public var PetIsMaxLevel:int;
      
      public var PetUpgradePrice:int;
      
      public var PetFailValue:int;
      
      public var UpgradeGift:Vector.<TBaseBox>;
      
      public var FoodList:Vector.<TBaseBox>;
      
      public var ConsumeBox:Vector.<TBaseBox>;
      
      public var ShowItems:TInventories;
      
      public function TNov()
      {
         super();
         this.GiftList = new Vector.<TBaseBox>();
         this.FoodList = new Vector.<TBaseBox>();
         this.UpgradeGift = new Vector.<TBaseBox>();
         this.ConsumeBox = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.GiftList.length)
         {
            if(this.GiftList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               this.GiftList[_loc1_].Status = TotalRechargeGold >= this.GiftList[_loc1_].Price ? 1 : 0;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.ConsumeBox.length)
         {
            if(this.ConsumeBox[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && TotalConsumeGold >= this.ConsumeBox[_loc1_].Price)
            {
               this.ConsumeBox[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function GetGiftIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.UpgradeGift.length)
         {
            if(this.UpgradeGift[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function GetConsumeGiftIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.ConsumeBox.length)
         {
            if(this.ConsumeBox[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
   }
}

