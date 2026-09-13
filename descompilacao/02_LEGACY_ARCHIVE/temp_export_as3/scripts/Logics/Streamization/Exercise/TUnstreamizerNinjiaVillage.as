package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TNinjaVillage;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageBaseData;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageData;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNinjiaVillage extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNinjiaVillage()
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
         var _loc17_:TNinjiaVillageData = null;
         var _loc18_:TNinjaVillage = null;
         var _loc19_:TNinjiaVillageBaseData = null;
         var _loc20_:uint = 0;
         var _loc21_:int = 0;
         _loc17_ = param2 as TNinjiaVillageData;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.Identify = CONST_BASEACTIVITY.TYPE_ActiveListThird_NinjiaVillage;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.FundID = param1.readUnsignedInt();
         _loc21_ = int(param1.readUnsignedInt());
         _loc17_.FiveCountryReturnType = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc17_.DataVect.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc20_ = param1.readUnsignedInt();
            _loc18_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NinjaVillage,_loc20_) as TNinjaVillage;
            _loc19_ = new TNinjiaVillageBaseData();
            _loc19_.Identify = _loc18_.Identifier;
            _loc19_.Title = _loc18_.Name;
            _loc19_.BigType = _loc18_.BigType;
            _loc19_.SmallType = _loc18_.SmallType;
            _loc19_.Desc1 = _loc18_.Desc1;
            _loc19_.Desc2 = _loc18_.Desc2;
            _loc19_.Desc3 = _loc18_.Desc3;
            _loc19_.LimitLevel = _loc18_.LimitLevel;
            _loc19_.Price = _loc18_.Price;
            _loc19_.Discount = _loc18_.ReturnRate;
            _loc19_.Count = _loc18_.MaxTime;
            _loc19_.ReturnGold = _loc18_.ReturnGold;
            _loc19_.ReturnType = _loc18_.ReturnType;
            _loc19_.MaxTime = _loc18_.MaxTime;
            _loc19_.Status = param1.readInt();
            _loc19_.ReturnGift = param1.readUnsignedInt();
            _loc19_.CZ = _loc18_.Cz;
            _loc19_.Desc4 = _loc18_.Desc4;
            if(_loc18_.GoldRegion.length > 1)
            {
               _loc19_.Min = _loc18_.GoldRegion[0];
               _loc19_.Max = _loc18_.GoldRegion[1];
            }
            if(_loc19_.Identify == _loc17_.FundID)
            {
               _loc19_.BuyCount = _loc21_;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc18_.AwardVect);
            _loc7_ = int(_loc18_.AwardVect.length);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = 1;
               _loc5_++;
            }
            _loc19_.Inventories = _loc9_;
            _loc17_.DataVect[_loc4_] = _loc19_;
            _loc4_++;
         }
         _loc17_.rechargeGoldNum = param1.readInt();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

