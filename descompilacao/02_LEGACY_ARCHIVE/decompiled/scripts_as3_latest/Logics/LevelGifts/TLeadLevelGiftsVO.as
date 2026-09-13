package Logics.LevelGifts
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TLeadLevelGifts;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TLeadLevelGiftsVO
   {
      
      protected var FIdentifier:int;
      
      protected var FReward:int;
      
      protected var FTopReward:int;
      
      protected var FStage:int;
      
      public var LeadLevelGifts:TLeadLevelGifts;
      
      public var RewardList:TInventories;
      
      public var TopRewardList:TInventories;
      
      public function TLeadLevelGiftsVO()
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
         this.LeadLevelGifts = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeadLevelGifts,this.FIdentifier) as TLeadLevelGifts;
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
      
      public function get Stage() : int
      {
         return this.FStage;
      }
      
      public function set Stage(param1:int) : void
      {
         this.FStage = param1;
      }
   }
}

