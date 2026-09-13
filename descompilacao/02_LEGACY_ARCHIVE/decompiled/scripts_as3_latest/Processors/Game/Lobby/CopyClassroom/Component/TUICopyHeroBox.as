package Processors.Game.Lobby.CopyClassroom.Component
{
   import Components.Slots.TUISlot;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.CopyHero.TCopyHero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COPYCLASSROOM;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUICopyHeroBox extends TUIComponent
   {
      
      protected var FMC_Slot:TUISlot;
      
      protected var FMC_Both:Sprite;
      
      protected var FMC_Timer:MovieClip;
      
      protected var FTF_Timer:TextField;
      
      protected var FMC_CopyHeroName:Sprite;
      
      protected var FTF_CopyHeroName:TextField;
      
      protected var FMC_Background:MovieClip;
      
      protected var FMC_Recruit:MovieClip;
      
      protected var FMC_OverState:Sprite;
      
      protected var FIsInitialization:Boolean;
      
      protected var FBRecruit:Boolean;
      
      public var FMC:MovieClip;
      
      protected var FOnClick:Function;
      
      protected var FOnOver:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FMyContext:TCopyHero;
      
      protected var FMyValue:Object;
      
      protected var FCopyingTime:int;
      
      protected var FTutorialNextStep:Function;
      
      public function TUICopyHeroBox(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         this.FMC_Timer = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_MC_CardTimerPart];
         this.FTF_Timer = this.FMC_Timer[CONST_COPYCLASSROOM.RESOURCE_Link_TF_Timer];
         this.FMC_Timer.visible = false;
         this.FTF_CopyHeroName = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_TF_CopyHeroName];
         this.FMC_Background = this.FMC[CONST_COPYCLASSROOM.RESOURCE_LINK_MC_Bg];
         this.FMC_Background.gotoAndStop(3);
         this.FMC_OverState = this.FMC_Background[CONST_COPYCLASSROOM.RESOURCE_Link_MC_OverState];
         this.FMC_OverState.visible = false;
         this.FMC_Recruit = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_MC_NoResuit];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.Resource = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_MC_CardLoadHreo] as Sprite;
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.Init();
         this.FMC_Slot.SetDefaultFilters(true);
         this.FMC.addEventListener(MouseEvent.CLICK,this.OnClick);
         this.FMC.addEventListener(MouseEvent.MOUSE_OVER,this.OnBoxOver);
         this.FMC.addEventListener(MouseEvent.MOUSE_OUT,this.OnBoxOut);
         this.FMC.buttonMode = true;
         this.FBRecruit = false;
      }
      
      protected function OnClick(param1:MouseEvent) : void
      {
         if(this.FMyContext == null)
         {
            return;
         }
         this.FOnClick(this,this.FMyContext);
         this.FTutorialNextStep(2201);
      }
      
      protected function OnBoxOver(param1:MouseEvent) : void
      {
         if(this.FMyContext == null)
         {
            return;
         }
         this.FMC_OverState.visible = true;
         this.FOnOver(this,this.FMyContext);
      }
      
      protected function OnBoxOut(param1:MouseEvent) : void
      {
         if(this.FMyContext == null)
         {
            return;
         }
         this.FMC_OverState.visible = false;
         this.FOnOut(this,this.FMyContext);
      }
      
      protected function UpDateInformation() : void
      {
         var _loc1_:TBaseHero = null;
         if(this.FMyContext)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FMyContext.HeroID) as TBaseHero;
            this.FMC_Recruit.visible = this.FMyContext.BRecruit == 1 ? false : true;
            this.FTF_CopyHeroName.text = String(this.FMyContext.HeroName);
            this.FTF_CopyHeroName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc1_.Quality];
            if(this.FMyContext.BRecruit == 1)
            {
               this.FMC_Background.gotoAndStop(1);
            }
            else
            {
               this.FMC_Background.gotoAndStop(3);
            }
            if(this.FMyContext.State == 1)
            {
               this.FMC_Background.gotoAndStop(2);
               this.FMC_Timer.visible = true;
            }
            else
            {
               this.FMC_Timer.visible = false;
            }
         }
         else
         {
            this.FMC_Recruit.visible = false;
            this.FTF_CopyHeroName.text = "";
            this.FMC_Background.gotoAndStop(3);
         }
      }
      
      protected function UpdateCopyingTime(param1:int) : void
      {
         this.FTF_Timer.text = TGameUtil.fomatTime(param1);
      }
      
      public function get BoxClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set BoxClick(param1:Function) : void
      {
         this.FOnClick = param1;
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
      
      public function get MyContext() : TCopyHero
      {
         return this.FMyContext;
      }
      
      public function set MyContext(param1:TCopyHero) : void
      {
         this.FMyContext = param1;
      }
      
      public function get MyValue() : Object
      {
         return this.FMyValue;
      }
      
      public function set MyValue(param1:Object) : void
      {
         this.FMyValue = param1;
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get CopyingTime() : int
      {
         return this.FCopyingTime;
      }
      
      public function set CopyingTime(param1:int) : void
      {
         this.FCopyingTime = param1;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
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
      
      public function UpDateSlotTime(param1:int) : void
      {
         if(Boolean(param1 > 0) && Boolean(this.FMyContext) && this.FMyContext.State == 1)
         {
            if(!this.FMC_Timer.visible)
            {
               this.FMC_Timer.visible = true;
            }
            this.UpdateCopyingTime(param1);
         }
         else
         {
            if(this.FMyContext)
            {
               if(this.FMyContext.State != 0)
               {
                  this.FMyContext.State = 0;
               }
            }
            if(Boolean(this.FMyContext) && Boolean(this.FMyContext.BRecruit))
            {
               this.FMC_Background.gotoAndStop(3);
            }
            else
            {
               this.FMC_Background.gotoAndStop(1);
            }
            if(this.FMC_Timer.visible)
            {
               this.FMC_Timer.visible = false;
            }
         }
      }
   }
}

