package Logics.Organization.TreasureTree
{
   public class TOperatingShowInfo
   {
      
      protected var FShowIndex:int;
      
      protected var FShowType:uint;
      
      protected var FUserName:String;
      
      protected var FAddExp:uint;
      
      protected var FCurrentTreeLevel:uint;
      
      protected var FRewardID:uint;
      
      protected var FRewardName:String;
      
      protected var FRewardCount:uint;
      
      protected var FFruitID:uint;
      
      protected var FFruitName:String;
      
      protected var FUserQuality:uint;
      
      public function TOperatingShowInfo()
      {
         super();
         this.FUserName = "";
         this.FRewardName = "";
         this.FFruitName = "";
      }
      
      public function get ShowIndex() : int
      {
         return this.FShowIndex;
      }
      
      public function set ShowIndex(param1:int) : void
      {
         this.FShowIndex = param1;
      }
      
      public function get ShowType() : uint
      {
         return this.FShowType;
      }
      
      public function set ShowType(param1:uint) : void
      {
         this.FShowType = param1;
      }
      
      public function get UserName() : String
      {
         return this.FUserName;
      }
      
      public function set UserName(param1:String) : void
      {
         this.FUserName = param1;
      }
      
      public function get AddExp() : uint
      {
         return this.FAddExp;
      }
      
      public function set AddExp(param1:uint) : void
      {
         this.FAddExp = param1;
      }
      
      public function get CurrentTreeLevel() : uint
      {
         return this.FCurrentTreeLevel;
      }
      
      public function set CurrentTreeLevel(param1:uint) : void
      {
         this.FCurrentTreeLevel = param1;
      }
      
      public function get RewardID() : uint
      {
         return this.FRewardID;
      }
      
      public function set RewardID(param1:uint) : void
      {
         this.FRewardID = param1;
      }
      
      public function get RewardName() : String
      {
         return this.FRewardName;
      }
      
      public function set RewardName(param1:String) : void
      {
         this.FRewardName = param1;
      }
      
      public function get RewardCount() : uint
      {
         return this.FRewardCount;
      }
      
      public function set RewardCount(param1:uint) : void
      {
         this.FRewardCount = param1;
      }
      
      public function get FruitID() : uint
      {
         return this.FFruitID;
      }
      
      public function set FruitID(param1:uint) : void
      {
         this.FFruitID = param1;
      }
      
      public function get FruitName() : String
      {
         return this.FFruitName;
      }
      
      public function set FruitName(param1:String) : void
      {
         this.FFruitName = param1;
      }
      
      public function get UserQuality() : uint
      {
         return this.FUserQuality;
      }
      
      public function set UserQuality(param1:uint) : void
      {
         this.FUserQuality = param1;
      }
   }
}

