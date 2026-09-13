package Processors.Game.Lobby.Illustrated.Panel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TArchive;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedAccessory extends TUIBaseWindow
   {
      
      private var _page:int = -1;
      
      private var _maxPage:int = -1;
      
      public function TUIIllustratedAccessory(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         super.Resources_UIDispatch(param1);
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            FMC_Scene["MC_Item_" + _loc2_].visible = false;
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,true);
         FMC_Scene.MC_PageLeft.addEventListener(MouseEvent.CLICK,this.OnPageLeftClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,true);
         FMC_Scene.MC_PageRight.addEventListener(MouseEvent.CLICK,this.OnPageRightClick);
      }
      
      override public function UpdateUI() : void
      {
         TIllustratedModel.Accessorys = TIllustratedModel.Sort(TIllustratedModel.Accessorys);
         if(this._maxPage == -1)
         {
            this._maxPage = Math.ceil(TIllustratedModel.Accessorys.length / 8);
            this.page = 1;
         }
         else
         {
            this.page = this.page;
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
         var _loc7_:int = 0;
         this._page = Math.max(1,param1);
         this._page = Math.min(this._maxPage,this._page);
         FMC_Scene.TF_Page.text = this._page + "/" + this._maxPage;
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,this._page > 1);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,this._page < this._maxPage);
         var _loc2_:int = Math.max((this._page - 1) * 8,0);
         var _loc3_:int = Math.min(this._page * 8,TIllustratedModel.Accessorys.length);
         var _loc4_:int = 0;
         while(_loc4_ < 8)
         {
            FMC_Scene["MC_Item_" + _loc4_].visible = _loc2_ + _loc4_ < _loc3_;
            if(FMC_Scene["MC_Item_" + _loc4_].visible)
            {
               _loc5_ = TIllustratedModel.Accessorys[_loc2_ + _loc4_];
               FMC_Scene["MC_Item_" + _loc4_]["TF_Name"].text = _loc5_.Name;
               _loc6_ = TIllustratedModel.ActivationData(_loc5_);
               _loc7_ = 11;
               while(_loc7_ <= 18)
               {
                  FMC_Scene["MC_Item_" + _loc4_]["MC_Equip_" + _loc7_].visible = _loc6_.indexOf(_loc7_) != -1;
                  _loc7_++;
               }
               FMC_Scene["MC_Item_" + _loc4_]["TF_AddAttribute"].text = TIllustratedModel.AttributeFormat(_loc5_.AddAttributeVector[0][0],_loc5_.AddAttributeVector[0][1]);
               FMC_Scene["MC_Item_" + _loc4_]["TF_AddAttribute"].textColor = _loc6_.length >= 8 ? 16777215 : 10066329;
               FMC_Scene["MC_Item_" + _loc4_]["MC_BG"].gotoAndStop(_loc6_.length >= 8 ? 2 : 1);
            }
            _loc4_++;
         }
      }
   }
}

