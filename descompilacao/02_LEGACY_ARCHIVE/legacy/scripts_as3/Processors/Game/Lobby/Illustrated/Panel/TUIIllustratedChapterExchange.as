package Processors.Game.Lobby.Illustrated.Panel
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.Cell.TUIIllustratedChapterExchangeCell;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedChapterExchange extends TUIBaseWindow
   {
      
      private var _page:int = -1;
      
      private var _maxPage:int = -1;
      
      private var _datas:Vector.<Object>;
      
      private var _items:Vector.<TUIIllustratedChapterExchangeCell>;
      
      private var _slots:Vector.<TUISlot>;
      
      public function TUIIllustratedChapterExchange(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         super.Resources_UIDispatch(param1);
         FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnClose);
         FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageLeft,true);
         FMC_Scene.MC_PageLeft.addEventListener(MouseEvent.CLICK,this.OnPageLeftClick);
         TGameUtil.setButtonMode(FMC_Scene.MC_PageRight,true);
         FMC_Scene.MC_PageRight.addEventListener(MouseEvent.CLICK,this.OnPageRightClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_ConfirmExchange,true);
         FMC_Scene.BTN_ConfirmExchange.addEventListener(MouseEvent.CLICK,this.OnConfirmExchangeClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_SelectedAll,true);
         FMC_Scene.BTN_SelectedAll.addEventListener(MouseEvent.CLICK,this.OnSelectedAllClick);
         this._datas = new Vector.<Object>();
         this._items = new Vector.<TUIIllustratedChapterExchangeCell>();
         this._slots = new Vector.<TUISlot>();
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            this._items.push(new TUIIllustratedChapterExchangeCell(this,FMC_Scene["MC_Item_" + _loc2_]));
            this._slots.push(this.GetSlot(FMC_Scene["MC_Item_" + _loc2_]["MC_Slot"]));
            _loc2_++;
         }
      }
      
      override public function UpdateUI() : void
      {
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this._slots)
         {
            _loc1_ = int(this._slots.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._slots[_loc2_].Update();
               _loc2_++;
            }
         }
      }
      
      override public function SetVisible(param1:Boolean) : void
      {
         var _loc2_:TInventories = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         super.SetVisible(param1);
         if(param1)
         {
            this._datas.length = 0;
            _loc2_ = TIllustratedModel.FCharacter.Equipments;
            _loc3_ = _loc2_.Count;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = {};
               _loc5_.Inventory = _loc2_.GetInventoryByIndex(_loc4_);
               _loc5_.Resolve = TIllustratedModel.ResolveCount(_loc5_.Inventory["SuitID"]);
               if(_loc5_.Resolve > 0)
               {
                  this._datas.push(_loc5_);
               }
               _loc4_++;
            }
            _loc2_ = TIllustratedModel.FCharacter.Accessories;
            _loc3_ = _loc2_.Count;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = {};
               _loc5_.Inventory = _loc2_.GetInventoryByIndex(_loc4_);
               _loc5_.Resolve = TIllustratedModel.ResolveCount(_loc5_.Inventory["SuitID"]);
               if(_loc5_.Resolve > 0)
               {
                  this._datas.push(_loc5_);
               }
               _loc4_++;
            }
            this._maxPage = Math.ceil(this._datas.length / 10);
            this.page = this.page;
         }
         else
         {
            TIllustratedModel.ClearSelecteds();
            this.UpdateItems();
         }
      }
      
      public function UpdateItems() : void
      {
         var _loc4_:Object = null;
         var _loc1_:int = int(TIllustratedModel.Selecteds.length);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            for each(_loc4_ in this._datas)
            {
               if(TIllustratedModel.MergeEquipID(_loc4_.Inventory) == TIllustratedModel.Selecteds[_loc3_])
               {
                  _loc2_ += _loc4_.Resolve;
                  break;
               }
            }
            _loc3_++;
         }
         FMC_Scene["TF_Equip"].text = TIllustratedModel.TextFormat(70470003,_loc1_);
         FMC_Scene["TF_Chapter"].text = TIllustratedModel.TextFormat(70470004,_loc2_);
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            this._items[_loc3_].UpdateUI(this._items[_loc3_].data);
            if(this._items[_loc3_].data)
            {
               this._slots[_loc3_].Context = this._items[_loc3_].data.Inventory;
            }
            else
            {
               this._slots[_loc3_].Context = null;
            }
            this._slots[_loc3_].Update();
            _loc3_++;
         }
      }
      
      public function PlayEffect() : void
      {
         FMC_Scene.MC_Succeed_Effect.gotoAndPlay(1);
      }
      
      protected function GetSlot(param1:Sprite) : TUISlot
      {
         var _loc2_:TUISlot = new TUISlot(this);
         _loc2_.Resource = param1;
         _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         _loc2_.OnOverlay = OnItemOver;
         _loc2_.OnOut = OnItemOut;
         _loc2_.Init();
         return _loc2_;
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = param2 as TInventory;
         var _loc6_:TResourceRepositoryTexture = SResourcesCore.TexturesInventory;
         var _loc7_:TTexture = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Common);
         }
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         this.SetVisible(false);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
      }
      
      private function OnPageLeftClick(param1:MouseEvent) : void
      {
         --this.page;
      }
      
      private function OnPageRightClick(param1:MouseEvent) : void
      {
         ++this.page;
      }
      
      private function OnConfirmExchangeClick(param1:MouseEvent) : void
      {
         var _loc5_:Object = null;
         var _loc2_:int = int(TIllustratedModel.Selecteds.length);
         var _loc3_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Illustrated_ExchangeReq);
         _loc3_.Data.writeShort(_loc2_ * 2);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            for each(_loc5_ in this._datas)
            {
               if(TIllustratedModel.MergeEquipID(_loc5_.Inventory) == TIllustratedModel.Selecteds[_loc4_])
               {
                  _loc3_.Data.writeUnsignedInt(_loc5_.Inventory.Identifier0);
                  _loc3_.Data.writeUnsignedInt(_loc5_.Inventory.Identifier1);
                  break;
               }
            }
            _loc4_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      private function OnSelectedAllClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this._items.length)
         {
            if(Boolean(this._items[_loc2_]) && Boolean(this._items[_loc2_].data) && !this._items[_loc2_].selected)
            {
               this._items[_loc2_].OnSelectedItem(null);
            }
            _loc2_++;
         }
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
         var _loc2_:int = Math.max((this._page - 1) * 10,0);
         var _loc3_:int = Math.min(this._page * 10,this._datas.length);
         var _loc4_:int = 0;
         while(_loc4_ < 10)
         {
            this._items[_loc4_].UpdateUI(_loc2_ + _loc4_ < _loc3_ ? this._datas[_loc2_ + _loc4_] : null);
            if(this._items[_loc4_].data)
            {
               this._slots[_loc4_].Context = this._items[_loc4_].data.Inventory;
            }
            else
            {
               this._slots[_loc4_].Context = null;
            }
            this._slots[_loc4_].Update();
            _loc4_++;
         }
      }
   }
}

