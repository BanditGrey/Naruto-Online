package Processors.Game.Lobby.Palace.Components
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TWingAdvanced;
   import Processors.Game.Lobby.Components.TUIHero;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import ghostcat.util.data.Json;
   
   public class TUIPalaceHeroModel extends TUIHero
   {
      
      private var WingBitmap:Bitmap;
      
      private var FTitleBitmap:Bitmap;
      
      public var TitleId:int;
      
      public var WingId:int;
      
      public function TUIPalaceHeroModel(param1:TUIComponent)
      {
         super(param1);
         this.WingBitmap = new Bitmap();
         addChildAt(this.WingBitmap,0);
         this.FTitleBitmap = new Bitmap();
         addChild(this.FTitleBitmap);
      }
      
      override public function Update() : void
      {
         super.Update();
         this.UpdateTitleEffect();
         this.UpdateWingEffect();
      }
      
      protected function UpdateWingEffect() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:TWingAdvanced = null;
         var _loc4_:THero = null;
         var _loc5_:TRoleModel = null;
         _loc4_ = Context as THero;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc4_.Identifier) as TRoleModel;
         if(!_loc3_)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingAdvanced,this.WingId) as TWingAdvanced;
         }
         if(_loc3_)
         {
            _loc1_ = Json.decode(_loc3_.offset);
            _loc2_ = _loc1_[_loc5_.Model];
         }
         if(FDefaultRole.visible)
         {
            return;
         }
         if(this.WingId != 0)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_Wing,this.WingBitmap,CONST_MODULES.MODULE_Palace,this.WingId);
            this.WingBitmap.x = _loc2_.Sx;
            this.WingBitmap.y = _loc2_.Sy;
         }
         else if(this.WingBitmap.bitmapData != null)
         {
            this.WingBitmap.bitmapData = null;
         }
      }
      
      protected function UpdateTitleEffect() : void
      {
         if(FDefaultRole.visible)
         {
            return;
         }
         if(this.TitleId != 0)
         {
            TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBitmap,CONST_MODULES.MODULE_Palace,this.TitleId);
         }
         else if(this.FTitleBitmap.bitmapData != null)
         {
            this.FTitleBitmap.bitmapData = null;
         }
         if(FCurrentFrame)
         {
            this.FTitleBitmap.x = FCurrentFrame.Pivot.X - this.FTitleBitmap.width / 2;
         }
      }
   }
}

