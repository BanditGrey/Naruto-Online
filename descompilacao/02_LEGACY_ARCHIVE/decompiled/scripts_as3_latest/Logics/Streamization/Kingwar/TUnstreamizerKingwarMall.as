package Logics.Streamization.Kingwar
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TKingBattleMall;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryUnknown;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerKingwarMall extends TUnstreamizerInventoryUnknown
   {
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerKingwarMall()
      {
         super();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:TKingBattleMall = null;
         var _loc7_:TInventorySamples = null;
         var _loc8_:TInventorySample = null;
         _loc7_ = param2 as TInventorySamples;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_KingBattleMall);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetDatebaseByIndex(_loc4_) as TKingBattleMall;
            _loc8_ = new TInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizerKingBattleMallByDatabase(null,_loc8_,_loc6_);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
   }
}

