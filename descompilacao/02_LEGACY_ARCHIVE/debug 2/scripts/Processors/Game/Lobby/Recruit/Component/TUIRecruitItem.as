package Processors.Game.Lobby.Recruit.Component
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDrawNinja;
   import Logics.Recruit.TRecruit;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class TUIRecruitItem extends Sprite
   {
      
      protected var FResource:MovieClip;
      
      protected var FHeroIcon:Bitmap;
      
      protected var FRecruit:TRecruit;
      
      protected var FDrawNinja:TDrawNinja;
      
      protected var FEffectGlow:TEffectBaseGlow;
      
      protected var FTF_Count:TextField;
      
      protected var FGlowFilter:GlowFilter;
      
      public var OnItemSelect:Function;
      
      public var ConfigValue:TConfigValue;
      
      public function TUIRecruitItem()
      {
         super();
         this.DispatchUIResource();
         addEventListener(MouseEvent.CLICK,this.OnClickSelf);
      }
      
      protected function DispatchUIResource() : void
      {
         this.FResource = TUtilityReflection.CreateDisplayObjectInstance("recruitItem") as MovieClip;
         addChild(this.FResource);
         this.FHeroIcon = new Bitmap();
         this.FResource.mc_head.addChild(this.FHeroIcon);
         this.FTF_Count = this.FResource.TF_Count;
         this.upStarView(0);
         this.FGlowFilter = new GlowFilter();
         if(this.FEffectGlow == null)
         {
            this.FEffectGlow = new TEffectBaseGlow();
            this.FEffectGlow.SetParameters(this,15911245,1);
         }
      }
      
      protected function OnClickSelf(param1:MouseEvent) : void
      {
         if(this.OnItemSelect != null)
         {
            this.OnItemSelect(this.FRecruit,this);
         }
      }
      
      public function Update(param1:TRecruit) : void
      {
         var _loc2_:int = 0;
         this.FRecruit = param1;
         this.visible = this.FRecruit ? true : false;
         if(this.FRecruit == null)
         {
            return;
         }
         _loc2_ = this.FRecruit.starNum;
         this.upStarView(_loc2_);
         this.FTF_Count.text = this.FRecruit.count > 0 ? this.FRecruit.count.toString() : "";
         if(this.FRecruit.activate == 1 && _loc2_ < this.ConfigValue.Value.length && this.FRecruit.count >= this.ConfigValue.Value[_loc2_])
         {
            this.FEffectGlow.Run();
         }
         else if(this.FRecruit.activate == 0 && this.FRecruit.count > 0)
         {
            this.FEffectGlow.Run();
         }
         else
         {
            this.FEffectGlow.Stop();
         }
         if(this.FRecruit.isDrawed == false)
         {
            this.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.filters = null;
         }
      }
      
      protected function upStarView(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         _loc3_ = 1;
         while(_loc3_ <= 5)
         {
            _loc4_ = this.FResource["star_" + _loc3_];
            _loc4_.visible = param2;
            if(_loc3_ <= param1)
            {
               _loc4_.gotoAndStop(1);
            }
            else
            {
               _loc4_.gotoAndStop(2);
            }
            _loc3_++;
         }
      }
      
      public function AddGlowFilter(param1:Boolean = true) : void
      {
         this.FResource.filters = param1 ? [this.FGlowFilter] : null;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FRecruit == null || !this.visible)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroIcon,CONST_MODULES.MODULE_DrawNinaja,this.FRecruit.heroId);
         if(Boolean(this.FEffectGlow) && this.FEffectGlow.IsRunOver)
         {
            this.FEffectGlow.Run();
         }
      }
      
      public function UpdateImage() : void
      {
         if(this.DrawNinja == null || !this.visible)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroIcon,CONST_MODULES.MODULE_DrawNinaja,this.DrawNinja.Ninjaid);
      }
      
      public function get DrawNinja() : TDrawNinja
      {
         return this.FDrawNinja;
      }
      
      public function set DrawNinja(param1:TDrawNinja) : void
      {
         this.FDrawNinja = param1;
         this.visible = this.FDrawNinja ? true : false;
         this.upStarView(0,false);
      }
   }
}

