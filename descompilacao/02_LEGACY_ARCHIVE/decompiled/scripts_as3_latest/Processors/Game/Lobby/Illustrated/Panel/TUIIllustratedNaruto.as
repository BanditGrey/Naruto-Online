package Processors.Game.Lobby.Illustrated.Panel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TArchive;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedNaruto extends TUIBaseWindow
   {
      
      private var _page:int = -1;
      
      private var _maxPage:int = -1;
      
      private var _psychics:Array;
      
      public function TUIIllustratedNaruto(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc3_:Bitmap = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene.mouseEnabled = false;
         this._psychics = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            FMC_Scene["MC_Item_" + _loc2_].visible = false;
            FMC_Scene["MC_Item_" + _loc2_].mouseEnabled = FMC_Scene["MC_Item_" + _loc2_].mouseChildren = false;
            _loc3_ = new Bitmap();
            FMC_Scene["MC_Item_" + _loc2_]["MC_Container"].addChild(_loc3_);
            _loc3_.scaleX = _loc3_.scaleY = 0.8;
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
         TIllustratedModel.Narutos = TIllustratedModel.Sort(TIllustratedModel.Narutos);
         if(this._maxPage == -1)
         {
            this._maxPage = Math.ceil(TIllustratedModel.Narutos.length / 8);
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
         super.LogicsPerform();
         var _loc1_:int = Math.max((this._page - 1) * 8,0);
         var _loc2_:int = Math.min(this._page * 8,TIllustratedModel.Narutos.length);
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            if(_loc1_ + _loc3_ < _loc2_)
            {
               _loc4_ = TIllustratedModel.Narutos[_loc1_ + _loc3_];
               TGameUtil.ShowImageByID(TGameUtil.Type_Model,this._psychics[_loc3_],CONST_MODULES.MODULE_Illustrated,_loc4_.SuitIdVector[0]);
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
         var _loc5_:TArchive = null;
         var _loc6_:Array = null;
         this._page = Math.max(1,param1);
         this._page = Math.min(this._maxPage,this._page);
         FMC_Scene.TF_Page.text = this._page + "/" + this._maxPage;
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,this._page > 1);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,this._page < this._maxPage);
         var _loc2_:int = Math.max((this._page - 1) * 8,0);
         var _loc3_:int = Math.min(this._page * 8,TIllustratedModel.Narutos.length);
         var _loc4_:int = 0;
         while(_loc4_ < 8)
         {
            FMC_Scene["MC_Item_" + _loc4_].visible = _loc2_ + _loc4_ < _loc3_;
            if(FMC_Scene["MC_Item_" + _loc4_].visible)
            {
               _loc5_ = TIllustratedModel.Narutos[_loc2_ + _loc4_];
               FMC_Scene["MC_Item_" + _loc4_]["TF_Name"].text = _loc5_.Name;
               _loc6_ = TIllustratedModel.ActivationData(_loc5_);
               FMC_Scene["MC_Item_" + _loc4_]["TF_AddAttribute"].text = TIllustratedModel.AttributeFormat(_loc5_.AddAttributeVector[0][0],_loc5_.AddAttributeVector[0][1]);
               FMC_Scene["MC_Item_" + _loc4_]["TF_AddAttribute"].textColor = _loc6_.length >= 1 ? 16777215 : 10066329;
               FMC_Scene["MC_Item_" + _loc4_]["MC_Container"].filters = _loc6_.length >= 1 ? null : [TIllustratedModel.GRAY_FILTER];
               FMC_Scene["MC_Item_" + _loc4_]["MC_BG"].gotoAndStop(_loc6_.length >= 1 ? 2 : 1);
            }
            _loc4_++;
         }
      }
   }
}

