package Processors.Game.Lobby.TacticalDeployment
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.THeroExp;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_DEPLOYMENT;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class TDeploymentTip extends TUIComponent
   {
      
      protected static const TYPE_PHYSICAL:uint = 1;
      
      protected static const TYPE_MAGIC:uint = 2;
      
      protected var FScene:MovieClip;
      
      protected var FHeroData:THero;
      
      protected var FHeadBitmap:Bitmap;
      
      protected var FRoleModel:TBins;
      
      public function TDeploymentTip(param1:TUIComponent)
      {
         super(param1);
         this.InitDeploymentTip();
      }
      
      protected function InitDeploymentTip() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_DEPLOYMENT.RESOURCE_ClassName_DeploymentTip) as MovieClip;
         addChild(this.FScene);
         this.FScene.Head.mc_outFight.visible = false;
         this.FHeadBitmap = new Bitmap();
         this.FScene.Head.mc_head.addChild(this.FHeadBitmap);
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:THeroExp = null;
         var _loc3_:TBaseHero = null;
         this.UpdataBitmap();
         this.FScene.tf_power.text = this.FHeroData.BaseAttributePower.toString();
         this.FScene.tf_intelligence.text = this.FHeroData.BaseAttributeIntelligence.toString();
         this.FScene.tf_agile.text = this.FHeroData.BaseAttributeAgile.toString();
         this.FScene.tf_speed.text = this.FHeroData.BaseAttributeSpeed.toString();
         this.FScene.tf_health.text = this.FHeroData.BaseAttributeHealth.toString();
         this.FScene.tf_physicalDefends.text = this.FHeroData.BaseAttributePhysicalDefends.toString();
         this.FScene.tf_magicDefends.text = this.FHeroData.BaseAttributeMagicDefends.toString();
         if(this.FHeroData.Profession != CONST_CHARACTER.PROFESSION_Intellect)
         {
            this.FScene.tf_attact.text = this.FHeroData.BaseAttributePhysicalAttack.toString();
            this.FScene.tf_attackName.gotoAndStop(TYPE_PHYSICAL);
         }
         else
         {
            this.FScene.tf_attact.text = this.FHeroData.BaseAttributeMagicAttack.toString();
            this.FScene.tf_attackName.gotoAndStop(TYPE_MAGIC);
         }
         this.FScene.tf_hit.text = this.FHeroData.BaseAttributeHit + "%";
         this.FScene.tf_dodge.text = this.FHeroData.BaseAttributeDodge + "%";
         this.FScene.tf_crit.text = this.FHeroData.BaseAttributeCrit + "%";
         this.FScene.tf_gridFile.text = this.FHeroData.BaseAttributeGridFile + "%";
         this.FScene.tf_wreck.text = this.FHeroData.BaseAttributeWreck + "%";
         this.FScene.tf_help.text = this.FHeroData.BaseAttributeHelp + "%";
         this.FScene.tf_punch.text = this.FHeroData.BaseAttributePunch + "%";
         this.FScene.tf_uprising.text = this.FHeroData.BaseAttributeUprising + "%";
         this.FScene.mc_posIcon.gotoAndStop(this.FHeroData.StandPositionWithProfession);
         var _loc4_:int = int(this.FHeroData.Level);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc4_) as THeroExp;
         this.FScene.tf_level.text = this.FHeroData.GetLevelStrByLevelLineFeed(this.FHeroData.Level);
         this.FScene.tf_name.text = this.FHeroData.Name ? this.FHeroData.Name : "";
         this.FScene.tf_name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FHeroData.Quality];
         this.FScene.tf_exp.text = this.FHeroData.Experience.ToString() + "/" + _loc2_.NeedExp.ToString();
         this.FScene.mc_expLine.mc_line.scaleX = this.FHeroData.Experience.ToNumber() / _loc2_.NeedExp.ToNumber();
         this.FHeroData.Skills.Sort();
         this.FScene.tf_skillName.text = this.FHeroData.Skills.GetSkillByIndex(0).Name;
         this.FScene.tf_talent.text = this.FHeroData.TalentName;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FHeroData.Identifier) as TBaseHero;
         this.FScene.mc_evaluate.gotoAndStop(_loc3_.Assess);
      }
      
      protected function CheckTipPoint() : void
      {
         if(mouseX > CONST_COMMON.STAGE_Width - this.FScene.width)
         {
            this.FScene.x = Math.max(mouseX - this.FScene.width - 40,0);
         }
         else
         {
            this.FScene.x = Math.min(mouseX + 40,CONST_COMMON.STAGE_Width - this.FScene.width);
         }
         if(mouseY > CONST_COMMON.STAGE_Height - this.FScene.height)
         {
            this.FScene.y = Math.max(mouseY - this.FScene.height,0);
         }
         else
         {
            this.FScene.y = Math.min(mouseY,CONST_COMMON.STAGE_Height - this.FScene.height);
         }
      }
      
      public function SetHeroData(param1:THero) : void
      {
         this.FHeroData = param1;
         this.UpdataUI();
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:TRoleModel = null;
         if(this.FHeroData == null)
         {
            return;
         }
         _loc1_ = this.FRoleModel.GetDatebaseByIdentifier(this.FHeroData.Identifier) as TRoleModel;
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadBitmap,CONST_MODULES.MODULE_TacticalDeployment,_loc1_.RoleHead);
         this.CheckTipPoint();
      }
   }
}

