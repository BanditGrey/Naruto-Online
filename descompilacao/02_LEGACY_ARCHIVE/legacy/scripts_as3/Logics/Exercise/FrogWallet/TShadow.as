package Logics.Exercise.FrogWallet
{
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   
   public class TShadow extends TBaseActivity
   {
      
      public static const RESULT_LOSE:int = -1;
      
      public static const RESULT_NOCHANGE:int = 0;
      
      public static const RESULT_WIN:int = 1;
      
      public static const MAX_RATE:int = 10000;
      
      protected var FMinGold:int;
      
      protected var FMaxGold:int;
      
      protected var FResult:int;
      
      protected var FPutGold:int;
      
      protected var FPutCount:int;
      
      protected var FShadowConfigs:Vector.<TShadowConfig>;
      
      protected var FIsContinue:Boolean;
      
      public function TShadow()
      {
         super();
         this.FShadowConfigs = new Vector.<TShadowConfig>();
         FInventories = new TInventories();
      }
      
      public function get MinGold() : int
      {
         return this.FMinGold;
      }
      
      public function set MinGold(param1:int) : void
      {
         this.FMinGold = param1;
      }
      
      public function get MaxGold() : int
      {
         var _loc1_:TCharacter = null;
         _loc1_ = SLogicsCore.Character;
         return _loc1_.CreditGold + _loc1_.CreditGiftCertificate;
      }
      
      public function get ShadowConfigs() : Vector.<TShadowConfig>
      {
         return this.FShadowConfigs;
      }
      
      public function set ShadowConfigs(param1:Vector.<TShadowConfig>) : void
      {
         this.FShadowConfigs = param1;
      }
      
      public function get Result() : int
      {
         return this.FResult;
      }
      
      public function set Result(param1:int) : void
      {
         this.FResult = param1;
      }
      
      public function get PutGold() : int
      {
         return this.FPutGold;
      }
      
      public function set PutGold(param1:int) : void
      {
         this.FPutGold = param1;
      }
      
      public function get PutCount() : int
      {
         return this.FPutCount;
      }
      
      public function set PutCount(param1:int) : void
      {
         this.FPutCount = param1;
      }
      
      public function get IsContinue() : Boolean
      {
         return this.FIsContinue;
      }
      
      public function set IsContinue(param1:Boolean) : void
      {
         this.FIsContinue = param1;
      }
      
      public function ChangeBoxStatus(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
      }
      
      public function GetConfigByItemID(param1:int) : TShadowConfig
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TShadowConfig = null;
         _loc3_ = int(this.FShadowConfigs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FShadowConfigs[_loc2_];
            if(_loc4_.ItemID == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetInventoryByResult() : void
      {
         this.FPutGold = this.FMinGold;
         if(this.FResult == RESULT_LOSE)
         {
            FInventories.Clear();
         }
      }
      
      public function GetReward() : void
      {
         if(this.FResult != RESULT_LOSE)
         {
            this.FResult = RESULT_LOSE;
            if(!this.FIsContinue)
            {
               FInventories.Clear();
               this.FPutCount = 0;
            }
         }
      }
      
      public function GetRate() : int
      {
         var _loc1_:int = 0;
         var _loc2_:TInventory = null;
         var _loc3_:TShadowConfig = null;
         _loc2_ = FInventories.GetInventoryByIndex(0);
         _loc3_ = this.GetConfigByItemID(_loc2_.IDTemplate);
         if(!_loc3_)
         {
            return 0;
         }
         if(this.FPutCount <= 0)
         {
            return 0;
         }
         _loc1_ = _loc3_.ItemCnt[this.FPutCount - 1];
         _loc1_ += _loc3_.ItemMinGold[this.FPutCount - 1] * this.FPutGold;
         return int(Math.min(_loc1_,MAX_RATE));
      }
   }
}

