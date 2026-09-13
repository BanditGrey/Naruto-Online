package Processors.Game.Lobby.LostShenqi
{
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.LostShenqi.Panel.TProcessorLostMi;
   import Processors.Game.Lobby.LostShenqi.Panel.TProcessoriShenQiMake;
   import Processors.Game.Lobby.LostShenqi.Panel.TProcessoriShenQiUpgrade;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerSuperTreasure;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorLostShenQi extends TProcessorLobbyWindows
   {
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      protected var FThisPanel:Sprite;
      
      protected var Fbtn_Close:SimpleButton;
      
      protected var FMC_Goto_EquipShenQi:MovieClip;
      
      protected var FProcessorLostMi:TProcessorLostMi;
      
      protected var FProcessoriShenQiMake:TProcessoriShenQiMake;
      
      protected var FProcessoriShenQiUpgrade:TProcessoriShenQiUpgrade;
      
      protected var FUITab:TUITab;
      
      protected var FCurTabIndex:int;
      
      protected var FIsInilization:Boolean;
      
      protected var FOverlayerSuperTreasure:TOverlayerSuperTreasure;
      
      protected var FMC_Goto_FaQiFunction:Function;
      
      protected var FMakeBtnFunction:Function;
      
      protected var FShengJiBackFunction:Function;
      
      protected var FEnterInMiGongFunction:Function;
      
      protected var FBuyFunction:Function;
      
      protected var FPiaoZi:Function;
      
      public function TProcessorLostShenQi(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorLostMi = new TProcessorLostMi(this);
         this.FProcessorLostMi.EnterInMiGongFunction = this.EnterInMiGongFunctionClick;
         this.FProcessorLostMi.BuyFunction = this.BuyFunctionClick;
         this.FProcessoriShenQiMake = new TProcessoriShenQiMake(this);
         this.FProcessoriShenQiMake.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessoriShenQiMake.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessoriShenQiMake.MakeBtnFunction = this.MakeBtnFunctionClick;
         this.FProcessoriShenQiUpgrade = new TProcessoriShenQiUpgrade(this);
         this.FProcessoriShenQiUpgrade.OnInventoryOver = UIComponentsHintOnOver;
         this.FProcessoriShenQiUpgrade.OnInventoryOut = UIComponentsHintOnOut;
         this.FProcessoriShenQiUpgrade.ShengJiBackFunct = this.ShengJiBackFunctionClick;
         this.FProcessoriShenQiUpgrade.PiaoZi = this.PiaoZiClick;
         this.FUITab = new TUITab(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_LostShenQi") as Sprite;
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         addChild(this.FThisPanel);
         this.Fbtn_Close = this.FThisPanel["btn_Close"];
         new Tools_Help(Parent,this.FThisPanel["btn_help"],70170092,FUICore);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = this.FThisPanel["MC_Tab_" + _loc2_];
            _loc1_.mouseChildren = false;
            this.FUITab.SetTabByIndex(_loc1_,_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabChange;
         this.FUITab.Init();
         this.FMC_Goto_EquipShenQi = this.FThisPanel["MC_Goto_EquipShenQi"];
         TGameUtil.setButtonMode(this.FMC_Goto_EquipShenQi,true);
         _loc1_ = this.FThisPanel["MC_LostMi"];
         this.FProcessorLostMi.SetPanel = _loc1_;
         _loc1_ = this.FThisPanel["MC_ShenQiMake"];
         this.FProcessoriShenQiMake.SetPanel = _loc1_;
         _loc1_ = this.FThisPanel["MC_ShenQiUpgrade"];
         this.FProcessoriShenQiUpgrade.SetPanel = _loc1_;
         FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_LostShenQi);
         FOverlayerEquipment.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_LostShenQi);
         FOverlayerAppliance.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_LostShenQi);
         FOverlayerTreasure.Visible = false;
         this.FOverlayerSuperTreasure = new TOverlayerSuperTreasure(this,CONST_MODULES.MODULE_LostShenQi);
         this.FOverlayerSuperTreasure.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSuperTreasure);
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function TabChange(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.PanelVisiByIndex();
      }
      
      public function UpdateViewByIndex(param1:int) : void
      {
         if(!this.FIsInilization)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               this.FProcessorLostMi.UpdateView();
               break;
            case 1:
               this.FProcessoriShenQiMake.OpenThisPanel();
               break;
            case 2:
               this.FProcessoriShenQiUpgrade.OpenThisPanel();
         }
      }
      
      protected function PanelVisiByIndex() : void
      {
         this.FProcessorLostMi.ThisPanel.visible = false;
         this.FProcessoriShenQiMake.ThisPanel.visible = false;
         this.FProcessoriShenQiUpgrade.ThisPanel.visible = false;
         switch(this.FCurTabIndex)
         {
            case 0:
               this.FProcessorLostMi.ThisPanel.visible = true;
               this.FProcessorLostMi.UpdateView();
               break;
            case 1:
               this.FProcessoriShenQiMake.ThisPanel.visible = true;
               this.FProcessoriShenQiMake.OpenThisPanel();
               break;
            case 2:
               this.FProcessoriShenQiUpgrade.ThisPanel.visible = true;
               this.FProcessoriShenQiUpgrade.OpenThisPanel();
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FProcessorLostMi.UiLocations();
         this.FProcessoriShenQiMake.UiLocations();
         this.FProcessoriShenQiUpgrade.UiLocations();
         this.Fbtn_Close.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_Goto_EquipShenQi.addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function ShenQiMakeBackFunction() : void
      {
         this.FProcessoriShenQiMake.RestDate();
         this.FProcessoriShenQiMake.UpdateView();
      }
      
      public function ShenQiShenJiBackFunction() : void
      {
         this.FProcessoriShenQiUpgrade.SligeEquipSetValue(true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!this.FIsInilization)
         {
            return;
         }
         this.FProcessorLostMi.LogicsUpdate();
         this.FProcessoriShenQiMake.LogicsUpdate();
         this.FProcessoriShenQiUpgrade.LogicsUpdate();
      }
      
      public function OpenThisPanel() : void
      {
         this.FCurTabIndex = 0;
         this.FUITab.SwithTagManual(this.FCurTabIndex);
         this.PanelVisiByIndex();
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.Fbtn_Close:
               if(FOnClose != null)
               {
                  FOnClose();
               }
               break;
            case this.FMC_Goto_EquipShenQi:
               if(this.FMC_Goto_FaQiFunction != null)
               {
                  this.FMC_Goto_FaQiFunction();
               }
         }
      }
      
      protected function ShengJiBackFunctionClick(param1:TInventory, param2:uint) : void
      {
         if(this.FShengJiBackFunction != null)
         {
            this.FShengJiBackFunction(param1,param2);
         }
      }
      
      protected function MakeBtnFunctionClick(param1:TInventory, param2:uint) : void
      {
         if(this.FMakeBtnFunction != null)
         {
            this.FMakeBtnFunction(param1,param2);
         }
      }
      
      protected function EnterInMiGongFunctionClick() : void
      {
         if(this.FEnterInMiGongFunction != null)
         {
            this.FEnterInMiGongFunction();
         }
      }
      
      protected function BuyFunctionClick() : void
      {
         if(this.FBuyFunction != null)
         {
            this.FBuyFunction();
         }
      }
      
      public function set MC_Goto_FaQiFunction(param1:Function) : void
      {
         this.FMC_Goto_FaQiFunction = param1;
      }
      
      public function set MakeBtnFunction(param1:Function) : void
      {
         this.FMakeBtnFunction = param1;
      }
      
      public function set ShengJiBackFunction(param1:Function) : void
      {
         this.FShengJiBackFunction = param1;
      }
      
      public function set EnterInMiGongFunction(param1:Function) : void
      {
         this.FEnterInMiGongFunction = param1;
      }
      
      public function set BuyFunction(param1:Function) : void
      {
         this.FBuyFunction = param1;
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
      
      protected function PiaoZiClick(param1:String) : void
      {
         if(this.FPiaoZi != null)
         {
            this.FPiaoZi(param1);
         }
      }
   }
}

