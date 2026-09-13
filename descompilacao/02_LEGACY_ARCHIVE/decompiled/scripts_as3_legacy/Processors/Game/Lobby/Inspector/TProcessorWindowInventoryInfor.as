package Processors.Game.Lobby.Inspector
{
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowInventoryInfor extends TProcessorLobbyWindow
   {
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected static const Tip_X:int = 281;
      
      protected static const Tip_Y:int = 619;
      
      protected var FIsOverlayerShow:Boolean;
      
      protected var FInventory:TInventory;
      
      protected var FCloseBtn:SimpleButton;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FCoordinate:TCoordinate;
      
      public function TProcessorWindowInventoryInfor(param1:TUIComponent)
      {
         super(param1);
         this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_InventoryInfor);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_InventoryInfor);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_InventoryInfor);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_InventoryInfor);
         this.FOverlayerAccessory.Visible = false;
         this.FIsOverlayerShow = false;
      }
      
      public function UIDispatch() : void
      {
         this.FCloseBtn = TUtilityReflection.CreateDisplayObjectInstance("CloseBtn") as SimpleButton;
         addChild(this.FCloseBtn);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         this.FCoordinate = new TCoordinate();
         this.FCoordinate.X = 0;
         this.FCoordinate.Y = 0;
      }
      
      public function UILocation() : void
      {
         this.FCloseBtn.addEventListener(MouseEvent.CLICK,this.OnCloseBtnClick);
      }
      
      protected function OnCloseBtnClick(param1:MouseEvent) : void
      {
         this.HideInventoryInfor();
      }
      
      protected function UIComponentsOverlayerOnOver(param1:Object) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc2_ = param1 as TInventory;
         switch(_loc2_.Category)
         {
            case CATEGORY_Equipment:
               _loc4_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc4_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc4_ = this.FOverlayerAccessory;
               break;
            default:
               _loc4_ = this.FOverlayerAppliance;
         }
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc2_;
            _loc4_.Render(this.FCoordinate);
            _loc4_.Show();
         }
         this.FCloseBtn.x = _loc4_.X + _loc4_.width - this.FCloseBtn.width;
         this.FCloseBtn.y = _loc4_.Y + 1;
         this.x = Tip_X;
         this.y = Tip_Y - _loc4_.height;
         this.FCloseBtn.visible = true;
      }
      
      protected function UIComponentsOverlayerOnOut(param1:TInventory) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:TOverlayer = null;
         _loc2_ = param1 as TInventory;
         switch(_loc2_.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Accessories:
               _loc3_ = this.FOverlayerAccessory;
               break;
            default:
               _loc3_ = this.FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
      
      public function ShowInventoryInfor() : void
      {
         this.HideInventoryInfor();
         this.FIsOverlayerShow = true;
         this.UIComponentsOverlayerOnOver(this.FInventory);
      }
      
      public function HideInventoryInfor() : void
      {
         if(!this.FIsOverlayerShow)
         {
            return;
         }
         this.FCloseBtn.visible = false;
         this.FOverlayerTreasure.Hide();
         this.FOverlayerEquipment.Hide();
         this.FOverlayerAppliance.Hide();
         this.FOverlayerAccessory.Hide();
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_InventoryInfor);
         this.FIsOverlayerShow = false;
      }
   }
}

