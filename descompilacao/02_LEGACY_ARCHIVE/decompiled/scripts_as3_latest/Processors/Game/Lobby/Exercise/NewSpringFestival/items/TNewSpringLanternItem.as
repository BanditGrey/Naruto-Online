package Processors.Game.Lobby.Exercise.NewSpringFestival.items
{
   import Components.SelectBox.TSelectBoxSingle;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TNewSpring2018Config2;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.TProcessorNewSpringFestival;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TNewSpringLanternItem extends TUIComponent
   {
      
      private var mc_refreshItems:MovieClip;
      
      private var mc_previewItems:MovieClip;
      
      private var mc_items:MovieClip;
      
      private var items:Array;
      
      private var _selectBoxSingle:TSelectBoxSingle;
      
      private var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public var FShowItem:TUIShowItem;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      private var _selectFun:Function;
      
      protected var _main:TProcessorNewSpringFestival;
      
      private var _selectInded:int = -1;
      
      private var _lanternIndex:int = -1;
      
      private var _mainMc:MovieClip;
      
      public function TNewSpringLanternItem(param1:TUIComponent, param2:TProcessorNewSpringFestival)
      {
         super(param1);
         this._main = param2;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      public function initUI(param1:MovieClip, param2:int) : void
      {
         var _loc3_:MovieClip = null;
         this._mainMc = param1;
         this._lanternIndex = param2;
         this.mc_refreshItems = param1["mc_refreshItems"] as MovieClip;
         TGameUtil.setButtonMode(this.mc_refreshItems,true);
         this.mc_previewItems = param1["mc_previewItems"] as MovieClip;
         TGameUtil.setButtonMode(this.mc_previewItems,true);
         this.mc_previewItems.addEventListener(MouseEvent.CLICK,this.onPreviewItemsHandler);
         this.mc_refreshItems.addEventListener(MouseEvent.CLICK,this.onRefreshItemsHandler);
         this.mc_items = param1["mc_items"] as MovieClip;
         this._selectBoxSingle = new TSelectBoxSingle();
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = param1["MC_Task_" + _loc4_.toString()] as MovieClip;
            this._selectBoxSingle.SetTaskByIndex(_loc4_,_loc3_);
            _loc4_++;
         }
         this._selectBoxSingle.CallBackOnSelect = this.onTaskSelectHandler;
         this._selectBoxSingle.CallBackOnUnselect = this.onTaskUnSelectHandler;
         this._selectBoxSingle.Init();
         this.FShowItem = new TUIShowItem(this,3);
         this.FShowItem.Perform_UIDispatch(param1["mc_items"]);
      }
      
      private function onPreviewItemsHandler(param1:MouseEvent) : void
      {
         this._main.tNewSpringRewardsPreview.UpdateUI(this._main.newSpring2018Data.LanternRewardsPreviewConfig[this._lanternIndex].Inventories);
         this._main.tNewSpringRewardsPreview.Visible = true;
      }
      
      public function restUI() : void
      {
         this._selectBoxSingle.Init();
         this._selectInded = -1;
      }
      
      private function onRefreshItemsHandler(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:TNewSpring2018Config2 = this._main.tabConfig2.GetDatebaseByIdentifier(60007 + this._lanternIndex) as TNewSpring2018Config2;
         var _loc4_:Object = new Object();
         _loc2_.push(this._lanternIndex);
         _loc4_["const"] = int(_loc3_.orgPrice);
         _loc4_["type"] = TProcessorNewSpringFestival.REFRESH_LANTERN;
         _loc4_["data"] = _loc2_;
         this._main.showBuyConfimBox(_loc4_);
      }
      
      private function onTaskUnSelectHandler(param1:int, param2:int) : void
      {
         this._selectInded = -1;
         this._selectFun();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      private function onTaskSelectHandler(param1:int, param2:int) : void
      {
         this._selectInded = param2;
         this._selectFun();
      }
      
      public function getSeletctCurrentPrice() : int
      {
         if(this._selectInded == -1)
         {
            return 0;
         }
         return this.getCurrentPrice()[this._selectInded];
      }
      
      private function updateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:TBins = null;
         var _loc11_:TBaseBox = null;
         var _loc12_:int = 0;
         var _loc13_:Object = null;
         _loc4_ = new TInventories();
         _loc11_ = new TBaseBox();
         _loc8_ = new Vector.<uint>();
         _loc9_ = new Vector.<uint>();
         _loc10_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc1_ = 0;
         while(_loc1_ < this.items.length)
         {
            _loc13_ = this.items[_loc1_];
            _loc7_ = uint(int(_loc13_["type"]));
            _loc6_ = uint(int(_loc13_["itemID"]));
            _loc5_ = CONST_COMMON.GetItemIDByType(_loc7_,_loc6_,_loc10_);
            _loc8_.push(_loc5_);
            _loc9_.push(int(_loc13_["amount"]));
            _loc1_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc8_);
         _loc12_ = 0;
         while(_loc12_ < _loc9_.length)
         {
            _loc3_ = _loc4_.GetInventoryByIndex(_loc12_);
            _loc3_.Quantity = _loc9_[_loc12_];
            _loc12_++;
         }
         _loc11_.Inventories = _loc4_;
         this.FShowItem.UpdateUI(_loc11_.Inventories);
         this.FShowItem.LogicsPerform();
      }
      
      private function updatePrice() : void
      {
         var _loc2_:TextField = null;
         var _loc1_:Array = this.getCurrentPrice();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = this._mainMc["t_price_" + _loc3_.toString()] as TextField;
            _loc2_.text = this.items[_loc3_]["price"];
            _loc3_++;
         }
      }
      
      public function getCurrentPrice() : Array
      {
         var _loc1_:Object = null;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < this.items.length)
         {
            _loc1_ = this.items[_loc4_] as Object;
            _loc3_ = int(_loc1_["price"]);
            _loc3_ = Math.round(_loc3_ * (this._main.newSpring2018Data.sale / 10));
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function LogicsPerform() : void
      {
         this.FShowItem.LogicsPerform();
      }
      
      public function updateUI(param1:Array) : void
      {
         this.items = param1;
         this.updateItems();
         this.updatePrice();
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get selectFun() : Function
      {
         return this._selectFun;
      }
      
      public function set selectFun(param1:Function) : void
      {
         this._selectFun = param1;
      }
      
      public function get selectInded() : int
      {
         return this._selectInded;
      }
      
      public function get lanternIndex() : int
      {
         return this._lanternIndex;
      }
      
      public function set lanternIndex(param1:int) : void
      {
         this._lanternIndex = param1;
      }
   }
}

