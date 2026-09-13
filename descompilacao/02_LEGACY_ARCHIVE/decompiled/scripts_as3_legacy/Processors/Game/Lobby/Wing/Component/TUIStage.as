package Processors.Game.Lobby.Wing.Component
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TWingBattleConfig;
   import Logics.DatebaseVO.VO.TWingConfig;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class TUIStage
   {
      
      protected var FScene:MovieClip;
      
      protected var FBitmap:Bitmap;
      
      protected var FTrialCampaign:TTrialCampaign;
      
      protected var FWingConfig:TWingConfig;
      
      protected var FWingBattleConfig:TWingBattleConfig;
      
      public function TUIStage(param1:MovieClip)
      {
         super();
         this.FScene = param1;
         this.FBitmap = new Bitmap();
         this.FScene["mc_head"].addChild(this.FBitmap);
         this.FScene.gotoAndStop(4);
      }
      
      public function SetData(param1:TTrialCampaign, param2:TWingConfig, param3:TWingBattleConfig) : void
      {
         this.FTrialCampaign = param1;
         this.FWingConfig = param2;
         this.FWingBattleConfig = param3;
         this.Update();
      }
      
      public function Update() : void
      {
         this.FScene["mc_select"].visible = false;
         this.FScene["mc_pass"].visible = false;
         this.FScene["tf_name"].text = this.FWingBattleConfig.Name;
         if(this.FWingBattleConfig.Identifier > this.FTrialCampaign.CurStageId + 1)
         {
            this.FScene.gotoAndStop(3);
            if(this.FScene["mc_lock"])
            {
               this.FScene["mc_lock"].visible = Boolean(this.FWingBattleConfig.Identifier > this.FTrialCampaign.HistoryStageId);
            }
         }
         else if(this.FWingBattleConfig.Identifier < this.FTrialCampaign.CurStageId + 1)
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_pass"].visible = true;
         }
         else
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_select"].visible = true;
         }
         if(this.FTrialCampaign.CurStageId == 0 && this.FWingConfig.StageStartId == this.FWingBattleConfig.Identifier)
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_select"].visible = true;
         }
      }
      
      public function UpdateImage() : void
      {
         if(this.FWingBattleConfig == null || this.FBitmap == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_MiddlePic,this.FBitmap,CONST_MODULES.MODULE_TransmigrationTrial,this.FWingBattleConfig.Image);
      }
   }
}

