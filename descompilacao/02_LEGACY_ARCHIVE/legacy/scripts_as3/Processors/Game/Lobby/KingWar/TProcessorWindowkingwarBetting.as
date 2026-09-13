package Processors.Game.Lobby.KingWar
{
   import Components.Pages.TUIPage;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Kingwar.TPVPKingBet;
   import Logics.Kingwar.TPVPKingPlayer;
   import Resources.Constants.CONST_KINGWAR;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowkingwarBetting extends TUIComponent
   {
      
      protected static const Page_Max:uint = 6;
      
      protected var FScene:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_Page:TUIPage;
      
      protected var FPageIndex:uint;
      
      protected var FPVPKingPlayers:Vector.<TPVPKingPlayer>;
      
      protected var FPVPKingBets:Vector.<TPVPKingBet>;
      
      public function TProcessorWindowkingwarBetting(param1:TUIComponent, param2:MovieClip)
      {
         super(param1);
         this.FScene = param2;
         addChild(param2);
         this.Visible = false;
         this.init();
      }
      
      protected function init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FMC_Page = new TUIPage(this);
         this.FMC_Page.ButtonPrevious.Substrate = this.FScene.Btn_Left;
         this.FMC_Page.ButtonNext.Substrate = this.FScene.Btn_Right;
         this.FMC_Page.LabelPage = this.FScene.TF_Page;
         this.FMC_Page.PageSize = Page_Max;
         this.FMC_Page.Init();
         this.FMC_Page.OnChangePage = this.OnChangePage;
         this.FBTN_Close = this.FScene[CONST_KINGWAR.RESOURCE_Link_Btn_Close];
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseBtnClick);
         _loc1_ = 0;
         while(_loc1_ < Page_Max)
         {
            _loc2_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Betting + _loc1_] as MovieClip;
            _loc2_.TF_Money.restrict = "0-9";
            TGameUtil.setButtonMode(_loc2_.Btn_betting,true);
            _loc2_.Btn_betting.addEventListener(MouseEvent.CLICK,this.OnClkBetHandle);
            _loc1_++;
         }
      }
      
      public function SetBetInfo(param1:Vector.<TPVPKingPlayer>) : void
      {
         this.FPVPKingPlayers = param1;
         this.FMC_Page.TotalQuantity = this.FPVPKingPlayers.length;
         this.FMC_Page.Update();
         this.UpdatePageByIndex();
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.UpdatePageByIndex();
      }
      
      protected function UpdatePageByIndex() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TPVPKingPlayer = null;
         var _loc4_:MovieClip = null;
         if(this.FPVPKingPlayers)
         {
            _loc1_ = 0;
            while(_loc1_ < Page_Max)
            {
               _loc4_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Betting + _loc1_] as MovieClip;
               _loc4_.visible = true;
               _loc2_ = this.FPageIndex * Page_Max + _loc1_;
               if(_loc2_ < this.FPVPKingPlayers.length)
               {
                  _loc3_ = this.FPVPKingPlayers[_loc2_];
                  _loc4_.TF_Player.text = _loc3_.Name;
                  _loc4_.TF_Money.text = "0";
                  this.updatePvpKingBet(_loc3_,_loc4_);
               }
               else
               {
                  _loc4_.visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      protected function updatePvpKingBet(param1:TPVPKingPlayer, param2:MovieClip) : void
      {
         var _loc3_:TPVPKingBet = null;
         TGameUtil.setButtonMode(param2.Btn_betting,true);
         if(this.FPVPKingBets)
         {
            for each(_loc3_ in this.FPVPKingBets)
            {
               if(param1.AgentId == _loc3_.AgentId && param1.ServerId == _loc3_.ServerId && param1.Uid == _loc3_.Uid)
               {
                  param2.TF_Money.text = _loc3_.BetNum;
                  TGameUtil.setButtonMode(param2.Btn_betting,false);
                  param2.Btn_betting.mouseEnabled = false;
                  break;
               }
               TGameUtil.setButtonMode(param2.Btn_betting,true);
               param2.Btn_betting.mouseEnabled = true;
            }
         }
      }
      
      protected function OnClkBetHandle(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TPVPKingPlayer = null;
         _loc2_ = 0;
         while(_loc2_ < Page_Max)
         {
            _loc4_ = this.FScene[CONST_KINGWAR.RESOURCE_MC_Betting + _loc2_] as MovieClip;
            if(_loc4_.Btn_betting == param1.currentTarget)
            {
               _loc3_ = this.FPageIndex * Page_Max + _loc2_;
               _loc5_ = this.FPVPKingPlayers[_loc3_];
               this.PerformPacket_SC_KingWar_Bet_Req(_loc5_.AgentId,_loc5_.ServerId,_loc5_.Uid,1,_loc4_.TF_Money.text);
               break;
            }
            _loc2_++;
         }
      }
      
      protected function PerformPacket_SC_KingWar_Bet_Req(param1:int, param2:int, param3:Number, param4:int, param5:int) : void
      {
         var _loc6_:TPacket = null;
         _loc6_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_KingWar_Bet_Req);
         _loc6_.Data.writeUnsignedInt(param1);
         _loc6_.Data.writeUnsignedInt(param2);
         _loc6_.Data.writeDouble(param3);
         _loc6_.Data.writeUnsignedInt(param4);
         _loc6_.Data.writeUnsignedInt(param5);
         SNetworkCore.Transceiver.PacketTransmit(_loc6_);
      }
      
      protected function OnCloseBtnClick(param1:MouseEvent) : void
      {
         this.Visible = false;
         this.FMC_Page.Reset();
         this.FPageIndex = 0;
      }
      
      public function set PVPKingBets(param1:Vector.<TPVPKingBet>) : void
      {
         this.FPVPKingBets = param1;
         this.UpdatePageByIndex();
      }
   }
}

