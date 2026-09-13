package Processors.Game.Lobby.Recharge
{
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_ACTIVITY_MODE;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_RECHARGE;
   import Resources.Constants.CONST_SIGNAL;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorRecharge extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Recharge:uint = 898;
      
      protected static const SIZE_HIGHT_Recharge:uint = 556;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      public static const SIGNALDESTINATION_ACTIVE_Recharge_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_Recharge_Ret;
      
      public static const KEY_Activity_FlockRecharge:uint = CONST_ACTIVITY_MODE.Activity_FlockRecharge;
      
      public static const KEY_Activity_VIPBox:uint = CONST_ACTIVITY_MODE.Activity_VIPBox;
      
      public static const KEY_Activity_OnePay:uint = CONST_ACTIVITY_MODE.Activity_OnePay;
      
      public static const KEY_Activity_EreryDayRecharge:uint = CONST_ACTIVITY_MODE.Activity_EreryDayRecharge;
      
      protected var FProcessorWindowRecharge:TProcessorWindowRecharge;
      
      protected var FRechargeBounds:TBounds;
      
      protected var FOnNewRechargeGift:Function;
      
      protected var FOnBuyActionTimes:Function;
      
      protected var FOnGotoRamen:Function;
      
      public function TProcessorRecharge(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowRecharge = new TProcessorWindowRecharge(this,CONST_MODULES.MODULE_Recharge);
         this.FProcessorWindowRecharge.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessorWindowRecharge.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessorWindowRecharge.OnHintOver = this.UIHintOnOver;
         this.FProcessorWindowRecharge.OnHintOut = this.UIHintOnOut;
         this.FProcessorWindowRecharge.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowRecharge.OnNewRechargeGift = this.ProcessorOnNewRechargeGift;
         this.FProcessorWindowRecharge.OnBuyActionTimes = this.ProcessorOnBuyActionTimes;
         this.FProcessorWindowRecharge.OnGotoRamen = this.ProcessorOnGotoRamen;
         this.FRechargeBounds = new TBounds();
         this.FRechargeBounds.X = this.FProcessorWindowRecharge.x;
         this.FRechargeBounds.Y = this.FProcessorWindowRecharge.y;
         this.FRechargeBounds.Width = SIZE_WIDTH_Recharge;
         this.FRechargeBounds.Height = SIZE_HIGHT_Recharge;
         ComponentBoundsCenter(this.FProcessorWindowRecharge,this.FRechargeBounds);
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_Recharge);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_Recharge);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_Recharge);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_Recharge);
         FOverlayerAccessory.Visible = false;
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_Recharge);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_RECHARGE.RESOURCESID_Swf_Recharge);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function ProcessorOnBuyActionTimes(param1:Object) : void
      {
         if(this.FOnBuyActionTimes != null)
         {
            this.FOnBuyActionTimes(this);
         }
      }
      
      protected function ProcessorOnGotoRamen(param1:Object) : void
      {
         if(this.FOnGotoRamen != null)
         {
            this.FOnGotoRamen(this);
         }
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnNewRechargeGift(param1:uint, param2:uint, param3:Boolean) : void
      {
         if(this.FOnNewRechargeGift != null)
         {
            this.FOnNewRechargeGift(param1,param2,param3);
         }
      }
      
      protected function UIHintOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIHintOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      public function get OnNewRechargeGift() : Function
      {
         return this.FOnNewRechargeGift;
      }
      
      public function set OnNewRechargeGift(param1:Function) : void
      {
         this.FOnNewRechargeGift = param1;
      }
      
      public function get OnBuyActionTimes() : Function
      {
         return this.FOnBuyActionTimes;
      }
      
      public function set OnBuyActionTimes(param1:Function) : void
      {
         this.FOnBuyActionTimes = param1;
      }
      
      public function get OnGotoRamen() : Function
      {
         return this.FOnGotoRamen;
      }
      
      public function set OnGotoRamen(param1:Function) : void
      {
         this.FOnGotoRamen = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecharge.Load();
            return;
         }
         this.FProcessorWindowRecharge.Visible = true;
         this.FProcessorWindowRecharge.Init();
      }
      
      public function SendRankData(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         this.FProcessorWindowRecharge.SendPayRank(param1);
      }
   }
}

