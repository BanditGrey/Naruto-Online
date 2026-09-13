package Processors.Game.Lobby.SummonBattle
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Streamization.SummonBattle.TUnstreamizerSummonBattle;
   import Logics.SummonBattle.TSummonBattleData;
   import Logics.SummonBattle.TSummonBattleReport;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.SummonBattle.Cell.TSummonBattleItem;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_ARENA;
   import Resources.Strings.STRING_TOPTEAM;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class TProcessorSummonBattle extends TProcessorLobbyPlate
   {
      
      protected static const REPORT_MAX:uint = 5;
      
      protected static const PAGE_NUM:uint = 9;
      
      protected var FMainPanel:MovieClip;
      
      protected var FCurPageIndex:int = 1;
      
      protected var FUIPage:TUIPage;
      
      protected var FTF_Page:TextField;
      
      protected var BTN_Shop:MovieClip;
      
      protected var BTN_Page:MovieClip;
      
      protected var BTN_Myself:MovieClip;
      
      protected var FSummonItemList:Array;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FHint:THint;
      
      protected var GroupValue:Vector.<Object>;
      
      protected var MyFieldId:int;
      
      protected var FWindowSummonBattle:TWindowSummonBattle;
      
      protected var FProcessorSummonBattleMall:TProcessorSummonBattleMall;
      
      protected var FUIWindowInformation:TUIWindowInformationNew;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FOnReturnMainScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnSetChatOptions:Function;
      
      protected var FUnstreamizerSumonBattle:TUnstreamizerSummonBattle;
      
      public function TProcessorSummonBattle(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FWindowSummonBattle = new TWindowSummonBattle(param1);
         this.FWindowSummonBattle.OnClickFun = this.PerformPacket_CS_SummonBattle_Occupy;
         this.FWindowSummonBattle.OnOpenInforWindon = this.OnOpenInformationWindon;
         this.FWindowSummonBattle.OncalcAgentNumFunc = this.CalculatSameAgentNumByAgentId;
         this.FUIWindowInformation = new TUIWindowInformationNew(param1);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (FUICore.StageWidth - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (FUICore.StageHeight - this.FUIWindowInformation.WindowHeight) / 2;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(param1);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (FUICore.StageWidth - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (FUICore.StageHeight - this.FUIWindowConfirmation.WindowHeight) / 2;
         this.FProcessorSummonBattleMall = new TProcessorSummonBattleMall(param1);
         this.FProcessorSummonBattleMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FUnstreamizerSumonBattle = new TUnstreamizerSummonBattle();
         this.FSummonItemList = new Array();
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4060086276);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TSummonBattleItem = null;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_SummonBattle") as MovieClip;
         addChild(this.FMainPanel);
         _loc1_ = 1;
         while(_loc1_ <= 9)
         {
            _loc2_ = new TSummonBattleItem(this.FMainPanel["MC_Field_" + _loc1_]);
            this.FSummonItemList.push(_loc2_);
            _loc2_.OnClickOccupy = this.OnOpenSumonPanel;
            _loc1_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonNext.Substrate = this.FMainPanel["BTN_Next"];
         this.FUIPage.ButtonPrevious.Substrate = this.FMainPanel["BTN_Prev"];
         this.FUIPage.OnChangePage = this.OnChangePage;
         this.FUIPage.PageSize = PAGE_NUM;
         this.FUIPage.TotalQuantity = PAGE_NUM * this.TotalSumonCount;
         this.FUIPage.Init();
         this.FUIPage.Update();
         this.BTN_Page = this.FMainPanel["Btn_Page"];
         TGameUtil.setButtonMode(this.BTN_Page,true);
         this.FTF_Page = this.FMainPanel["TF_Page"];
         this.FTF_Page.restrict = "0-9";
         this.BTN_Shop = this.FMainPanel["BTN_Shop"];
         TGameUtil.setButtonMode(this.BTN_Shop,true);
         this.BTN_Myself = this.FMainPanel["BTN_Myself"];
         TGameUtil.setButtonMode(this.BTN_Myself,true);
         TUtilityUIWindow.SetupWindowInformationNew(this.FUIWindowInformation);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         this.FMainPanel.BTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick);
         this.BTN_Page.addEventListener(MouseEvent.CLICK,this.OnTurntoPage);
         this.FTF_Page.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FMainPanel.BTN_Help.addEventListener(MouseEvent.MOUSE_OVER,this.OnHelpButtonOver);
         this.FMainPanel.BTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnHelpButtonOut);
         this.BTN_Shop.addEventListener(MouseEvent.CLICK,this.OnBTNShopClick);
         this.BTN_Myself.addEventListener(MouseEvent.CLICK,this.OngotoMeClick);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99000005) as TConfigValue;
         this.FWindowSummonBattle.BaseUnitValue = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99000006) as TConfigValue;
         this.FWindowSummonBattle.AddRateValue = _loc1_.Value as Vector.<Object>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99000002) as TConfigValue;
         this.GroupValue = _loc1_.Value as Vector.<Object>;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUI(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSummonBattleItem = null;
         _loc2_ = 0;
         while(_loc2_ < this.FUnstreamizerSumonBattle.SummonBattleDatas.length)
         {
            _loc3_ = this.FSummonItemList[_loc2_] as TSummonBattleItem;
            _loc3_.UpData(this.FUnstreamizerSumonBattle.SummonBattleDatas[_loc2_]);
            _loc2_++;
         }
         this.FMainPanel["TF_Score"].text = this.FProcessorSummonBattleMall.FPointId = param1.readInt();
         this.MyFieldId = param1.readInt();
         this.BTN_Myself.visible = this.MyFieldId > 0;
         this.FProcessorSummonBattleMall.UpdateNinjaPointUI();
      }
      
      protected function UpdateSumonReportInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:TSummonBattleReport = null;
         var _loc4_:Vector.<TSummonBattleReport> = null;
         _loc4_ = this.FUnstreamizerSumonBattle.SummonBattleReports;
         _loc1_ = 0;
         while(_loc1_ < REPORT_MAX)
         {
            _loc2_ = this.FMainPanel["MC_Report"]["TF_Report_" + _loc1_];
            if(_loc1_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc1_];
               _loc2_.htmlText = this.MakeHtmlTextInfo(_loc3_);
            }
            else
            {
               _loc2_.htmlText = "";
            }
            _loc1_++;
         }
      }
      
      protected function MakeHtmlTextInfo(param1:TSummonBattleReport) : String
      {
         var _loc2_:String = null;
         _loc2_ = STRING_ARENA.ARENA_Report_BFight;
         if(param1.IsWin)
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Lost;
         }
         else
         {
            _loc2_ += STRING_ARENA.ARENA_Report_Win;
         }
         _loc2_ = _loc2_.split("%when%").join(this.GetReportWhen(param1.When));
         return _loc2_.split("%who%").join(param1.PlayerNick);
      }
      
      protected function GetReportWhen(param1:uint) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:Date = null;
         var _loc6_:Date = null;
         _loc2_ = "";
         _loc3_ = STimingCore.GetServerTick() - param1;
         _loc4_ = _loc3_ / (24 * 60 * 60);
         if(_loc4_ < 7)
         {
            _loc5_ = new Date(STimingCore.GetServerTime() * 1000);
            _loc6_ = new Date(STimingCore.GetClientShowTime(param1) * 1000);
            if(_loc5_.day == _loc6_.day)
            {
               _loc2_ = STRING_ARENA.ARENA_Report_WhenVect[_loc4_];
            }
            else
            {
               _loc2_ = STRING_ARENA.ARENA_Report_WhenVect[_loc4_ + 1];
            }
         }
         else
         {
            _loc2_ = STRING_ARENA.ARENA_Report_WhenVect[STRING_ARENA.ARENA_Report_WhenVect.length - 1];
         }
         return _loc2_;
      }
      
      protected function CalculatSameAgentNumByAgentId(param1:int) : int
      {
         var _loc3_:TSummonBattleData = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(this.FUnstreamizerSumonBattle)
         {
            _loc4_ = 0;
            while(_loc4_ < this.FUnstreamizerSumonBattle.SummonBattleDatas.length)
            {
               _loc3_ = this.FUnstreamizerSumonBattle.SummonBattleDatas[_loc4_];
               if(_loc3_.AgentId == param1 && param1 != 0 || this.CheckSameGroupByAgentId(param1,_loc3_.AgentId))
               {
                  _loc2_++;
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      protected function CheckSameGroupByAgentId(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         _loc3_ = 0;
         while(_loc3_ < this.GroupValue.length)
         {
            _loc4_ = this.GroupValue[_loc3_] as Array;
            if(_loc4_.indexOf(param1) != -1)
            {
               if(_loc4_.indexOf(param2) != -1)
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function UpdatePageLabel() : void
      {
         this.FTF_Page.text = String(this.FCurPageIndex);
      }
      
      protected function get TotalSumonCount() : int
      {
         var _loc1_:TBins = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SummonBattle);
         return _loc1_.Count;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SummonBattle_Field_Ret,this.PerformPacket_SC_SummonBattle_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SummonBattle_Occupy_Ret,this.PerformPacket_SC_SummonBattle_Occupy);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SummonBattle_Finish_Ret,this.PerformPacket_SC_SummonBattle_Finish);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_SummonBattle_Buy_Ret,this.PerformPacket_SC_SummonBattle_Buy);
      }
      
      protected function PerformPacket_SC_SummonBattle_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerSumonBattle.Unstreamize(_loc2_,null,null);
         this.UpdateUI(_loc2_);
         this.UpdateSumonReportInfo();
      }
      
      protected function PerformPacket_SC_SummonBattle_Occupy(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = int(_loc2_.readUnsignedInt());
         this.PerformPacket_CS_SummonBattle_Info(this.FCurPageIndex);
         this.FWindowSummonBattle.OnHideClick(null);
         if(_loc6_ == 1)
         {
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_SummonBattle,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
      }
      
      protected function PerformPacket_SC_SummonBattle_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.PerformPacket_CS_SummonBattle_Info(this.FCurPageIndex);
      }
      
      protected function PerformPacket_SC_SummonBattle_Finish(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc5_:String = null;
         _loc2_ = param1.Data;
         var _loc3_:String = TGameUtil.fomatTime_NoDay(_loc2_.readUnsignedInt());
         var _loc4_:uint = _loc2_.readUnsignedInt();
         if(this.FUIWindowInformation)
         {
            _loc5_ = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_SummmonBattle_01);
            _loc5_ = _loc5_.replace(/\\n/g,"\n");
            this.FUIWindowInformation.SetHtml = TUtilityString.Format(_loc5_,_loc3_,_loc4_);
            this.FUIWindowInformation.Visible = true;
         }
         this.PerformPacket_CS_SummonBattle_Info(this.FCurPageIndex);
      }
      
      protected function PerformPacket_SC_SummonBattle_Buy(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.PerformPacket_CS_SummonBattle_Info(this.FCurPageIndex);
         EffectGenerateText(STRING_TOPTEAM.STRING_ChargeSuccess);
      }
      
      protected function PerformPacket_CS_SummonBattle_Info(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SummonBattle_Field_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_SummonBattle_Occupy(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SummonBattle_Occupy_Req);
         _loc4_.Data.writeInt(param3);
         _loc4_.Data.writeInt(param1);
         _loc4_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_CS_SummonBattle_Finish() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SummonBattle_Finish_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnMallBuy(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SummonBattle_Buy_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         this.FCurPageIndex = param2 + 1;
         this.PerformPacket_CS_SummonBattle_Info(this.FCurPageIndex);
         this.UpdatePageLabel();
      }
      
      protected function OnOpenSumonPanel(param1:TSummonBattleItem) : void
      {
         if(this.FWindowSummonBattle)
         {
            this.FWindowSummonBattle.SetDate(param1.SummonBattleData);
            this.FWindowSummonBattle.Visible = true;
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         this.FWindowSummonBattle.OnHideClick(null);
      }
      
      protected function OnOpenInformationWindon() : void
      {
         if(this.FUIWindowConfirmation)
         {
            this.FUIWindowConfirmation.SetHtml = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_SummmonBattle_02);
            this.FUIWindowConfirmation.Visible = true;
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         this.PerformPacket_CS_SummonBattle_Finish();
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         this.FCurPageIndex = int(this.FTF_Page.text);
         if(this.FCurPageIndex > this.FUIPage.TotalPage)
         {
            this.FCurPageIndex = this.FUIPage.TotalPage;
         }
         if(this.FCurPageIndex < 1)
         {
            this.FCurPageIndex = 1;
         }
         this.UpdatePageLabel();
      }
      
      protected function OngotoMeClick(param1:MouseEvent) : void
      {
         this.FUIPage.PageIndex = this.MyFieldId - 1;
         this.OnChangePage(null,this.FUIPage.PageIndex);
      }
      
      protected function OnBTNShopClick(param1:MouseEvent) : void
      {
         this.FProcessorSummonBattleMall.Visible = true;
         this.FProcessorSummonBattleMall.Update();
      }
      
      protected function OnTurntoPage(param1:MouseEvent) : void
      {
         this.FUIPage.PageIndex = int(this.FTF_Page.text) - 1;
         this.OnChangePage(null,this.FUIPage.PageIndex);
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         if(this.FOnReturnMainScene != null)
         {
            this.FOnReturnMainScene(this);
         }
      }
      
      protected function OnHelpButtonOver(param1:MouseEvent) : void
      {
         this.FHint.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_SummmonBattle);
         this.FOverlayerHelpTips.Context = this.FHint;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function OnHelpButtonOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      public function set OnReturnMainScene(param1:Function) : void
      {
         this.FOnReturnMainScene = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnSetChatOptions(param1:Function) : void
      {
         this.FOnSetChatOptions = param1;
      }
      
      override protected function LogicsPerform() : void
      {
         this.FWindowSummonBattle.UpdateTime();
         super.LogicsPerform();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FWindowSummonBattle.Load();
            this.FProcessorSummonBattleMall.Load();
            return;
         }
         this.PerformPacket_CS_SummonBattle_Info(this.FCurPageIndex);
         setTimeout(this.CloseChat,50);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,true);
         }
      }
      
      protected function CloseChat() : void
      {
         if(this.FOnSetChatOptions != null)
         {
            this.FOnSetChatOptions(this,false);
         }
      }
   }
}

