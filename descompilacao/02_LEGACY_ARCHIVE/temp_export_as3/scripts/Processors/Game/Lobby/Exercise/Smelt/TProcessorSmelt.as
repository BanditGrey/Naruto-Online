package Processors.Game.Lobby.Exercise.Smelt
{
   import Components.ComboBox.TComboBox;
   import Components.ScrollBar.TScrollBar;
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
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Smelt.TSmelt;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerSmelt;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorSmelt extends TProcessorBaseActivity
   {
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FMC_ComboBox:TComboBox;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var FList_SmeltItem:Vector.<TSingleEquip>;
      
      protected var FCurrentClickSingleItem:TSingleEquip;
      
      protected var FSmeltSlot:TUISlot;
      
      protected var FCurrentSelectInventory:TInventory;
      
      protected var FBackpackInventories:TInventories;
      
      protected var FUIWindowEditor:TUIWindowEditor;
      
      protected var FUISmeltBuyPopFream:TUISmeltBuyPopFream;
      
      protected var FLeftShowItem:TUIShowItem;
      
      protected var FRightShowItem:TUIShowItem;
      
      protected var FSelectClickList:TInventories = new TInventories();
      
      protected var FSmeltTypeComboBoxSelectIndex:int;
      
      protected var FPageIndex:int;
      
      protected var FBtn_reset:MovieClip;
      
      protected var FBtn_Get:MovieClip;
      
      protected var FBtn_Smelt:MovieClip;
      
      protected var FTF_SmeltSum:TextField;
      
      protected var FTF_NeedPoint:TextField;
      
      protected var FSmelt:TSmelt;
      
      protected var FUnstreamizerSmelt:TUnstreamizerSmelt;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TProcessorSmelt(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         super(param1,param2,param3);
         this.FSmelt = SLogicsCore.Smelt;
         this.FUnstreamizerSmelt = new TUnstreamizerSmelt();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBackpackInventories = new TInventories();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Vector.<DisplayObject> = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:String = null;
         super.ResourcesPerform_UIDispatch();
         this.FSmeltSlot = new TUISlot(this);
         this.FSmeltSlot.Resource = FMC_Scene["Smelt_slot"];
         this.FSmeltSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FSmeltSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FSmeltSlot.OnOverlay = UIComponentsHintOnOver;
         this.FSmeltSlot.OnOut = UIComponentsHintOnOut;
         this.FSmeltSlot.OnClick = this.OnSmeltSlotClick;
         this.FSmeltSlot.Init();
         this.FList_SmeltItem = new Vector.<TSingleEquip>();
         this.FMC_List = FMC_Scene.mc_list;
         this.FScrollBar = new TScrollBar(this.FMC_List,323,false,0);
         _loc1_ = new Vector.<DisplayObject>();
         _loc2_ = [CONST_SYSTEMLANGUAGE.STRING_Smelt_01,CONST_SYSTEMLANGUAGE.STRING_Smelt_02,CONST_SYSTEMLANGUAGE.STRING_Smelt_03,CONST_SYSTEMLANGUAGE.STRING_Smelt_04,CONST_SYSTEMLANGUAGE.STRING_Smelt_05,CONST_SYSTEMLANGUAGE.STRING_Smelt_06,CONST_SYSTEMLANGUAGE.STRING_Smelt_07];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc5_ = new ConsumeFrame(_loc2_[_loc3_]).DescribeString;
            _loc4_ = this.MakeComboItem(_loc5_);
            _loc1_.push(_loc4_);
            _loc3_++;
         }
         this.FMC_ComboBox = new TComboBox(this,FMC_Scene.mc_list_type,_loc1_,50,this.OnTypeSelect);
         this.FTF_SmeltSum = FMC_Scene.TF_SmeltSum;
         this.FTF_NeedPoint = FMC_Scene.TF_NeedPoint;
         this.FLeftShowItem = new TUIShowItem(this,10);
         this.FLeftShowItem.Perform_UIDispatch(FMC_Scene);
         this.FLeftShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FLeftShowItem.OnOut = UIComponentsHintOnOut;
         this.FLeftShowItem.OnClick = this.UIComponentHintClick;
         this.FLeftShowItem.OnPageChange = this.FLeftShowItem.SetSlotFilter;
         this.FRightShowItem = new TUIShowItem(this,6);
         this.FRightShowItem.Perform_UIDispatch(FMC_Scene.MC_RightPanel);
         this.FRightShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FRightShowItem.OnOut = UIComponentsHintOnOut;
         this.FRightShowItem.OnClick = this.UIComponentHintClick_right;
         this.FBtn_reset = FMC_Scene.Btn_reset;
         TGameUtil.setButtonMode(this.FBtn_reset,true);
         this.FBtn_reset.addEventListener(MouseEvent.CLICK,this.OnRestBtnClick);
         this.FBtn_Get = FMC_Scene.Btn_Get;
         TGameUtil.setButtonMode(this.FBtn_Get,true);
         this.FBtn_Get.addEventListener(MouseEvent.CLICK,this.OnGetBtnClick);
         this.FBtn_Smelt = FMC_Scene.Btn_Smelt;
         TGameUtil.setButtonMode(this.FBtn_Smelt,true);
         this.FBtn_Smelt.addEventListener(MouseEvent.CLICK,this.OnSmeltBtnClick);
         this.FUIWindowEditor = new TUIWindowEditor(this.Parent,CONST_MODULES.ACTIVE_Test);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (FUICore.StageWidth - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (FUICore.StageHeight - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         this.FUISmeltBuyPopFream = new TUISmeltBuyPopFream(Parent);
         this.FUISmeltBuyPopFream.Perform_UIDispatch(FMC_Scene.MC_Smelt_Popup);
         this.FUISmeltBuyPopFream.SureBtn = this.PerformPacket_CS_Smelt_BuyReq;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FUISmeltBuyPopFream.Perform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         super.LogicsPerform();
         if(this.FList_SmeltItem)
         {
            _loc2_ = int(this.FList_SmeltItem.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FList_SmeltItem[_loc1_];
               _loc3_.UpdateSingleEquip();
               _loc1_++;
            }
            this.FSmeltSlot.Update();
            this.FLeftShowItem.LogicsPerform();
            this.FRightShowItem.LogicsPerform();
         }
         if(this.FUIWindowEditor != null && this.FUIWindowEditor.visible)
         {
            this.FUIWindowEditor.Update();
         }
         if(Boolean(this.FUISmeltBuyPopFream) && this.FUISmeltBuyPopFream.visible)
         {
            this.FUISmeltBuyPopFream.LogicsPerform();
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.updateSmeltConsumeMatrial();
         this.OnTypeSelect(null,this.FSmeltTypeComboBoxSelectIndex);
         this.FSelectClickList.Clear();
         this.FRightShowItem.ResetSlot();
         this.FTF_SmeltSum.text = this.FSmelt.SmeltSum.toString();
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:Vector.<TBaseBox> = null;
         _loc2_ = int(this.FList_SmeltItem.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FList_SmeltItem[_loc1_];
            _loc3_.StubReferences.Dereference(this);
            _loc1_++;
         }
         this.FList_SmeltItem.length = 0;
         this.FCurrentClickSingleItem = null;
         this.FScrollBar.Clear();
         _loc4_ = this.AcquireShowItemListByType(this.FSmeltTypeComboBoxSelectIndex);
         _loc2_ = int(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this,"EquipSingle");
            _loc3_.StubReferences.Reference(this);
            _loc3_.OnClick = this.OnSingleItemClick;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOut = UIComponentsHintOnOut;
            _loc3_.OnOver = UIComponentsHintOnOver;
            this.FScrollBar.AddItem(_loc3_);
            this.FList_SmeltItem.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function UpdateShowItemList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TSingleEquip = null;
         var _loc5_:Vector.<TBaseBox> = null;
         _loc5_ = this.AcquireShowItemListByType(this.FSmeltTypeComboBoxSelectIndex);
         _loc2_ = int(this.FList_SmeltItem.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc5_[_loc1_].Inventory;
            _loc4_ = this.FList_SmeltItem[_loc1_];
            _loc4_.SetEquip(_loc3_,_loc5_[_loc1_].Price.toString(),TUtilityString.Format(STRING_OhtsutsukiKaguya.XIANGOU,_loc5_[_loc1_].BuyCount),0);
            _loc1_++;
         }
      }
      
      protected function AcquireShowItemListByType(param1:int = 0) : Vector.<TBaseBox>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         var _loc5_:Vector.<TBaseBox> = null;
         _loc5_ = new Vector.<TBaseBox>();
         _loc3_ = int(this.FSmelt.ShowList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FSmelt.ShowList[_loc2_] as TBaseBox;
            if(_loc4_.Type == param1)
            {
               _loc5_.push(_loc4_);
            }
            _loc2_++;
         }
         return param1 > 0 ? _loc5_ : this.FSmelt.ShowList;
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance("listitem") as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function OnTypeSelect(param1:Object, param2:int) : void
      {
         this.FSmeltTypeComboBoxSelectIndex = param2;
         this.ConstructScroolBar();
         this.UpdateShowItemList();
      }
      
      protected function OnSingleItemClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TSingleEquip = null;
         _loc3_ = param1 as TSingleEquip;
         if(this.FCurrentClickSingleItem != null)
         {
            this.FCurrentClickSingleItem.BClick = false;
         }
         this.FCurrentClickSingleItem = _loc3_;
         this.FCurrentSelectInventory = param2 as TInventory;
         this.UpdateCurrentSelectSlot();
      }
      
      protected function UpdateCurrentSelectSlot() : void
      {
         this.FSmeltSlot.Context = this.FCurrentSelectInventory;
         this.FTF_NeedPoint.text = new ConsumeFrame(CONST_SYSTEMLANGUAGE.STRING_Smelt_08).DescribeString + this.FCurrentClickSingleItem.TF_TalismanName.text;
      }
      
      protected function OnSmeltSlotClick(param1:Object, param2:Object) : void
      {
         this.Reset();
         this.FCurrentSelectInventory = null;
         UIComponentsHintOnOut(param1,param2 as TInventory);
      }
      
      protected function updateSmeltConsumeMatrial() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = int(CONST_COMMON.CAPACITY_INVENTORIES);
         this.FBackpackInventories.Clear();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ != CONST_COMMON.INVENTORIESINDEX_Gems)
            {
               _loc1_ = SLogicsCore.Character.GetBackpackByIndex(_loc5_);
               _loc6_ = 0;
               while(_loc6_ < this.FSmelt.SmeltList.Count)
               {
                  _loc2_ = this.FSmelt.SmeltList.GetInventoryByIndex(_loc6_);
                  _loc3_ = int(_loc1_.GetAllCountByTempletID(_loc2_.IDTemplate));
                  if(_loc3_ > 0)
                  {
                     _loc2_.Quantity = _loc3_;
                     this.FBackpackInventories.Add(_loc2_);
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         this.FLeftShowItem.UpdateUI(this.FBackpackInventories);
         this.FLeftShowItem.SetSlotFilter();
      }
      
      protected function UIComponentHintClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         if(_loc3_.Quantity == 0)
         {
            return;
         }
         this.FUIWindowEditor.Context = _loc3_;
         this.FUIWindowEditor.Label = _loc3_.Name;
         this.FUIWindowEditor.Quantity = String(_loc3_.Quantity);
         this.FUIWindowEditor.Value = _loc3_.Quantity;
         this.FUIWindowEditor.Max = _loc3_.Quantity;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.visible = true;
      }
      
      protected function UIComponentHintClick_right(param1:Object, param2:Object) : void
      {
         var _loc4_:TInventory = null;
         var _loc3_:TInventory = param2 as TInventory;
         var _loc5_:int = 0;
         while(_loc5_ < this.FBackpackInventories.Count)
         {
            _loc4_ = this.FBackpackInventories.GetInventoryByIndex(_loc5_);
            if(_loc4_.IDTemplate == _loc3_.IDTemplate)
            {
               _loc4_.Quantity += _loc3_.Quantity;
               break;
            }
            _loc5_++;
         }
         this.FSelectClickList.DeleteInventoryByTempletID(_loc3_.IDTemplate);
         this.FRightShowItem.UpdateUI(this.FSelectClickList);
         this.FLeftShowItem.SetSlotFilter();
         this.intredeemPoint();
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      protected function Reset() : void
      {
         this.FSmeltSlot.Context = null;
         if(this.FCurrentClickSingleItem != null)
         {
            this.FCurrentClickSingleItem.BClick = false;
         }
         this.FCurrentClickSingleItem = null;
         this.FSelectClickList.Clear();
         this.FTF_NeedPoint.text = "";
      }
      
      protected function WindowEditorOnOK(param1:TUIWindowEditor) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TInventory = null;
         var _loc2_:Boolean = true;
         var _loc5_:TInventories = new TInventories();
         var _loc6_:Vector.<uint> = new Vector.<uint>();
         _loc4_ = param1.Context as TInventory;
         if(param1.Value <= _loc4_.Quantity)
         {
            _loc4_.Quantity -= param1.Value;
         }
         var _loc7_:int = 0;
         while(_loc7_ < this.FSelectClickList.Count)
         {
            _loc3_ = this.FSelectClickList.GetInventoryByIndex(_loc7_);
            if(_loc3_.IDTemplate == _loc4_.IDTemplate)
            {
               _loc3_.Quantity += param1.Value;
               _loc2_ = false;
            }
            _loc7_++;
         }
         if(_loc2_)
         {
            _loc6_.push(_loc4_.IDTemplate);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_,_loc6_);
            _loc3_ = _loc5_.GetInventoryByIndex(0);
            _loc3_.Quantity = param1.Value;
            _loc3_.LimitCount = _loc4_.LimitCount;
            this.FSelectClickList.Add(_loc3_);
         }
         this.FRightShowItem.UpdateUI(this.FSelectClickList);
         this.FLeftShowItem.SetSlotFilter();
         this.intredeemPoint();
      }
      
      protected function intredeemPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.FSelectClickList.Count)
         {
            _loc2_ = this.FSelectClickList.GetInventoryByIndex(_loc4_);
            if(_loc2_)
            {
               _loc3_ += _loc2_.LimitCount * _loc2_.Quantity;
            }
            _loc4_++;
         }
         this.FTF_SmeltSum.htmlText = this.FSmelt.SmeltSum + "<font color=\'#00CC33\'>(+" + _loc3_ + ")</font>";
      }
      
      protected function WindowEditorOnMax(param1:TUIWindowEditor) : void
      {
         param1.Value = param1.Max;
      }
      
      protected function OnSmeltBtnClick(param1:MouseEvent) : void
      {
         this.PerformPacket_CS_Smelt_SellReq();
      }
      
      protected function OnGetBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<TBaseBox> = null;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         if(this.FCurrentSelectInventory)
         {
            this.FUISmeltBuyPopFream.visible = true;
            _loc2_ = this.AcquireShowItemListByType(this.FSmeltTypeComboBoxSelectIndex);
            _loc3_ = int(_loc2_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = _loc2_[_loc5_].Inventory;
               if(_loc4_ == this.FCurrentSelectInventory)
               {
                  this.FUISmeltBuyPopFream.CurData = _loc2_[_loc5_];
                  break;
               }
               _loc5_++;
            }
         }
      }
      
      protected function OnRestBtnClick(param1:MouseEvent) : void
      {
         while(this.FSelectClickList.Count)
         {
            this.UIComponentHintClick_right(null,this.FSelectClickList.GetInventoryByIndex(0));
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Smelt_SellReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc3_:TInventory = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Smelt_SellReq);
         _loc1_.Data.writeShort(this.FSelectClickList.Count);
         var _loc2_:int = 0;
         while(_loc2_ < this.FSelectClickList.Count)
         {
            _loc3_ = this.FSelectClickList.GetInventoryByIndex(_loc2_);
            _loc1_.Data.writeUnsignedInt(_loc3_.IDTemplate);
            _loc1_.Data.writeUnsignedInt(_loc3_.Quantity);
            _loc2_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Smelt_BuyReq(param1:TBaseBox, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Smelt_BuyReq);
         _loc3_.Data.writeUnsignedInt(param1.Inventory.IDTemplate);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FRightShowItem.ResetSlot();
         this.FUISmeltBuyPopFream.CurData = null;
         this.FCurrentSelectInventory = null;
         this.Reset();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerSmelt.Unstreamize(_loc2_,this.FSmelt,null);
         this.UpdateUI();
      }
      
      public function ProcessorOnSellRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FSmelt.SmeltSum = _loc2_.readInt();
         this.UpdateUI();
      }
      
      public function ProcessorOnBuyRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(new ConsumeFrame(CONST_SYSTEMLANGUAGE.STRING_Smelt_09).DescribeString);
         this.PerformPacket_CS_LoadInfoReq();
      }
   }
}

