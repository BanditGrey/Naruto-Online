package Processors.Game.Lobby.Jade
{
   import Components.Slots.TUISlot;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventory;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_TRANSMIGRATIONACCESSORY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TSingelJageList extends TProcessorGame
   {
      
      protected var FScene:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FTF_Name0:TextField;
      
      protected var FTF_Name1:TextField;
      
      protected var FTF_MeiYong:TextField;
      
      protected var FContext:Object;
      
      protected var FBClick:Boolean;
      
      protected var FBSelect:Boolean;
      
      protected var FInventory:TInventory;
      
      protected var FInitialized:Boolean;
      
      protected var FOnClick:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnQueryEuqipLevel:Function;
      
      protected var FIsSelected:Boolean;
      
      public function TSingelJageList(param1:TUIComponent)
      {
         super(param1);
         this.AddPanel();
         this.AdddEvent();
      }
      
      protected function AddPanel() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance("MC_DanGeZiMoBan") as MovieClip;
         addChild(this.FScene);
         this.FTF_Name0 = this.FScene["TF_Name0"];
         this.FTF_Name1 = this.FScene["TF_Name1"];
         this.FTF_MeiYong = this.FScene["TF_MeiYong"];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.visible = true;
         this.FMC_Slot.Resource = this.FScene["MC_Slot"] as Sprite;
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FIsSelected = false;
         this.FMC_Slot.Init();
      }
      
      protected function AdddEvent() : void
      {
         this.FTF_Name0.selectable = false;
         this.FTF_Name1.selectable = false;
         this.FTF_MeiYong.selectable = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.EquipOnOver,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.EquipOnOut,false,0,true);
         this.addEventListener(MouseEvent.CLICK,this.EquipOnClick,false,0,true);
         this.FBSelect = true;
         this.buttonMode = true;
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
         this.FScene.gotoAndStop(3);
         this.FTF_Name0.text = "";
         this.FTF_Name1.text = "";
         this.FTF_MeiYong.visible = false;
         this.FIsSelected = false;
      }
      
      protected function EquipOnSelected(param1:MouseEvent = null) : void
      {
         this.FIsSelected = true;
         this.EquipOnOut(null);
      }
      
      protected function EquipOnUnSelect(param1:MouseEvent = null) : void
      {
         this.FIsSelected = false;
         this.EquipOnOut(null);
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
         this.BClick = false;
      }
      
      public function SetEquip(param1:TInventory, param2:String, param3:Boolean = false) : void
      {
         this.FMC_Slot.Context = param1;
         this.FMC_Slot.Resource.visible = true;
         if(!param3)
         {
            this.FScene.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
         }
         this.FTF_Name0.text = param2;
         this.FTF_Name0.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
         if(param1.EquipmentDeJade)
         {
            this.FTF_Name1.text = param1.EquipmentDeJade.Name;
            this.FTF_Name1.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
         }
         else
         {
            this.FTF_Name1.text = STRING_TRANSMIGRATIONACCESSORY.STR_1;
         }
         this.FTF_MeiYong.visible = true;
      }
      
      public function OnSelect() : void
      {
         this.EquipOnClick(null);
      }
      
      public function UpdateSingleEquip() : void
      {
         this.FMC_Slot.Update();
      }
      
      public function Release() : void
      {
         this.Reset();
      }
   }
}

