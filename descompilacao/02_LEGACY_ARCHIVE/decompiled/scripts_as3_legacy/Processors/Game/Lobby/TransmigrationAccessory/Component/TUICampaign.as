package Processors.Game.Lobby.TransmigrationAccessory.Component
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNewornament_battle;
   import Logics.DatebaseVO.VO.TNewornament_config;
   import Logics.SLogicsCore;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TRANSMIGRATIONACCESSORY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUICampaign
   {
      
      protected var FScene:MovieClip;
      
      protected var FAccessoryCampaign:TAccessoryCampaign;
      
      protected var FCanResetCount:uint;
      
      protected var FActive:TActive;
      
      protected var FImageId:uint;
      
      protected var FLastResetTimes:uint;
      
      protected var FResetCost:uint;
      
      protected var FGotoStage:Function;
      
      protected var FShowConfirmation:Function;
      
      public function TUICampaign(param1:MovieClip, param2:uint)
      {
         super();
         this.FScene = param1;
         TGameUtil.setButtonMode(this.FScene["btn_AutoBattle"],true);
         TGameUtil.setButtonMode(this.FScene["btn_Reset"],true);
         TGameUtil.setButtonMode(this.FScene["btn_Campaign"],true);
         this.FScene["btn_AutoBattle"].addEventListener(MouseEvent.CLICK,this.OnAutoBattle);
         this.FScene["btn_Reset"].addEventListener(MouseEvent.CLICK,this.OnResetBattle);
         this.FScene["btn_Campaign"].addEventListener(MouseEvent.CLICK,this.OnEnterBattle);
         this.FActive = TPoolRole.GetActive(null,12101001,CONST_MODULES.MODULE_TransmigrationAccessory,false,false);
         this.FScene["mc_bg"]["mc_Image"].addChild(this.FActive);
         this.FScene["mc_bg"].gotoAndStop(param2 + 1);
      }
      
      protected function OnAutoBattle(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationAccessory_AutoFight_Req);
         _loc2_.Data.writeUnsignedInt(this.FAccessoryCampaign.CampaignId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnResetBattle(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FShowConfirmation != null)
         {
            this.FShowConfirmation(this,this.FLastResetTimes,this.FResetCost,this.FAccessoryCampaign.CampaignId);
         }
      }
      
      protected function OnEnterBattle(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FGotoStage != null)
         {
            this.FGotoStage(this,this.FAccessoryCampaign);
         }
      }
      
      public function get GotoStage() : Function
      {
         return this.FGotoStage;
      }
      
      public function set GotoStage(param1:Function) : void
      {
         this.FGotoStage = param1;
      }
      
      public function get ShowConfirmation() : Function
      {
         return this.FShowConfirmation;
      }
      
      public function set ShowConfirmation(param1:Function) : void
      {
         this.FShowConfirmation = param1;
      }
      
      public function SetData(param1:TAccessoryCampaign) : void
      {
         this.FAccessoryCampaign = param1;
         this.Update();
      }
      
      public function Update() : void
      {
         var _loc1_:TNewornament_config = null;
         var _loc2_:TNewornament_battle = null;
         var _loc3_:uint = 0;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_config,this.FAccessoryCampaign.CampaignId) as TNewornament_config;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_battle,this.FAccessoryCampaign.CurStageId) as TNewornament_battle;
         this.FImageId = _loc1_.PicID;
         this.FActive.ResetActive(null,this.FImageId,CONST_MODULES.MODULE_TransmigrationAccessory,false,false);
         this.FScene["mc_bg"]["mc_Image"].addChild(this.FActive);
         _loc3_ = this.FAccessoryCampaign.TodayResetTimes;
         if(_loc3_ >= _loc1_.ReplayCostVect.length)
         {
            _loc3_ = _loc1_.ReplayCostVect.length - 1;
         }
         this.FResetCost = _loc1_.ReplayCostVect[_loc3_][1];
         this.FLastResetTimes = Math.max(this.FCanResetCount - this.FAccessoryCampaign.TodayResetTimes,0);
         this.FScene["tf_OpenLevel"].text = TUtilityString.Format(STRING_TRANSMIGRATIONACCESSORY.STRING_OPENLEVEL,_loc1_.CampaignName,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc1_.OpenLevel));
         this.FScene["tf_Step"].text = (_loc2_ ? _loc2_.SStageID : 0) + "/" + _loc1_.CampaignCount;
         this.FScene["tf_ResetTimes"].text = this.FLastResetTimes + "/" + this.FCanResetCount;
         TGameUtil.setButtonMode(this.FScene["btn_AutoBattle"],this.FAccessoryCampaign.CurStageId < this.FAccessoryCampaign.HistoryStageId);
         if(this.FAccessoryCampaign.CurStageId != 0 && this.FLastResetTimes > 0)
         {
            TGameUtil.setButtonMode(this.FScene["btn_Reset"],true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene["btn_Reset"],false);
         }
         TGameUtil.setButtonMode(this.FScene["btn_Campaign"],_loc1_.OpenLevel <= SLogicsCore.Character.GetMainLevel());
         if(SLogicsCore.Character.GetMainLevel() < _loc1_.OpenLevel)
         {
            this.FScene["mc_lock"].visible = true;
            this.FScene["btn_AutoBattle"].visible = false;
            this.FScene["btn_Campaign"].visible = false;
            this.FScene["btn_Reset"].visible = false;
         }
         else
         {
            this.FScene["mc_lock"].visible = false;
            this.FScene["btn_AutoBattle"].visible = true;
            this.FScene["btn_Campaign"].visible = true;
            this.FScene["btn_Reset"].visible = true;
         }
      }
      
      public function SetResetCount(param1:uint) : void
      {
         this.FCanResetCount = param1;
         this.Update();
      }
      
      public function UpdateImage() : void
      {
         if(this.FAccessoryCampaign == null || this.FScene == null)
         {
            return;
         }
         this.FActive.UpdateActive();
      }
   }
}

