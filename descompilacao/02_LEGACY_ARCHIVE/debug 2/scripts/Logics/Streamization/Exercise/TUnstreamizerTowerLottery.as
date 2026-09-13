package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TowerLottery.TTowerLottery;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTowerLottery extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerTowerLottery()
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
         var _loc17_:TTowerLottery = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TTowerLottery;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_NationalDay;
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
         _loc17_.CurLayer = param1.readUnsignedInt();
         _loc17_.GameStatus = param1.readUnsignedInt();
         _loc17_.MaxLayer = param1.readUnsignedInt();
         _loc17_.MaxCol = param1.readUnsignedInt();
         _loc17_.PetID = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc17_.LotteryPrice.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.LotteryPrice[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = param1.readShort();
         _loc9_ = new TInventories();
         _loc17_.LotteryStatus.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.LotteryStatus[_loc4_] = param1.readInt();
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
            _loc9_.GetInventoryByIndex(_loc4_).Quantity = _loc14_[_loc4_];
            _loc4_++;
         }
         _loc17_.LotteryInventories = _loc9_;
         _loc6_ = param1.readShort();
         _loc9_ = new TInventories();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc17_.RewardStatus.length = 0;
         _loc17_.RewardDescsNew.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.RewardDescsNew[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc17_.RewardStatus[_loc4_] = param1.readInt();
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
            _loc9_.GetInventoryByIndex(_loc4_).Quantity = _loc14_[_loc4_];
            _loc4_++;
         }
         _loc17_.InitRewardDescsNew();
         _loc17_.Inventories = _loc9_;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

