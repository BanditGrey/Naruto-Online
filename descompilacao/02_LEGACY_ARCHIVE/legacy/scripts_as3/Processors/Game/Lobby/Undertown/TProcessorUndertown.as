package Processors.Game.Lobby.Undertown
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDungeonsBattle;
   import Logics.SLogicsCore;
   import Logics.Undertown.TDailyTaskRewardCopy;
   import Logics.Undertown.TUndertownPracticeListData;
   import Logics.Undertown.TUndertownRewardListData;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Lobby.Undertown.Panel.TProcessorUndertownFighting;
   import Processors.Game.Lobby.Undertown.Panel.TProcessorUndertownFightingLog;
   import Processors.Game.Lobby.Undertown.Panel.TProcessorUndertownPractice;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_MUSIC;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_Undertown;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorUndertown extends TProcessorLobbyWindows
   {
      
      protected var FProcessorUndertownFighting:TProcessorUndertownFighting;
      
      protected var FProcessorUndertownPractice:TProcessorUndertownPractice;
      
      protected var FProcessorUndertownFightingLog:TProcessorUndertownFightingLog;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationC:TUIWindowConfirmation;
      
      protected var FHint:THint;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var FSetBattlePacket:Function;
      
      protected var FTimeID:int;
      
      protected var F_Ci:int;
      
      public function TProcessorUndertown(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         this.FProcessorUndertownFighting = new TProcessorUndertownFighting(this);
         this.FProcessorUndertownFighting.MopUpBtnClickBack = this.MopUpBtnClickBack;
         this.FProcessorUndertownFighting.MC_ResetBtnClickBack = this.MC_ResetBtnClickBack;
         this.FProcessorUndertownFighting.TiaoZhanBackFunction = this.ChallengeBtnBackFunction;
         this.FProcessorUndertownFighting.C_S_GetPaiMing = this.C_S_GetPaiMing;
         this.FProcessorUndertownFighting.BackFunctionForTiaoZhanLog = this.BackFunctionForTiaoZhanLog;
         this.FProcessorUndertownFighting.BackFunctionForSeePracticeLise = this.BackFunctionForSeePracticeLise;
         this.FProcessorUndertownFighting.BackFunctionForOverPractice = this.BackFunctionForOverPractice;
         this.FProcessorUndertownFighting.CAO = ProcessorClose;
         this.FProcessorUndertownFighting.C_S_SaoDang = this.C_S_SaoDang;
         this.FProcessorUndertownFighting.GetRewardFunction = this.GetRewardFunction;
         this.FProcessorUndertownPractice = new TProcessorUndertownPractice(this);
         this.FProcessorUndertownPractice.GetRewardBtnBackFunction = this.GetRewardBtnBackFunction;
         this.FProcessorUndertownPractice.BackFunction = this.BackFunction;
         this.FProcessorUndertownPractice.OccupyBtnOnOver = this.ProcessorOccupyBtnOnOver;
         this.FProcessorUndertownPractice.OccupyBtnOnOut = this.ProcessorOccupyBtnOnOut;
         this.FProcessorUndertownPractice.BuyCountFunction = this.BuyCountFunction;
         this.FProcessorUndertownFightingLog = new TProcessorUndertownFightingLog(this);
         this.FHint = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_Undertown);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_Undertown.RESOURCE_SwfId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmation.OnOK = this.OnConfirmationOk;
         this.FUIWindowConfirmation.x = (FUICore.StageWidth - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (FUICore.StageHeight - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.x = (FUICore.StageWidth - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (FUICore.StageHeight - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         this.FUIWindowConfirmationCopy.SetCheckBox(true);
         this.FUIWindowConfirmationC = new TUIWindowConfirmation(Parent);
         this.FUIWindowConfirmationC.OnOK = this.OnConfirmationOkC;
         this.FUIWindowConfirmationC.x = (FUICore.StageWidth - this.FUIWindowConfirmationC.WindowWidth) / 2;
         this.FUIWindowConfirmationC.y = (FUICore.StageHeight - this.FUIWindowConfirmationC.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationC);
         this.FUIWindowConfirmationC.SetCheckBox(true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function BackFunctionForSeePracticeLise() : void
      {
         SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex = 1;
         this.OpenPanelByIndex();
      }
      
      protected function ProcessorOccupyBtnOnOver(param1:String) : void
      {
         this.FHint.Caption = param1;
         FOverlayerHint.Context = this.FHint;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function ProcessorOccupyBtnOnOut() : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function OpenPanelByIndex() : void
      {
         this.FProcessorUndertownFighting.visible = false;
         this.FProcessorUndertownPractice.visible = false;
         this.FProcessorUndertownFightingLog.visible = false;
         switch(SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex)
         {
            case 0:
               this.FProcessorUndertownFighting.Visible = true;
               this.FProcessorUndertownFighting.OpenThisPanel();
               break;
            case 1:
               this.FProcessorUndertownFighting.Visible = true;
               this.FProcessorUndertownPractice.visible = true;
               this.FProcessorUndertownPractice.OpenThisPanel();
               break;
            case 2:
               this.FProcessorUndertownFighting.Visible = true;
               this.FProcessorUndertownFightingLog.visible = true;
               this.FProcessorUndertownFightingLog.ReflashView();
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorUndertownFighting.Load();
            this.FProcessorUndertownPractice.Load();
            this.FProcessorUndertownFightingLog.Load();
            return;
         }
         this.EnterTheRoom();
         this.C_S_SuiGetReward();
         this.C_S_GetPractice();
         this.C_S_GetReward();
         this.C_S_SaoDang();
         this.MopUpBtnClickBackCopy();
         this.C_S_Initilization();
         this.OpenPanelByIndex();
         this.SetInterval();
      }
      
      protected function PACKETID_S2C_Dungeons_Enter_Room(param1:TPacket) : void
      {
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.OutOfTheRoom();
      }
      
      protected function PACKETID_S2C_Dungeons_Quit_Room(param1:TPacket) : void
      {
      }
      
      protected function C_S_GetReward() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_Practise_Info);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function C_S_GetPractice() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_DisciplineList);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BuyCountFunction() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Vector.<uint> = null;
         if(this.FUIWindowConfirmationCopy.IsSelected)
         {
            this.C_Sc();
         }
         else
         {
            _loc1_ = uint(SLogicsCore.UndertownLogicData.BuyCount);
            _loc2_ = SLogicsCore.UndertownLogicData.CountAndCost;
            if(_loc1_ <= 1)
            {
               _loc1_ = 0;
            }
            else
            {
               _loc1_--;
            }
            this.FUIWindowConfirmationCopy.Text = TUtilityString.Format(new ConsumeFrame(70270077).DescribeString,_loc2_[_loc1_]);
            this.FUIWindowConfirmationCopy.Visible = true;
         }
      }
      
      protected function OnConfirmationOkCopy(param1:Object) : void
      {
         this.C_Sc();
      }
      
      protected function C_Sc() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Buy_Tms);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BackFunction(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_Practise_Award);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.C_S_Initilization();
      }
      
      protected function BackFunctionForOverPractice() : void
      {
         var _loc1_:TUndertownPracticeListData = null;
         _loc1_ = SLogicsCore.UndertownLogicData.GetTUndertownPracticeListDataById64(SLogicsCore.Character.Identifier0,SLogicsCore.Character.Identifier1);
         if(_loc1_)
         {
            this.GetRewardBtnBackFunction(_loc1_.DungeonsPractiseData.Identifier,1);
         }
      }
      
      protected function GetRewardBtnBackFunction(param1:uint, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         this.F_Ci = param1;
         if(param2 == 1)
         {
            if(this.FUIWindowConfirmationC.IsSelected)
            {
               this.Ci();
            }
            else
            {
               this.FUIWindowConfirmationC.Text = new ConsumeFrame(70310001).DescribeString;
               this.FUIWindowConfirmationC.visible = true;
            }
            return;
         }
         switch(param2)
         {
            case 0:
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Occupation_Tower);
               break;
            case 1:
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Stop_Practise);
               break;
            case 2:
               _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_PVP_User);
         }
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnConfirmationOkC(param1:Object) : void
      {
         this.Ci();
      }
      
      protected function Ci() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Stop_Practise);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.F_Ci);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function GetRewardFunction(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_Ranking_Award);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function C_S_SaoDang() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_Clean);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BackFunctionForTiaoZhanLog() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_FightLog);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function C_S_SuiGetReward() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_Drop);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function C_S_Initilization() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_BaseInfo);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function C_S_GetPaiMing(param1:TDungeonsBattle) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_RankingList);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ChallengeBtnBackFunction() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_FightBoss);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.C_S_Initilization();
      }
      
      protected function MC_ResetBtnClickBack() : void
      {
         var _loc1_:Vector.<Object> = null;
         var _loc2_:uint = 0;
         if(this.FUIWindowConfirmation.IsSelected)
         {
            this.C_Ss();
         }
         else
         {
            _loc1_ = SLogicsCore.UndertownLogicData.Dungeons_Reset_Cost;
            _loc2_ = uint(SLogicsCore.UndertownLogicData.RestCount);
            if(_loc2_ <= 1)
            {
               _loc2_ = 0;
            }
            else
            {
               _loc2_--;
            }
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(70270076).DescribeString,_loc1_[_loc2_][1]);
            this.FUIWindowConfirmation.Visible = true;
         }
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.C_Ss();
      }
      
      protected function C_Ss() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Reset_Fight);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function MopUpBtnClickBackCopy() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Clean_End);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function MopUpBtnClickBack() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Auto_FightBoss);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         this.C_S_Initilization();
      }
      
      protected function EnterTheRoom() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Enter_Room);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OutOfTheRoom() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Quit_Room);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_BaseInfo,this.PACKETID_S2C_Dungeons_Get_BaseInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_DisciplineList,this.PACKETID_S2C_Dungeons_Get_DisciplineList);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_FightLog,this.PACKETID_S2C_Dungeons_Get_FightLog);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_RankingList,this.PACKETID_S2C_Dungeons_Get_RankingList);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_FightBoss,this.PACKETID_S2C_Dungeons_FightBoss);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Auto_FightBoss,this.PACKETID_S2C_Dungeons_Auto_FightBoss);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Reset_Fight,this.PACKETID_S2C_Dungeons_Reset_Fight);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Occupation_Tower,this.PACKETID_S2C_Dungeons_Occupation_Tower);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_Practise_Award,this.PACKETID_S2C_Dungeons_Get_Practise_Award);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_PVP_User,this.PACKETID_S2C_Dungeons_PVP_User);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Enter_Room,this.PACKETID_S2C_Dungeons_Enter_Room);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Quit_Room,this.PACKETID_S2C_Dungeons_Quit_Room);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_Practise_Info,this.PACKETID_S2C_Dungeons_Get_Practise_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Stop_Practise,this.PACKETID_S2C_Dungeons_Stop_Practise);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_Clean,this.PACKETID_S2C_Dungeons_Get_Clean);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Get_Drop,this.PACKETID_S2C_Dungeons_Get_Drop);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_Dungeons_Buy_Tms,this.PACKETID_S2C_Dungeons_Buy_Tms);
         super.PacketRegisterRoutines();
      }
      
      protected function PACKETID_S2C_Dungeons_Clean_End(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
      }
      
      protected function PACKETID_S2C_Dungeons_Buy_Tms(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         ++SLogicsCore.UndertownLogicData.BuyCount;
         this.FProcessorUndertownPractice.UpdateCount();
      }
      
      protected function PACKETID_S2C_Dungeons_Get_Drop(param1:TPacket) : void
      {
         this.FProcessorUndertownFighting.SuiJiReward(param1.Data);
      }
      
      protected function PACKETID_S2C_Dungeons_Get_Clean(param1:TPacket) : void
      {
         this.FProcessorUndertownFighting.SaoDangLog(param1.Data);
      }
      
      protected function PACKETID_S2C_Dungeons_Stop_Practise(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
      }
      
      protected function PACKETID_S2C_Dungeons_Get_Practise_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<TUndertownRewardListData> = null;
         var _loc8_:TUndertownRewardListData = null;
         var _loc9_:TDailyTaskRewardCopy = null;
         _loc2_ = param1.Data;
         _loc7_ = SLogicsCore.UndertownLogicData.UndertownRewardListDataVector;
         _loc7_.length = 0;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc8_ = new TUndertownRewardListData();
            _loc8_.DiaoLuoTime = _loc2_.readUnsignedInt();
            _loc8_.AllPracticeTime = _loc2_.readUnsignedInt();
            _loc8_.Type = _loc2_.readUnsignedByte();
            _loc8_.Name = TUtilityString.FetchUTF(_loc2_);
            _loc8_.AwardVect.length = 0;
            _loc5_ = _loc2_.readShort();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc9_ = new TDailyTaskRewardCopy();
               _loc9_.Type = _loc2_.readShort();
               _loc9_.Code = _loc2_.readUnsignedInt();
               _loc9_.Amount = _loc2_.readUnsignedInt();
               _loc8_.AwardVect.push(_loc9_);
               _loc6_++;
            }
            _loc7_.push(_loc8_);
            _loc4_++;
         }
         if(this.FProcessorUndertownPractice.Visible)
         {
            this.FProcessorUndertownPractice.UpdateTotalQuantity2();
            this.FProcessorUndertownPractice.UpdateRewardList();
         }
      }
      
      protected function PACKETID_S2C_Dungeons_PVP_User(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_UnderTown,CONST_MUSIC.ID_SCENE_Arena);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex = 1;
         ++SLogicsCore.UndertownLogicData.CostCount;
         this.FProcessorUndertownPractice.UpdateCount();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Undertown,SLogicsCore.UndertownLogicData.CheckLimitTimes());
      }
      
      protected function PACKETID_S2C_Dungeons_Get_Practise_Award(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FProcessorUndertownPractice.GetRewardBack();
      }
      
      protected function PACKETID_S2C_Dungeons_Occupation_Tower(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex = 1;
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_UnderTown,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         ++SLogicsCore.UndertownLogicData.CostCount;
         this.FProcessorUndertownPractice.UpdateCount();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Undertown,SLogicsCore.UndertownLogicData.CheckLimitTimes());
      }
      
      protected function PACKETID_S2C_Dungeons_Reset_Fight(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         SLogicsCore.UndertownLogicData.LastCustomsId = 0;
         ++SLogicsCore.UndertownLogicData.RestCount;
         this.FProcessorUndertownFighting.CueCurFream = 0;
         this.FProcessorUndertownFighting.VisibelByFream();
      }
      
      protected function PACKETID_S2C_Dungeons_Auto_FightBoss(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         this.FProcessorUndertownFighting.SaoDangBack(_loc2_);
      }
      
      protected function PACKETID_S2C_Dungeons_FightBoss(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         var _loc4_:int = int(_loc3_.readUnsignedInt());
         var _loc5_:int = int(_loc3_.readUnsignedInt());
         if(_loc5_)
         {
            this.FProcessorUndertownFighting.CueCurFream = 1;
         }
         else
         {
            this.FProcessorUndertownFighting.CueCurFream = 2;
         }
         if(this.FSetStatusType != null)
         {
            this.FSetStatusType(this,CONST_BATTLE.BattleType_UnderTown,0);
         }
         if(this.FOnInitBattle != null)
         {
            this.FOnInitBattle(this);
         }
         SLogicsCore.UndertownLogicData.LastCustomsId = _loc4_;
         if(!SLogicsCore.UndertownLogicData.HistoricHighsCustomsData)
         {
            SLogicsCore.UndertownLogicData.HistoricHighsCustomsId = _loc4_;
         }
         else if(_loc4_ > SLogicsCore.UndertownLogicData.HistoricHighsCustomsData.Identifier)
         {
            SLogicsCore.UndertownLogicData.HistoricHighsCustomsId = _loc4_;
         }
      }
      
      protected function PACKETID_S2C_Dungeons_Get_RankingList(param1:TPacket) : void
      {
         this.FProcessorUndertownFighting.S_C_GetPaiMing(param1.Data);
      }
      
      protected function PACKETID_S2C_Dungeons_Get_FightLog(param1:TPacket) : void
      {
         SLogicsCore.UndertownLogicData.NextWillOpenPanelIndex = 2;
         this.OpenPanelByIndex();
         this.FProcessorUndertownFightingLog.SetDataByStream(param1.Data);
      }
      
      protected function PACKETID_S2C_Dungeons_Get_DisciplineList(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TUndertownPracticeListData = null;
         _loc2_ = param1.Data;
         _loc4_ = _loc2_.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc2_.readUnsignedInt();
            _loc7_ = _loc2_.readUnsignedInt();
            _loc8_ = _loc2_.readUnsignedInt();
            _loc9_ = TUtilityString.FetchUTF(_loc2_);
            _loc10_ = _loc2_.readUnsignedInt();
            _loc11_ = _loc2_.readUnsignedInt();
            _loc12_ = _loc2_.readUnsignedInt();
            _loc13_ = SLogicsCore.UndertownLogicData.GetTUndertownPracticeListDataByLayer(_loc12_);
            _loc13_.Identifier0 = _loc6_;
            _loc13_.Identifier1 = _loc7_;
            _loc13_.PracticeEndTime = _loc8_;
            _loc13_.UserName = _loc9_;
            _loc13_.FirstOccupyProtectEndTime = _loc10_;
            _loc13_.AttackedProtectEndTime = _loc11_;
            _loc5_++;
         }
         if(this.FProcessorUndertownPractice.Visible)
         {
            this.FProcessorUndertownPractice.OpenThisPanel();
         }
         if(this.FProcessorUndertownFighting.Visible)
         {
            this.FProcessorUndertownFighting.UpdateMainRoleInformation();
         }
      }
      
      protected function PACKETID_S2C_Dungeons_Get_BaseInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         _loc2_ = param1.Data;
         SLogicsCore.UndertownLogicData.LastCustomsId = _loc2_.readUnsignedInt();
         SLogicsCore.UndertownLogicData.HistoricHighsCustomsId = _loc2_.readUnsignedInt();
         SLogicsCore.UndertownLogicData.RestCount = _loc2_.readUnsignedInt();
         SLogicsCore.UndertownLogicData.BuyCount = _loc2_.readUnsignedInt();
         SLogicsCore.UndertownLogicData.CostCount = _loc2_.readUnsignedInt();
         SLogicsCore.Character.AwakenGeneralsSoul = _loc2_.readUnsignedInt();
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Undertown,SLogicsCore.UndertownLogicData.CheckLimitTimes());
         if(FIsResourcesLoadCompleted)
         {
            this.OpenPanelByIndex();
         }
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function set SetBattlePacket(param1:Function) : void
      {
         this.FSetBattlePacket = param1;
      }
      
      public function get SetBattlePacket() : Function
      {
         return this.FSetBattlePacket;
      }
      
      protected function SetInterval() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         var _loc1_:Date = new Date(STimingCore.GetServerTime() * 1000);
         _loc1_.hours = 0;
         _loc1_.minutes = 0;
         _loc1_.seconds = 0;
         _loc3_ = _loc1_.getTime() + 24 * 60 * 60 * 1000 + 5000;
         _loc2_ = _loc3_ - STimingCore.GetServerTime() * 1000;
         this.FTimeID = setTimeout(this.C_S_Initilization,_loc2_);
      }
   }
}

