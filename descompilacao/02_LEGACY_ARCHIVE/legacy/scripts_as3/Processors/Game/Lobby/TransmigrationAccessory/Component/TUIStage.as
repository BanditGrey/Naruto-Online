package Processors.Game.Lobby.TransmigrationAccessory.Component
{
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TNewornament_battle;
   import Logics.DatebaseVO.VO.TNewornament_config;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class TUIStage
   {
      
      protected var FScene:MovieClip;
      
      protected var FBitmap:Bitmap;
      
      protected var FAccessoryCampaign:TAccessoryCampaign;
      
      protected var FNewornament_config:TNewornament_config;
      
      protected var FNewornament_battle:TNewornament_battle;
      
      public function TUIStage(param1:MovieClip)
      {
         super();
         this.FScene = param1;
         this.FBitmap = new Bitmap();
         this.FScene["mc_head"].addChild(this.FBitmap);
         this.FScene.gotoAndStop(4);
      }
      
      public function SetData(param1:TAccessoryCampaign, param2:TNewornament_config, param3:TNewornament_battle) : void
      {
         this.FAccessoryCampaign = param1;
         this.FNewornament_config = param2;
         this.FNewornament_battle = param3;
         this.Update();
      }
      
      public function Update() : void
      {
         this.FScene["mc_select"].visible = false;
         this.FScene["mc_pass"].visible = false;
         this.FScene["tf_name"].text = this.FNewornament_battle.Name;
         if(this.FNewornament_battle.Identifier > this.FAccessoryCampaign.CurStageId + 1)
         {
            this.FScene.gotoAndStop(3);
            if(this.FScene["mc_lock"])
            {
               this.FScene["mc_lock"].visible = Boolean(this.FNewornament_battle.Identifier > this.FAccessoryCampaign.HistoryStageId);
            }
         }
         else if(this.FNewornament_battle.Identifier < this.FAccessoryCampaign.CurStageId + 1)
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_pass"].visible = true;
         }
         else
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_select"].visible = true;
         }
         if(this.FAccessoryCampaign.CurStageId == 0 && this.FNewornament_config.StageStartId == this.FNewornament_battle.Identifier)
         {
            this.FScene.gotoAndStop(1);
            this.FScene["mc_select"].visible = true;
         }
      }
      
      public function UpdateImage() : void
      {
         if(this.FNewornament_battle == null || this.FBitmap == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_MiddlePic,this.FBitmap,CONST_MODULES.MODULE_TransmigrationAccessory,this.FNewornament_battle.Image);
      }
   }
}

