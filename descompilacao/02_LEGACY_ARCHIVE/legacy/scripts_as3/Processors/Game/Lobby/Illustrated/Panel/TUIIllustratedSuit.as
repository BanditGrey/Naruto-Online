package Processors.Game.Lobby.Illustrated.Panel
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TArchive;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.Cell.TUIIllustratedSuitCell;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedSuit extends TUIBaseWindow
   {
      
      private var _page:int = -1;
      
      private var _maxPage:int = -1;
      
      private var _suits:Vector.<TUIIllustratedSuitCell>;
      
      public function TUIIllustratedSuit(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         super.Resources_UIDispatch(param1);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,true);
         FMC_Scene.MC_PageLeft.addEventListener(MouseEvent.CLICK,this.OnPageLeftClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,true);
         FMC_Scene.MC_PageRight.addEventListener(MouseEvent.CLICK,this.OnPageRightClick);
      }
      
      override public function UpdateUI() : void
      {
         var _loc1_:int = 0;
         if(this._suits == null)
         {
            this._suits = new Vector.<TUIIllustratedSuitCell>();
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               this._suits.push(new TUIIllustratedSuitCell(FMC_Scene["MC_Item_" + _loc1_],OnShowHtmlTip,OnHideHtmlTip));
               _loc1_++;
            }
         }
         TIllustratedModel.Suits = TIllustratedModel.Sort(TIllustratedModel.Suits);
         if(this._maxPage == -1)
         {
            this._maxPage = Math.ceil(TIllustratedModel.Suits.length / 8);
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
         this._page = Math.max(1,param1);
         this._page = Math.min(this._maxPage,this._page);
         FMC_Scene.TF_Page.text = this._page + "/" + this._maxPage;
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,this._page > 1);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,this._page < this._maxPage);
         var _loc2_:int = Math.max((this._page - 1) * 8,0);
         var _loc3_:int = Math.min(this._page * 8,TIllustratedModel.Suits.length);
         var _loc4_:int = 0;
         while(_loc4_ < 8)
         {
            this._suits[_loc4_].Data = _loc2_ + _loc4_ < _loc3_ ? TIllustratedModel.Suits[_loc2_ + _loc4_] : null;
            _loc4_++;
         }
      }
   }
}

