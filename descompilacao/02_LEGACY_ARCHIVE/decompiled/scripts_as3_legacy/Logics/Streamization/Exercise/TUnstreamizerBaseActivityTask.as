package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.Json.TActivityTaskReward;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import Logics.DatebaseVO.VO.TActivityTask;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   public class TUnstreamizerBaseActivityTask extends TUnstreamizer
   {
      
      public static const GIFT_ID:int = 0;
      
      public var activityId:int;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerBaseActivityTask()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBaseBox = null;
         var _loc18_:TBins = null;
         var _loc19_:TActivityTaskData = null;
         var _loc20_:TActivityTask = null;
         var _loc21_:TDessertHouseTask = null;
         var _loc22_:TActivityTaskReward = null;
         var _loc23_:TTaskReward = null;
         var _loc24_:int = 0;
         var _loc25_:Array = null;
         var _loc26_:TBins = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = param2 as TActivityTaskData;
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc19_.Score = param1.readUnsignedInt();
         _loc19_.MaxScore = param1.readUnsignedInt();
         _loc26_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityTask);
         _loc20_ = _loc26_.GetDatebaseByValue2("Identifier",GIFT_ID,"Tasktype",this.activityId) as TActivityTask;
         if(_loc20_)
         {
            _loc19_.DescList.length = 0;
            _loc25_ = Json.decode(_loc20_.TaskDesc) as Array;
            _loc7_ = int(_loc25_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc19_.DescList[_loc4_] = _loc25_[_loc4_];
               _loc4_++;
            }
            _loc19_.BoxList.length = 0;
            _loc7_ = param1.readShort();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc17_ = new TBaseBox();
               _loc17_.Status = param1.readInt();
               _loc17_.Price = _loc20_.Requirements[_loc4_];
               _loc15_.length = 0;
               _loc16_.length = 0;
               _loc11_ = new TInventories();
               _loc8_ = int(_loc20_.Rewards[_loc4_].Rewards.length);
               _loc5_ = 0;
               while(_loc5_ < _loc8_)
               {
                  _loc23_ = _loc20_.Rewards[_loc4_].Rewards[_loc5_];
                  _loc14_ = _loc23_.Type;
                  _loc13_ = _loc23_.Code;
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc18_);
                  _loc15_.push(_loc12_);
                  _loc16_.push(_loc23_.Amount);
                  _loc5_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
               _loc5_ = 0;
               while(_loc5_ < _loc8_)
               {
                  _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
                  _loc10_.Quantity = _loc16_[_loc5_];
                  _loc5_++;
               }
               _loc17_.Inventories = _loc11_;
               _loc19_.BoxList[_loc4_] = _loc17_;
               _loc4_++;
            }
         }
         _loc19_.TaskList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc24_ = param1.readInt();
            _loc20_ = _loc26_.GetDatebaseByValue2("Identifier",_loc24_,"Tasktype",this.activityId) as TActivityTask;
            _loc21_ = new TDessertHouseTask(_loc24_);
            _loc21_.TaskName = _loc20_.TaskName;
            _loc21_.TaskDesc = _loc20_.TaskDesc;
            _loc21_.TaskReq = _loc20_.Requirements;
            _loc21_.ClientTaskReq = _loc20_.ClientReq;
            _loc21_.TaskPoint = _loc20_.Points;
            _loc21_.MaxReset = _loc20_.Reset;
            _loc21_.Consume = _loc20_.Consume;
            _loc21_.Go = _loc20_.Go;
            _loc21_.Step = param1.readUnsignedInt();
            _loc21_.Reset = param1.readUnsignedInt();
            _loc21_.Process = param1.readUnsignedInt();
            _loc21_.Status = param1.readInt();
            _loc8_ = int(_loc20_.Rewards.length);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc15_.length = 0;
               _loc16_.length = 0;
               _loc11_ = new TInventories();
               _loc22_ = _loc20_.Rewards[_loc5_];
               _loc9_ = int(_loc22_.Rewards.length);
               _loc6_ = 0;
               while(_loc6_ < _loc9_)
               {
                  _loc23_ = _loc22_.Rewards[_loc6_];
                  _loc14_ = _loc23_.Type;
                  _loc13_ = _loc23_.Code;
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc18_);
                  _loc15_.push(_loc12_);
                  _loc16_.push(_loc23_.Amount);
                  _loc6_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
               _loc6_ = 0;
               while(_loc6_ < _loc9_)
               {
                  _loc10_ = _loc11_.GetInventoryByIndex(_loc6_);
                  _loc10_.Quantity = _loc16_[_loc6_];
                  _loc6_++;
               }
               _loc21_.TaskAward.push(_loc11_);
               _loc5_++;
            }
            _loc19_.TaskList[_loc4_] = _loc21_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerformNew(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBaseBox = null;
         var _loc18_:TBins = null;
         var _loc19_:TActivityTaskData = null;
         var _loc20_:TActivityTask = null;
         var _loc21_:TDessertHouseTask = null;
         var _loc22_:TActivityTaskReward = null;
         var _loc23_:TTaskReward = null;
         var _loc24_:int = 0;
         var _loc25_:Array = null;
         var _loc26_:TBins = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = param2 as TActivityTaskData;
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc19_.Score = param1.readUnsignedInt();
         _loc19_.MaxScore = param1.readUnsignedInt();
         _loc26_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityTaskConfig);
         _loc20_ = _loc26_.GetDatebaseByValue2("Identifier",GIFT_ID,"Tasktype",this.activityId) as TActivityTask;
         if(_loc20_)
         {
            _loc19_.DescList.length = 0;
            _loc25_ = Json.decode(_loc20_.TaskDesc) as Array;
            _loc7_ = int(_loc25_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc19_.DescList[_loc4_] = _loc25_[_loc4_];
               _loc4_++;
            }
            _loc19_.BoxList.length = 0;
            _loc7_ = param1.readShort();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc17_ = new TBaseBox();
               _loc17_.Status = param1.readInt();
               _loc17_.Price = _loc20_.Requirements[_loc4_];
               _loc15_.length = 0;
               _loc16_.length = 0;
               _loc11_ = new TInventories();
               _loc8_ = int(_loc20_.Rewards[_loc4_].Rewards.length);
               _loc5_ = 0;
               while(_loc5_ < _loc8_)
               {
                  _loc23_ = _loc20_.Rewards[_loc4_].Rewards[_loc5_];
                  _loc14_ = _loc23_.Type;
                  _loc13_ = _loc23_.Code;
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc18_);
                  _loc15_.push(_loc12_);
                  _loc16_.push(_loc23_.Amount);
                  _loc5_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
               _loc5_ = 0;
               while(_loc5_ < _loc8_)
               {
                  _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
                  _loc10_.Quantity = _loc16_[_loc5_];
                  _loc5_++;
               }
               _loc17_.Inventories = _loc11_;
               _loc19_.BoxList[_loc4_] = _loc17_;
               _loc4_++;
            }
         }
         _loc19_.TaskList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc24_ = param1.readInt();
            _loc20_ = _loc26_.GetDatebaseByValue2("Identifier",_loc24_,"Tasktype",this.activityId) as TActivityTask;
            _loc21_ = new TDessertHouseTask(_loc24_);
            _loc21_.TaskName = _loc20_.TaskName;
            _loc21_.TaskDesc = _loc20_.TaskDesc;
            _loc21_.TaskReq = _loc20_.Requirements;
            _loc21_.ClientTaskReq = _loc20_.ClientReq;
            _loc21_.TaskPoint = _loc20_.Points;
            _loc21_.MaxReset = _loc20_.Reset;
            _loc21_.Consume = _loc20_.Consume;
            _loc21_.Go = _loc20_.Go;
            _loc21_.Step = param1.readUnsignedInt();
            _loc21_.Reset = param1.readUnsignedInt();
            _loc21_.Process = param1.readUnsignedInt();
            _loc21_.Status = param1.readInt();
            _loc8_ = int(_loc20_.Rewards.length);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc15_.length = 0;
               _loc16_.length = 0;
               _loc11_ = new TInventories();
               _loc22_ = _loc20_.Rewards[_loc5_];
               _loc9_ = int(_loc22_.Rewards.length);
               _loc6_ = 0;
               while(_loc6_ < _loc9_)
               {
                  _loc23_ = _loc22_.Rewards[_loc6_];
                  _loc14_ = _loc23_.Type;
                  _loc13_ = _loc23_.Code;
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc18_);
                  _loc15_.push(_loc12_);
                  _loc16_.push(_loc23_.Amount);
                  _loc6_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
               _loc6_ = 0;
               while(_loc6_ < _loc9_)
               {
                  _loc10_ = _loc11_.GetInventoryByIndex(_loc6_);
                  _loc10_.Quantity = _loc16_[_loc6_];
                  _loc6_++;
               }
               _loc21_.TaskAward.push(_loc11_);
               _loc5_++;
            }
            _loc19_.TaskList[_loc4_] = _loc21_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeNew(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformNew(param1,param2,param3);
      }
   }
}

