package Processors.Game.Lobby.Illustrated.Panel
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TArchive;
   import Logics.DatebaseVO.VO.TTitleConfig;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedTitle extends TUIBaseWindow
   {
      
      private var _page:int = -1;
      
      private var _maxPage:int = -1;
      
      private var _psychics:Array;
      
      public function TUIIllustratedTitle(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc3_:Bitmap = null;
         super.Resources_UIDispatch(param1);
         this._psychics = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            FMC_Scene["MC_Item_" + _loc2_].visible = false;
            FMC_Scene["MC_Item_" + _loc2_].mouseEnabled = FMC_Scene["MC_Item_" + _loc2_].mouseChildren = false;
            _loc3_ = new Bitmap();
            FMC_Scene["MC_Item_" + _loc2_]["MC_Container"].addChild(_loc3_);
            this._psychics.push(_loc3_);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,true);
         FMC_Scene.MC_PageLeft.addEventListener(MouseEvent.CLICK,this.OnPageLeftClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,true);
         FMC_Scene.MC_PageRight.addEventListener(MouseEvent.CLICK,this.OnPageRightClick);
      }
      
      override public function UpdateUI() : void
      {
         TIllustratedModel.Titles = TIllustratedModel.Sort(TIllustratedModel.Titles);
         if(this._maxPage == -1)
         {
            this._maxPage = Math.ceil(TIllustratedModel.Titles.length / 9);
            this.page = 1;
         }
         else
         {
            this.page = this.page;
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc4_:TArchive = null;
         var _loc5_:Array = null;
         var _loc6_:TTitleConfig = null;
         super.LogicsPerform();
         var _loc1_:int = Math.max((this._page - 1) * 9,0);
         var _loc2_:int = Math.min(this._page * 9,TIllustratedModel.Titles.length);
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            if(_loc1_ + _loc3_ < _loc2_)
            {
               _loc4_ = TIllustratedModel.Titles[_loc1_ + _loc3_];
               _loc5_ = TIllustratedModel.ActivationData(_loc4_);
               _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TitleConfig,_loc4_.SuitIdVector[0]) as TTitleConfig;
               if(_loc5_.length >= 1)
               {
                  TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this._psychics[_loc3_],CONST_MODULES.MODULE_Illustrated,_loc6_.ImageId);
               }
               else
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_UserTitle,this._psychics[_loc3_],CONST_MODULES.MODULE_Illustrated,_loc6_.ImageId);
               }
            }
            _loc3_++;
         }
      }
      
      private function OnPageLeftClick(param1:MouseEvent) : void
      {
         --this.page;
      }
      
      private function OnPageRightClick(param1:MouseEvent) : void
      {
         ++this.page;
      }
      
      public function get page() : int
      {
         return this._page;
      }
      
      public function set page(param1:int) : void
      {
         var _loc6_:TArchive = null;
         var _loc7_:Array = null;
         this._page = Math.max(1,param1);
         this._page = Math.min(this._maxPage,this._page);
         FMC_Scene.TF_Page.text = this._page + "/" + this._maxPage;
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,this._page > 1);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,this._page < this._maxPage);
         var _loc2_:int = Math.max((this._page - 1) * 9,0);
         var _loc3_:int = Math.min(this._page * 9,TIllustratedModel.Titles.length);
         var _loc4_:Bitmap = new Bitmap();
         var _loc5_:int = 0;
         while(_loc5_ < 9)
         {
            FMC_Scene["MC_Item_" + _loc5_].visible = _loc2_ + _loc5_ < _loc3_;
            if(FMC_Scene["MC_Item_" + _loc5_].visible)
            {
               _loc6_ = TIllustratedModel.Titles[_loc2_ + _loc5_];
               FMC_Scene["MC_Item_" + _loc5_]["TF_Name"].text = _loc6_.Name;
               _loc7_ = TIllustratedModel.ActivationData(_loc6_);
               FMC_Scene["MC_Item_" + _loc5_]["TF_AddAttribute"].text = TIllustratedModel.AttributeFormat(_loc6_.AddAttributeVector[0][0],_loc6_.AddAttributeVector[0][1]);
               FMC_Scene["MC_Item_" + _loc5_]["TF_AddAttribute"].textColor = _loc7_.length >= 1 ? 16777215 : 10066329;
               FMC_Scene["MC_Item_" + _loc5_]["MC_Container"].filters = _loc7_.length >= 1 ? null : [TIllustratedModel.GRAY_FILTER];
               FMC_Scene["MC_Item_" + _loc5_]["MC_BG"].gotoAndStop(_loc7_.length >= 1 ? 2 : 1);
            }
            _loc5_++;
         }
      }
   }
}

