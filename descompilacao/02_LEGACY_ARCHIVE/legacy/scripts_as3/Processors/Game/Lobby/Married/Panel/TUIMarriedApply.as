package Processors.Game.Lobby.Married.Panel
{
   import Components.ComboBox.TComboBox;
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TFriendDigest;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.Married.TProcessorMarried;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TUIMarriedApply extends TUIBaseWindow
   {
      
      public static var RINGS:Vector.<uint> = null;
      
      private var _data:Object = null;
      
      private var _ring:Number = 0;
      
      private var _user:Number = 0;
      
      protected var FEquipInventories:TInventories = null;
      
      protected var FFriendComboBox:TComboBox = null;
      
      protected var FItems:Vector.<MovieClip> = null;
      
      protected var FSlots:Vector.<TUISlot> = null;
      
      public function TUIMarriedApply(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Object = null;
         var _loc8_:TInventory = null;
         FMC_Scene = param1;
         RINGS = new Vector.<uint>();
         RINGS.push(14211709);
         RINGS.push(14211710);
         RINGS.push(14211711);
         var _loc2_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var _loc3_:int = int(SLogicsCore.Friends.Count);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = TUtilityReflection.CreateDisplayObjectInstance("friend_item") as MovieClip;
            _loc6_.tf_into.text = SLogicsCore.Friends.GetDigestByIndex(_loc4_).Name;
            _loc2_.push(_loc6_);
            _loc4_++;
         }
         this.FFriendComboBox = new TComboBox(FMC_Scene,FMC_Scene["mc_friend_list"],_loc2_,78,this.onFriendSelected);
         this.FEquipInventories = new TInventories();
         var _loc5_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc5_.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FEquipInventories,RINGS);
         this.FItems = new Vector.<MovieClip>();
         this.FSlots = new Vector.<TUISlot>();
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc7_ = this.getRingCharge(_loc4_);
            _loc8_ = this.FEquipInventories.GetInventoryByIndex(_loc4_);
            this.FItems.push(FMC_Scene["MC_Ring_" + _loc4_]);
            if(_loc7_.type == 0)
            {
               this.FItems[_loc4_].Text_Ring.text = _loc7_.consume + STRING_COMMON.ITEMNAME_Coin;
            }
            else if(_loc7_.type == 2 || _loc7_.type == 3)
            {
               this.FItems[_loc4_].Text_Ring.text = _loc7_.consume + STRING_COMMON.ITEMNAME_Vouchers;
            }
            else
            {
               this.FItems[_loc4_].Text_Ring.text = _loc7_.consume + STRING_COMMON.ITEMNAME_Gold;
            }
            this.FSlots.push(this.GetSlot(FMC_Scene["MC_Ring_" + _loc4_]["MC_Ring"]));
            this.FSlots[_loc4_].Context = _loc8_;
            _loc4_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Apply,true);
         FMC_Scene.BTN_Apply.addEventListener(MouseEvent.CLICK,this.onApplyClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Cancel,true);
         FMC_Scene.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.onCancelClick);
         FMC_Scene.BTN_RingProperty.addEventListener(MouseEvent.MOUSE_OVER,this.onRingPropertyOver);
         FMC_Scene.BTN_RingProperty.addEventListener(MouseEvent.MOUSE_OUT,this.onRingPropertyOut);
         this.SetVisible(false);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this.FSlots)
         {
            _loc1_ = int(this.FSlots.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.FSlots[_loc2_].Update();
               _loc2_++;
            }
         }
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
      
      private function getRingCharge(param1:int) : Object
      {
         var _loc2_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         var _loc3_:TConfigValue = _loc2_.GetDatebaseByIdentifier(91100014) as TConfigValue;
         return _loc3_.Value[param1];
      }
      
      private function onFriendSelected(param1:Object, param2:int) : void
      {
         this._user = param2;
      }
      
      private function onRingClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FItems.length)
         {
            this.FItems[_loc2_].MC_Ring_Selected.visible = this.FItems[_loc2_] == param1.currentTarget;
            if(this.FItems[_loc2_].MC_Ring_Selected.visible)
            {
               this._ring = _loc2_;
            }
            _loc2_++;
         }
      }
      
      private function onApplyClick(param1:MouseEvent) : void
      {
         var desc:String = null;
         var friend:TFriendDigest = null;
         var equipments:TInventories = null;
         var ring:TEquipment = null;
         var Inventory:TInventory = null;
         var Result:String = null;
         var bin:TBins = null;
         var config:TConfigValue = null;
         var charge:Object = null;
         var event:MouseEvent = param1;
         if(SLogicsCore.Friends.Count > 0)
         {
            desc = "";
            friend = SLogicsCore.Friends.GetDigestByIndex(this._user);
            equipments = SLogicsCore.Character.Equipments;
            ring = equipments.GetInventoryByTempletID(RINGS[this._ring]) as TEquipment;
            if(ring)
            {
               desc = TIllustratedModel.TextFormat(70480019,friend.Name);
            }
            else
            {
               Inventory = this.FEquipInventories.GetInventoryByIndex(this._ring);
               Result = TIllustratedModel.SystemLanguage.GetDatebaseByIdentifier(70480020)["Desc"];
               bin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
               config = bin.GetDatebaseByIdentifier(91100014) as TConfigValue;
               charge = config.Value[this._ring];
               if(charge.type == 0)
               {
                  desc = TUtilityString.Format(Result,charge.consume,STRING_COMMON.ITEMNAME_Coin,Inventory.Name,friend.Name);
               }
               else if(charge.type == 2 || charge.type == 3)
               {
                  desc = TUtilityString.Format(Result,charge.consume,STRING_COMMON.ITEMNAME_Vouchers,Inventory.Name,friend.Name);
               }
               else
               {
                  desc = TUtilityString.Format(Result,charge.consume,STRING_COMMON.ITEMNAME_Gold,Inventory.Name,friend.Name);
               }
            }
            this.parent["Check"].Show(desc,function apply():void
            {
               var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_MarryReq);
               _loc1_.Data.writeInt(0);
               _loc1_.Data.writeUnsignedInt(friend.Identifier0);
               _loc1_.Data.writeUnsignedInt(friend.Identifier1);
               _loc1_.Data.writeInt(RINGS[_ring]);
               SNetworkCore.Transceiver.PacketTransmit(_loc1_);
            },new Point(457,195));
         }
      }
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var friend:TFriendDigest = SLogicsCore.Friends.GetDigestByIndex(this._user);
         this.parent["Check"].Show(TIllustratedModel.TextFormat(70480023,friend.Name),function cancel():void
         {
            var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_MarryReq);
            _loc1_.Data.writeInt(1);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         },new Point(457,195));
      }
      
      private function onRingPropertyOver(param1:MouseEvent) : void
      {
         Parent["Tips"].Show(-1,new Point(790,100));
      }
      
      private function onRingPropertyOut(param1:MouseEvent) : void
      {
         Parent["Tips"].Hide();
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TFriendDigest = null;
         this._data = param1;
         FMC_Scene["BTN_Apply"].visible = this._data.status == 0;
         FMC_Scene["BTN_Cancel"].visible = this._data.status == 1;
         if(this._data.status == 0)
         {
            this.FFriendComboBox.Enabled = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Apply,SLogicsCore.Friends.Count > 0);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               this.FItems[_loc2_].MC_Ring_Selected.visible = false;
               this.FItems[_loc2_].addEventListener(MouseEvent.CLICK,this.onRingClick);
               if(_loc2_ == 0)
               {
                  this._ring = 0;
                  this.FItems[_loc2_].MC_Ring_Selected.visible = true;
               }
               _loc2_++;
            }
         }
         else if(this._data.status == 1)
         {
            this.FFriendComboBox.Enabled = false;
            _loc3_ = int(SLogicsCore.Friends.Count);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = SLogicsCore.Friends.GetDigestByIndex(_loc2_);
               if(_loc4_.Identifier0 == this._data.Identifier0 && _loc4_.Identifier1 == this._data.Identifier1)
               {
                  this.FFriendComboBox.SetChildSelectByIndex(_loc2_);
                  break;
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               this.FItems[_loc2_].MC_Ring_Selected.visible = false;
               this.FItems[_loc2_].removeEventListener(MouseEvent.CLICK,this.onRingClick);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < RINGS.length)
            {
               if(RINGS[_loc2_] == this._data.ring)
               {
                  this._ring = _loc2_;
                  this.FItems[_loc2_].MC_Ring_Selected.visible = true;
               }
               _loc2_++;
            }
         }
      }
      
      public function set Status(param1:int) : void
      {
         this.SetVisible(param1 == TProcessorMarried.APPLY);
      }
   }
}

