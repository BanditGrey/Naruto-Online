package Processors.Game.Lobby.Married.Panel
{
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
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.Married.TProcessorMarried;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TUIMarriedTreatment extends TUIBaseWindow
   {
      
      private var _data:Object = null;
      
      protected var FSlot:TUISlot = null;
      
      protected var FEquipInventories:TInventories = null;
      
      public function TUIMarriedTreatment(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         FMC_Scene = param1;
         FMC_Scene.MC_Ring.MC_Ring_Selected.visible = false;
         this.FSlot = this.GetSlot(FMC_Scene.MC_Ring.MC_Ring);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Agree,true);
         FMC_Scene.BTN_Agree.addEventListener(MouseEvent.CLICK,this.onAgreeClick);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reject,true);
         FMC_Scene.BTN_Reject.addEventListener(MouseEvent.CLICK,this.onRejectClick);
         FMC_Scene.BTN_RingProperty.addEventListener(MouseEvent.MOUSE_OVER,this.onRingPropertyOver);
         FMC_Scene.BTN_RingProperty.addEventListener(MouseEvent.MOUSE_OUT,this.onRingPropertyOut);
         this.SetVisible(false);
      }
      
      override public function UpdateUI() : void
      {
         var _loc1_:String = THomelandModel.selfHome.userrace_0;
         var _loc2_:int = int(_loc1_.charAt(_loc1_.length - 1));
         FMC_Scene.MC_Suitor.MC_HeadPortrait.gotoAndStop(_loc2_);
         FMC_Scene.MC_Suitor.Text_Suitor.text = TIllustratedModel.TextFormat(70480027,THomelandModel.selfHome.username_0);
         var _loc3_:Vector.<uint> = new Vector.<uint>();
         _loc3_.push(this._data.Ring);
         this.FEquipInventories = new TInventories();
         var _loc4_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc4_.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FEquipInventories,_loc3_);
         var _loc5_:Object = this.getRingCharge(TUIMarriedApply.RINGS.indexOf(this._data.Ring));
         var _loc6_:TInventory = this.FEquipInventories.GetInventoryByTempletID(this._data.Ring);
         this.FSlot.Context = _loc6_;
         if(_loc5_.type == 0)
         {
            FMC_Scene.MC_Ring.Text_Ring.text = _loc5_.consume + " " + STRING_COMMON.ITEMNAME_Coin;
         }
         else if(_loc5_.type == 2 || _loc5_.type == 3)
         {
            FMC_Scene.MC_Ring.Text_Ring.text = _loc5_.consume + " " + STRING_COMMON.ITEMNAME_Vouchers;
         }
         else
         {
            FMC_Scene.MC_Ring.Text_Ring.text = _loc5_.consume + " " + STRING_COMMON.ITEMNAME_Gold;
         }
      }
      
      override public function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FSlot)
         {
            this.FSlot.Update();
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
      
      private function onAgreeClick(param1:MouseEvent) : void
      {
         var Result:String = null;
         var Inventory:TInventory = null;
         var charge:Object = null;
         var event:MouseEvent = param1;
         var desc:String = "";
         var equipments:TInventories = SLogicsCore.Character.Equipments;
         var ring:TEquipment = equipments.GetInventoryByTempletID(this._data.Ring) as TEquipment;
         if(ring)
         {
            desc = TIllustratedModel.TextFormat(70480021,FMC_Scene.MC_Suitor.Text_Suitor.text);
         }
         else
         {
            Result = TIllustratedModel.SystemLanguage.GetDatebaseByIdentifier(70480030)["Desc"];
            Inventory = this.FEquipInventories.GetInventoryByTempletID(this._data.Ring);
            charge = this.getRingCharge(TUIMarriedApply.RINGS.indexOf(this._data.Ring));
            if(charge.type == 0)
            {
               desc = TUtilityString.Format(Result,charge.consume,STRING_COMMON.ITEMNAME_Coin,Inventory.Name,FMC_Scene.MC_Suitor.Text_Suitor.text);
            }
            else if(charge.type == 2 || charge.type == 3)
            {
               desc = TUtilityString.Format(Result,charge.consume,STRING_COMMON.ITEMNAME_Vouchers,Inventory.Name,FMC_Scene.MC_Suitor.Text_Suitor.text);
            }
            else
            {
               desc = TUtilityString.Format(Result,charge.consume,STRING_COMMON.ITEMNAME_Gold,Inventory.Name,FMC_Scene.MC_Suitor.Text_Suitor.text);
            }
         }
         this.parent["Check"].Show(desc,function agree():void
         {
            var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_AgreeReq);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         },new Point(457,195));
      }
      
      private function onRejectClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.parent["Check"].Show(TIllustratedModel.TextFormat(70480022,FMC_Scene.MC_Suitor.Text_Suitor.text),function reject():void
         {
            var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_MarryReq);
            _loc1_.Data.writeInt(1);
            SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         },new Point(457,195));
      }
      
      private function onRingPropertyOver(param1:MouseEvent) : void
      {
         Parent["Tips"].Show(this._data.Ring,new Point(790,240));
      }
      
      private function onRingPropertyOut(param1:MouseEvent) : void
      {
         Parent["Tips"].Hide();
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         this.UpdateUI();
      }
      
      public function set Status(param1:int) : void
      {
         this.SetVisible(param1 == TProcessorMarried.TREATMENT);
      }
   }
}

