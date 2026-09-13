package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.RechargeExchange.TRechargeExchange;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerRechargeExchange extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerRechargeExchange()
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
         var _loc15_:TRechargeExchange = null;
         var _loc16_:TBins = null;
         var _loc17_:TBaseBox = null;
         _loc15_ = param2 as TRechargeExchange;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc15_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_RechargeExchange;
         _loc15_.BeginTime = param1.readUnsignedInt();
         _loc15_.EndTime = param1.readUnsignedInt();
         _loc15_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc15_.TotalRecharge = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc15_.RechargeVect.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_.RechargeVect.push(param1.readUnsignedInt());
            _loc4_++;
         }
         if(_loc15_.NeedConfig)
         {
            _loc6_ = int(param1.readUnsignedShort());
            _loc15_.GetBoxVect.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc17_ = new TBaseBox();
               _loc9_ = new TInventories();
               _loc17_.Identify = _loc4_ + 1;
               _loc17_.Status = param1.readInt();
               _loc17_.Inventories = _loc9_;
               _loc7_ = int(param1.readUnsignedShort());
               _loc13_ = new Vector.<uint>();
               _loc14_ = new Vector.<uint>();
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc12_ = param1.readUnsignedInt();
                  _loc11_ = param1.readUnsignedInt();
                  _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
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
               _loc15_.GetBoxVect.push(_loc17_);
               _loc4_++;
            }
            _loc6_ = int(param1.readUnsignedShort());
            _loc15_.BuyBoxVect.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc17_ = new TBaseBox();
               _loc9_ = new TInventories();
               _loc17_.Identify = _loc4_ + 1;
               _loc17_.Count = param1.readUnsignedInt();
               _loc17_.BuyCount = param1.readUnsignedInt();
               _loc17_.Price = param1.readUnsignedInt();
               _loc17_.Status = param1.readInt();
               _loc17_.Inventories = _loc9_;
               _loc7_ = int(param1.readUnsignedShort());
               _loc13_ = new Vector.<uint>();
               _loc14_ = new Vector.<uint>();
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc12_ = param1.readUnsignedInt();
                  _loc11_ = param1.readUnsignedInt();
                  _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc16_);
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
               _loc15_.BuyBoxVect.push(_loc17_);
               _loc4_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

