package Processors.Game.Lobby.Wing.Component
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWingBattleConfig;
   import Logics.DatebaseVO.VO.TWingConfig;
   import Logics.SLogicsCore;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import Resources.Strings.STRING_WING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUICampaign
   {
      
      protected var FScene:MovieClip;
      
      protected var FTrialCampaign:TTrialCampaign;
      
      protected var FCanResetCount:uint;
      
      protected var FActive:TActive;
      
      protected var FImageId:uint;
      
      protected var FLastResetTimes:uint;
      
      protected var FResetCost:uint;
      
      public var GotoStage:Function;
      
      public var ShowConfirmation:Function;
      
      public var OnAutoBattle:Function;
      
      public var OnAutoTip:Function;
      
      public var HideAutoTip:Function;
      
      public function TUICampaign(param1:MovieClip, param2:uint)
      {
         super();
         this.FScene = param1;
         TGameUtil.setButtonMode(this.FScene["btn_AutoBattle"],true);
         TGameUtil.setButtonMode(this.FScene["btn_Campaign"],true);
         this.FScene["btn_AutoBattle"].addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoBattle);
         this.FScene["btn_Reset"].addEventListener(MouseEvent.CLICK,this.ProcessorOnResetBattle);
         this.FScene["btn_Reset"].addEventListener(MouseEvent.MOUSE_MOVE,this.onBtnResponse);
         this.FScene["btn_Reset"].addEventListener(MouseEvent.ROLL_OUT,this.onBtnResponse);
         this.FScene["btn_Reset"].addEventListener(MouseEvent.MOUSE_DOWN,this.onBtnResponse);
         this.FScene["btn_Reset"].addEventListener(MouseEvent.MOUSE_UP,this.onBtnResponse);
         this.FScene["btn_Campaign"].addEventListener(MouseEvent.CLICK,this.ProcessorOnEnterBattle);
         this.FScene["mc_bg"].gotoAndStop(param2 + 1);
      }
      
      protected function onBtnResponse(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            if(this.FTrialCampaign.TodayResetTimes == 0)
            {
               if(param1.type == MouseEvent.MOUSE_MOVE)
               {
                  _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_025).DescribeString;
                  _loc2_ = TUtilityString.Format(_loc2_,8);
                  this.OnAutoTip(_loc2_);
               }
               else
               {
                  this.HideAutoTip();
               }
            }
            return;
         }
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            param1.currentTarget.gotoAndStop(2);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            param1.currentTarget.gotoAndStop(1);
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            param1.currentTarget.gotoAndStop(3);
         }
         else if(param1.type == MouseEvent.MOUSE_UP)
         {
            param1.currentTarget.gotoAndStop(1);
         }
      }
      
      protected function ProcessorOnAutoBattle(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.OnAutoBattle != null)
         {
            this.OnAutoBattle(this.FTrialCampaign.CampaignId);
         }
      }
      
      protected function ProcessorOnResetBattle(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.ShowConfirmation != null)
         {
            this.ShowConfirmation(this,this.FLastResetTimes,this.FResetCost,this.FTrialCampaign.CampaignId);
         }
      }
      
      protected function ProcessorOnEnterBattle(param1:MouseEvent) : void
      {
         if(this.GotoStage != null)
         {
            this.GotoStage(this.FTrialCampaign);
         }
      }
      
      public function SetData(param1:TTrialCampaign) : void
      {
         this.FTrialCampaign = param1;
         this.Update();
      }
      
      public function Update() : void
      {
         var _loc1_:TWingConfig = null;
         var _loc2_:TWingBattleConfig = null;
         var _loc3_:uint = 0;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingConfig,this.FTrialCampaign.CampaignId) as TWingConfig;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingBattleConfig,this.FTrialCampaign.CurStageId) as TWingBattleConfig;
         this.FImageId = _loc1_.PicID;
         this.RoleReset();
         this.FActive = TPoolRole.GetActive(null,this.FImageId,CONST_MODULES.MODULE_Wing,false,false);
         this.FScene["mc_bg"]["mc_Image"].addChild(this.FActive);
         _loc3_ = this.FTrialCampaign.TodayResetTimes;
         if(_loc3_ >= _loc1_.ReplayCostVect.length)
         {
            _loc3_ = _loc1_.ReplayCostVect.length - 1;
         }
         this.FResetCost = _loc1_.ReplayCostVect[_loc3_][1];
         this.FLastResetTimes = Math.max(this.FCanResetCount - this.FTrialCampaign.TodayResetTimes,0);
         this.FScene["tf_OpenLevel"].text = TUtilityString.Format(STRING_TRANSMIGRATIONTRIAL.STRING_OPENLEVEL,_loc1_.CampaignName,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc1_.OpenLevel));
         this.FScene["tf_Step"].text = (_loc2_ ? _loc2_.SStageID : 0) + "/" + _loc1_.CampaignCount;
         this.FScene["tf_ResetTimes"].text = this.FLastResetTimes + "/" + this.FCanResetCount;
         TGameUtil.setButtonMode(this.FScene["btn_AutoBattle"],this.FTrialCampaign.CurStageId < this.FTrialCampaign.HistoryStageId);
         if(this.FTrialCampaign.CurStageId != 0)
         {
            MovieClip(this.FScene["btn_Reset"]).buttonMode = true;
            this.FScene["btn_Reset"].gotoAndStop(1);
         }
         else
         {
            MovieClip(this.FScene["btn_Reset"]).buttonMode = false;
            MovieClip(this.FScene["btn_Reset"]).gotoAndStop(4);
         }
         if(this.FTrialCampaign.TodayResetTimes >= this.FCanResetCount && this.FTrialCampaign.TodayResetTimes != 0)
         {
            MovieClip(this.FScene["btn_Reset"]).buttonMode = false;
            this.FScene["btn_Reset"].gotoAndStop(5);
         }
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
      }
      
      public function UpdateImage() : void
      {
         if(this.FTrialCampaign == null || this.FScene == null || this.FActive == null)
         {
            return;
         }
         this.FActive.UpdateActive();
      }
      
      public function RoleReset() : void
      {
         if(this.FActive)
         {
            TPoolRole.SaveActive(this.FActive);
            this.FActive = null;
         }
      }
   }
}

