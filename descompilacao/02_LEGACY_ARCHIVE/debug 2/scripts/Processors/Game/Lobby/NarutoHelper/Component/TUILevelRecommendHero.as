package Processors.Game.Lobby.NarutoHelper.Component
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TNinjiaRecommend;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUILevelRecommendHero extends TProcessorUIResourceTemplate
   {
      
      protected var FSelectBox:MovieClip;
      
      protected var FMC_HasOwn:MovieClip;
      
      protected var FMC_Head:MovieClip;
      
      protected var FBM:Bitmap;
      
      protected var FOnClick:Function;
      
      public function TUILevelRecommendHero(param1:TUIComponent)
      {
         super(param1);
         this.FBM = new Bitmap();
      }
      
      override protected function UIDispatch() : void
      {
         this.FSelectBox = FResource["MC_Select"];
         this.FSelectBox.visible = false;
         this.FMC_HasOwn = FResource["MC_HasOwn"];
         this.FMC_Head = FResource["MC_Bmp_Icon"];
         this.FMC_Head.addChild(this.FBM);
      }
      
      override protected function UILocations() : void
      {
         FResource.addEventListener(MouseEvent.CLICK,this.HeadOnClick,false,0,true);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TNinjiaRecommend = null;
         var _loc2_:THero = null;
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TNinjiaRecommend;
         _loc2_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc1_.Avatar);
         this.FMC_HasOwn.visible = _loc2_ != null;
      }
      
      protected function UpdateHeroHead() : void
      {
         var _loc1_:TNinjiaRecommend = null;
         var _loc2_:TCoordinate = null;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TNinjiaRecommend;
         _loc3_ = uint(_loc1_.Avatar);
         _loc2_ = TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBM,CONST_MODULES.MODULE_NarutoHelper,_loc3_);
      }
      
      protected function HeadOnClick(param1:MouseEvent) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,FContext);
         }
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function HideSelect() : void
      {
         this.FSelectBox.visible = false;
      }
      
      public function ShowSelect() : void
      {
         this.FSelectBox.visible = true;
      }
      
      public function UpdateHead() : void
      {
         this.UpdateHeroHead();
      }
   }
}

