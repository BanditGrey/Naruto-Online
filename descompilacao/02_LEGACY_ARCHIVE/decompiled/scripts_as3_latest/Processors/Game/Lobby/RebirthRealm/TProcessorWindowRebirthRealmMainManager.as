package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_REBIRTHREALM;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowRebirthRealmMainManager extends TProcessorLobbyWindow
   {
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData = null;
      
      protected var FProcessorWindowRebirthRealmPanel:TProcessorWindowRebirthRealmPanel = null;
      
      protected var FProcessorWindowSixRebirthPanel:TProcessorWindowSixRebirthPanel = null;
      
      protected var FProcessorWindowCustomPanel:TProcessorWindowCustomPanel = null;
      
      protected var FProcessorWindowDestinyCoronaPanel:TProcessorWindowDestinyCoronaPanel = null;
      
      protected var FProcessorWindowEntryRebirthPanel:TProcessorWindowEntryRebirthPanel = null;
      
      protected var RebirthRealmPanelRoot:MovieClip = null;
      
      protected var SixRebirthPanelRoot:MovieClip = null;
      
      protected var CustomPanelPanelRoot:MovieClip = null;
      
      protected var DestinyCoronaPanelRoot:MovieClip = null;
      
      protected var EntryRebirthPanelRoot:MovieClip = null;
      
      protected var FBeginFun:Function;
      
      protected var FEndFun:Function;
      
      protected var FCloseFun:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOvut:Function;
      
      protected var FTurntableTipMove:Function;
      
      protected var FTurntableTipOut:Function;
      
      protected var FChanllge_Btn:Function;
      
      protected var FMC_GotoSixRebirthFun:Function;
      
      protected var FMC_GotoDestinyCoronaFun:Function;
      
      protected var FMC_GotoRebirthRealmFun:Function;
      
      protected var FAutoBtnClickBack:Function;
      
      protected var FBtnOverFunc:Function;
      
      protected var FBtnOutFunc:Function;
      
      protected var FBtnMoveFunc:Function;
      
      protected var FUpgradeBtn:Function;
      
      protected var FChallenge_BtnFun:Function;
      
      public function TProcessorWindowRebirthRealmMainManager(param1:TUIComponent, param2:TRebirthRealmBaseData)
      {
         super(param1);
         this.FRebirthRealmBaseData = param2;
         this.FProcessorWindowRebirthRealmPanel = new TProcessorWindowRebirthRealmPanel(param1,param2);
         this.FProcessorWindowRebirthRealmPanel.OnEffectText = this.ForEffect;
         this.FProcessorWindowRebirthRealmPanel.Challenge_BtnFun = this.Challenge_BtnFunClick;
         this.FProcessorWindowRebirthRealmPanel.MC_GotoSixRebirthFun = this.MC_GotoSixRebirthFunClick;
         this.FProcessorWindowRebirthRealmPanel.MC_GotoDestinyCoronaFun = this.MC_GotoDestinyCoronaFunClick;
         this.FProcessorWindowRebirthRealmPanel.AutoBtnClickBack = this.FAutoBtnClickBackH;
         this.FProcessorWindowRebirthRealmPanel.BtnOverFunc = this.AutoBtnOverFunc;
         this.FProcessorWindowRebirthRealmPanel.BtnOutFunc = this.AutoBtnOutFunc;
         this.FProcessorWindowRebirthRealmPanel.BtnMoveFunc = this.AutoBtnMoveFunc;
         this.FProcessorWindowRebirthRealmPanel.GotoEntryRebirthFun = this.CloseFunClick;
         this.FProcessorWindowSixRebirthPanel = new TProcessorWindowSixRebirthPanel(param1,param2);
         this.FProcessorWindowSixRebirthPanel.OnEffectText = this.ForEffect;
         this.FProcessorWindowSixRebirthPanel.UIComponentsHintOnOver = this.UIComponentsHintOnOverF;
         this.FProcessorWindowSixRebirthPanel.UIComponentsHintOnOut = this.UIComponentsHintOnOutF;
         this.FProcessorWindowSixRebirthPanel.UpgradeBtn = this.FUpgradeBtnF;
         this.FProcessorWindowCustomPanel = new TProcessorWindowCustomPanel(param1,param2);
         this.FProcessorWindowCustomPanel.OnEffectText = this.ForEffect;
         this.FProcessorWindowCustomPanel.Chanllge_Btn = this.Chanllge_BtnF;
         this.FProcessorWindowDestinyCoronaPanel = new TProcessorWindowDestinyCoronaPanel(param1,param2);
         this.FProcessorWindowDestinyCoronaPanel.OnEffectText = this.ForEffect;
         this.FProcessorWindowDestinyCoronaPanel.BeginFun = this.BeginFunF;
         this.FProcessorWindowDestinyCoronaPanel.EndFun = this.EndFunF;
         this.FProcessorWindowDestinyCoronaPanel.TurntableTipMove = this.TurntableTipMoveF;
         this.FProcessorWindowDestinyCoronaPanel.TurntableTipOut = this.TurntableTipOutF;
         this.FProcessorWindowEntryRebirthPanel = new TProcessorWindowEntryRebirthPanel(param1);
         this.FProcessorWindowEntryRebirthPanel.OnEffectText = this.ForEffect;
         this.FProcessorWindowEntryRebirthPanel.GotoRebirthRealmFun = this.MC_GotoRebirthRealmFunClick;
      }
      
      public function set TurntableTipMove(param1:Function) : void
      {
         this.FTurntableTipMove = param1;
      }
      
      public function set TurntableTipOut(param1:Function) : void
      {
         this.FTurntableTipOut = param1;
      }
      
      protected function TurntableTipMoveF() : void
      {
         if(this.FTurntableTipMove != null)
         {
            this.FTurntableTipMove();
         }
      }
      
      protected function TurntableTipOutF() : void
      {
         if(this.FTurntableTipOut != null)
         {
            this.FTurntableTipOut();
         }
      }
      
      public function ClosePanel() : void
      {
         this.FProcessorWindowCustomPanel.ClosePanel();
         this.FProcessorWindowDestinyCoronaPanel.ClosePanel();
         this.FProcessorWindowRebirthRealmPanel.ClosePanel();
         this.FProcessorWindowEntryRebirthPanel.ClosePanel();
         this.FProcessorWindowSixRebirthPanel.SlotReset();
      }
      
      public function UpdatePerform() : void
      {
         this.FProcessorWindowDestinyCoronaPanel.UpdatePerform();
         this.FProcessorWindowCustomPanel.UpdatePerform();
         this.FProcessorWindowSixRebirthPanel.UpdatePerform();
      }
      
      public function set Challenge_BtnFun(param1:Function) : void
      {
         this.FChallenge_BtnFun = param1;
      }
      
      public function Challenge_BtnFunClick(param1:int) : void
      {
         if(this.FChallenge_BtnFun != null)
         {
            this.FChallenge_BtnFun(param1);
         }
      }
      
      public function set Chanllge_Btn(param1:Function) : void
      {
         this.FChanllge_Btn = param1;
      }
      
      public function Chanllge_BtnF() : void
      {
         if(this.FChanllge_Btn != null)
         {
            this.FChanllge_Btn();
         }
      }
      
      public function ChangeWaitStatus() : void
      {
         this.FProcessorWindowCustomPanel.WaitReq = false;
      }
      
      public function set MC_GotoSixRebirthFun(param1:Function) : void
      {
         this.FMC_GotoSixRebirthFun = param1;
      }
      
      public function MC_GotoSixRebirthFunClick() : void
      {
         if(this.FMC_GotoSixRebirthFun != null)
         {
            this.FMC_GotoSixRebirthFun();
         }
      }
      
      public function set MC_GotoDestinyCoronaFun(param1:Function) : void
      {
         this.FMC_GotoDestinyCoronaFun = param1;
      }
      
      public function MC_GotoDestinyCoronaFunClick() : void
      {
         if(this.FMC_GotoDestinyCoronaFun != null)
         {
            this.FMC_GotoDestinyCoronaFun();
         }
      }
      
      public function set MC_GotoRebirthRealmFun(param1:Function) : void
      {
         this.FMC_GotoRebirthRealmFun = param1;
      }
      
      public function MC_GotoRebirthRealmFunClick(param1:int) : void
      {
         if(this.FMC_GotoRebirthRealmFun != null)
         {
            this.FMC_GotoRebirthRealmFun(param1);
         }
      }
      
      public function BeginFunF() : void
      {
         if(this.FBeginFun != null)
         {
            this.FBeginFun();
         }
      }
      
      public function EndFunF() : void
      {
         if(this.FEndFun != null)
         {
            this.FEndFun();
         }
      }
      
      public function CloseFunClick(param1:MouseEvent) : void
      {
         if(this.FCloseFun != null)
         {
            this.FCloseFun();
         }
      }
      
      public function CloseClick(param1:MouseEvent) : void
      {
         FOnClose();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_REBIRTHREALM.RebirthRealm_Resource);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.EntryRebirthPanelRoot = TUtilityReflection.CreateDisplayObjectInstance("EntryRebirth") as MovieClip;
         addChild(this.EntryRebirthPanelRoot);
         this.FProcessorWindowEntryRebirthPanel.SetThisPanel(this.EntryRebirthPanelRoot);
         this.EntryRebirthPanelRoot.x = (FUICore.StageWidth - this.EntryRebirthPanelRoot.width) / 2;
         this.EntryRebirthPanelRoot.y = (FUICore.StageHeight - this.EntryRebirthPanelRoot.height) / 2;
         this.RebirthRealmPanelRoot = TUtilityReflection.CreateDisplayObjectInstance("RebirthRealm") as MovieClip;
         addChild(this.RebirthRealmPanelRoot);
         this.FProcessorWindowRebirthRealmPanel.SetThisPanel(this.RebirthRealmPanelRoot);
         this.RebirthRealmPanelRoot.x = (FUICore.StageWidth - this.RebirthRealmPanelRoot.width) / 2;
         this.RebirthRealmPanelRoot.y = (FUICore.StageHeight - this.RebirthRealmPanelRoot.height) / 2;
         this.SixRebirthPanelRoot = TUtilityReflection.CreateDisplayObjectInstance("SixRebirth") as MovieClip;
         addChild(this.SixRebirthPanelRoot);
         this.FProcessorWindowSixRebirthPanel.SetThisPanel(this.SixRebirthPanelRoot);
         this.SixRebirthPanelRoot.x = (FUICore.StageWidth - this.SixRebirthPanelRoot.width) / 2;
         this.SixRebirthPanelRoot.y = (FUICore.StageHeight - this.SixRebirthPanelRoot.height) / 2;
         this.CustomPanelPanelRoot = TUtilityReflection.CreateDisplayObjectInstance("CustomPanel") as MovieClip;
         addChild(this.CustomPanelPanelRoot);
         this.FProcessorWindowCustomPanel.SetThisPanel(this.CustomPanelPanelRoot);
         this.CustomPanelPanelRoot.x = (FUICore.StageWidth - this.CustomPanelPanelRoot.width) / 2;
         this.CustomPanelPanelRoot.y = (FUICore.StageHeight - this.CustomPanelPanelRoot.height) / 2;
         this.DestinyCoronaPanelRoot = TUtilityReflection.CreateDisplayObjectInstance("DestinyCorona") as MovieClip;
         addChild(this.DestinyCoronaPanelRoot);
         this.FProcessorWindowDestinyCoronaPanel.SetThisPanel(this.DestinyCoronaPanelRoot);
         this.DestinyCoronaPanelRoot.x = (FUICore.StageWidth - this.DestinyCoronaPanelRoot.width) / 2;
         this.DestinyCoronaPanelRoot.y = (FUICore.StageHeight - this.DestinyCoronaPanelRoot.height) / 2;
         this.addEvent();
         super.ResourcesPerform_UIDispatch();
      }
      
      public function addEvent() : void
      {
         SimpleButton(this.RebirthRealmPanelRoot["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseClick);
         SimpleButton(this.EntryRebirthPanelRoot["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseClick);
         SimpleButton(this.SixRebirthPanelRoot["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseFunClick);
         SimpleButton(this.CustomPanelPanelRoot["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseFunClick);
         SimpleButton(this.DestinyCoronaPanelRoot["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseFunClick);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      public function OpenPanelByIndex(param1:int, param2:int = 0) : void
      {
         this.RebirthRealmPanelRoot.visible = false;
         this.SixRebirthPanelRoot.visible = false;
         this.CustomPanelPanelRoot.visible = false;
         this.DestinyCoronaPanelRoot.visible = false;
         this.EntryRebirthPanelRoot.visible = false;
         switch(param1)
         {
            case 0:
               this.EntryRebirthPanelRoot.visible = true;
               break;
            case 1:
               this.SixRebirthPanelRoot.visible = true;
               this.FProcessorWindowSixRebirthPanel.UpdateManual();
               break;
            case 2:
               this.CustomPanelPanelRoot.visible = true;
               this.FProcessorWindowCustomPanel.UpdateManual();
               break;
            case 3:
               this.DestinyCoronaPanelRoot.visible = true;
               this.FProcessorWindowDestinyCoronaPanel.UpdateManual();
               break;
            case 4:
               this.RebirthRealmPanelRoot.visible = true;
               this.FProcessorWindowRebirthRealmPanel.CurPage = param2;
               this.FProcessorWindowRebirthRealmPanel.UpdateManual();
         }
      }
      
      public function RebirthRealmPanelUpdateManual() : void
      {
         this.FProcessorWindowRebirthRealmPanel.UpdateManual();
      }
      
      public function DestinyCoronaPanelUpdateManual() : void
      {
         this.FProcessorWindowDestinyCoronaPanel.UpdateManual();
      }
      
      public function CustomPanelUpdateManual() : void
      {
         this.FProcessorWindowCustomPanel.UpdateManual();
      }
      
      public function SixRebirthPanelUpdateManual() : void
      {
         this.FProcessorWindowSixRebirthPanel.UpdateManual();
      }
      
      public function ForEffect(param1:Object, param2:String, param3:TEffectTextParameters = null, param4:TEffectCoordinateParameters = null) : void
      {
         EffectGenerateText(param2);
      }
      
      public function PointerTurntableStart(param1:int) : void
      {
         this.FProcessorWindowDestinyCoronaPanel.PointerTurntableStart(param1);
      }
      
      public function set BeginFun(param1:Function) : void
      {
         this.FBeginFun = param1;
      }
      
      public function set EndFun(param1:Function) : void
      {
         this.FEndFun = param1;
      }
      
      public function set CloseFun(param1:Function) : void
      {
         this.FCloseFun = param1;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOvut = param1;
      }
      
      public function set UpgradeBtn(param1:Function) : void
      {
         this.FUpgradeBtn = param1;
      }
      
      protected function FUpgradeBtnF() : void
      {
         if(this.FUpgradeBtn != null)
         {
            this.FUpgradeBtn();
         }
      }
      
      protected function UIComponentsHintOnOverF(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOutF(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOvut != null)
         {
            this.FUIComponentsHintOnOvut(param1,param2);
         }
      }
      
      protected function FAutoBtnClickBackH(param1:int) : void
      {
         if(this.FAutoBtnClickBack != null)
         {
            this.FAutoBtnClickBack(param1);
         }
      }
      
      protected function AutoBtnOverFunc(param1:int) : void
      {
         if(this.FBtnOverFunc != null)
         {
            this.FBtnOverFunc(param1);
         }
      }
      
      protected function AutoBtnOutFunc() : void
      {
         if(this.FBtnOutFunc != null)
         {
            this.FBtnOutFunc();
         }
      }
      
      protected function AutoBtnMoveFunc() : void
      {
         if(this.FBtnMoveFunc != null)
         {
            this.FBtnMoveFunc();
         }
      }
      
      public function set BtnOverFunc(param1:Function) : void
      {
         this.FBtnOverFunc = param1;
      }
      
      public function set BtnOutFunc(param1:Function) : void
      {
         this.FBtnOutFunc = param1;
      }
      
      public function set BtnMoveFunc(param1:Function) : void
      {
         this.FBtnMoveFunc = param1;
      }
      
      public function set AutoBtnClickBack(param1:Function) : void
      {
         this.FAutoBtnClickBack = param1;
      }
      
      public function UpdateAutoBtnState() : void
      {
         this.FProcessorWindowRebirthRealmPanel.UpdateManual();
         this.FProcessorWindowRebirthRealmPanel.UpdateThreeAutoBtn();
      }
   }
}

