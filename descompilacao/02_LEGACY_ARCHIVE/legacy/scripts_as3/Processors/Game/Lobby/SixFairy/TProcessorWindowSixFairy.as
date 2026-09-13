package Processors.Game.Lobby.SixFairy
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_SIXFAIRYMAIN;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowSixFairy extends TProcessorLobbyWindow
   {
      
      protected var FMC_SixFairyMan_Panel:MovieClip = null;
      
      protected var FMC_SixFairy_Panel:MovieClip = null;
      
      protected var FMC_SixFairyMan_Class:TProcessorWindowSixFairyManPanel = null;
      
      protected var FMC_SixFairy_Class:TProcessorWindowSixFairyPanel = null;
      
      protected var FBreakThroughFun:Function = null;
      
      protected var FGoldPracticehFun:Function = null;
      
      protected var FGetAwardFun:Function = null;
      
      protected var FSixFairyManChangeStatue:Function = null;
      
      protected var FBtn_enterFun:Function = null;
      
      protected var FSixFaryAllDataBase:SixFaryAllDataBase = null;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      protected var FExcelOne:Function;
      
      public function TProcessorWindowSixFairy(param1:TUIComponent, param2:SixFaryAllDataBase)
      {
         super(param1);
         this.FSixFaryAllDataBase = param2;
         this.FMC_SixFairyMan_Class = new TProcessorWindowSixFairyManPanel(param1,param2);
         this.FMC_SixFairyMan_Class.OnEffectText = this.ForEffect;
         this.FMC_SixFairyMan_Class.GetAwardFun = this.GetAwardFunF;
         this.FMC_SixFairyMan_Class.GotoPracticeFun = this.GotoPracticeFunF;
         this.FMC_SixFairyMan_Class.Btn_enterFun = this.FBtn_enterFunF;
         this.FMC_SixFairyMan_Class.UIComponentsHintOnOver = this.UIComponentsOnOverFun;
         this.FMC_SixFairyMan_Class.UIComponentsHintOnOut = this.UIComponentsOnOutFun;
         this.FMC_SixFairyMan_Class.ExcelOne = this.ExcelOneFun;
         this.FMC_SixFairyMan_Class.LevelupSixFairFun = this.OnLevelupSixFairFun;
         this.FMC_SixFairy_Class = new TProcessorWindowSixFairyPanel(param1,param2);
         this.FMC_SixFairy_Class.OnEffectText = this.ForEffect;
         this.FMC_SixFairy_Class.BreakThroughFun = this.BreakThroughFunF;
         this.FMC_SixFairy_Class.GoldPracticehFun = this.GoldPracticehFunF;
         this.FMC_SixFairy_Class.GotoSixFairyManFun = this.GotoSixFairyManFunF;
         this.FMC_SixFairy_Class.UIComponentsHintOnOver = this.UIComponentsHintOnOverFun;
         this.FMC_SixFairy_Class.UIComponentsHintOnOut = this.UIComponentsHintOnOutFun;
         this.FMC_SixFairy_Class.LevelupSixFairFun = this.OnLevelupSixFairFun;
      }
      
      public function set ExcelOne(param1:Function) : void
      {
         this.FExcelOne = param1;
      }
      
      public function set UIComponentsOnOver(param1:Function) : void
      {
         this.FUIComponentsOnOver = param1;
      }
      
      public function set UIComponentsOnOut(param1:Function) : void
      {
         this.FUIComponentsOnOut = param1;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function UIComponentsOnOverFun(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsOnOver != null)
         {
            this.FUIComponentsOnOver(param1,param2);
         }
      }
      
      public function ExcelOneFun() : void
      {
         if(this.FExcelOne != null)
         {
            this.FExcelOne();
         }
      }
      
      public function OnLevelupSixFairFun(param1:Object, param2:uint) : void
      {
         if(this.FSixFairyManChangeStatue != null)
         {
            this.FSixFairyManChangeStatue(param1,param2);
         }
      }
      
      public function UIComponentsOnOutFun(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(param1,param2);
         }
      }
      
      public function UIComponentsHintOnOverFun(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      public function UIComponentsHintOnOutFun(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      public function setGetRewardBtnState() : void
      {
         this.FMC_SixFairyMan_Class.setGetRewardBtnState();
      }
      
      public function JudgeCanPlayerEffectByCondition() : void
      {
         this.FMC_SixFairyMan_Class.JudgeCanPlayerEffectByCondition();
      }
      
      public function UpdateLogic() : void
      {
         this.FMC_SixFairyMan_Class.UpdateLogic();
         this.FMC_SixFairy_Class.UpdateLogic();
      }
      
      public function AddItem(param1:Sprite) : void
      {
         this.FMC_SixFairyMan_Class.AddItem(param1);
      }
      
      public function AddItemS(param1:Vector.<DisplayObject>) : void
      {
         this.FMC_SixFairyMan_Class.AddItems(param1);
      }
      
      public function ScrollBarClear() : void
      {
         this.FMC_SixFairyMan_Class.ScrollBarClear();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SIXFAIRYMAIN.SixFairyMain_ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_SixFairyMan_Panel = TUtilityReflection.CreateDisplayObjectInstance(CONST_SIXFAIRYMAIN.MC_SixFairyMan_Panel_name) as MovieClip;
         addChild(this.FMC_SixFairyMan_Panel);
         this.FMC_SixFairyMan_Class.SetThisPanel(this.FMC_SixFairyMan_Panel);
         this.FMC_SixFairyMan_Panel.x = (FUICore.StageWidth - 712) / 2;
         this.FMC_SixFairyMan_Panel.y = (FUICore.StageHeight - 524) / 2;
         this.FMC_SixFairy_Panel = TUtilityReflection.CreateDisplayObjectInstance(CONST_SIXFAIRYMAIN.MC_SixFairy_Panel_name) as MovieClip;
         addChild(this.FMC_SixFairy_Panel);
         this.FMC_SixFairy_Class.SetThisPanel(this.FMC_SixFairy_Panel);
         this.FMC_SixFairy_Panel.x = (FUICore.StageWidth - 712) / 2;
         this.FMC_SixFairy_Panel.y = (FUICore.StageHeight - 524) / 2;
         this.addEvent();
         super.ResourcesPerform_UIDispatch();
      }
      
      public function addEvent() : void
      {
         SimpleButton(this.FMC_SixFairyMan_Panel["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseClick);
         SimpleButton(this.FMC_SixFairy_Panel["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseClick);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      public function CloseClick(param1:MouseEvent) : void
      {
         FOnClose();
      }
      
      public function OpenPanelByIndex(param1:int) : void
      {
         this.FMC_SixFairyMan_Panel.visible = false;
         this.FMC_SixFairy_Panel.visible = false;
         if(param1 == 0)
         {
            this.FMC_SixFairyMan_Panel.visible = true;
            this.FMC_SixFairyMan_Class.UpdateManual();
         }
         else
         {
            this.FMC_SixFairy_Panel.visible = true;
            this.FMC_SixFairy_Class.UpdateManual();
         }
         this.PlayerEffect(param1);
      }
      
      public function UpdateManual(param1:int) : void
      {
         if(param1 == 0)
         {
            this.FMC_SixFairyMan_Class.UpdateManual();
         }
         else
         {
            this.FMC_SixFairy_Class.UpdateManual();
         }
      }
      
      public function BreakThroughFunF(param1:int) : void
      {
         if(this.FBreakThroughFun != null)
         {
            this.FBreakThroughFun(param1);
         }
      }
      
      public function GoldPracticehFunF(param1:int) : void
      {
         if(this.FGoldPracticehFun != null)
         {
            this.FGoldPracticehFun(param1);
         }
      }
      
      public function GotoSixFairyManFunF() : void
      {
         this.OpenPanelByIndex(0);
      }
      
      public function GotoPracticeFunF() : void
      {
         this.OpenPanelByIndex(1);
      }
      
      public function GetAwardFunF() : void
      {
         if(this.FGetAwardFun != null)
         {
            this.FGetAwardFun();
         }
      }
      
      public function FBtn_enterFunF(param1:int, param2:int) : void
      {
         if(this.FBtn_enterFun != null)
         {
            this.FBtn_enterFun(param1,param2);
         }
      }
      
      public function ForEffect(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
      
      public function set BreakThroughFun(param1:Function) : void
      {
         this.FBreakThroughFun = param1;
      }
      
      public function set GoldPracticehFun(param1:Function) : void
      {
         this.FGoldPracticehFun = param1;
      }
      
      public function set GetAwardFun(param1:Function) : void
      {
         this.FGetAwardFun = param1;
      }
      
      public function set SixFairyManChangeStatue(param1:Function) : void
      {
         this.FSixFairyManChangeStatue = param1;
      }
      
      public function set Btn_enterFun(param1:Function) : void
      {
         this.FBtn_enterFun = param1;
      }
      
      public function PlayerEffect(param1:int = 0) : void
      {
         if(param1)
         {
            MovieClip(this.FMC_SixFairy_Panel["MC_EffectLeft"]).gotoAndPlay(1);
            MovieClip(this.FMC_SixFairy_Panel["MC_EffectRight"]).gotoAndPlay(1);
         }
         else
         {
            MovieClip(this.FMC_SixFairy_Panel["MC_EffectLeft"]).gotoAndPlay(1);
            MovieClip(this.FMC_SixFairy_Panel["MC_EffectRight"]).gotoAndPlay(1);
         }
      }
   }
}

