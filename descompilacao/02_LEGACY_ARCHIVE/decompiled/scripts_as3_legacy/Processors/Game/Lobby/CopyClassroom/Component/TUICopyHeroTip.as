package Processors.Game.Lobby.CopyClassroom.Component
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.CopyHero.TCopyHero;
   import Logics.DatebaseVO.VO.TBaseCopyHero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_COPYCLASSROOM;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TUICopyHeroTip extends TUIComponent
   {
      
      protected var FScene:MovieClip;
      
      protected var FTF_HeroName:TextField;
      
      protected var FCopyHero:TCopyHero;
      
      protected var FBaseCopyHero:TBaseCopyHero;
      
      public function TUICopyHeroTip(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COPYCLASSROOM.RESOURCE_Link_MC_CopyHeroTip) as MovieClip;
         this.FTF_HeroName = this.FScene["tf_name"];
         addChild(this.FScene);
         this.FScene.mouseEnabled = false;
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TBaseHero = null;
         if(this.FCopyHero == null)
         {
            this.FScene.tf_name.text = "";
            this.FScene.tf_changeTime.text = 0;
         }
         else
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FCopyHero.HeroID) as TBaseHero;
            this.FTF_HeroName.text = String(this.FCopyHero.HeroName == null ? "" : this.FCopyHero.HeroName);
            this.FTF_HeroName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc1_.Quality];
            this.FScene.tf_changeTime.text = String(this.FCopyHero.TimeLimit) + STRING_COMMON.TYPE_TIME_Minute;
         }
         this.FScene.tf_mapName.text = STRING_COMMON.TYPE_PLACE_MainCity;
      }
      
      public function SetCopyHeroData(param1:TCopyHero) : void
      {
         this.FCopyHero = param1;
         this.UpdateUI();
      }
      
      public function CheckTipPoint() : void
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
   }
}

