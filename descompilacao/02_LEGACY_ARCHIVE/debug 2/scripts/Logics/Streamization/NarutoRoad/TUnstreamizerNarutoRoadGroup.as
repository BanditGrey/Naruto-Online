package Logics.Streamization.NarutoRoad
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.*;
   import Foundation.Streamization.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.NarutoRoad.*;
   import Logics.SLogicsCore;
   import Resources.Constants.*;
   import flash.utils.*;
   
   public class TUnstreamizerNarutoRoadGroup extends TUnstreamizer
   {
      
      protected var FUnstreamizerNarutoRoadMission:TUnstreamizerNarutoRoadMission;
      
      public function TUnstreamizerNarutoRoadGroup()
      {
         super();
         this.FUnstreamizerNarutoRoadMission = new TUnstreamizerNarutoRoadMission();
      }
      
      protected function UnstreamizationGroup(param1:uint, param2:Object, param3:Object) : void
      {
         var _loc4_:TNarutoRoadGroup = null;
         var _loc5_:TResourceRepositoryBin = null;
         var _loc6_:TNarutoRoadPackage = null;
         _loc4_ = param2 as TNarutoRoadGroup;
         _loc5_ = param3 as TResourceRepositoryBin;
         _loc6_ = _loc5_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NarutoRoadPackage,param1) as TNarutoRoadPackage;
         _loc4_.NarutoRoadPackage = _loc6_;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TNarutoRoadData = null;
         var _loc8_:TNarutoRoadGroup = null;
         _loc7_ = param2 as TNarutoRoadData;
         _loc6_ = param1.readUnsignedInt();
         _loc8_ = _loc7_.GetGroupByID(_loc6_);
         if(_loc8_ == null)
         {
            _loc8_ = new TNarutoRoadGroup();
            _loc7_.AddGroup(_loc8_);
            this.UnstreamizationGroup(_loc6_,_loc8_,param3);
         }
         this.FUnstreamizerNarutoRoadMission.Unstreamize(param1,_loc8_,param3);
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_.BuyCount[_loc4_] = param1.readByte();
            _loc4_++;
         }
      }
      
      protected function Unstreamization_Mission(param1:uint, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TNarutoRoadData = null;
         var _loc7_:TNarutoRoadGroup = null;
         var _loc8_:TNarutoRoadMission = null;
         var _loc9_:TResourceRepositoryBin = null;
         var _loc10_:TNarutoRoadPackage = null;
         var _loc11_:TNarutoRoadTask = null;
         var _loc12_:TBins = null;
         _loc6_ = param2 as TNarutoRoadData;
         _loc9_ = param3 as TResourceRepositoryBin;
         _loc12_ = _loc9_.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NarutoRoadPackage);
         _loc4_ = 0;
         while(_loc4_ < _loc12_.Count)
         {
            _loc10_ = _loc12_.GetDatebaseByIndex(_loc4_) as TNarutoRoadPackage;
            _loc5_ = uint(_loc10_.Identifier);
            _loc7_ = _loc6_.GetGroupByID(_loc5_);
            if(_loc7_ == null)
            {
               _loc7_ = new TNarutoRoadGroup();
               _loc6_.AddGroup(_loc7_);
               this.UnstreamizationGroup(_loc5_,_loc7_,param3);
            }
            _loc4_++;
         }
         _loc11_ = _loc9_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NarutoRoadTask,param1) as TNarutoRoadTask;
         if(_loc11_ == null)
         {
            return;
         }
         _loc7_ = _loc6_.GetGroupByID(_loc11_.Type);
         _loc8_ = _loc7_.GetMissionById(param1);
         if(_loc8_ == null)
         {
            _loc8_ = new TNarutoRoadMission();
            _loc7_.AddMission(_loc8_);
            this.FUnstreamizerNarutoRoadMission.UnstreamizeNarutoRoadMission(param1,_loc8_,param3);
         }
      }
      
      protected function Unstreamization_ObligatoryCourses(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TNarutoRoadData = null;
         var _loc9_:TResourceRepositoryBin = null;
         var _loc10_:TBins = null;
         var _loc11_:TObligatoryCourses = null;
         var _loc12_:TNarutoRoadDayTask = null;
         var _loc13_:uint = 0;
         _loc8_ = param2 as TNarutoRoadData;
         _loc9_ = param3 as TResourceRepositoryBin;
         _loc10_ = _loc9_.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NarutoRoadDayTask);
         _loc13_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc5_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = param1.readUnsignedInt();
            _loc7_ = param1.readUnsignedInt();
            _loc12_ = _loc10_.GetDatebaseByIdentifier(_loc6_) as TNarutoRoadDayTask;
            _loc11_ = _loc8_.GetObligatoryCoursesById(_loc6_);
            if(_loc11_ == null)
            {
               _loc11_ = new TObligatoryCourses();
               _loc8_.AddObligatoryCourses(_loc11_);
            }
            _loc11_.SetNarutoRoadDay(_loc6_,_loc7_,_loc12_,_loc13_);
            _loc4_++;
         }
         _loc8_.SortObligatoryCourses();
      }
      
      public function UnstreamizationNarutoRoadMission(param1:uint, param2:Object, param3:Object) : void
      {
         this.Unstreamization_Mission(param1,param2,param3);
      }
      
      public function UnstreamizeObligatoryCourses(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamization_ObligatoryCourses(param1,param2,param3);
      }
   }
}

