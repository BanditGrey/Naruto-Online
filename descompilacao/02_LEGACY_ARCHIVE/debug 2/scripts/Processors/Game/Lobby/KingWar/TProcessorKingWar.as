package Processors.Game.Lobby.KingWar
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Kingwar.TPVPKingBet;
   import Logics.Kingwar.TPVPKingPlayer;
   import Logics.Kingwar.TPVPKingPlayers;
   import Logics.Kingwar.TPVPKingReport;
   import Logics.Streamization.Kingwar.TUnstreamizerKingwar;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_KINGWAR;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_TOPTEAM;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorKingWar extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowKingWarResult:TProcessorWindowKingWarResult;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMCScene:MovieClip;
      
      protected var FBTN_SignUp:MovieClip;
      
      protected var FBTN_Enter:MovieClip;
      
      protected var FMC_Result:MovieClip;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FBTN_Report:MovieClip;
      
      protected var FProcessorWindowKingwarReport:TProcessorWindowKingwarReport;
      
      protected var FProcessorWindowKingWarMall:TProcessorKingwarMall;
      
      protected var FBTN_Mall:MovieClip;
      
      protected var FUnstreamizerKingwar:TUnstreamizerKingwar;
      
      protected var FSelfPVPKingPlayer:TPVPKingPlayer;
      
      protected var FPVPKingPlayers:TPVPKingPlayers;
      
      protected var FPVPKingBets:Vector.<TPVPKingBet>;
      
      protected var FUseCount:int;
      
      protected var FTotalCnt:int;
      
      public function TProcessorKingWar(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowKingWarResult = new TProcessorWindowKingWarResult(param1);
         this.FProcessorWindowKingWarResult.onSubmitDeployment = this.onSubmitDeployment;
         this.FProcessorWindowKingWarMall = new TProcessorKingwarMall(param1);
         this.FProcessorWindowKingWarMall.OnMallBuy = this.ProcessorOnMallBuy;
         this.FProcessorWindowKingWarMall.SlotOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowKingWarMall.SlotOnOut = UIComponentsHintOnOut;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(param1);
         this.FUIWindowConfirmation.OnOK = this.ConfirmationOnOk;
         this.FUIWindowConfirmation.x = (FUICore.stage.stageWidth - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (FUICore.stage.stageHeight - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         this.FUnstreamizerKingwar = new TUnstreamizerKingwar();
         this.FPVPKingPlayers = new TPVPKingPlayers();
         this.FSelfPVPKingPlayer = new TPVPKingPlayer();
         this.FPVPKingBets = new Vector.<TPVPKingBet>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_KINGWAR.RESOURCESID_KingWar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         super.ResourcesPerform_UIDispatch();
         this.FMCScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_KINGWAR.RESOURCE_ClassName_KingWar) as MovieClip;
         addChild(this.FMCScene);
         this.FProcessorWindowKingwarReport = new TProcessorWindowKingwarReport(this,this.FMCScene["fightReport"]);
         this.FProcessorWindowKingwarReport.ReportInfoFun = this.FetchReportInfo;
         this.FBTN_Close = this.FMCScene[CONST_KINGWAR.RESOURCE_Link_Btn_Close];
         this.FBTN_SignUp = this.FMCScene[CONST_KINGWAR.RESOURCE_Link_Btn_SignUp];
         TGameUtil.setButtonMode(this.FBTN_SignUp,true);
         this.FBTN_Enter = this.FMCScene[CONST_KINGWAR.RESOURCE_Link_Btn_Enter];
         this.FMC_Result = this.FMCScene.MC_Result;
         this.FMC_Result.gotoAndStop(4);
         this.FBTN_Report = this.FMCScene.Btn_Report;
         TGameUtil.setButtonMode(this.FBTN_Report,true);
         this.FBTN_Mall = this.FMCScene.BTN_Mall;
         TGameUtil.setButtonMode(this.FBTN_Mall,true);
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.x = FUICore.stage.stageWidth - this.width >> 1;
         this.y = FUICore.stage.stageHeight - this.height >> 1;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KingBattle) as TConfigValue;
         this.FTotalCnt = _loc1_.Value as int;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.onBtnClose);
         this.FBTN_SignUp.addEventListener(MouseEvent.CLICK,this.onSignUpHandle);
         this.FBTN_Enter.addEventListener(MouseEvent.CLICK,this.onClickBtnEnter);
         this.FBTN_Report.addEventListener(MouseEvent.CLICK,this.onReportClick);
         this.FBTN_Mall.addEventListener(MouseEvent.CLICK,this.onMallBtnClick);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_KingWar_Apply_Ret,this.PerformPacket_SC_KingWar_ApplyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_KingWar_Top32_Ret,this.PerformPacket_SC_KingWar_Top32Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_KingWar_Bet_Ret,this.PerformPacket_SC_KingWar_Bet_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_KingWar_Buy_Ret,this.PerformPacket_SC_KingWar_Buy_Ret);
      }
      
      protected function PerformPacket_SC_KingWar_Top32Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0 && this.Visible == false)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerKingwar.UnstreamizationPVPKingPlayer(_loc2_,this.FSelfPVPKingPlayer,null);
         this.FUseCount = _loc2_.readUnsignedInt();
         this.FPVPKingPlayers.Clear();
         this.FUnstreamizerKingwar.Unstreamize(_loc2_,this.FPVPKingPlayers,null);
         this.FProcessorWindowKingWarResult.updateUI(this.FPVPKingPlayers);
         this.FUnstreamizerKingwar.UnstreamizationPVPKingBet(_loc2_,this.FPVPKingBets,null);
         this.FProcessorWindowKingWarResult.PVPKingBets = this.FPVPKingBets;
         this.UpdateUI();
      }
      
      protected function PerformPacket_SC_KingWar_Bet_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TSystemLanguage = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_Kingwar_03) as TSystemLanguage;
         EffectGenerateText(_loc4_.Desc);
         this.FProcessorWindowKingWarResult.PerformPacket_CS_KingWar_Top32_Req();
      }
      
      protected function PerformPacket_SC_KingWar_Buy_Ret(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FProcessorWindowKingWarMall.UpdateNinjaPointUI();
         EffectGenerateText(STRING_TOPTEAM.STRING_ChargeSuccess);
      }
      
      protected function UpdateUI() : void
      {
         if(this.FSelfPVPKingPlayer.Group == 0)
         {
            this.FMC_Result.gotoAndStop(4);
         }
         else if(this.FSelfPVPKingPlayer.Group == 10)
         {
            this.FMC_Result.gotoAndStop(1);
         }
         else if(this.FSelfPVPKingPlayer.Group % 2 == 1)
         {
            this.FMC_Result.gotoAndStop(2);
         }
         else if(this.FSelfPVPKingPlayer.Group % 2 == 0)
         {
            this.FMC_Result.gotoAndStop(3);
         }
         this.UpdateBTN_SignUp();
      }
      
      protected function PerformPacket_SC_KingWar_ApplyRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TSystemLanguage = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_Kingwar_04) as TSystemLanguage;
         EffectGenerateText(_loc4_.Desc);
         this.FProcessorWindowKingWarResult.PerformPacket_CS_KingWar_Top32_Req();
      }
      
      protected function onSignUpHandle(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_Kingwar_01) as TSystemLanguage;
         this.FUIWindowConfirmation.Text = _loc2_.Desc;
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function onSubmitDeployment() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         var _loc3_:int = 0;
         _loc3_ = this.FTotalCnt - this.FUseCount;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.STRING_Kingwar_02) as TSystemLanguage;
         this.FUIWindowConfirmation.Text = TUtilityString.Format(_loc1_.Desc,_loc3_);
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function onClickBtnEnter(param1:MouseEvent) : void
      {
         this.FProcessorWindowKingWarResult.Visible = true;
         ProcessorClose();
      }
      
      protected function onReportClick(param1:MouseEvent) : void
      {
         this.FProcessorWindowKingwarReport.Visible = true;
         this.FProcessorWindowKingwarReport.SetFightReport(this.FSelfPVPKingPlayer);
      }
      
      protected function onMallBtnClick(param1:MouseEvent) : void
      {
         this.FProcessorWindowKingWarMall.Visible = true;
         this.FProcessorWindowKingWarMall.Update();
      }
      
      protected function onBtnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ConfirmationOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_KingWar_Apply_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnMallBuy(param1:Object, param2:uint, param3:uint) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_KingWar_Buy_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param3);
         _loc5_.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowKingWarResult.Load();
            this.FUIWindowConfirmation.Load();
            this.FProcessorWindowKingWarMall.Load();
            return;
         }
         this.FMCScene.visible = true;
         this.FProcessorWindowKingWarResult.PerformPacket_CS_KingWar_Top32_Req();
         this.UpdateEntrystatus();
      }
      
      public function ProcessorCheckEffect() : void
      {
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_KingWar,this.CheckSignUpEnable());
      }
      
      protected function FetchReportInfo(param1:TPVPKingPlayer, param2:TPVPKingReport) : Object
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:TPVPKingReport = null;
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param1.PVPKingReports.Count)
         {
            _loc6_ = param1.PVPKingReports.GetPVPKingReportByIndex(_loc7_);
            if(_loc6_.Ack_Agent_Id == param2.Ack_Agent_Id && _loc6_.Ack_Server_Id == param2.Ack_Server_Id && _loc6_.Ack_UserID == param2.Ack_UserID)
            {
               _loc4_ = _loc6_.Ack_Name;
            }
            if(_loc6_.Def_Agent_Id == param2.Def_Agent_Id && _loc6_.Def_Server_Id == param2.Def_Server_Id && _loc6_.Def_UserID == param2.Def_UserID)
            {
               _loc5_ = _loc6_.Def_Name;
            }
            _loc7_++;
         }
         _loc3_ = param2.IsWin;
         if(param1.Uid == param2.Ack_UserID)
         {
            _loc3_ = 1 - param2.IsWin;
         }
         return {
            "AckName":_loc4_,
            "DefName":_loc5_,
            "IsWin":_loc3_
         };
      }
      
      protected function UpdateBTN_SignUp() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.CheckSignUpEnable();
         TGameUtil.setButtonMode(this.FBTN_SignUp,_loc1_);
         this.FBTN_SignUp.mouseEnabled = _loc1_;
      }
      
      protected function UpdateEntrystatus() : void
      {
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         var _loc2_:Number = _loc1_.getDate();
         var _loc3_:Number = _loc1_.getHours();
         var _loc4_:Number = _loc1_.getMinutes();
         if(_loc2_ >= 1 && _loc2_ <= 4 || _loc2_ >= 16 && _loc2_ <= 19)
         {
            TGameUtil.setButtonMode(this.FBTN_Enter,false);
            this.FBTN_Enter.mouseEnabled = false;
            if(_loc2_ == 4 || _loc2_ == 19)
            {
               if(_loc3_ * 60 + _loc4_ > 17 * 60)
               {
                  TGameUtil.setButtonMode(this.FBTN_Enter,true);
                  this.FBTN_Enter.mouseEnabled = true;
               }
            }
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Enter,true);
            this.FBTN_Enter.mouseEnabled = true;
         }
      }
      
      protected function CheckSignUpEnable() : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         var _loc2_:Number = _loc1_.getDate();
         var _loc3_:Number = _loc1_.getHours();
         var _loc4_:Number = _loc1_.getMinutes();
         if(_loc2_ >= 1 && _loc2_ <= 2 || _loc2_ >= 16 && _loc2_ <= 17)
         {
            if(this.FSelfPVPKingPlayer.Uid == 0 || isNaN(this.FSelfPVPKingPlayer.Uid))
            {
               _loc5_ = true;
            }
            if(_loc2_ == 2 || _loc2_ == 17)
            {
               if(_loc3_ * 60 + _loc4_ > 17 * 60)
               {
                  _loc5_ = false;
               }
            }
         }
         return _loc5_;
      }
   }
}

