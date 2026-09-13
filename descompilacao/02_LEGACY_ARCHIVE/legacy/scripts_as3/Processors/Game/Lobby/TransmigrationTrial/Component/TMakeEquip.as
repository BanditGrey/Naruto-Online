package Processors.Game.Lobby.TransmigrationTrial.Component
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TRANSMIGRATIONTRIAL;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TMakeEquip extends TUIComponent
   {
      
      protected var FScene:MovieClip;
      
      protected var FUISlot:TUISlot;
      
      protected var FContext:Object;
      
      protected var FIsSelected:Boolean;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FOnClick:Function;
      
      public function TMakeEquip(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TRANSMIGRATIONTRIAL.RESOURCE_ClassName_TransmigrationEquitSlot) as MovieClip;
         addChild(this.FScene);
         this.FIsSelected = false;
         this.FScene["mc_Select"].visible = false;
         this.FUISlot = new TUISlot(this);
         this.FUISlot.Resource = this.FScene["mc_Slot"];
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FUISlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FUISlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FUISlot.Init();
         addEventListener(MouseEvent.CLICK,this.OnSlotClick);
      }
      
      protected function OnSlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence) : void
      {
         if(this.FSlotsOnQuerySequenceContext != null)
         {
            this.FSlotsOnQuerySequenceContext(param1,param2,param3);
         }
      }
      
      protected function OnUIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function OnUIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      protected function OnSlotClick(param1:MouseEvent) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,this.FContext);
         }
      }
      
      public function get SlotsOnQuerySequenceContext() : Function
      {
         return this.FSlotsOnQuerySequenceContext;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function get UIComponentsHintOnOver() : Function
      {
         return this.FUIComponentsHintOnOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function get UIComponentsHintOnOut() : Function
      {
         return this.FUIComponentsHintOnOut;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get IsSelected() : Boolean
      {
         return this.FIsSelected;
      }
      
      public function set IsSelected(param1:Boolean) : void
      {
         this.FIsSelected = param1;
         this.FScene["mc_Select"].visible = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
         this.FUISlot.Context = param1;
      }
      
      public function UpdateSlot() : void
      {
         if(this.FUISlot)
         {
            this.FUISlot.Update();
         }
      }
   }
}

