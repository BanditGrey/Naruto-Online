package Processors.Game.Lobby.NinjaHostel.Components
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.THero;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NINJAHOSTEL;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUITeamHero extends TUIComponent
   {
      
      public static const SceneWidth:uint = 90;
      
      public static const SceneHeight:uint = 90;
      
      protected var FScene:MovieClip;
      
      protected var FHeroHead:Bitmap;
      
      protected var FHero:THero;
      
      protected var FShowHeroTip:Function;
      
      protected var FHideHeroTip:Function;
      
      protected var FHeroLeaveTeam:Function;
      
      public function TUITeamHero(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NINJAHOSTEL.RESOURCE_ClassName_TeamNijia) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Leave],true);
         this.FHeroHead = new Bitmap();
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Head].addChild(this.FHeroHead);
         addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.OnMouseRollOut);
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Leave].addEventListener(MouseEvent.CLICK,this.OnLeaveTeam);
      }
      
      protected function OnMouseRollOver(param1:MouseEvent) : void
      {
         this.FScene.gotoAndStop(2);
         if(this.FShowHeroTip != null)
         {
            this.FShowHeroTip(this,1,this.FHero.Identifier);
         }
      }
      
      protected function OnMouseRollOut(param1:MouseEvent) : void
      {
         this.FScene.gotoAndStop(1);
         if(this.FHideHeroTip != null)
         {
            this.FHideHeroTip(this);
         }
      }
      
      protected function OnLeaveTeam(param1:MouseEvent) : void
      {
         if(this.FHeroLeaveTeam != null)
         {
            this.FHeroLeaveTeam(this,this.FHero.Identifier);
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
      
      public function get HeroLeaveTeam() : Function
      {
         return this.FHeroLeaveTeam;
      }
      
      public function set HeroLeaveTeam(param1:Function) : void
      {
         this.FHeroLeaveTeam = param1;
      }
      
      public function SetHeroInfo(param1:THero) : void
      {
         this.FHero = param1;
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Leave].visible = true;
      }
      
      public function CantLeave() : void
      {
         this.FScene[CONST_NINJAHOSTEL.RESOURCE_MC_Leave].visible = false;
      }
      
      public function UpdateHead() : void
      {
         if(this.FHero != null)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroHead,CONST_MODULES.MODULE_NinjaHostel,this.FHero.SmallID);
         }
      }
   }
}

