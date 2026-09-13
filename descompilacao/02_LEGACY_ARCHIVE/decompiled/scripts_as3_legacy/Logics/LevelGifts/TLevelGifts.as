package Logics.LevelGifts
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TTalentLevelGifts;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TLevelGifts
   {
      
      protected var FIdentifier:int;
      
      protected var FReward:int;
      
      protected var FTopReward:int;
      
      public var TalentLevelGifts:TTalentLevelGifts;
      
      public var RewardList:TInventories;
      
      public var TopRewardList:TInventories;
      
      public function TLevelGifts()
      {
         super();
      }
      
      public function get Identifier() : int
      {
         return this.FIdentifier;
      }
      
      public function set Identifier(param1:int) : void
      {
         this.FIdentifier = param1;
         this.TalentLevelGifts = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TalentLevelGifts,this.FIdentifier) as TTalentLevelGifts;
      }
      
      public function get Reward() : int
      {
         return this.FReward;
      }
      
      public function set Reward(param1:int) : void
      {
         this.FReward = param1;
      }
      
      public function get TopReward() : int
      {
         return this.FTopReward;
      }
      
      public function set TopReward(param1:int) : void
      {
         this.FTopReward = param1;
      }
   }
}

