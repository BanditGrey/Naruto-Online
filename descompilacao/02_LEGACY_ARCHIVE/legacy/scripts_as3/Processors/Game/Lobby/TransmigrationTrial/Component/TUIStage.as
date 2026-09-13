package Processors.Game.Lobby.TransmigrationTrial.Component
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TEpicConfig;
   import Logics.DatebaseVO.VO.TEpicEquip_battle;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class TUIStage
   {
      
      protected var FScene:MovieClip;
      
      protected var FBitmap:Bitmap;
      
      protected var FTrialCampaign:TTrialCampaign;
      
      protected var FEpicConfig:TEpicConfig;
      
      protected var FEpicEquip_battle:TEpicEquip_battle;
      
      public function TUIStage(param1:MovieClip)
      {
         super();
         this.FScene = param1;
         this.FBitmap = new Bitmap();
         this.FScene["mc_head"].addChild(this.FBitmap);
         this.FScene.gotoAndStop(4);
      }
      
      public function SetData(param1:TTrialCampaign, param2:TEpicConfig, param3:TEpicEquip_battle) : void
      {
         this.FTrialCampaign = param1;
         this.FEpicConfig = param2;
         this.FEpicEquip_battle = param3;
         this.Update();
      }
      
      public function Update() : void
      {
         this.FScene["mc_select"].visible = false;
         this.FScene["mc_pass"].visible = false;
         this.FScene["tf_name"].text = this.FEpicEquip_battle.Name;
         if(this.FEpicEquip_battle.Identifier > this.FTrialCampaign.CurStageId + 1)
         {
            this.FScene.gotoAndStop(3);
            if(this.FScene["mc_lock"])
            {
               this.FScene["mc_lock"].visible = Boolean(this.FEpicEquip_battle.Identifier > this.FTrialCampaign.HistoryStageId);
            }
         }
         else if(this.FEpicEquip_battle.Identifier < this.FTrialCampaign.CurStageId + 1)
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_pass"].visible = true;
         }
         else
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_select"].visible = true;
         }
         if(this.FTrialCampaign.CurStageId == 0 && this.FEpicConfig.StageStartId == this.FEpicEquip_battle.Identifier)
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_select"].visible = true;
         }
      }
      
      public function UpdateImage() : void
      {
         if(this.FEpicEquip_battle == null || this.FBitmap == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBitmap,CONST_MODULES.MODULE_TransmigrationTrial,this.FEpicEquip_battle.Image);
      }
   }
}

