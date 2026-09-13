package Processors.Game.Lobby.Pet.Component
{
   import Components.Slots.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIPetBox extends TUIComponent
   {
      
      protected static const LEVEL_ENOUGH:uint = 0;
      
      protected static const LEVEL_NOT_ENOUGH:uint = 1;
      
      protected static const RENDERINGSTATE_Normal:int = 1;
      
      protected static const RENDERINGSTATE_Selected:int = 2;
      
      protected static const RENDERINGSTATE_Disabled:int = 3;
      
      protected static const RENDERINGSTATE_Over:int = 4;
      
      protected var FTF_Name:TextField;
      
      protected var FMC_ImageLockDesc:Sprite;
      
      protected var FTF_ImageLockDesc:TextField;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FIsInitialization:Boolean;
      
      protected var FBSelect:Boolean;
      
      public var FBClick:Boolean;
      
      public var FMC:MovieClip;
      
      protected var FOnClick:Function;
      
      protected var FDoubleClick:Function;
      
      protected var FName:String;
      
      protected var FMyContext:Object;
      
      protected var FUnLuckBoo:Boolean;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FMCImageLockDesc:Function;
      
      protected var FImageLockDesc:String;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      public var FlevelEnough:Boolean;
      
      public function TUIPetBox(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         this.FTF_Name = this.FMC[CONST_PET.RESOURCE_Link_TF_Name];
         this.FTF_Name.mouseEnabled = false;
         this.FMC_ImageLockDesc = this.FMC[CONST_PET.RESOURCE_Link_MC_ImageLockDesc];
         this.FTF_ImageLockDesc = this.FMC_ImageLockDesc[CONST_PET.RESOURCE_Link_TF_ImageLockDesc];
         this.FTF_ImageLockDesc.mouseEnabled = false;
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.Resource = this.FMC[CONST_PET.RESOURCE_Link_MC_Slot] as Sprite;
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.Init();
         this.FMC_Slot.SetDefaultFilters(true);
         this.FMC.addEventListener(MouseEvent.MOUSE_MOVE,this.OnOver);
         this.FMC.addEventListener(MouseEvent.MOUSE_OUT,this.OnOut);
         this.FMC.addEventListener(MouseEvent.CLICK,this.BoxOnClick);
         this.FMC.addEventListener(MouseEvent.DOUBLE_CLICK,this.BoxOnDoubleClick);
         this.FBSelect = true;
         this.FMC.gotoAndStop(RENDERINGSTATE_Disabled);
      }
      
      protected function OnOver(param1:MouseEvent) : void
      {
         if(this.FBClick)
         {
            if(this.FOnOver != null)
            {
               this.FOnOver(this,this.FMyContext.Desc,LEVEL_ENOUGH);
            }
            return;
         }
         if(this.FUnLuckBoo)
         {
            this.FMC_Slot.Resource.mouseEnabled = true;
            if(this.FOnOver != null)
            {
               this.FOnOver(this,this.FMyContext.Desc,LEVEL_ENOUGH);
            }
            this.FMC.gotoAndStop(RENDERINGSTATE_Over);
         }
         else if(this.FlevelEnough)
         {
            this.FMC_Slot.Resource.mouseEnabled = false;
            if(this.FOnOver != null)
            {
               this.FOnOver(this,this.FMyContext.LockDesc,LEVEL_NOT_ENOUGH);
            }
            this.FMC.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else
         {
            this.FMC.gotoAndStop(RENDERINGSTATE_Disabled);
         }
      }
      
      protected function OnOut(param1:MouseEvent) : void
      {
         if(this.FBClick)
         {
            if(this.FOnOut != null)
            {
               this.FOnOut(this);
            }
            return;
         }
         if(this.FUnLuckBoo)
         {
            this.FMC.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else if(this.FlevelEnough)
         {
            this.FMC.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else
         {
            this.FMC.gotoAndStop(RENDERINGSTATE_Disabled);
         }
         if(this.FOnOut != null)
         {
            this.FOnOut(this);
         }
      }
      
      protected function BoxOnClick(param1:MouseEvent) : void
      {
         if(this.FUnLuckBoo)
         {
            if(this.FOnClick != null)
            {
               this.FOnClick(this);
            }
            this.FMC.gotoAndStop(RENDERINGSTATE_Selected);
            this.FBClick = true;
         }
         else if(this.FlevelEnough)
         {
            this.FMC.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else
         {
            this.FMC.gotoAndStop(RENDERINGSTATE_Disabled);
            if(this.FDoubleClick != null)
            {
               this.FDoubleClick(this);
            }
         }
      }
      
      protected function BoxOnDoubleClick(param1:MouseEvent) : void
      {
      }
      
      protected function UpDateInformation() : void
      {
         if(this.FMyContext != null)
         {
            this.FTF_Name.text = this.FMyContext.Name;
            this.FTF_ImageLockDesc.text = TUtilityString.Format(STRING_PET.FORMAT_UnlockLevel,STRING_COMMON.GetLevelStrByLevelLineFeed(this.FMyContext.LevelLimit));
         }
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get OnDoubleClick() : Function
      {
         return this.FDoubleClick;
      }
      
      public function set OnDoubleClick(param1:Function) : void
      {
         this.FDoubleClick = param1;
      }
      
      public function get BSelect() : Boolean
      {
         return this.FBSelect;
      }
      
      public function set BSelect(param1:Boolean) : void
      {
         this.FBSelect = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function set ImageLockDesc(param1:String) : void
      {
         this.FTF_ImageLockDesc.text = param1;
      }
      
      public function get UnLuckBoo() : Boolean
      {
         return this.FUnLuckBoo;
      }
      
      public function set UnLuckBoo(param1:Boolean) : void
      {
         this.FUnLuckBoo = param1;
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get MyContext() : Object
      {
         return this.FMyContext;
      }
      
      public function set MyContext(param1:Object) : void
      {
         this.FMyContext = param1;
         if(this.FMC_Slot)
         {
            this.FMC_Slot.Context = param1;
         }
      }
      
      public function set MCImageLockDesc(param1:Boolean) : void
      {
         this.FMC_ImageLockDesc.visible = param1;
      }
      
      public function get Over() : Function
      {
         return this.FOnOver;
      }
      
      public function set Over(param1:Function) : void
      {
         this.FOnOver = param1;
      }
      
      public function get Out() : Function
      {
         return this.FOnOut;
      }
      
      public function set Out(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpDateSlot() : void
      {
         this.UpDateInformation();
         this.FMC_Slot.Context = this.FMyContext;
         this.FMC_Slot.OnQuerySequenceContext = this.FOnQuerySequenceContext;
         this.FMC_Slot.Update();
      }
      
      public function SetNormal() : void
      {
         this.FMC_Slot.SetDefaultFilters(false);
      }
      
      public function SetBlack() : void
      {
         this.FMC_Slot.SetDefaultFilters(true);
      }
   }
}

