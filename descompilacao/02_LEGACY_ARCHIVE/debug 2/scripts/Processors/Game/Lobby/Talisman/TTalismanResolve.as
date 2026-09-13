package Processors.Game.Lobby.Talisman
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TTreasureUpgrade;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TTalismanResolve extends TProcessorLobbyWindow
   {
      
      protected var TalismanResolveMaterialId:uint = 14107138;
      
      protected var FScene:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FTF_Select_5:TextField;
      
      protected var FTF_Select_6:TextField;
      
      protected var FTF_Select_7:TextField;
      
      protected var FMC_Selected:SimpleButton;
      
      protected var FMC_UnSelect:SimpleButton;
      
      protected var FBtn_Resolve:MovieClip;
      
      protected var FBtn_Combin:MovieClip;
      
      protected var FBtn_Max:MovieClip;
      
      protected var FTF_CombinCount:TextField;
      
      protected var FTF_CombinMax:TextField;
      
      protected var FTF_Count_0:TextField;
      
      protected var FTF_Count_1:TextField;
      
      protected var FMC_Slot0:TUISlot;
      
      protected var FMC_Slot1:TUISlot;
      
      protected var FRoleIndex:uint;
      
      protected var FItemIndex:uint;
      
      protected var FInitialized:Boolean;
      
      protected var FSelectTalismanCount:uint;
      
      protected var FCurCombinCount:uint;
      
      protected var FCombinNeedCount:uint;
      
      protected var FCurMaterialCount:uint;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FTreasureUpgradeBins:TBins;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public function TTalismanResolve(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FInitialized = false;
      }
      
      protected static function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Talisman);
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TALISMAN.RESOURCESID_Swf_Talisman);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TConfigValue = null;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TALISMAN.RESOURCE_ClassName_MC_Resolve) as MovieClip;
         this.x = CONST_TALISMAN.POSX_MC_SCENE;
         this.y = CONST_TALISMAN.POSY_MC_SCENE;
         addChild(this.FScene);
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FTF_Select_5 = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Select_5];
         this.FTF_Select_6 = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Select_6];
         this.FTF_Select_7 = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Select_7];
         this.FMC_Selected = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Selected];
         this.FMC_UnSelect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_UnSelect];
         this.FBtn_Resolve = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_Resolve];
         this.FBtn_Combin = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_Combin];
         this.FBtn_Max = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_Max];
         this.FTF_CombinCount = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_CombinCount];
         this.FTF_CombinMax = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_CombinMax];
         this.FTF_CombinCount.restrict = "[0-9]";
         this.FTF_CombinCount.maxChars = 4;
         this.FTF_Count_0 = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Count_0];
         this.FTF_Count_1 = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Count_1];
         this.FTF_Count_0.mouseEnabled = false;
         this.FTF_Count_1.mouseEnabled = false;
         _loc3_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc3_,Vector.<uint>([this.TalismanResolveMaterialId]));
         this.FMC_Slot0 = new TUISlot(this);
         this.FMC_Slot0.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Slot_Item0];
         this.FMC_Slot0.OnOut = this.SlotOnOut;
         this.FMC_Slot0.OnOverlay = this.SlotOnOver;
         this.FMC_Slot0.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot0.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
         this.FMC_Slot0.Init();
         this.FMC_Slot1 = new TUISlot(this);
         this.FMC_Slot1.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Slot_Item1];
         this.FMC_Slot1.OnOut = this.SlotOnOut;
         this.FMC_Slot1.OnOverlay = this.SlotOnOver;
         this.FMC_Slot1.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot1.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
         this.FMC_Slot1.Init();
         this.FMC_Slot0.Context = _loc3_.GetInventoryByIndex(0);
         this.FMC_Slot1.Context = _loc3_.GetInventoryByIndex(0);
         this.FMC_List = this.FScene[CONST_TALISMAN.RESOURCE_Link_Mc_List];
         this.FScrollBar = new TScrollBar(this.FMC_List,348,false,0);
         this.FTF_CombinCount.addEventListener(Event.CHANGE,this.CombinCountOnChange);
         this.FMC_Selected.addEventListener(MouseEvent.CLICK,this.OnUnSelectAll);
         this.FMC_UnSelect.addEventListener(MouseEvent.CLICK,this.OnSelectAll);
         this.FBtn_Resolve.addEventListener(MouseEvent.CLICK,this.OnResolveTalisman);
         this.FBtn_Combin.addEventListener(MouseEvent.CLICK,this.OnCombinTalismanPaper);
         this.FBtn_Max.addEventListener(MouseEvent.CLICK,this.OnCombinCountMax);
         TGameUtil.setButtonMode(this.FBtn_Max,true);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TALISMAN_CombinTalismanPaperCount) as TConfigValue;
         this.FCombinNeedCount = _loc4_.Value as uint;
         this.FTreasureUpgradeBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TreasureUpgrade);
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function SlotOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2,null);
         }
      }
      
      protected function SlotOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2,null);
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TEquipment = null;
         if(param2 is TEquipment)
         {
            _loc4_ = param2 as TEquipment;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TSingleEquip = null;
         _loc3_ = param1 as TSingleEquip;
         if(_loc3_.IsSelected)
         {
            this.FMC_Selected.visible = false;
            this.FMC_UnSelect.visible = true;
         }
         _loc3_.IsSelected = !_loc3_.IsSelected;
         this.CheckResolveMaterialCount();
      }
      
      protected function ResetView() : void
      {
         this.FTF_Select_5.text = "0";
         this.FTF_Select_6.text = "0";
         this.FTF_Select_7.text = "0";
         this.FTF_CombinCount.text = "0";
         this.FTF_CombinMax.text = "/0";
         this.FTF_Count_0.text = "0";
         this.FTF_Count_1.text = "0";
         TGameUtil.setButtonMode(this.FBtn_Resolve,false);
         TGameUtil.setButtonMode(this.FBtn_Combin,false);
      }
      
      protected function UpdateBackpack() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TArticle = null;
         this.FScrollBar.Clear();
         this.FMC_Selected.visible = false;
         this.FMC_UnSelect.visible = true;
         _loc1_ = this.FMC_SingleEquipList.length;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ > -1)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc2_];
            this.FMC_SingleEquipList.pop();
            _loc3_.StubReferences.Dereference(this);
            _loc2_--;
         }
         this.FMC_SingleEquipList.length = 0;
         _loc1_ = uint(SLogicsCore.Character.Treasures.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = SLogicsCore.Character.Treasures.GetInventoryByIndex(_loc2_);
            if(_loc4_ != null)
            {
               _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc4_.IDTemplate) as TArticle;
               if(!(_loc8_.Level < 5 || _loc8_.Level > 7))
               {
                  _loc5_ = _loc4_.Name;
                  _loc6_ = uint(_loc8_.Level);
                  _loc7_ = _loc4_.Quality;
                  _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
                  _loc3_.StubReferences.Reference(this);
                  _loc3_.OnClick = this.SingleEquipOnClick;
                  _loc3_.OnOut = this.SlotOnOut;
                  _loc3_.OnOver = this.SlotOnOver;
                  _loc3_.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
                  _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
                  _loc3_.IsSelected = false;
                  this.FMC_SingleEquipList.push(_loc3_);
                  _loc3_.SetEquip(_loc4_,_loc5_,STRING_TALISMAN.STRINGS_TalismanLevel + _loc6_,_loc7_);
                  this.FScrollBar.AddItem(_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FInitialized)
         {
            this.FMC_Slot0.Update();
            this.FMC_Slot1.Update();
            _loc2_ = int(this.FMC_SingleEquipList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function CheckResolveMaterialCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TTreasureUpgrade = null;
         var _loc9_:TArticle = null;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc2_ = int(this.FMC_SingleEquipList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FMC_SingleEquipList[_loc1_].IsSelected)
            {
               _loc3_ = this.FMC_SingleEquipList[_loc1_].Context as TInventory;
               _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc3_.IDTemplate) as TArticle;
               if(_loc9_.Level == 5)
               {
                  _loc4_++;
               }
               else if(_loc9_.Level == 6)
               {
                  _loc5_++;
               }
               else if(_loc9_.Level == 7)
               {
                  _loc6_++;
               }
               _loc8_ = this.FTreasureUpgradeBins.GetDatebaseByValue2("Itemid",_loc3_.IDTemplate,"Level",_loc3_.UpgradingLevel) as TTreasureUpgrade;
               _loc7_ += _loc8_.Decomposition;
            }
            _loc1_++;
         }
         this.FTF_Select_5.text = "" + _loc4_;
         this.FTF_Select_6.text = "" + _loc5_;
         this.FTF_Select_7.text = "" + _loc6_;
         this.FSelectTalismanCount = _loc4_ + _loc5_ + _loc6_;
         this.FTF_Count_0.text = "" + _loc7_;
         TGameUtil.setButtonMode(this.FBtn_Resolve,_loc7_ > 0);
      }
      
      protected function CheckCurMaterialCount() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         _loc4_ = SLogicsCore.Character.Appliances;
         _loc2_ = uint(_loc4_.Count);
         this.FCurMaterialCount = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetInventoryByIndex(_loc1_);
            if(_loc3_.IDTemplate == this.TalismanResolveMaterialId)
            {
               this.FCurMaterialCount += _loc3_.Quantity;
            }
            _loc1_++;
         }
         this.FTF_Count_1.text = "" + this.FCurMaterialCount;
         this.FTF_CombinMax.text = "/" + int(this.FCurMaterialCount / this.FCombinNeedCount);
      }
      
      protected function OnSelectAll(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FMC_Selected.visible = true;
         this.FMC_UnSelect.visible = false;
         _loc3_ = int(this.FMC_SingleEquipList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FMC_SingleEquipList[_loc2_].IsSelected = true;
            _loc2_++;
         }
         this.CheckResolveMaterialCount();
      }
      
      protected function OnUnSelectAll(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FMC_Selected.visible = false;
         this.FMC_UnSelect.visible = true;
         _loc3_ = int(this.FMC_SingleEquipList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FMC_SingleEquipList[_loc2_].IsSelected = false;
            _loc2_++;
         }
         this.CheckResolveMaterialCount();
      }
      
      protected function OnCombinCountMax(param1:MouseEvent) : void
      {
         this.FCurCombinCount = uint(this.FCurMaterialCount / this.FCombinNeedCount);
         this.FTF_CombinCount.text = "" + this.FCurCombinCount;
         TGameUtil.setButtonMode(this.FBtn_Combin,this.FCurCombinCount > 0);
      }
      
      protected function CombinCountOnChange(param1:Event) : void
      {
         this.FCurCombinCount = Math.min(uint(this.FTF_CombinCount.text),uint(this.FCurMaterialCount / this.FCombinNeedCount));
         this.FTF_CombinCount.text = "" + this.FCurCombinCount;
         TGameUtil.setButtonMode(this.FBtn_Combin,this.FCurCombinCount > 0);
      }
      
      protected function OnResolveTalisman(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         var _loc6_:TInventory = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TalismanResolveRequest);
         _loc5_ = _loc4_.Data;
         _loc5_.writeShort(this.FSelectTalismanCount);
         _loc3_ = this.FMC_SingleEquipList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FMC_SingleEquipList[_loc2_].IsSelected)
            {
               _loc6_ = this.FMC_SingleEquipList[_loc2_].Context as TInventory;
               _loc5_.writeUnsignedInt(_loc6_.Identifier0);
               _loc5_.writeUnsignedInt(_loc6_.Identifier1);
            }
            _loc2_++;
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function OnCombinTalismanPaper(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TalismanCombinRequest);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCurCombinCount);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function get OnInventoryOut() : Function
      {
         return this.FOnInventoryOut;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function Update(param1:uint, param2:uint = 0) : void
      {
         this.FRoleIndex = param1;
         this.FItemIndex = param2;
         this.ResetView();
         this.UpdateBackpack();
         this.CheckCurMaterialCount();
      }
      
      public function Reset() : void
      {
      }
   }
}

