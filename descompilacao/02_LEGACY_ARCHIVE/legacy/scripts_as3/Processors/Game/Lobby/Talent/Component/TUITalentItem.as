package Processors.Game.Lobby.Talent.Component
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TRefreshTalent;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class TUITalentItem extends Sprite
   {
      
      protected var FResource:MovieClip;
      
      protected var FHeroIcon:Bitmap;
      
      protected var FRefreshTalent:TRefreshTalent;
      
      protected var FGlowFilter:GlowFilter;
      
      public var OnItemSelect:Function;
      
      public function TUITalentItem()
      {
         super();
         this.DispatchUIResource();
         addEventListener(MouseEvent.CLICK,this.OnClickSelf);
      }
      
      protected function DispatchUIResource() : void
      {
         this.FResource = TUtilityReflection.CreateDisplayObjectInstance("talentItem") as MovieClip;
         addChild(this.FResource);
         this.FHeroIcon = new Bitmap();
         this.FResource.mc_head.addChild(this.FHeroIcon);
         this.FGlowFilter = new GlowFilter();
      }
      
      protected function OnClickSelf(param1:MouseEvent) : void
      {
         if(this.OnItemSelect != null)
         {
            this.OnItemSelect(this.FRefreshTalent,this);
         }
      }
      
      public function Update(param1:TRefreshTalent) : void
      {
         this.FRefreshTalent = param1;
         this.visible = this.FRefreshTalent ? true : false;
      }
      
      public function AddGlowFilter(param1:Boolean = true) : void
      {
         this.FResource.filters = param1 ? [this.FGlowFilter] : null;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FRefreshTalent == null || !this.visible)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroIcon,CONST_MODULES.MODULE_NinjaTalent,this.FRefreshTalent.Identifier);
      }
      
      public function get RefreshTalent() : TRefreshTalent
      {
         return this.FRefreshTalent;
      }
      
      public function set RefreshTalent(param1:TRefreshTalent) : void
      {
         this.FRefreshTalent = param1;
         this.visible = this.FRefreshTalent ? true : false;
      }
   }
}

