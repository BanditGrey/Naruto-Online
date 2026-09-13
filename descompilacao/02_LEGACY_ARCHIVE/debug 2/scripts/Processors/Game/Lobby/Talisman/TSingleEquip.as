package Processors.Game.Lobby.Talisman
{
   import Components.Slots.*;
   import Foundation.Common.Stubs.*;
   import Foundation.Queries.TQueryString;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Inventories.*;
   import Processors.Game.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TSingleEquip extends TProcessorGame
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FScene:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FTF_TalismanName:TextField;
      
      protected var FTF_TalismanLevel:TextField;
      
      protected var FClassName:String;
      
      protected var FMC_Option:MovieClip;
      
      protected var FMC_Selected:MovieClip;
      
      protected var FMC_UnSelect:MovieClip;
      
      protected var FContext:Object;
      
      protected var FBClick:Boolean;
      
      protected var FBSelect:Boolean;
      
      protected var FInventory:TInventory;
      
      protected var FInitialized:Boolean;
      
      protected var FIsSelected:Boolean;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FOnClick:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnQueryEuqipLevel:Function;
      
      public function TSingleEquip(param1:TUIComponent, param2:String = null)
      {
         this.FClassName = param2;
         super(param1);
         this.UIDispatch();
         this.UILocation();
      }
      
      protected function UIDispatch() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(this.FClassName ? this.FClassName : CONST_TALISMAN.RESOURCE_ClassName_MC_SingleEquip) as MovieClip;
         addChild(this.FScene);
         this.FTF_TalismanName = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_TalismanName];
         this.FTF_TalismanLevel = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_TalismanLevel];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.visible = true;
         this.FMC_Slot.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Slot] as Sprite;
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Option = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Option];
         this.FMC_Selected = this.FMC_Option[CONST_TALISMAN.RESOURCE_Link_MC_Selected];
         this.FMC_Selected.visible = false;
         this.FMC_UnSelect = this.FMC_Option[CONST_TALISMAN.RESOURCE_Link_MC_UnSelect];
         this.FMC_UnSelect.visible = false;
         this.FIsSelected = false;
         this.FMC_Slot.OnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FMC_Slot.Init();
      }
      
      protected function UILocation() : void
      {
         this.FTF_TalismanName.selectable = false;
         this.FTF_TalismanLevel.selectable = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.EquipOnOver,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.EquipOnOut,false,0,true);
         this.addEventListener(MouseEvent.CLICK,this.EquipOnClick,false,0,true);
         this.FBSelect = true;
         this.FStubReferences = new TStubReferences(this);
         this.buttonMode = true;
         TGameUtil.setButtonMode(this.FMC_Selected,true);
         TGameUtil.setButtonMode(this.FMC_UnSelect,true);
         this.FMC_Selected.addEventListener(MouseEvent.CLICK,this.EquipOnSelected,false,0,true);
         this.FMC_UnSelect.addEventListener(MouseEvent.CLICK,this.EquipOnUnSelect,false,0,true);
         this.Reset();
      }
      
      protected function EquipOnOver(param1:MouseEvent) : void
      {
         if(!this.FBClick && this.FMC_Slot.Context != null)
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Over);
         }
      }
      
      protected function EquipOnOut(param1:MouseEvent) : void
      {
         if(!this.FBClick && this.FMC_Slot.Context != null)
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
         }
      }
      
      protected function EquipOnClick(param1:MouseEvent) : void
      {
         if(this.FMC_Slot.Context == null)
         {
            return;
         }
         if(this.FBSelect)
         {
            this.FBClick = true;
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Selected);
         }
         else
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
         }
         if(this.FOnClick != null)
         {
            this.FOnClick(this,this.FMC_Slot.Context);
         }
      }
      
      protected function ClearEventListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.EquipOnOver,false);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.EquipOnOut,false);
         this.removeEventListener(MouseEvent.CLICK,this.EquipOnClick,false);
      }
      
      protected function Reset() : void
      {
         this.FMC_Slot.Resource.visible = false;
         this.FMC_Slot.Context = null;
         this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_disabled);
         this.FTF_TalismanName.text = "";
         this.FTF_TalismanLevel.text = "";
         this.FMC_UnSelect.visible = false;
         this.FMC_Selected.visible = false;
         this.FIsSelected = false;
      }
      
      protected function EquipOnSelected(param1:MouseEvent = null) : void
      {
         this.FIsSelected = true;
         this.FMC_Selected.visible = this.FIsSelected;
         this.FMC_UnSelect.visible = !this.FIsSelected;
         this.EquipOnOut(null);
      }
      
      protected function EquipOnUnSelect(param1:MouseEvent = null) : void
      {
         this.FIsSelected = false;
         this.FMC_Selected.visible = this.FIsSelected;
         this.FMC_UnSelect.visible = !this.FIsSelected;
         this.EquipOnOut(null);
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         _loc4_ = param2 as TInventory;
         param3.Value = _loc4_.Quantity.toString();
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function set OnOver(param1:Function) : void
      {
         this.FMC_Slot.OnOverlay = param1;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FMC_Slot.OnOut = param1;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FMC_Slot.Context = param1;
      }
      
      public function get Context() : Object
      {
         return this.FMC_Slot.Context;
      }
      
      public function get BClick() : Boolean
      {
         return this.FBClick;
      }
      
      public function set BClick(param1:Boolean) : void
      {
         this.FBClick = param1;
         this.SetIsSelectByBoolean(this.FBClick);
      }
      
      protected function SetIsSelectByBoolean(param1:Boolean) : void
      {
         if(!param1)
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
         }
         else
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Selected);
         }
      }
      
      public function get BSelect() : Boolean
      {
         return this.FBSelect;
      }
      
      public function set BSelect(param1:Boolean) : void
      {
         this.FBSelect = param1;
         this.FBClick = param1;
         this.SetIsSelectByBoolean(this.FBSelect);
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FMC_Slot.OnQuerySequenceContext = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get OnQueryEuqipLevel() : Function
      {
         return this.FOnQueryEuqipLevel;
      }
      
      public function set OnQueryEuqipLevel(param1:Function) : void
      {
         this.FMC_Slot.OnQueryEuqipLevel = param1;
      }
      
      public function get IsSelected() : Boolean
      {
         return this.FIsSelected;
      }
      
      public function set IsSelected(param1:Boolean) : void
      {
         this.FIsSelected = param1;
         this.FMC_Selected.visible = this.FIsSelected;
         this.FMC_UnSelect.visible = !this.FIsSelected;
         this.BClick = false;
      }
      
      public function SetEquip(param1:TInventory, param2:String, param3:String, param4:uint, param5:Boolean = false) : void
      {
         this.FMC_Slot.Context = param1;
         this.FMC_Slot.Resource.visible = true;
         if(!param5)
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
         }
         this.FTF_TalismanName.text = param2;
         this.FTF_TalismanLevel.text = param3;
         this.FTF_TalismanName.textColor = QUALITYCOLOR_INDEX[param4];
      }
      
      public function RefeshLevelText() : void
      {
         if(Boolean(this.FMC_Slot) && Boolean(this.FMC_Slot.Context) && Boolean(this.FTF_TalismanLevel))
         {
            this.FTF_TalismanLevel.text = STRING_TRANSMIGRATIONACCESSORY.STRENGTHEPRIFIX_NAME + (this.FMC_Slot.Context as TEquipment).UpgradingLevel;
         }
      }
      
      public function OnSelect() : void
      {
         this.EquipOnClick(null);
      }
      
      public function UpdateSingleEquip() : void
      {
         this.FMC_Slot.Update();
      }
      
      public function get TF_TalismanName() : TextField
      {
         return this.FTF_TalismanName;
      }
      
      public function Release() : void
      {
         this.Reset();
      }
   }
}

