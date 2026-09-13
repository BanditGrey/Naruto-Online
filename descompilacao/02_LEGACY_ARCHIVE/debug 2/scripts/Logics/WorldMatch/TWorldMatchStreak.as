package Logics.WorldMatch
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TGlobalArenaStreak;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TWorldMatchStreak
   {
      
      protected var FIdentifier:int;
      
      protected var FReward:int;
      
      protected var FTopReward:int;
      
      protected var FLimit:int;
      
      public var Level:String;
      
      public var Count:int;
      
      public var GlobalArenaStreak:TGlobalArenaStreak;
      
      public var RewardList:TInventories;
      
      public var TopRewardList:TInventories;
      
      public function TWorldMatchStreak()
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
         this.GlobalArenaStreak = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_GlobalArenaStreak,this.FIdentifier) as TGlobalArenaStreak;
         this.Level = this.GlobalArenaStreak.Level;
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

