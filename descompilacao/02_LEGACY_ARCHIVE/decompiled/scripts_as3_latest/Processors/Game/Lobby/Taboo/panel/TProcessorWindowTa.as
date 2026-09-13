package Processors.Game.Lobby.Taboo.panel
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TTabooBattleConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.TSevenGunaQia;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TABOO;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTa extends TProcessorLobbyWindow
   {
      
      public static const SEVEN:int = 7;
      
      protected var MainPanel:Sprite = null;
      
      protected var FBtn_Close:SimpleButton = null;
      
      protected var FMC_HelpBtn:SimpleButton = null;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_GoTo_Taboo:MovieClip = null;
      
      protected var FMC_ResetBtn:MovieClip = null;
      
      protected var FTF_Fight_Times:TextField = null;
      
      protected var FSevenVec:Vector.<TSevenGunaQia> = new Vector.<TSevenGunaQia>(SEVEN);
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FHpelhint:THint = new THint();
      
      protected var FGoTo_TabooFun:Function = null;
      
      protected var FAddTimesCS:Function;
      
      protected var FClosThisPanel:Function = null;
      
      protected var FSevenScreenClick:Function = null;
      
      public function TProcessorWindowTa(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TABOO.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MC_Ta) as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FBtn_Close = this.MainPanel["Btn_Close"];
         this.FMC_HelpBtn = this.MainPanel["MC_HelpBtn"];
         this.FMC_GoTo_Taboo = this.MainPanel["MC_GoTo_Taboo"];
         this.FMC_ResetBtn = this.MainPanel["MC_ResetBtn"];
         this.FTF_Fight_Times = this.MainPanel["TF_Fight_Times"];
         TGameUtil.setButtonMode(this.FMC_GoTo_Taboo,true);
         var _loc2_:TSevenGunaQia = null;
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            _loc2_ = new TSevenGunaQia();
            _loc2_.ThisPanelClick = this.ScreenClick;
            _loc2_.ThisPanelOver = this.ScreenOver;
            _loc2_.ThisPanelOut = this.ScreenOut;
            _loc2_.ThisPanelMove = this.ScreenMove;
            _loc2_.SetPanel(this.MainPanel["MC_Seven_" + _loc1_],_loc1_ + 1);
            this.FSevenVec[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBins = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.MoClick);
         this.FMC_GoTo_Taboo.addEventListener(MouseEvent.CLICK,this.MoClick);
         this.FMC_ResetBtn.addEventListener(MouseEvent.CLICK,this.MoClick);
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TabooBattleConfig);
         var _loc3_:TTabooBattleConfig = null;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.Count)
         {
            _loc3_ = _loc2_.GetDatebaseByIndex(_loc1_) as TTabooBattleConfig;
            this.FSevenVec[_loc1_].ConfigInformation = _loc3_;
            _loc1_++;
         }
         new Tools_Help(this,this.MainPanel["Btn_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_TABOO_ChridlePanel,FUICore);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ScreenOver(param1:String) : void
      {
         this.FHpelhint.Content = param1;
         this.FOverlayerHelpTips.Context = this.FHpelhint;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function ScreenOut() : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function ScreenMove() : void
      {
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
      }
      
      override protected function LogicsPerform() : void
      {
         if(this.FIsInilization)
         {
         }
         super.LogicsPerform();
      }
      
      public function OpenThisPanel() : void
      {
         var _loc1_:int = 0;
         if(!this.FIsInilization)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            this.FSevenVec[_loc1_].UpdateInforMation();
            _loc1_++;
         }
         this.FTF_Fight_Times.text = SLogicsCore.TBooData.ChallengeSurplusCount.toString();
         if(SLogicsCore.TBooData.ChallengeSurplusCount > 0)
         {
            TGameUtil.setButtonMode(this.FMC_ResetBtn,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_ResetBtn,true);
         }
         SLogicsCore.KaguyaData.C_S_Privilege(10);
      }
      
      public function UpdateRestCount() : void
      {
      }
      
      public function set ClosThisPanel(param1:Function) : void
      {
         this.FClosThisPanel = param1;
      }
      
      protected function MoClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_GoTo_Taboo:
               this.visible = false;
               if(this.FGoTo_TabooFun != null)
               {
                  this.FGoTo_TabooFun();
               }
               break;
            case this.FBtn_Close:
               this.FClosThisPanel();
               break;
            case this.FMC_ResetBtn:
               if(this.FAddTimesCS != null && this.FMC_ResetBtn.buttonMode)
               {
                  this.FAddTimesCS();
               }
         }
      }
      
      protected function ScreenClick(param1:int, param2:TTabooBattleConfig) : void
      {
         this.FSevenScreenClick(param1,param2);
      }
      
      public function set SevenScreenClick(param1:Function) : void
      {
         this.FSevenScreenClick = param1;
      }
      
      public function set GoTo_TabooFun(param1:Function) : void
      {
         this.FGoTo_TabooFun = param1;
      }
      
      public function set AddTimesCS(param1:Function) : void
      {
         this.FAddTimesCS = param1;
      }
   }
}

