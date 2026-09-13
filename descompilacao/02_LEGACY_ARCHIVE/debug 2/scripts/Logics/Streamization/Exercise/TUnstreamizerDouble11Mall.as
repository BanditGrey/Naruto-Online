package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TDouble11Mall;
   import Logics.Exercise.Double11Mall.TDouble11Mall;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerDouble11Mall extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerDouble11Mall()
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
         var _loc8_:TBaseBox = null;
         var _loc9_:TBins = null;
         var _loc10_:Logics.DatebaseVO.VO.TDouble11Mall = null;
         var _loc11_:uint = 0;
         var _loc13_:TInventory = null;
         var _loc14_:TInventories = null;
         var _loc15_:Logics.Exercise.Double11Mall.TDouble11Mall = null;
         var _loc12_:Vector.<uint> = new Vector.<uint>();
         _loc15_ = param2 as Logics.Exercise.Double11Mall.TDouble11Mall;
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Double11) as TBins;
         _loc15_.BeginTime = param1.readUnsignedInt();
         _loc15_.EndTime = param1.readUnsignedInt();
         _loc15_.TotalRechargeGold = param1.readUnsignedInt();
         _loc15_.Keys = param1.readInt();
         _loc15_.DescList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < 2)
         {
            _loc15_.DescList[_loc4_] = String(20020 + _loc4_);
            _loc4_++;
         }
         _loc15_.InitDescListNew();
         _loc5_ = param1.readShort();
         _loc15_.NumList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(param1.readUnsignedInt());
            _loc7_ = int(param1.readUnsignedInt());
            _loc15_.NumList.push(_loc7_);
            _loc4_++;
         }
         _loc5_ = param1.readShort();
         _loc15_.SaleItems.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = new TBaseBox();
            _loc14_ = new TInventories();
            _loc8_.Identify = param1.readUnsignedInt();
            _loc8_.BuyCount = param1.readUnsignedInt();
            _loc10_ = _loc9_.GetDatebaseByIdentifier(_loc8_.Identify) as Logics.DatebaseVO.VO.TDouble11Mall;
            _loc11_ = _loc10_.Itemid;
            _loc12_.length = 0;
            _loc12_.push(_loc11_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc14_,_loc12_);
            _loc13_ = _loc14_.GetInventoryByIndex(0);
            _loc13_.Quantity = _loc10_.Amount;
            _loc13_.NewType = _loc10_.Itemtype;
            _loc13_.NewIdentify = _loc10_.Heroid;
            _loc8_.Price = _loc10_.Price;
            _loc8_.Type = _loc10_.Type;
            _loc8_.Count = _loc10_.Maxbuy;
            _loc8_.Inventories = _loc14_;
            _loc15_.SaleItems.push(_loc8_);
            _loc4_++;
         }
      }
   }
}

