package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NinjaFund.TNinjaFund;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNinjaFund extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerNinjaFund(param1:int)
      {
         super();
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerBaseActivityTask = new TUnstreamizerBaseActivityTask();
         this.FUnstreamizerBaseActivityTask.activityId = param1;
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
         var _loc17_:TBins = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:TNinjaFund = null;
         var _loc22_:TLotteryNews = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = param2 as TNinjaFund;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc21_.BeginTime = param1.readUnsignedInt();
         _loc21_.EndTime = param1.readUnsignedInt();
         _loc21_.DescList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc21_.InitDescListNew();
         _loc21_.TotalRechargeGold = param1.readUnsignedInt();
         _loc18_ = new TBaseBox();
         _loc18_.Price = param1.readInt();
         _loc18_.Count = param1.readInt();
         _loc21_.RechargeGift = _loc18_;
         _loc21_.FreshPrice = param1.readUnsignedInt();
         _loc21_.NextTime = param1.readUnsignedInt();
         _loc21_.FreshCount = param1.readUnsignedInt();
         _loc21_.Funds.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Price = param1.readInt();
            _loc18_.Status = param1.readInt();
            _loc18_.Level = param1.readInt();
            _loc21_.Funds[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc21_.FoodList.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.FoodList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc21_.SaleItems.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Status = param1.readInt();
            _loc18_.Price = param1.readInt();
            _loc18_.Type = param1.readInt();
            _loc18_.Count = param1.readUnsignedInt();
            _loc21_.SaleItems[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc21_.TotalFundDatas.length = 0;
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Status = param1.readInt();
            _loc18_.Discount = param1.readUnsignedInt();
            _loc18_.Min = param1.readUnsignedInt();
            _loc18_.Max = param1.readUnsignedInt();
            _loc18_.Count = param1.readUnsignedInt();
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc11_ = new TInventories();
            _loc8_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
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
            _loc18_.Items = _loc11_;
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc11_ = new TInventories();
            _loc8_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
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
            _loc18_.Inventories = _loc11_;
            _loc21_.TotalFundDatas[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

