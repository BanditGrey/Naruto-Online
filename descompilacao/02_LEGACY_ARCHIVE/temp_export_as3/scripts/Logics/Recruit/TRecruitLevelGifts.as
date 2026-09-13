package Logics.Recruit
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TDrawNinjaConfig;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TRecruitLevelGifts
   {
      
      protected var FIdentifier:int;
      
      protected var FReward:int;
      
      protected var FTopReward:int;
      
      public var DrawNinjaConfig:TDrawNinjaConfig;
      
      public var RewardList:TInventories;
      
      public var TopRewardList:TInventories;
      
      public function TRecruitLevelGifts()
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
         this.DrawNinjaConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_DrawNinjaConfig,this.FIdentifier) as TDrawNinjaConfig;
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

