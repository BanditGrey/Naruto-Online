package Logics.Characters
{
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import Logics.Inventories.TInventories;
   import Logics.Items.TItem;
   
   public class TSuperHero extends THero
   {
      
      protected var FHeroType:int;
      
      protected var FHeroSpecialTalk:String;
      
      protected var FHeroDescribtion:String;
      
      protected var FEnlistCondition:Vector.<TItem>;
      
      protected var FOriginalEnlistCondition:Vector.<TItem>;
      
      protected var FEnlistInventory:TInventories;
      
      protected var FRelationHeroID:uint;
      
      protected var FEnlistLevelLimit:int;
      
      protected var FAdvanceNeedVipLevel:int;
      
      protected var FHeroState:int;
      
      public function TSuperHero(param1:uint)
      {
         super(param1);
         this.FEnlistCondition = new Vector.<TItem>();
         this.FOriginalEnlistCondition = new Vector.<TItem>();
         this.FEnlistInventory = new TInventories();
      }
      
      public function get HeroType() : int
      {
         return this.FHeroType;
      }
      
      public function set HeroType(param1:int) : void
      {
         this.FHeroType = param1;
      }
      
      public function get RelationHeroID() : uint
      {
         return this.FRelationHeroID;
      }
      
      public function set RelationHeroID(param1:uint) : void
      {
         this.FRelationHeroID = param1;
      }
      
      public function get AdvanceNeedVipLevel() : int
      {
         return this.FAdvanceNeedVipLevel;
      }
      
      public function set AdvanceNeedVipLevel(param1:int) : void
      {
         this.FAdvanceNeedVipLevel = param1;
      }
      
      public function get HeroSpecialTalk() : String
      {
         return this.FHeroSpecialTalk;
      }
      
      public function set HeroSpecialTalk(param1:String) : void
      {
         this.FHeroSpecialTalk = param1;
      }
      
      public function get HeroState() : int
      {
         return this.FHeroState;
      }
      
      public function set HeroState(param1:int) : void
      {
         this.FHeroState = param1;
      }
      
      public function get HeroDescribtion() : String
      {
         return this.FHeroDescribtion;
      }
      
      public function set HeroDescribtion(param1:String) : void
      {
         this.FHeroDescribtion = param1;
      }
      
      public function get EnlistCondition() : Vector.<TItem>
      {
         return this.FEnlistCondition;
      }
      
      public function get OriginalEnlistCondition() : Vector.<TItem>
      {
         return this.FOriginalEnlistCondition;
      }
      
      public function get EnlistInventory() : TInventories
      {
         return this.FEnlistInventory;
      }
      
      public function set EnlistInventory(param1:TInventories) : void
      {
         this.FEnlistInventory = param1;
      }
      
      public function get EnlistLevelLimit() : int
      {
         return this.FEnlistLevelLimit;
      }
      
      public function set EnlistLevelLimit(param1:int) : void
      {
         this.FEnlistLevelLimit = param1;
      }
      
      public function AddEnlistCondition(param1:Vector.<TTaskReward>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TItem = null;
         var _loc5_:TTaskReward = null;
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TItem();
            _loc5_ = param1[_loc2_];
            _loc4_.Type = _loc5_.Type;
            _loc4_.ID = _loc5_.Code;
            _loc4_.Count = _loc5_.Amount;
            this.FEnlistCondition.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function AddOriginalEnlistCondition(param1:Vector.<TTaskReward>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TItem = null;
         var _loc5_:TTaskReward = null;
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TItem();
            _loc5_ = param1[_loc2_];
            _loc4_.Type = _loc5_.Type;
            _loc4_.ID = _loc5_.Code;
            _loc4_.Count = _loc5_.Amount;
            this.FOriginalEnlistCondition.push(_loc4_);
            _loc2_++;
         }
      }
   }
}

