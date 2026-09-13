package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TItem2item;
   import Logics.Exercise.Smelt.TSmelt;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TUnstreamizerSmelt extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerSmelt()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:TBins = null;
         var _loc14_:TBaseBox = null;
         var _loc15_:TSmelt = null;
         var _loc16_:TItem2item = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc17_:Dictionary = new Dictionary();
         _loc11_ = new Vector.<uint>();
         _loc12_ = new Vector.<uint>();
         _loc15_ = param2 as TSmelt;
         _loc15_.BeginTime = param1.readUnsignedInt();
         _loc15_.EndTime = param1.readUnsignedInt();
         _loc15_.SmeltSum = param1.readUnsignedInt();
         _loc5_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc18_ = int(param1.readUnsignedInt());
            _loc19_ = int(param1.readUnsignedInt());
            _loc17_[_loc18_] = _loc19_;
            _loc4_++;
         }
         _loc15_.ShowList.length = 0;
         _loc13_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Smelt) as TBins;
         _loc5_ = _loc13_.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc16_ = _loc13_.GetDatebaseByIndex(_loc4_) as TItem2item;
            if(_loc16_.NeedPoint != 0)
            {
               _loc14_ = new TBaseBox();
               _loc14_.Identify = _loc16_.Identifier;
               _loc14_.Type = _loc16_.Type;
               _loc11_.length = 0;
               _loc12_.length = 0;
               _loc7_ = new TInventories();
               _loc8_ = _loc16_.Itemid;
               _loc11_.push(_loc8_);
               _loc12_.push(_loc16_.Amount);
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc11_);
               _loc6_ = _loc7_.GetInventoryByIndex(0);
               _loc6_.Quantity = _loc12_[0];
               _loc14_.Inventory = _loc6_;
               if(_loc6_.IDTemplate in _loc17_)
               {
                  _loc14_.BuyCount = _loc16_.Maxbuy - _loc17_[_loc6_.IDTemplate];
               }
               else
               {
                  _loc14_.BuyCount = _loc16_.Maxbuy;
               }
               _loc14_.Price = _loc16_.NeedPoint;
               _loc15_.ShowList.push(_loc14_);
            }
            _loc4_++;
         }
         _loc15_.SmeltList.Clear();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc16_ = _loc13_.GetDatebaseByIndex(_loc4_) as TItem2item;
            if(_loc16_.RedeemPoint != 0)
            {
               _loc14_ = new TBaseBox();
               _loc14_.Identify = _loc16_.Identifier;
               _loc11_.length = 0;
               _loc12_.length = 0;
               _loc7_ = new TInventories();
               _loc8_ = _loc16_.Itemid;
               _loc11_.push(_loc8_);
               _loc12_.push(_loc16_.Amount);
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc11_);
               _loc6_ = _loc7_.GetInventoryByIndex(0);
               _loc14_.Inventory = _loc6_;
               _loc6_.LimitCount = _loc16_.RedeemPoint;
               _loc15_.SmeltList.Add(_loc6_);
            }
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

