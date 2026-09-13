package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CloudBuy.TCloudBuy;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerCloudBuy extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerCloudBuy()
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
         var _loc17_:TCloudBuy = null;
         var _loc18_:Vector.<int> = null;
         var _loc19_:Vector.<int> = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = new Vector.<int>();
         _loc19_ = new Vector.<int>();
         _loc17_ = param2 as TCloudBuy;
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
         _loc17_.Price = param1.readUnsignedInt();
         _loc17_.ItemCost = param1.readUnsignedInt();
         _loc17_.MyCount = param1.readUnsignedInt();
         _loc17_.BoughtCount = param1.readUnsignedInt();
         _loc17_.RemainCount = param1.readUnsignedInt();
         _loc17_.GameStatus = param1.readUnsignedInt();
         _loc17_.NextTime = param1.readUnsignedInt();
         _loc17_.LuckyGuy = TUtilityString.FetchUTF(param1);
         _loc17_.BuySuccess = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_[_loc4_] = param1.readUnsignedInt();
            _loc19_[_loc4_] = param1.readUnsignedInt();
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
            _loc8_.NewType = _loc18_[_loc4_];
            _loc8_.NewIdentify = _loc19_[_loc4_];
            _loc4_++;
         }
         _loc17_.Items = _loc9_;
         _loc17_.LastItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Time = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc18_.length = 0;
            _loc19_.length = 0;
            _loc9_ = new TInventories();
            _loc18_[0] = param1.readUnsignedInt();
            _loc19_[0] = param1.readUnsignedInt();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            _loc14_[0] = param1.readUnsignedInt();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc14_[0];
            _loc8_.NewType = _loc18_[0];
            _loc8_.NewIdentify = _loc19_[0];
            _loc16_.Inventories = _loc9_;
            _loc17_.LastItems[_loc4_] = _loc16_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

