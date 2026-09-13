package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.AncientTreasure.TAncientTreasure;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerAncientTreasure extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerAncientTreasure()
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
         var _loc17_:TBins = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:TAncientTreasure = null;
         var _loc22_:int = 0;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = param2 as TAncientTreasure;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc21_.BeginTime = param1.readUnsignedInt();
         _loc21_.EndTime = param1.readUnsignedInt();
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc21_.InitDescListNew();
         _loc21_.GameStatus = param1.readInt();
         _loc21_.SignStatus = param1.readInt();
         _loc21_.CurIndex = param1.readUnsignedInt() - 1;
         _loc21_.SurpriseStatus = param1.readInt();
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc11_ = new TInventories();
            _loc22_ = param1.readUnsignedInt() - 1;
            _loc18_ = _loc21_.BoxList[_loc22_];
            _loc18_.Type = param1.readUnsignedInt();
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc11_.GetInventoryByIndex(0).Quantity = _loc16_[0];
            _loc18_.Inventories = _loc11_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

