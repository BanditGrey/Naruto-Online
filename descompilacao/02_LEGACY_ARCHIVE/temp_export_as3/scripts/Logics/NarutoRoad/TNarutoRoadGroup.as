package Logics.NarutoRoad
{
   import Logics.DatebaseVO.VO.*;
   
   public class TNarutoRoadGroup
   {
      
      protected var FNarutoRoadMissions:Vector.<TNarutoRoadMission>;
      
      protected var FNarutoRoadPackage:TNarutoRoadPackage;
      
      protected var FBuyCount:Vector.<uint>;
      
      public function TNarutoRoadGroup()
      {
         super();
         this.FNarutoRoadMissions = new Vector.<TNarutoRoadMission>();
         this.FBuyCount = new Vector.<uint>();
      }
      
      protected function ValueSort(param1:TNarutoRoadMission, param2:TNarutoRoadMission) : int
      {
         return param2.ShowTipValue() - param1.ShowTipValue();
      }
      
      public function get Count() : uint
      {
         return this.FNarutoRoadMissions.length;
      }
      
      public function get Identifier() : uint
      {
         return this.FNarutoRoadPackage.Identifier;
      }
      
      public function get NarutoRoadPackage() : TNarutoRoadPackage
      {
         return this.FNarutoRoadPackage;
      }
      
      public function set NarutoRoadPackage(param1:TNarutoRoadPackage) : void
      {
         this.FNarutoRoadPackage = param1;
      }
      
      public function get BuyCount() : Vector.<uint>
      {
         return this.FBuyCount;
      }
      
      public function set BuyCount(param1:Vector.<uint>) : void
      {
         this.FBuyCount = param1;
      }
      
      public function SortByValue() : void
      {
         this.FNarutoRoadMissions.sort(this.ValueSort);
      }
      
      public function GetMissionByIndex(param1:uint) : TNarutoRoadMission
      {
         if(param1 >= this.FNarutoRoadMissions.length)
         {
            return null;
         }
         return this.FNarutoRoadMissions[param1];
      }
      
      public function GetMissionById(param1:uint) : TNarutoRoadMission
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadMission = null;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadMissions.length)
         {
            _loc3_ = this.FNarutoRoadMissions[_loc2_];
            if(_loc3_.Identifier == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function AddMission(param1:TNarutoRoadMission) : void
      {
         this.FNarutoRoadMissions.push(param1);
      }
      
      public function GetMissionIndexById(param1:uint) : uint
      {
         var _loc2_:TNarutoRoadMission = null;
         _loc2_ = this.GetMissionById(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return this.FNarutoRoadMissions.indexOf(_loc2_);
      }
      
      public function GetPopMission(param1:uint) : TNarutoRoadMission
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadMission = null;
         var _loc4_:TNarutoRoadMission = null;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadMissions.length)
         {
            _loc3_ = this.FNarutoRoadMissions[_loc2_];
            if(_loc4_ == null)
            {
               _loc4_ = _loc3_;
            }
            else if(_loc4_.ShowTipValue() < _loc3_.ShowTipValue())
            {
               _loc4_ = _loc3_;
            }
            _loc2_++;
         }
         if(Boolean(_loc4_) && Boolean(_loc4_.MissionStatus == 2) && !_loc4_.HasRewardCanGet(param1))
         {
            return null;
         }
         return _loc4_;
      }
      
      public function CheckEffect(param1:uint) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:TNarutoRoadMission = null;
         var _loc4_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FNarutoRoadMissions.length)
         {
            _loc3_ = this.FNarutoRoadMissions[_loc2_];
            _loc4_ = _loc3_.HasRewardCanGet(param1);
            if(_loc4_ > 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

