package Processors.Game.Lobby.Recruit
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDrawNinjaArchive;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Recruit.Component.TUIWindowRecruitAlert;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowRecruit extends TProcessorLobbyWindow
   {
      
      protected var FMCScene:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FCurIndex:int;
      
      protected var FBTN_Archive:MovieClip;
      
      protected var FBTN_Draw:MovieClip;
      
      protected var FBTN_DrawTen:MovieClip;
      
      protected var FBTN_Perview:MovieClip;
      
      protected var FBTN_Mall:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FUIWindowRecruitAlert:TUIWindowRecruitAlert;
      
      protected var FConfigValue:TConfigValue;
      
      public var OnDrawNinjaReq:Function;
      
      public var OnOpenArchive:Function;
      
      public var OnOpenPerview:Function;
      
      public var OnOpenMall:Function;
      
      public var OnHelpHintOver:Function;
      
      public var OnHelpHintOut:Function;
      
      public function TProcessorWindowRecruit(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMCScene = TUtilityReflection.CreateDisplayObjectInstance("MC_Recruit") as MovieClip;
         addChild(this.FMCScene);
         this.FUIWindowRecruitAlert = new TUIWindowRecruitAlert();
         this.FUIWindowRecruitAlert.Resource = this.FMCScene["MC_alert"];
         this.FUIWindowRecruitAlert.OnDrawNinjaReq = this.OnDrawNinjaReq;
         this.FUIWindowRecruitAlert.Visible = false;
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMCScene.MC_Tab_0,0);
         this.FUITab.SetTabByIndex(this.FMCScene.MC_Tab_1,1);
         this.FUITab.OnSwitch = this.OnSwitchTab;
         this.FUITab.Init();
         this.FBTN_Draw = this.FMCScene.BTN_DrawOne;
         TGameUtil.setButtonMode(this.FBTN_Draw,true);
         this.FBTN_DrawTen = this.FMCScene.BTN_DrawTen;
         TGameUtil.setButtonMode(this.FBTN_DrawTen,true);
         this.FBTN_Archive = this.FMCScene.BTN_Archive;
         TGameUtil.setButtonMode(this.FBTN_Archive,true);
         this.FBTN_Perview = this.FMCScene.BTN_Perview;
         TGameUtil.setButtonMode(this.FBTN_Perview,true);
         this.FBTN_Mall = this.FMCScene.BTN_Mall;
         TGameUtil.setButtonMode(this.FBTN_Mall,true);
         this.FBTN_Close = this.FMCScene.BTN_Close;
         this.FBTN_Help = this.FMCScene.BTN_Help;
         this.FMCScene.x = FUICore.StageWidth - this.FMCScene.width >> 1;
         this.FMCScene.y = FUICore.StageHeight - this.FMCScene.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Draw.addEventListener(MouseEvent.CLICK,this.OnClickDraw);
         this.FBTN_DrawTen.addEventListener(MouseEvent.CLICK,this.OnClickDrawTen);
         this.FBTN_Archive.addEventListener(MouseEvent.CLICK,this.OnBtnArchiveClick);
         this.FBTN_Perview.addEventListener(MouseEvent.CLICK,this.OnBtnPerviewClick);
         this.FBTN_Mall.addEventListener(MouseEvent.CLICK,this.OnMCMallClick);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99400008) as TConfigValue;
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateUI(param1:Vector.<TDrawNinjaArchive>, param2:int, param3:int) : void
      {
         this.FUIWindowRecruitAlert.UpdateUI(param1,param2,param3);
         this.FUIWindowRecruitAlert.Visible = true;
      }
      
      public function SetTabShowOrHide(param1:Boolean) : void
      {
         if(param1)
         {
            this.FUITab.SetTabShowByIndex(1);
            this.FMCScene.TF_actTime.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,this.FConfigValue.Value.startTime,this.FConfigValue.Value.endTime);
         }
         else
         {
            this.FUITab.SetTabHideByIndex(1);
            this.FMCScene.TF_actTime.text = "";
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FUIWindowRecruitAlert.LogicsPerform();
      }
      
      protected function OnClickDraw(param1:MouseEvent) : void
      {
         if(this.OnDrawNinjaReq != null)
         {
            this.OnDrawNinjaReq(this.FCurIndex + 1,1);
         }
      }
      
      protected function OnClickDrawTen(param1:MouseEvent) : void
      {
         if(this.OnDrawNinjaReq != null)
         {
            this.OnDrawNinjaReq(this.FCurIndex + 1,10);
         }
      }
      
      protected function OnSwitchTab(param1:int) : void
      {
         this.FCurIndex = param1;
         TProcessorRecruit.RecruitType = this.FCurIndex + 1;
      }
      
      protected function OnBtnArchiveClick(param1:MouseEvent) : void
      {
         if(this.OnOpenArchive != null)
         {
            this.OnOpenArchive();
         }
      }
      
      protected function OnBtnPerviewClick(param1:MouseEvent) : void
      {
         if(this.OnOpenPerview != null)
         {
            this.OnOpenPerview();
         }
      }
      
      protected function OnMCMallClick(param1:MouseEvent) : void
      {
         if(this.OnOpenMall != null)
         {
            this.OnOpenMall();
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(this.OnHelpHintOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_DrawNinja);
            this.OnHelpHintOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.OnHelpHintOut != null)
         {
            this.OnHelpHintOut(this);
         }
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
   }
}

