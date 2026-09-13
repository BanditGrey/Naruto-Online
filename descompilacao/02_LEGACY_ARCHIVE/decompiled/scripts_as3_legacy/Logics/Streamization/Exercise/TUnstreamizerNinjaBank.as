package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NinjaBank.TNinjaBank;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNinjaBank extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNinjaBank()
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
         var _loc17_:TNinjaBank = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TNinjaBank;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_NinjaBank;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.InitDescListNew();
         _loc17_.SecondTime = param1.readUnsignedInt();
         _loc17_.RechargeGold = param1.readUnsignedInt();
         _loc17_.Money = param1.readUnsignedInt();
         _loc17_.CurPrice = param1.readUnsignedInt();
         _loc17_.Price = param1.readUnsignedInt();
         _loc17_.CanBuyCount = param1.readUnsignedInt();
         _loc17_.BoughtCount = param1.readUnsignedInt();
         _loc17_.CurDay = param1.readUnsignedInt();
         _loc17_.CurBuyIndex = param1.readUnsignedInt();
         _loc17_.GameStatus = param1.readUnsignedInt();
         _loc17_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc16_.DescList[_loc5_] = TUtilityString.FetchUTF(param1);
               _loc5_++;
            }
            _loc16_.InitDescListNew();
            _loc16_.Min = param1.readUnsignedInt();
            _loc16_.Max = param1.readUnsignedInt();
            _loc16_.Discount = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
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
            _loc16_.Inventories = _loc9_;
            _loc17_.BoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc17_.OpenBoxCount = param1.readUnsignedInt();
         _loc17_.OpenBoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc16_.DescList[_loc5_] = TUtilityString.FetchUTF(param1);
               _loc5_++;
            }
            _loc16_.InitDescListNew();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
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
            _loc16_.Inventories = _loc9_;
            _loc17_.OpenBoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc9_ = new TInventories();
         _loc13_.length = 0;
         _loc14_.length = 0;
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
         _loc17_.ShowInventories = _loc9_;
         _loc16_ = new TBaseBox();
         _loc9_ = new TInventories();
         if(_loc17_.GameStatus == 2 && _loc17_.CurBuyIndex > 0)
         {
            _loc17_.AwardStatus = param1.readInt();
            _loc17_.ReturnGold = param1.readUnsignedInt();
            _loc17_.NextAwardTime = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
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
            _loc17_.ReturnItems = _loc16_;
            _loc17_.DayList.length = 0;
            _loc6_ = int(param1.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc17_.DayList[_loc4_] = param1.readUnsignedInt();
               _loc4_++;
            }
         }
         else
         {
            _loc17_.AwardStatus = TBaseActivity.STATUS_CANNOTGET;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

