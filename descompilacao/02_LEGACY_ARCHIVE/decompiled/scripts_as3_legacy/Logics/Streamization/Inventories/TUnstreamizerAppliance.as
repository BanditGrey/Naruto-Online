package Logics.Streamization.Inventories
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.Inventories.TAppliance;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerAppliance extends TUnstreamizerInventory
   {
      
      public function TUnstreamizerAppliance()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizationPerform(param1,param2,param3);
         this.UnstreamizationPerform_ApplianceProperties(param1,param2,param3);
         this.UnstreamizationPerform_ApplianceByDatabase(param2,param3);
      }
      
      protected function UnstreamizationPerform_ApplianceProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TAppliance = null;
         var _loc5_:int = 0;
         _loc4_ = param2 as TAppliance;
      }
      
      protected function UnstreamizationPerform_AdditionalData_Appliance(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TBins = null;
         var _loc5_:TArticle = null;
         var _loc6_:TAppliance = null;
         _loc6_ = param2 as TAppliance;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc6_.IDTemplate) as TArticle;
         _loc6_.Quantity = 1;
         _loc6_.UpgradingLevel = _loc5_.Level;
         _loc6_.TimingCategory = 3;
         _loc6_.TimingState = 4;
         _loc6_.TimingTime = 0;
         _loc6_.TempTimingTime = 0;
         _loc6_.ObtainType = 0;
      }
      
      protected function UnstreamizationPerform_ApplianceByDatabase(param1:Object, param2:Object) : void
      {
         var _loc3_:TBins = null;
         var _loc4_:TArticle = null;
         var _loc5_:TAppliance = null;
         var _loc6_:Boolean = false;
         _loc5_ = param1 as TAppliance;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.IDTemplate) as TArticle;
         _loc5_.IDTexture = _loc5_.IDTexture;
         _loc5_.Usable = _loc4_.ExpandUsable;
         _loc5_.StackableQuantityMax = _loc4_.OverlayNumber;
         if(_loc5_.StackableQuantityMax <= 1)
         {
            _loc6_ = false;
         }
         else
         {
            _loc6_ = true;
         }
         _loc5_.Stackable = _loc6_;
      }
      
      protected function UnstreamizationPerform_GenerateApplianceProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
      }
      
      override protected function UnstreamizationPerform_QuestReward(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizationPerform_QuestReward(param1,param2,param3);
         this.UnstreamizationPerform_QRApplianceProperties(param1,param2,param3);
      }
      
      protected function UnstreamizationPerform_QRApplianceProperties(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TAppliance = null;
         var _loc5_:int = 0;
         _loc4_ = param2 as TAppliance;
      }
      
      public function UnstreamizeAdditionalDataAppliance(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_AdditionalData_Appliance(param1,param2,param3);
         super.UnstreamizationPerform_InventoryByDatabase(param2);
         this.UnstreamizationPerform_ApplianceByDatabase(param2,param3);
      }
      
      override public function UnstreamizeGenerateInventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         super.UnstreamizeGenerateInventory(param1,param2,param3);
         this.UnstreamizationPerform_GenerateApplianceProperties(param1,param2,param3);
         this.UnstreamizationPerform_ApplianceByDatabase(param2,param3);
      }
   }
}

