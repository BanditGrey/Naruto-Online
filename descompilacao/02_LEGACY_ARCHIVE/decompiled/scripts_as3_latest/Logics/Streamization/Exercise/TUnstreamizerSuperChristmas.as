package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TActivityTaskReward;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import Logics.DatebaseVO.VO.TActivityTask;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.SuperChristmas.TSuperChristmas;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSuperChristmas extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerSuperChristmas()
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
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBins = null;
         var _loc16_:TBaseBox = null;
         var _loc17_:TSuperChristmas = null;
         var _loc18_:Vector.<int> = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:TLotteryNews = null;
         var _loc21_:TDessertHouseTask = null;
         var _loc22_:TActivityTaskReward = null;
         var _loc23_:TTaskReward = null;
         var _loc24_:TActivityTask = null;
         var _loc25_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = new Vector.<int>();
         _loc19_ = new Vector.<int>();
         _loc17_ = param2 as TSuperChristmas;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.InitDescListNew();
         _loc17_.GameStatus = param1.readInt();
         _loc16_ = new TBaseBox();
         _loc16_.Status = param1.readInt();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc4_);
            _loc8_.Quantity = _loc14_[_loc4_];
            _loc4_++;
         }
         _loc16_.Inventories = _loc9_;
         _loc17_.Gift = _loc16_;
         _loc17_.NextTime = param1.readUnsignedInt();
         _loc25_ = int(param1.readUnsignedInt());
         _loc24_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityTaskConfig,_loc25_) as TActivityTask;
         _loc21_ = new TDessertHouseTask(_loc25_);
         _loc21_.Step = param1.readUnsignedInt();
         _loc21_.Process = param1.readUnsignedInt();
         _loc21_.Status = param1.readInt();
         if(_loc24_ != null)
         {
            _loc21_.TaskName = _loc24_.TaskName;
            _loc21_.TaskDesc = _loc24_.TaskDesc;
            _loc21_.TaskReq = _loc24_.Requirements;
            _loc21_.ClientTaskReq = _loc24_.ClientReq;
            _loc21_.TaskPoint = _loc24_.Points;
            _loc21_.MaxReset = _loc24_.Reset;
            _loc21_.Consume = _loc24_.Consume;
            _loc21_.Go = _loc24_.Go;
            _loc6_ = int(_loc24_.Rewards.length);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc13_.length = 0;
               _loc14_.length = 0;
               _loc9_ = new TInventories();
               _loc22_ = _loc24_.Rewards[_loc4_];
               _loc7_ = int(_loc22_.Rewards.length);
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc23_ = _loc22_.Rewards[_loc5_];
                  _loc12_ = _loc23_.Type;
                  _loc11_ = _loc23_.Code;
                  _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
                  _loc13_.push(_loc10_);
                  _loc14_.push(_loc23_.Amount);
                  _loc5_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
                  _loc8_.Quantity = _loc14_[_loc5_];
                  _loc5_++;
               }
               _loc21_.TaskAward.push(_loc9_);
               _loc4_++;
            }
            _loc17_.ActivityTask = _loc21_;
         }
         else
         {
            _loc17_.ActivityTask = null;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

