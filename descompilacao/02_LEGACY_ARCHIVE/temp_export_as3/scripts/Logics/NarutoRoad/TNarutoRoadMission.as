package Logics.NarutoRoad
{
   import Logics.DatebaseVO.VO.TNarutoRoadTask;
   
   public class TNarutoRoadMission
   {
      
      protected var FMissionCount:uint;
      
      protected var FNarutoRoadTask:TNarutoRoadTask;
      
      protected var FRewardType:uint;
      
      protected var FVipRewardType:uint;
      
      protected var FMissionStatus:int;
      
      protected var FTipValue:int;
      
      protected var FPopTipValue:int;
      
      public function TNarutoRoadMission()
      {
         super();
      }
      
      public function get Identifier() : uint
      {
         return this.FNarutoRoadTask.Identifier;
      }
      
      public function get MissionCount() : uint
      {
         return this.FMissionCount;
      }
      
      public function set MissionCount(param1:uint) : void
      {
         this.FMissionCount = param1;
      }
      
      public function get NarutoRoadTask() : TNarutoRoadTask
      {
         return this.FNarutoRoadTask;
      }
      
      public function set NarutoRoadTask(param1:TNarutoRoadTask) : void
      {
         this.FNarutoRoadTask = param1;
      }
      
      public function get RewardType() : uint
      {
         return this.FRewardType;
      }
      
      public function set RewardType(param1:uint) : void
      {
         this.FRewardType = param1;
      }
      
      public function get VipRewardType() : uint
      {
         return this.FVipRewardType;
      }
      
      public function set VipRewardType(param1:uint) : void
      {
         this.FVipRewardType = param1;
      }
      
      public function get MissionStatus() : int
      {
         return this.FMissionStatus;
      }
      
      public function set MissionStatus(param1:int) : void
      {
         this.FMissionStatus = param1;
      }
      
      public function get TipValue() : int
      {
         return this.FTipValue;
      }
      
      public function set TipValue(param1:int) : void
      {
         this.FTipValue = param1;
      }
      
      public function get PopTipValue() : int
      {
         return this.FPopTipValue;
      }
      
      public function set PopTipValue(param1:int) : void
      {
         this.FPopTipValue = param1;
      }
      
      public function get VipLimit() : int
      {
         return this.FNarutoRoadTask.VipLimit;
      }
      
      public function ShowTipValue() : int
      {
         return this.FTipValue - this.FNarutoRoadTask.Identifier;
      }
      
      public function ShowPopTipValue() : int
      {
         return this.FPopTipValue - this.FNarutoRoadTask.Identifier;
      }
      
      public function HasReward() : Boolean
      {
         if(this.FMissionStatus != 2)
         {
            return false;
         }
         if(this.FRewardType == 0)
         {
            return true;
         }
         return false;
      }
      
      public function HasRewardVip() : Boolean
      {
         if(this.FMissionStatus != 2)
         {
            return false;
         }
         if(this.FVipRewardType == 0)
         {
            return true;
         }
         return false;
      }
      
      public function HasRewardCanGet(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         if(this.FMissionStatus != 2)
         {
            return _loc2_;
         }
         if(this.FRewardType == 0 && param1 >= this.FNarutoRoadTask.RewardLevel)
         {
            _loc2_++;
         }
         if(this.FVipRewardType == 0 && param1 >= this.FNarutoRoadTask.RewardVipLevel)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function IsClose(param1:uint) : Boolean
      {
         if(this.FRewardType != 0 && this.FVipRewardType != 0)
         {
            return true;
         }
         return false;
      }
   }
}

