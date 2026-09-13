package Logics.GroupBattle
{
   import Logics.Inventories.TInventories;
   
   public class TGroupBattleLevel
   {
      
      protected var FLevelID:uint;
      
      protected var FLevelName:String;
      
      protected var FSortIndex:int;
      
      protected var FOpenLevel:uint;
      
      protected var FRecommendLevel:uint;
      
      protected var FPreLevel:uint;
      
      protected var FNextOpen:uint;
      
      protected var FBigImage:uint;
      
      protected var FAwardInventories:TInventories;
      
      protected var FIsOpenLevel:Boolean;
      
      protected var FIsServerData:Boolean;
      
      protected var FExpAward:uint;
      
      protected var FMoneyAward:uint;
      
      public function TGroupBattleLevel()
      {
         super();
         this.FAwardInventories = new TInventories();
         this.FIsServerData = false;
      }
      
      public function get LevelID() : uint
      {
         return this.FLevelID;
      }
      
      public function set LevelID(param1:uint) : void
      {
         this.FLevelID = param1;
      }
      
      public function get LevelName() : String
      {
         return this.FLevelName;
      }
      
      public function set LevelName(param1:String) : void
      {
         this.FLevelName = param1;
      }
      
      public function get SortIndex() : int
      {
         return this.FSortIndex;
      }
      
      public function set SortIndex(param1:int) : void
      {
         this.FSortIndex = param1;
      }
      
      public function get OpenLevel() : uint
      {
         return this.FOpenLevel;
      }
      
      public function set OpenLevel(param1:uint) : void
      {
         this.FOpenLevel = param1;
      }
      
      public function get RecommendLevel() : uint
      {
         return this.FRecommendLevel;
      }
      
      public function set RecommendLevel(param1:uint) : void
      {
         this.FRecommendLevel = param1;
      }
      
      public function get PreLevel() : uint
      {
         return this.FPreLevel;
      }
      
      public function set PreLevel(param1:uint) : void
      {
         this.FPreLevel = param1;
      }
      
      public function get NextOpen() : uint
      {
         return this.FNextOpen;
      }
      
      public function set NextOpen(param1:uint) : void
      {
         this.FNextOpen = param1;
      }
      
      public function get BigImage() : uint
      {
         return this.FBigImage;
      }
      
      public function set BigImage(param1:uint) : void
      {
         this.FBigImage = param1;
      }
      
      public function get AwardInventories() : TInventories
      {
         return this.FAwardInventories;
      }
      
      public function set AwardInventories(param1:TInventories) : void
      {
         this.FAwardInventories = param1;
      }
      
      public function get IsOpenLevel() : Boolean
      {
         return this.FIsOpenLevel;
      }
      
      public function set IsOpenLevel(param1:Boolean) : void
      {
         this.FIsOpenLevel = param1;
      }
      
      public function get IsServerData() : Boolean
      {
         return this.FIsServerData;
      }
      
      public function set IsServerData(param1:Boolean) : void
      {
         this.FIsServerData = param1;
      }
      
      public function get ExpAward() : uint
      {
         return this.FExpAward;
      }
      
      public function set ExpAward(param1:uint) : void
      {
         this.FExpAward = param1;
      }
      
      public function get MoneyAward() : uint
      {
         return this.FMoneyAward;
      }
      
      public function set MoneyAward(param1:uint) : void
      {
         this.FMoneyAward = param1;
      }
   }
}

