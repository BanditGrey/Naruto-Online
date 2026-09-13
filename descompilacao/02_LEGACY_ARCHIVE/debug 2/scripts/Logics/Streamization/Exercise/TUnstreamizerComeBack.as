package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ComeBack.TComeBack;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerComeBack extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerComeBack()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBins = null;
         var _loc7_:TComeBack = null;
         _loc7_ = param2 as TComeBack;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc7_.BeginTime = param1.readUnsignedInt();
         _loc7_.EndTime = param1.readUnsignedInt();
         _loc7_.DescList.length = 0;
         _loc5_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc7_.InitDescListNew();
         _loc7_.ActivityBeginTime = param1.readUnsignedInt();
         _loc7_.ActivityEndTime = param1.readUnsignedInt();
         _loc7_.ServerID = TUtilityString.FetchUTF(param1);
         _loc7_.IsOld = param1.readUnsignedInt();
         if(_loc7_.IsOld == TComeBack.TYPE_OLD_PLAYER_IN_OLD_SERVER)
         {
            this.UnstreamizationPerform_OldServer(param1,_loc7_,_loc6_);
         }
         else if(_loc7_.IsOld != TComeBack.TYPE_NONE)
         {
            this.UnstreamizationPerform_NewServer(param1,_loc7_,_loc6_);
         }
      }
      
      protected function UnstreamizationPerform_NewServer(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc15_:TBaseBox = null;
         var _loc16_:TComeBack = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TComeBack;
         _loc15_ = new TBaseBox();
         _loc15_.Status = param1.readInt();
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
         _loc15_.Inventories = _loc9_;
         _loc16_.OldAward = _loc15_;
         _loc15_ = new TBaseBox();
         _loc15_.Status = param1.readInt();
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
         _loc15_.Inventories = _loc9_;
         _loc16_.NewAward = _loc15_;
         _loc15_ = new TBaseBox();
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
         _loc15_.Inventories = _loc9_;
         _loc16_.CDKAward = _loc15_;
         _loc15_ = new TBaseBox();
         _loc15_.BuyCount = param1.readUnsignedInt();
         _loc15_.Status = param1.readInt();
         _loc15_.Count = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
         _loc15_.Inventories = _loc9_;
         _loc16_.CDKLotteryAward = _loc15_;
      }
      
      protected function UnstreamizationPerform_OldServer(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc15_:TBaseBox = null;
         var _loc16_:TComeBack = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TComeBack;
         _loc16_.BackAwardStatus = param1.readInt();
         _loc16_.LeftDays = param1.readUnsignedInt();
         _loc16_.TotalRechargeGold = param1.readUnsignedInt();
         _loc16_.RechargeGold = param1.readUnsignedInt();
         _loc16_.Rate = param1.readUnsignedInt();
         _loc16_.RewardGold = param1.readUnsignedInt();
         _loc16_.BackAwardList = new Object();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_.BackAwardList["Type" + _loc4_] = param1.readUnsignedInt();
            _loc16_.BackAwardList["Value" + _loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc16_.SaleBox.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.LimitCount = param1.readUnsignedInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.CurPrice = param1.readInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc15_.Inventories = _loc9_;
            _loc16_.SaleBox[_loc4_] = _loc15_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

