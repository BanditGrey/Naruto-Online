package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipment;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipmentChipBox;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipmentSuit;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerOrangeEquipment extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerOrangeEquipment()
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
         var _loc15_:TOrangeEquipment = null;
         var _loc16_:TBins = null;
         var _loc17_:TOrangeEquipmentChipBox = null;
         var _loc18_:TOrangeEquipmentSuit = null;
         var _loc19_:TBaseBox = null;
         _loc15_ = param2 as TOrangeEquipment;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc15_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_OrangeEquipment;
         _loc15_.BeginTime = param1.readUnsignedInt();
         _loc15_.EndTime = param1.readUnsignedInt();
         _loc15_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc15_.ActivityTabName = TUtilityString.FetchUTF(param1);
         _loc15_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc15_.ActiveDesc2 = TUtilityString.FetchUTF(param1);
         _loc6_ = int(param1.readUnsignedShort());
         _loc15_.ChipVect.length = 0;
         _loc15_.ChipID.length = 0;
         _loc15_.ChipPrice.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_.ChipID.push(param1.readUnsignedInt());
            _loc15_.ChipVect.push(param1.readUnsignedInt());
            _loc15_.ChipPrice.push(param1.readUnsignedInt());
            _loc4_++;
         }
         _loc15_.FreeTimes = param1.readUnsignedInt();
         _loc13_ = new Vector.<uint>();
         _loc9_ = new TInventories();
         _loc10_ = param1.readUnsignedInt();
         _loc13_.push(_loc10_);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
         _loc15_.FreeInventory = _loc9_.GetInventoryByIndex(0);
         if(_loc15_.NeedConfig)
         {
            _loc6_ = int(param1.readUnsignedShort());
            _loc15_.SuitBoxes.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc18_ = new TOrangeEquipmentSuit();
               _loc13_.length = 0;
               _loc9_ = new TInventories();
               _loc13_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc18_.ExchangeItemID = _loc13_[0];
               _loc18_.ExchangeInventory = _loc9_.GetInventoryByIndex(0);
               _loc18_.Title = TUtilityString.FetchUTF(param1);
               _loc7_ = int(param1.readUnsignedShort());
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc19_ = new TBaseBox();
                  _loc13_.length = 0;
                  _loc13_.push(param1.readUnsignedInt());
                  _loc9_ = new TInventories();
                  this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
                  _loc19_.Inventories = _loc9_;
                  _loc19_.Price = param1.readUnsignedInt();
                  _loc19_.Count = param1.readUnsignedInt();
                  _loc19_.BuyCount = param1.readUnsignedInt();
                  _loc18_.SuitVect.push(_loc19_);
                  _loc5_++;
               }
               _loc15_.SuitBoxes.push(_loc18_);
               _loc4_++;
            }
            _loc6_ = int(param1.readUnsignedShort());
            _loc15_.ChipBoxes.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc17_ = new TOrangeEquipmentChipBox();
               _loc17_.Title = TUtilityString.FetchUTF(param1);
               _loc7_ = int(param1.readUnsignedShort());
               _loc13_.length = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc13_.push(param1.readUnsignedInt());
                  _loc17_.PriceVect.push(param1.readUnsignedInt());
                  _loc5_++;
               }
               _loc9_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc17_.Inventories = _loc9_;
               _loc15_.ChipBoxes.push(_loc17_);
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

