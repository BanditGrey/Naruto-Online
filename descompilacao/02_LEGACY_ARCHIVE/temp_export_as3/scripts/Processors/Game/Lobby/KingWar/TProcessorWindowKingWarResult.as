package Processors.Game.Lobby.KingWar
{
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Kingwar.TPVPKingBet;
   import Logics.Kingwar.TPVPKingPlayer;
   import Logics.Kingwar.TPVPKingPlayers;
   import Logics.Kingwar.TPVPKingReport;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_KINGWAR;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowKingWarResult extends TProcessorLobbyWindow
   {
      
      protected static const TOP_Catory:Array = [32,16,8,4,2,1];
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FUISubTabs:Vector.<TUITab>;
      
      protected var FMainPanel:MovieClip;
      
      protected var FBTN_betting:MovieClip;
      
      protected var FBTN_Deployment:MovieClip;
      
      protected var FTabIndex:int = -1;
      
      protected var FTabSubIndex:int = -1;
      
      protected var FProcessorWindowKingwarReport:TProcessorWindowKingwarReport;
      
      protected var FProcessorWindowKingwarBetting:TProcessorWindowkingwarBetting;
      
      protected var FPVPKingPlayers:TPVPKingPlayers;
      
      public var onSubmitDeployment:Function;
      
      public function TProcessorWindowKingWarResult(param1:TUIComponent)
      {
         super(param1);
         this.FUITab = new TUITab(this);
         this.FUISubTabs = new Vector.<TUITab>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_KINGWAR.RESOURCESID_KingWar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc4_:int = 0;
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_KINGWAR.RESOURCE_ClassName_KingwarResult) as MovieClip;
         addChild(this.FMainPanel);
         this.FProcessorWindowKingwarReport = new TProcessorWindowKingwarReport(this,this.FMainPanel["fightReport"]);
         this.FProcessorWindowKingwarReport.ReportInfoFun = this.FetchReportInfo;
         this.FProcessorWindowKingwarBetting = new TProcessorWindowkingwarBetting(this,this.FMainPanel["MC_Betting"]);
         this.FBTN_Close = this.FMainPanel[CONST_KINGWAR.RESOURCE_Link_Btn_Close];
         this.FBTN_Help = this.FMainPanel[CONST_KINGWAR.RESOURCE_Link_Btn_Help];
         var _loc3_:int = 0;
         while(_loc3_ < CONST_KINGWAR.CAPACITY_MC_Tabs)
         {
            _loc1_ = this.FMainPanel[CONST_KINGWAR.RESOURCES_MC_Tab_ + _loc3_];
            this.FUITab.SetTabByIndex(_loc1_,_loc3_);
            this.FUISubTabs[_loc3_] = new TUITab(this);
            _loc4_ = 0;
            while(_loc4_ < CONST_KINGWAR.CAPACITY_MC_SubTabs)
            {
               _loc2_ = _loc1_[CONST_KINGWAR.RESOURCES_MC_SubTab_ + _loc4_];
               this.FUISubTabs[_loc3_].SetTabByIndex(_loc2_,_loc4_);
               _loc4_++;
            }
            this.FUISubTabs[_loc3_].OnSwitch = this.OnSubTabChange;
            this.FUISubTabs[_loc3_].Init();
            _loc3_++;
         }
         this.FUITab.TabIndex = 1;
         this.FUITab.OnSwitch = this.OnTabChange;
         this.FUITab.SwithTagManual(0);
         this.FUITab.Init();
         this.FBTN_betting = this.FMainPanel[CONST_KINGWAR.RESOURCE_Btn_Betting];
         TGameUtil.setButtonMode(this.FBTN_betting,true);
         this.FBTN_Deployment = this.FMainPanel[CONST_KINGWAR.RESOURCE_Btn_Deployment];
         TGameUtil.setButtonMode(this.FBTN_Deployment,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.onBtnClose);
         this.FBTN_betting.addEventListener(MouseEvent.CLICK,this.onClickBetting);
         this.FBTN_Deployment.addEventListener(MouseEvent.CLICK,this.onClickDeployment);
         super.ResourcesPerform_UILocations();
      }
      
      public function PerformPacket_CS_KingWar_Top32_Req() : void
      {
         var _loc2_:TPacket = null;
         var _loc1_:int = this.FTabIndex << 1 | this.FTabSubIndex;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_KingWar_Top32_Req);
         _loc2_.Data.writeInt(6 - _loc1_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function updateUI(param1:TPVPKingPlayers) : void
      {
         this.Reset();
         this.FPVPKingPlayers = param1;
         if(this.FPVPKingPlayers)
         {
            this.updatePVPKingPlayers();
         }
      }
      
      protected function FetchReportInfo(param1:TPVPKingPlayer, param2:TPVPKingReport) : Object
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:TPVPKingPlayer = null;
         if(this.FPVPKingPlayers)
         {
            for each(_loc6_ in this.FPVPKingPlayers.PVPKingTop32)
            {
               if(_loc6_.AgentId == param2.Ack_Agent_Id && _loc6_.ServerId == param2.Ack_Server_Id && _loc6_.Uid == param2.Ack_UserID)
               {
                  _loc4_ = _loc6_.Name;
               }
               if(_loc6_.AgentId == param2.Def_Agent_Id && _loc6_.ServerId == param2.Def_Server_Id && _loc6_.Uid == param2.Def_UserID)
               {
                  _loc5_ = _loc6_.Name;
               }
            }
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
      
      protected function updatePVPKingPlayers() : void
      {
         var i:int = 0;
         var j:int = 0;
         var Top:int = 0;
         var MC_Player:MovieClip = null;
         var PvpKingPlayers:Vector.<TPVPKingPlayer> = null;
         var PvpKingPlayer:TPVPKingPlayer = null;
         i = 0;
         while(i < TOP_Catory.length)
         {
            Top = int(TOP_Catory[i]);
            try
            {
               PvpKingPlayers = this.FPVPKingPlayers["PVPKingTop" + Top];
               j = 0;
               while(j < PvpKingPlayers.length)
               {
                  PvpKingPlayer = PvpKingPlayers[j];
                  MC_Player = this.FMainPanel["MC_Player_" + i + "_" + PvpKingPlayer.Pos];
                  MC_Player.addEventListener(MouseEvent.CLICK,this.OnMCClick);
                  MC_Player["TF_PlayerName"].text = PvpKingPlayer.Name;
                  MC_Player.gotoAndStop(this.JudgePvpKingPlayerIsWin(PvpKingPlayer,PvpKingPlayers) ? 1 : 2);
                  if(i != 4)
                  {
                     this.FMainPanel["MC_line_" + i + "_" + PvpKingPlayer.Pos].visible = PvpKingPlayer.Rank > i;
                  }
                  j++;
               }
            }
            catch(e:Error)
            {
               PvpKingPlayer = FPVPKingPlayers["PVPKingTop" + Top];
               FMainPanel["TF_PlayerName"].text = PvpKingPlayer ? PvpKingPlayer.Name : "";
            }
            i++;
         }
      }
      
      protected function OnTabChange(param1:int) : void
      {
         if(this.FTabIndex == param1)
         {
            return;
         }
         this.FTabIndex = param1;
         this.FTabSubIndex = -1;
         this.FUISubTabs[param1].TabIndex = 1;
         this.FUISubTabs[param1].Reset();
      }
      
      protected function OnSubTabChange(param1:int) : void
      {
         if(this.FTabSubIndex == param1)
         {
            return;
         }
         this.FTabSubIndex = param1;
         this.PerformPacket_CS_KingWar_Top32_Req();
      }
      
      protected function onClickDeployment(param1:MouseEvent) : void
      {
         if(this.onSubmitDeployment != null)
         {
            this.onSubmitDeployment();
         }
      }
      
      protected function OnMCClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TPVPKingPlayer = null;
         var _loc7_:Vector.<TPVPKingPlayer> = null;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         _loc2_ = 0;
         for(; _loc2_ < TOP_Catory.length; _loc2_++)
         {
            _loc4_ = int(TOP_Catory[_loc2_]);
            if(_loc8_)
            {
               break;
            }
            if("PVPKingTop" + _loc4_ in this.FPVPKingPlayers)
            {
               try
               {
                  _loc7_ = this.FPVPKingPlayers["PVPKingTop" + _loc4_];
                  _loc3_ = 0;
                  while(_loc3_ < _loc7_.length)
                  {
                     _loc6_ = _loc7_[_loc3_];
                     _loc5_ = this.FMainPanel["MC_Player_" + _loc2_ + "_" + _loc6_.Pos];
                     if(_loc5_ == param1.currentTarget)
                     {
                        _loc8_ = true;
                        _loc9_ = _loc2_ + 3;
                        break;
                     }
                     _loc3_++;
                  }
               }
               catch(error:Error)
               {
                  continue;
               }
            }
         }
         if(_loc8_)
         {
            this.FProcessorWindowKingwarReport.Visible = true;
            this.FProcessorWindowKingwarReport.SetFightReport(_loc6_,_loc9_);
         }
      }
      
      protected function onClickBetting(param1:MouseEvent) : void
      {
         var i:int = 0;
         var Top:int = 0;
         var PvpKingPlayers:Vector.<TPVPKingPlayer> = null;
         var NextPvpKingPlayers:Vector.<TPVPKingPlayer> = null;
         var pvpKingPlayer:TPVPKingPlayer = null;
         var IsFind:Boolean = false;
         var e:MouseEvent = param1;
         if(this.FPVPKingPlayers == null)
         {
            return;
         }
         i = 1;
         for(; i < TOP_Catory.length - 1; i++)
         {
            Top = int(TOP_Catory[i]);
            PvpKingPlayers = this.FPVPKingPlayers["PVPKingTop" + Top];
            if(Boolean(PvpKingPlayers) && PvpKingPlayers.length > 0)
            {
               Top = int(TOP_Catory[i + 1]);
               try
               {
                  NextPvpKingPlayers = this.FPVPKingPlayers["PVPKingTop" + Top];
                  if(Boolean(NextPvpKingPlayers) && Boolean(NextPvpKingPlayers.length == 0) || NextPvpKingPlayers == null)
                  {
                     IsFind = true;
                     break;
                  }
               }
               catch(error:Error)
               {
                  pvpKingPlayer = FPVPKingPlayers["PVPKingTop" + Top];
                  if(pvpKingPlayer == null)
                  {
                     IsFind = true;
                     break;
                  }
                  continue;
               }
            }
         }
         if(IsFind)
         {
            this.FProcessorWindowKingwarBetting.Visible = true;
            this.FProcessorWindowKingwarBetting.SetBetInfo(PvpKingPlayers);
         }
      }
      
      protected function onBtnClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.FMainPanel["TF_PlayerName"].text = "";
         _loc1_ = 0;
         while(_loc1_ < TOP_Catory.length)
         {
            if(_loc1_ > 4)
            {
               break;
            }
            _loc3_ = int(TOP_Catory[_loc1_]);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FMainPanel["MC_Player_" + _loc1_ + "_" + _loc2_];
               _loc4_["TF_PlayerName"].text = "";
               _loc4_.gotoAndStop(1);
               if(_loc1_ != 4)
               {
                  this.FMainPanel["MC_line_" + _loc1_ + "_" + _loc2_].visible = false;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function JudgePvpKingPlayerIsWin(param1:TPVPKingPlayer, param2:Vector.<TPVPKingPlayer>) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = true;
         _loc4_ = param1.Pos % 2 == 0 ? int(param1.Pos + 1) : int(param1.Pos - 1);
         if(param2)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               if(param2[_loc3_].Pos == _loc4_)
               {
                  if(param1.Rank < param2[_loc3_].Rank)
                  {
                     _loc5_ = false;
                  }
               }
               _loc3_++;
            }
         }
         return _loc5_;
      }
      
      public function set PVPKingBets(param1:Vector.<TPVPKingBet>) : void
      {
         this.FProcessorWindowKingwarBetting.PVPKingBets = param1;
      }
   }
}

