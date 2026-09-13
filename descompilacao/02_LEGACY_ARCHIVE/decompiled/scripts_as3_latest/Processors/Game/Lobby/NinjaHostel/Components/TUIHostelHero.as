package Processors.Game.Lobby.NinjaHostel.Components
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.NinjaHostel.THeroBaseData;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NINJAHOSTEL;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_NINJAHOSTEL;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIHostelHero extends TUIComponent
   {
      
      public static const SceneWidth:uint = 103;
      
      public static const SceneHeight:uint = 125;
      
      protected var FScene:MovieClip;
      
      protected var FHeroHead:Bitmap;
      
      protected var FHero:THero;
      
      protected var FHeroId:uint;
      
      protected var FHeroSmallId:uint;
      
      protected var FHeroLevel:uint;
      
      protected var FIsLock:Boolean;
      
      protected var FShowHeroTip:Function;
      
      protected var FHideHeroTip:Function;
      
      protected var FHeroReturnTeam:Function;
      
      protected var FHeroDismissal:Function;
      
      public function TUIHostelHero(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NINJAHOSTEL.RESOURCE_ClassName_HostelNijia) as MovieClip;
         addChild(this.FScene);
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HighLight].visible = false;
         this.FHeroHead = new Bitmap();
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Head].addChild(this.FHeroHead);
         addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.OnMouseRollOut);
         TGameUtil.setButtonMode(this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_ReturnTeam],true);
         TGameUtil.setButtonMode(this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Dismissal],true);
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_ReturnTeam].addEventListener(MouseEvent.CLICK,this.OnReturnTeam);
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Dismissal].addEventListener(MouseEvent.CLICK,this.OnDismissal);
         this.FIsLock = true;
      }
      
      protected function OnMouseRollOver(param1:MouseEvent) : void
      {
         if(this.FIsLock)
         {
            return;
         }
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HighLight].visible = true;
         if(this.FShowHeroTip != null)
         {
            this.FShowHeroTip(this,2,this.FHeroId);
         }
      }
      
      protected function OnMouseRollOut(param1:MouseEvent) : void
      {
         if(this.FIsLock)
         {
            return;
         }
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HighLight].visible = false;
         if(this.FHideHeroTip != null)
         {
            this.FHideHeroTip(this);
         }
      }
      
      protected function OnReturnTeam(param1:MouseEvent) : void
      {
         if(this.FHeroReturnTeam != null)
         {
            this.FHeroReturnTeam(this,this.FHeroId,this.FHeroLevel);
         }
      }
      
      protected function OnDismissal(param1:MouseEvent) : void
      {
         if(this.FHeroDismissal != null)
         {
            this.FHeroDismissal(this,this.FHeroId);
         }
      }
      
      public function get ShowHeroTip() : Function
      {
         return this.FShowHeroTip;
      }
      
      public function set ShowHeroTip(param1:Function) : void
      {
         this.FShowHeroTip = param1;
      }
      
      public function get HideHeroTip() : Function
      {
         return this.FHideHeroTip;
      }
      
      public function set HideHeroTip(param1:Function) : void
      {
         this.FHideHeroTip = param1;
      }
      
      public function get HeroReturnTeam() : Function
      {
         return this.FHeroReturnTeam;
      }
      
      public function set HeroReturnTeam(param1:Function) : void
      {
         this.FHeroReturnTeam = param1;
      }
      
      public function get HeroDismissal() : Function
      {
         return this.FHeroDismissal;
      }
      
      public function set HeroDismissal(param1:Function) : void
      {
         this.FHeroDismissal = param1;
      }
      
      public function SetLock(param1:Boolean = false, param2:uint = 0) : void
      {
         var _loc3_:String = null;
         this.FIsLock = true;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Lock].visible = true;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HighLight].visible = false;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_TF_Level].visible = false;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_ReturnTeam].visible = false;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Dismissal].visible = false;
         if(param1 && param2 > 0)
         {
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_MainLevel].visible = true;
            _loc3_ = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevelCopy(param2);
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_MainLevel][CONST_NINJAHOSTEL.RESOURCE_TF_MainLevel].text = TUtilityString.Format(STRING_NINJAHOSTEL.STRING_MainLevelOpen,_loc3_);
         }
         else
         {
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_MainLevel].visible = false;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_MainLevel][CONST_NINJAHOSTEL.RESOURCE_TF_MainLevel].text = "";
         }
         this.FHeroHead.bitmapData = null;
      }
      
      public function SetHero(param1:THeroBaseData) : void
      {
         var _loc2_:TRoleModel = null;
         this.FIsLock = false;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Lock].visible = false;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_HighLight].visible = false;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_MainLevel].visible = false;
         if(param1 == null)
         {
            this.FHeroId = 0;
            this.FHeroSmallId = 0;
            this.FHeroLevel = 0;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_TF_Level].visible = false;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_ReturnTeam].visible = false;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Dismissal].visible = false;
            this.FHeroHead.bitmapData = null;
         }
         else
         {
            this.FHeroId = param1.Identifier;
            this.FHeroLevel = param1.HeroLevel;
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,this.FHeroId) as TRoleModel;
            this.FHeroSmallId = _loc2_.RoleHead;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_ReturnTeam].visible = true;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Dismissal].visible = true;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_TF_Level].visible = true;
            this.FScene[CONST_NINJAHOSTEL.RESOURCE_TF_Level].text = STRING_COMMON.GetLevelStrByLevelLineFeed(param1.HeroLevel);
         }
      }
      
      public function UpdateHead() : void
      {
         if(this.FHeroHead != null && this.FHeroSmallId != 0)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroHead,CONST_MODULES.MODULE_NinjaHostel,this.FHeroSmallId);
         }
      }
   }
}

