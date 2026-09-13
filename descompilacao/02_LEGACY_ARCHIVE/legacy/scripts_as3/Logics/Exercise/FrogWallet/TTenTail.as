package Logics.Exercise.FrogWallet
{
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Resources.Strings.STRING_FROGWALLET;
   
   public class TTenTail extends TBaseActivity
   {
      
      public static const TAIL_COUNT:int = 10;
      
      public static const SOUL_COUNT:int = 9;
      
      protected var FCurSoul:int;
      
      protected var FCurTenTail:int;
      
      protected var FExchangeScale:int;
      
      protected var FFireColor:int;
      
      protected var FRewardID:Vector.<int>;
      
      protected var FRewardColor:Vector.<int>;
      
      protected var FDisplaySoulConfig:Vector.<int>;
      
      protected var FRealSoulConfig:Vector.<int>;
      
      protected var FCertificateConfig:Vector.<int>;
      
      protected var FDisplayTenTailConfig:Vector.<int>;
      
      protected var FRealTenTailConfig:Vector.<int>;
      
      protected var FRewards:Vector.<TInventories>;
      
      protected var FChangeTabIndex:int;
      
      public function TTenTail()
      {
         super();
         this.FDisplaySoulConfig = new Vector.<int>(SOUL_COUNT);
         this.FRealSoulConfig = new Vector.<int>(SOUL_COUNT);
         this.FCertificateConfig = new Vector.<int>(SOUL_COUNT);
         this.FDisplayTenTailConfig = new Vector.<int>(TAIL_COUNT);
         this.FRealTenTailConfig = new Vector.<int>(TAIL_COUNT);
         this.FRewards = new Vector.<TInventories>(TAIL_COUNT);
         this.FRewardID = new Vector.<int>(TAIL_COUNT);
         this.FRewardColor = new Vector.<int>(TAIL_COUNT);
      }
      
      public function get CurSoul() : int
      {
         return this.FCurSoul;
      }
      
      public function set CurSoul(param1:int) : void
      {
         this.FCurSoul = param1;
      }
      
      public function get CurTenTail() : int
      {
         return this.FCurTenTail;
      }
      
      public function set CurTenTail(param1:int) : void
      {
         this.FCurTenTail = param1;
      }
      
      public function get ExchangeScale() : int
      {
         return this.FExchangeScale;
      }
      
      public function set ExchangeScale(param1:int) : void
      {
         this.FExchangeScale = param1;
      }
      
      public function get FireColor() : int
      {
         return this.FFireColor;
      }
      
      public function set FireColor(param1:int) : void
      {
         this.FFireColor = param1;
      }
      
      public function get RewardID() : Vector.<int>
      {
         return this.FRewardID;
      }
      
      public function set RewardID(param1:Vector.<int>) : void
      {
         this.FRewardID = param1;
      }
      
      public function get DisplaySoulConfig() : Vector.<int>
      {
         return this.FDisplaySoulConfig;
      }
      
      public function set DisplaySoulConfig(param1:Vector.<int>) : void
      {
         this.FDisplaySoulConfig = param1;
      }
      
      public function get RealSoulConfig() : Vector.<int>
      {
         return this.FRealSoulConfig;
      }
      
      public function set RealSoulConfig(param1:Vector.<int>) : void
      {
         this.FRealSoulConfig = param1;
      }
      
      public function get CertificateConfig() : Vector.<int>
      {
         return this.FCertificateConfig;
      }
      
      public function set CertificateConfig(param1:Vector.<int>) : void
      {
         this.FCertificateConfig = param1;
      }
      
      public function get DisplayTenTailConfig() : Vector.<int>
      {
         return this.FDisplayTenTailConfig;
      }
      
      public function set DisplayTenTailConfig(param1:Vector.<int>) : void
      {
         this.FDisplayTenTailConfig = param1;
      }
      
      public function get RealTenTailConfig() : Vector.<int>
      {
         return this.FRealTenTailConfig;
      }
      
      public function set RealTenTailConfig(param1:Vector.<int>) : void
      {
         this.FRealTenTailConfig = param1;
      }
      
      public function get Rewards() : Vector.<TInventories>
      {
         return this.FRewards;
      }
      
      public function set Rewards(param1:Vector.<TInventories>) : void
      {
         this.FRewards = param1;
      }
      
      public function get RewardColor() : Vector.<int>
      {
         return this.FRewardColor;
      }
      
      public function set RewardColor(param1:Vector.<int>) : void
      {
         this.FRewardColor = param1;
      }
      
      public function get ChangeTabIndex() : int
      {
         return this.FChangeTabIndex;
      }
      
      public function set ChangeTabIndex(param1:int) : void
      {
         this.FChangeTabIndex = param1;
      }
      
      public function ChangeBoxStatus(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = this.FRewardID.indexOf(param1);
         if(_loc4_ == -1)
         {
            return;
         }
         FRewardStatus[_loc4_] = param2;
      }
      
      public function GetCurSoulIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = SOUL_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FCurSoul < this.FRealSoulConfig[_loc1_])
            {
               break;
            }
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function GetNextSoulDesc() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = this.GetCurSoulIndex();
         if(_loc2_ >= SOUL_COUNT)
         {
            _loc1_ = STRING_FROGWALLET.FORMAT_MAX_SOUL;
         }
         else
         {
            _loc1_ = TUtilityString.Format(STRING_FROGWALLET.FORMAT_NEXT_SOUL,this.FRealSoulConfig[_loc2_] - this.FCurSoul);
         }
         return _loc1_;
      }
      
      public function GetCurTailIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = TAIL_COUNT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FCurTenTail < this.FRealTenTailConfig[_loc1_])
            {
               break;
            }
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function GetNextTailDesc() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = this.GetCurTailIndex();
         if(_loc2_ >= TAIL_COUNT)
         {
            _loc1_ = STRING_FROGWALLET.FORMAT_MAX_TAIL;
         }
         else
         {
            _loc1_ = TUtilityString.Format(STRING_FROGWALLET.FORMAT_NEXT_TAIL,this.FRealTenTailConfig[_loc2_] - this.FCurTenTail);
         }
         return _loc1_;
      }
      
      public function IsFinish() : Boolean
      {
         var _loc1_:int = this.GetCurTailIndex();
         if(_loc1_ >= TAIL_COUNT)
         {
            return true;
         }
         return false;
      }
   }
}

