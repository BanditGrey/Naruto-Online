package Logics.Streamization.Inventories
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.CrossServerWar.TOrangeInventorySamples;
   import Logics.CrossServerWar.TTokenInventorySample;
   import Logics.CrossServerWar.TTokenInventorySamples;
   import Logics.DatebaseVO.VO.TGSPVP_CreditExchange;
   import Logics.DatebaseVO.VO.TGSPVP_GemExchange;
   import Logics.DatebaseVO.VO.TMall;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerInventorySamples extends TUnstreamizerInventories
   {
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerInventorySamples()
      {
         super();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_Inventories(param1,param2,param3);
      }
      
      override protected function UnstreamizationPerform_Inventories(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySamples = null;
         var _loc5_:TInventorySample = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = param2 as TInventorySamples;
         _loc4_.Clear();
         _loc6_ = int(param1.readUnsignedShort());
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = FPoolInventory.AcquireInventorySample();
            this.FUnstreamizerInventorySample.Unstreamize(param1,_loc5_,param3);
            _loc4_.Add(_loc5_);
            _loc7_++;
         }
         FReference.Inventory = null;
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TMall = null;
         var _loc8_:TInventorySamples = null;
         var _loc9_:TInventorySample = null;
         _loc8_ = param2 as TInventorySamples;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Mall);
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetDatebaseByIndex(_loc4_) as TMall;
            _loc9_ = FPoolInventory.AcquireInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizeInventorySampleByDatabase(null,_loc9_,_loc7_);
            _loc8_.Add(_loc9_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_OrangeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TGSPVP_GemExchange = null;
         var _loc8_:TOrangeInventorySamples = null;
         var _loc9_:TOrangeInventorySample = null;
         _loc8_ = param2 as TOrangeInventorySamples;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GSPVP_GemExchange);
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetDatebaseByIndex(_loc4_) as TGSPVP_GemExchange;
            _loc9_ = new TOrangeInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizeOrangeInventorySampleByDatabase(null,_loc9_,_loc7_);
            _loc8_.Add(_loc9_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_TokenInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TGSPVP_CreditExchange = null;
         var _loc8_:TTokenInventorySamples = null;
         var _loc9_:TTokenInventorySample = null;
         _loc8_ = param2 as TTokenInventorySamples;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GSPVP_CreditExchange);
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetDatebaseByIndex(_loc4_) as TGSPVP_CreditExchange;
            _loc9_ = new TTokenInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizeTokenInventorySampleByDatabase(null,_loc9_,_loc7_);
            _loc8_.Add(_loc9_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeOrangeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_OrangeInventorySamplesByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeTokenInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_TokenInventorySamplesByDatabase(param1,param2,param3);
      }
   }
}

