package Logics.Exercise.NationalDay
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Processors.Game.Lobby.Exercise.NationalDay.TProcessorWindowNationalDayFund;
   import Processors.Game.Lobby.Exercise.NationalDay.TProcessorWindowNationalDayGift;
   import Processors.Game.Lobby.Exercise.NationalDay.TProcessorWindowNationalDayNinjia;
   
   public class TNationalDay extends TBaseActivity
   {
      
      public static const GIFT_COUNT:int = TProcessorWindowNationalDayGift.GIFT_COUNT;
      
      public static const FUND_COUNT:int = TProcessorWindowNationalDayFund.FUND_COUNT;
      
      public static const STONE_COUNT:int = TProcessorWindowNationalDayNinjia.STONE_COUNT;
      
      public static const NINJIA_COUNT:int = TProcessorWindowNationalDayNinjia.NINJIA_COUNT;
      
      public static const RESULT_FAILED:int = 0;
      
      public static const RESULT_SUCCESS:int = 1;
      
      protected var FActiveDesc2:String;
      
      protected var FGiftVect:Vector.<TBaseBox>;
      
      protected var FFundVect:Vector.<TBaseBox>;
      
      protected var FStoneVect:Vector.<TBaseBox>;
      
      protected var FNinjiaVect:Vector.<TBaseBox>;
      
      protected var FGiftID:int;
      
      protected var FFundID:int;
      
      protected var FFreeTimes:int;
      
      protected var FStones:int;
      
      public function TNationalDay()
      {
         super();
         this.FGiftVect = new Vector.<TBaseBox>(GIFT_COUNT);
         this.FFundVect = new Vector.<TBaseBox>(FUND_COUNT);
         this.FStoneVect = new Vector.<TBaseBox>(STONE_COUNT);
         this.FNinjiaVect = new Vector.<TBaseBox>(NINJIA_COUNT);
      }
      
      public function get ActiveDesc2() : String
      {
         return this.FActiveDesc2;
      }
      
      public function set ActiveDesc2(param1:String) : void
      {
         this.FActiveDesc2 = param1;
      }
      
      public function get GiftVect() : Vector.<TBaseBox>
      {
         return this.FGiftVect;
      }
      
      public function set GiftVect(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftVect = param1;
      }
      
      public function get FundVect() : Vector.<TBaseBox>
      {
         return this.FFundVect;
      }
      
      public function set FundVect(param1:Vector.<TBaseBox>) : void
      {
         this.FFundVect = param1;
      }
      
      public function get GiftID() : int
      {
         return this.FGiftID;
      }
      
      public function set GiftID(param1:int) : void
      {
         this.FGiftID = param1;
      }
      
      public function get FundID() : int
      {
         return this.FFundID;
      }
      
      public function set FundID(param1:int) : void
      {
         this.FFundID = param1;
      }
      
      public function get FreeTimes() : int
      {
         return this.FFreeTimes;
      }
      
      public function set FreeTimes(param1:int) : void
      {
         this.FFreeTimes = param1;
      }
      
      public function get Stones() : int
      {
         return this.FStones;
      }
      
      public function set Stones(param1:int) : void
      {
         this.FStones = param1;
      }
      
      public function get StoneVect() : Vector.<TBaseBox>
      {
         return this.FStoneVect;
      }
      
      public function set StoneVect(param1:Vector.<TBaseBox>) : void
      {
         this.FStoneVect = param1;
      }
      
      public function get NinjiaVect() : Vector.<TBaseBox>
      {
         return this.FNinjiaVect;
      }
      
      public function set NinjiaVect(param1:Vector.<TBaseBox>) : void
      {
         this.FNinjiaVect = param1;
      }
      
      public function ChangeStoneStatus(param1:int, param2:int) : void
      {
         if(param1 != 0)
         {
            this.FStoneVect[param1].Status = TBaseActivity.STATUS_CANNOTGET;
         }
         if(param2 == RESULT_SUCCESS)
         {
            if(param1 != this.FStoneVect.length - 1)
            {
               this.FStoneVect[param1 + 1].Status = TBaseActivity.STATUS_CANGET;
            }
         }
      }
      
      public function ChangeHeroStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.NinjiaVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FStones >= this.NinjiaVect[_loc1_].Price)
            {
               this.NinjiaVect[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckBoxStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FGiftVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FGiftVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc2_ = int(this.NinjiaVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.NinjiaVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         if(this.FFreeTimes > 0)
         {
            return true;
         }
         return false;
      }
   }
}

