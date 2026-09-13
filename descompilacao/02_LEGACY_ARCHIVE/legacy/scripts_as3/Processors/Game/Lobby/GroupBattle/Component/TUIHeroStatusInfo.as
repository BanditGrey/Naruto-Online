package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.GroupBattle.TRoomDetailInfo;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_GROUPBATTLE;
   import Resources.Strings.STRING_TOPTEAM;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIHeroStatusInfo extends TProcessorUIResourceTemplate
   {
      
      protected var FMC_Master:Sprite;
      
      protected var FTF_Name:TextField;
      
      protected var FMC_Role:MovieClip;
      
      protected var FMC_Status:MovieClip;
      
      protected var FTF_Status:TextField;
      
      protected var FTF_FightPower:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FActive:TActive;
      
      protected var FRoomDetailInfo:TRoomDetailInfo;
      
      protected var FReadyOnClick:Function;
      
      public function TUIHeroStatusInfo(param1:TUIComponent)
      {
         super(param1);
         this.FRoomDetailInfo = SLogicsCore.GroupBattleData.RoomDetailInfo;
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Parent.Visible)
         {
            return;
         }
         if(this.FActive != null)
         {
            this.FActive.UpdateActive();
         }
         super.LogicsPerform();
      }
      
      override protected function UIDispatch() : void
      {
         this.FMC_Master = FResource["MC_Master"];
         this.FTF_Name = FResource["MC_Name"]["TF_Name"];
         this.FMC_Status = FResource["MC_Status"];
         this.FTF_Status = this.FMC_Status["TF_Status"];
         this.FTF_FightPower = FResource["TF_FightPower"];
         this.FTF_Level = FResource["TF_Level"];
         this.FMC_Role = FResource["MC_Role"];
      }
      
      override protected function UILocations() : void
      {
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TRoomPlayer = null;
         Reset();
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TRoomPlayer;
         this.FMC_Master.visible = this.FRoomDetailInfo.HostIndex == FTag;
         this.FMC_Status.gotoAndStop((_loc1_.IsReady + 1) % 2 + 1);
         this.FTF_Name.text = _loc1_.PlayerName;
         this.FTF_FightPower.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_FightPower,_loc1_.FightPower.ToString());
         this.UpdateActive(_loc1_);
      }
      
      protected function UpdateActive(param1:TRoomPlayer) : void
      {
         if(this.FActive == null)
         {
            this.FActive = TPoolRole.GetActive(this,param1.PlayerModelID,CONST_MODULES.MODULE_GroupBattle,true,false);
         }
         else
         {
            this.FActive.ResetActive(this,param1.PlayerModelID,CONST_MODULES.MODULE_GroupBattle,true,false);
         }
         this.FMC_Role.addChild(this.FActive);
      }
      
      protected function UpdateTopTeamUI() : void
      {
         var _loc1_:TRoomPlayer = null;
         Reset();
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TRoomPlayer;
         this.FMC_Master.visible = Boolean(_loc1_.IsCaptaian);
         this.FMC_Status.gotoAndStop((_loc1_.IsReady + 1) % 2 + 1);
         this.FTF_Name.text = _loc1_.PlayerName;
         this.FTF_FightPower.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_FightPower,_loc1_.FightPower.ToString());
         this.FTF_Level.text = TUtilityString.Format(STRING_TOPTEAM.FORMAT_Level,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc1_.PlayerLevel));
         this.UpdateActive(_loc1_);
      }
      
      protected function MCStatusOnClick(param1:MouseEvent) : void
      {
         if(this.FReadyOnClick != null)
         {
            this.FReadyOnClick(this,CONST_GROUPBATTLE.RoomOperateReq_Ready);
         }
      }
      
      public function set ReadyOnClick(param1:Function) : void
      {
         this.FReadyOnClick = param1;
      }
      
      public function UpdateTopTeamInfo() : void
      {
         this.UpdateTopTeamUI();
      }
   }
}

