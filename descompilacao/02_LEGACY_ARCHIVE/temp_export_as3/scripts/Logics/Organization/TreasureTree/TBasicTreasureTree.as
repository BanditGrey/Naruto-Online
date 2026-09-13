package Logics.Organization.TreasureTree
{
   public class TBasicTreasureTree
   {
      
      protected var FOrgFruitMatureTimes:uint;
      
      protected var FOrgFruitPickCount:uint;
      
      protected var FUserFruitPickCount:uint;
      
      protected var FUserWaterCount:uint;
      
      protected var FPushChakaraCount:uint;
      
      protected var FPushChakaraCDTime:uint;
      
      protected var FTreeLevel:uint;
      
      protected var FTreeCurrentExp:uint;
      
      protected var FTreeLevelupExp:uint;
      
      protected var FAddPushChakaraRestCount:uint;
      
      protected var FIsNew:int;
      
      protected var FIsPickOrgFruit:uint;
      
      protected var FOrgFruitUpdateTime:uint;
      
      protected var FUserWaterInfos:TUserWaterInfos;
      
      protected var FUserFruitInfos:TUserFruitInfos;
      
      protected var FOperatingShowInfos:TOperatingShowInfos;
      
      public function TBasicTreasureTree()
      {
         super();
         this.FUserWaterInfos = new TUserWaterInfos();
         this.FUserFruitInfos = new TUserFruitInfos();
         this.FOperatingShowInfos = new TOperatingShowInfos();
      }
      
      public function get UserWaterInfos() : TUserWaterInfos
      {
         return this.FUserWaterInfos;
      }
      
      public function set UserWaterInfos(param1:TUserWaterInfos) : void
      {
         this.FUserWaterInfos = param1;
      }
      
      public function get UserFruitInfos() : TUserFruitInfos
      {
         return this.FUserFruitInfos;
      }
      
      public function set UserFruitInfos(param1:TUserFruitInfos) : void
      {
         this.FUserFruitInfos = param1;
      }
      
      public function get OrgFruitMatureTimes() : uint
      {
         return this.FOrgFruitMatureTimes;
      }
      
      public function set OrgFruitMatureTimes(param1:uint) : void
      {
         this.FOrgFruitMatureTimes = param1;
      }
      
      public function get OrgFruitPickCount() : uint
      {
         return this.FOrgFruitPickCount;
      }
      
      public function set OrgFruitPickCount(param1:uint) : void
      {
         this.FOrgFruitPickCount = param1;
      }
      
      public function get UserFruitPickCount() : uint
      {
         return this.FUserFruitPickCount;
      }
      
      public function set UserFruitPickCount(param1:uint) : void
      {
         this.FUserFruitPickCount = param1;
      }
      
      public function get UserWaterCount() : uint
      {
         return this.FUserWaterCount;
      }
      
      public function set UserWaterCount(param1:uint) : void
      {
         this.FUserWaterCount = param1;
      }
      
      public function get PushChakaraCount() : uint
      {
         return this.FPushChakaraCount;
      }
      
      public function set PushChakaraCount(param1:uint) : void
      {
         this.FPushChakaraCount = param1;
      }
      
      public function get PushChakaraCDTime() : uint
      {
         return this.FPushChakaraCDTime;
      }
      
      public function set PushChakaraCDTime(param1:uint) : void
      {
         this.FPushChakaraCDTime = param1;
      }
      
      public function get TreeLevel() : uint
      {
         return this.FTreeLevel;
      }
      
      public function set TreeLevel(param1:uint) : void
      {
         this.FTreeLevel = param1;
      }
      
      public function get TreeCurrentExp() : uint
      {
         return this.FTreeCurrentExp;
      }
      
      public function set TreeCurrentExp(param1:uint) : void
      {
         this.FTreeCurrentExp = param1;
      }
      
      public function get TreeLevelupExp() : uint
      {
         return this.FTreeLevelupExp;
      }
      
      public function set TreeLevelupExp(param1:uint) : void
      {
         this.FTreeLevelupExp = param1;
      }
      
      public function get AddPushChakaraRestCount() : uint
      {
         return this.FAddPushChakaraRestCount;
      }
      
      public function set AddPushChakaraRestCount(param1:uint) : void
      {
         this.FAddPushChakaraRestCount = param1;
      }
      
      public function get OperatingShowInfos() : TOperatingShowInfos
      {
         return this.FOperatingShowInfos;
      }
      
      public function set OperatingShowInfos(param1:TOperatingShowInfos) : void
      {
         this.FOperatingShowInfos = param1;
      }
      
      public function get IsNew() : int
      {
         return this.FIsNew;
      }
      
      public function set IsNew(param1:int) : void
      {
         this.FIsNew = param1;
      }
      
      public function get IsPickOrgFruit() : uint
      {
         return this.FIsPickOrgFruit;
      }
      
      public function set IsPickOrgFruit(param1:uint) : void
      {
         this.FIsPickOrgFruit = param1;
      }
      
      public function get OrgFruitUpdateTime() : uint
      {
         return this.FOrgFruitUpdateTime;
      }
      
      public function set OrgFruitUpdateTime(param1:uint) : void
      {
         this.FOrgFruitUpdateTime = param1;
      }
      
      public function HasMatureFruit() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:TUserFruitInfo = null;
         _loc1_ = 0;
         while(_loc1_ < this.FUserFruitInfos.Count)
         {
            _loc2_ = this.FUserFruitInfos.GetUserFruitByIndex(_loc1_);
            if(this.FUserFruitPickCount > 0 && _loc2_.FruitMatureTime == 0 && _loc2_.FruitLevel >= 5)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

