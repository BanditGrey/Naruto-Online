package Processors.Game.Lobby.Shop
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowPetDesc;
   import Processors.Game.Lobby.MakeEquip.EquipSlots.TEquipSlot;
   import Processors.Game.Lobby.MakeEquip.EquipSlots.TEquipSlotList;
   import Processors.Game.Lobby.Shop.data.ShopCellData;
   import Processors.Game.Lobby.Shop.data.ShopData;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHOP;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TProcessorWindowShop extends TProcessorLobbyWindows
   {
      
      protected static const CAPACITY_MC_Tabs:uint = CONST_SHOP.CAPACITY_MC_Tabs;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FEquipSlotList:TEquipSlotList;
      
      protected var FMaterialSlotList:Vector.<TUISlot>;
      
      protected var FMateriaNumTextFieldList:Vector.<TextField>;
      
      protected var FOwnMaterialNumList:Vector.<uint>;
      
      protected var FNeedMaterialNumList:Vector.<uint>;
      
      protected var FCharacter:TCharacter;
      
      protected var FMainUI:MovieClip;
      
      protected var FBTN_Purchase:MovieClip;
      
      protected var FMC_Close:SimpleButton;
      
      protected var FMaterialFilterButton:MovieClip;
      
      protected var FBtn_MaterialFilterSelected:SimpleButton;
      
      protected var FBtn_MaterialFilterUnSelected:SimpleButton;
      
      protected var FBHide:Boolean;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FMC_EquipBoxSlot:TUISlot;
      
      protected var FTF_Todaybuy:TextField;
      
      protected var FTF_Maxbuy:TextField;
      
      protected var FBTN_ShowRecruit:MovieClip;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var FCurTabVector:Array;
      
      protected var FCurShopCellData:ShopCellData;
      
      protected var FShopData:ShopData;
      
      protected var FSelectEquipSlot:TEquipSlot;
      
      protected var FSelectInventory:TInventory;
      
      protected var FEquipInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TProcessorWindowShop(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,FParameters);
         this.FUITab = new TUITab(this);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (stage.stageWidth - 390) / 2;
         this.FProcessorWindowRecruit.y = (stage.stageHeight - 358) / 2;
         this.FProcessorWindowRecruit.Load();
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
         this.FProcessorWindowPetDesc.x = (stage.stageWidth - 390) / 2;
         this.FProcessorWindowPetDesc.y = (stage.stageHeight - 358) / 2;
         this.FProcessorWindowPetDesc.Load();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FEquipInventories = new TInventories();
         this.FShopData = SLogicsCore.ShopLogicData;
         this.FCharacter = SLogicsCore.Character;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_SHOP.RESOURCES_Swf_ID);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:MovieClip = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHOP.RESOURCESID_ClassName_Shop) as MovieClip;
         addChild(_loc1_);
         this.FMainUI = _loc1_[CONST_SHOP.MC_MainUI];
         _loc2_ = this.FMainUI[CONST_SHOP.MC_Tabs];
         _loc4_ = int(CAPACITY_MC_Tabs);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_["MC_Tab_" + _loc5_];
            this.FUITab.SetTabByIndex(_loc3_,_loc5_);
            _loc5_++;
         }
         this.FUITab.Init();
         this.FUITab.OnSwitch = this.OnTabSwitch;
         this.ResourcesDispatch_SlotItem();
         this.FMaterialFilterButton = this.FMainUI[CONST_SHOP.BTN_MaterialFilter];
         if(this.FMaterialFilterButton)
         {
            this.FBtn_MaterialFilterSelected = this.FMaterialFilterButton[CONST_SHOP.BTN_MaterialFilterSelected];
            this.FBtn_MaterialFilterSelected.visible = false;
            this.FBtn_MaterialFilterUnSelected = this.FMaterialFilterButton[CONST_SHOP.BTN_MaterialFilterUnSelected];
            this.FBtn_MaterialFilterUnSelected.visible = true;
         }
         this.FBTN_Purchase = this.FMainUI[CONST_SHOP.BTN_Purchase];
         TGameUtil.setButtonMode(this.FBTN_Purchase,true);
         this.FMC_Close = _loc1_[CONST_SHOP.BTN_CLOSE];
         _loc1_.y = FUICore.StageHeight - _loc1_.height >> 1;
         _loc1_.x = FUICore.StageWidth - _loc1_.width >> 1;
         this.FShopData.InitShopData();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.onCloseHander);
         this.FBTN_Purchase.addEventListener(MouseEvent.CLICK,this.onClickPurchase);
         this.FMaterialFilterButton.addEventListener(MouseEvent.CLICK,this.MaterialFilterOnClick);
         this.FBTN_ShowRecruit.addEventListener(MouseEvent.CLICK,this.OnShowRecruit);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewShop_InfoRet,this.PacketPerform_SC_NewShop_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NewShop_BuyRet,this.PacketPerform_SC_NewShop_Buy);
      }
      
      protected function PacketPerform_SC_NewShop_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.FShopData.SetValueByByteArray(_loc2_);
            _loc4_++;
         }
         if(Boolean(this.FSelectEquipSlot) && Boolean(this.FSelectInventory))
         {
            this.SingleEquipOnClick(this.FSelectEquipSlot,this.FSelectInventory);
         }
      }
      
      protected function PacketPerform_SC_NewShop_Buy(param1:TPacket) : void
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
         EffectGenerateText(this.LangDescByIdentifer(80002329));
         this.PacketPerform_CS_NewShop_Info();
      }
      
      protected function PacketPerform_CS_NewShop_Buy(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewShop_BuyReq);
         _loc2_.Data.writeUnsignedInt(param1);
         _loc2_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_NewShop_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewShop_InfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ResourcesDispatch_SlotItem() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUISlot = null;
         _loc1_ = this.FMainUI[CONST_SHOP.MC_List];
         this.FScrollBar = new TScrollBar(_loc1_,323,false,5);
         this.FEquipSlotList = new TEquipSlotList(this);
         _loc2_ = this.FMainUI[CONST_SHOP.MC_SlotBox];
         this.FMC_EquipBoxSlot = new TUISlot(this);
         this.FMC_EquipBoxSlot.Resource = _loc2_[CONST_SHOP.MC_Slot];
         this.FMC_EquipBoxSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_EquipBoxSlot.OnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FMC_EquipBoxSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_EquipBoxSlot.OnOut = this.SlotsOnOut;
         this.FMC_EquipBoxSlot.Init();
         this.FBTN_ShowRecruit = _loc2_[CONST_SHOP.BTN_ShowRecruit];
         TGameUtil.setButtonMode(this.FBTN_ShowRecruit,true);
         this.FBTN_ShowRecruit.visible = false;
         this.FMaterialSlotList = new Vector.<TUISlot>();
         this.FOwnMaterialNumList = new Vector.<uint>();
         this.FNeedMaterialNumList = new Vector.<uint>();
         this.FMateriaNumTextFieldList = new Vector.<TextField>();
         _loc3_ = int(CONST_SHOP.CAPACITY_MaterialSlot);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = this.FMainUI[CONST_SHOP.MC_MaterialBox][CONST_SHOP.MC_Material_Slot + _loc4_];
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc5_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc5_.OnOverlay = this.SlotsOnMove;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.Init();
            this.FMaterialSlotList[_loc4_] = _loc5_;
            this.FMateriaNumTextFieldList[_loc4_] = this.FMainUI[CONST_SHOP.MC_MaterialBox][CONST_SHOP.MC_Material_Slot + _loc4_][CONST_SHOP.TF_NeedNum] as TextField;
            this.FMateriaNumTextFieldList[_loc4_].visible = false;
            _loc4_++;
         }
         this.FTF_Todaybuy = _loc2_[CONST_SHOP.TF_Todaybuy];
         this.FTF_Maxbuy = _loc2_[CONST_SHOP.TF_Maxbuy];
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Visible && Boolean(this.FEquipSlotList))
         {
            this.UpdateSlots();
         }
         if(Boolean(this.FProcessorWindowRecruit) && this.FProcessorWindowRecruit.Visible)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
         if(Boolean(this.FProcessorWindowPetDesc) && this.FProcessorWindowPetDesc.Visible)
         {
            this.FProcessorWindowPetDesc.UpdataBitmap();
         }
      }
      
      protected function UpdateSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TEquipSlot = null;
         var _loc4_:TUISlot = null;
         _loc2_ = this.FEquipSlotList.Count;
         if(_loc2_ > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FEquipSlotList.GetSlotByIndex(_loc1_);
               _loc3_.Update();
               _loc1_++;
            }
         }
         _loc2_ = this.FMaterialSlotList.length;
         if(_loc2_ > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = this.FMaterialSlotList[_loc1_];
               _loc4_.Update();
               _loc1_++;
            }
         }
         if(this.FMC_EquipBoxSlot != null)
         {
            this.FMC_EquipBoxSlot.Update();
         }
      }
      
      protected function MakeEquipList(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:ShopCellData = null;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:TInventories = null;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:TInventory = null;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:TEquipSlot = null;
         var _loc16_:Dictionary = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         _loc16_ = new Dictionary();
         _loc6_ = new Vector.<uint>();
         _loc7_ = new TInventories();
         _loc9_ = this.GetNeedMaterials();
         this.FEquipSlotList.Clear(this.FScrollBar);
         this.FEquipInventories.Clear();
         _loc3_ = this.FCurTabVector.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FCurTabVector[_loc2_] as ShopCellData;
            _loc11_ = int(_loc4_.ItemMall.Materials.length);
            _loc12_ = true;
            _loc17_ = 0;
            while(_loc17_ < _loc11_)
            {
               _loc13_ = 0;
               _loc14_ = _loc4_.ItemMall.Quantitys[_loc17_];
               _loc18_ = 0;
               while(_loc18_ < _loc9_.Count)
               {
                  _loc10_ = _loc9_.GetInventoryByIndex(_loc18_) as TInventory;
                  if(_loc10_ != null && _loc10_.IDTemplate == _loc4_.ItemMall.Materials[_loc17_])
                  {
                     _loc13_ += _loc10_.Quantity;
                  }
                  _loc18_++;
               }
               if(_loc13_ < _loc14_)
               {
                  _loc12_ = false;
                  break;
               }
               _loc17_++;
            }
            _loc16_[_loc4_.ItemMall.Identifier] = _loc12_;
            _loc6_.push(_loc4_.ItemMall.Itemid);
            _loc2_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FEquipInventories,_loc6_);
         _loc3_ = uint(this.FEquipInventories.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = this.FEquipInventories.GetInventoryByIndex(_loc2_);
            _loc4_ = this.FCurTabVector[_loc2_] as ShopCellData;
            _loc4_.Inventory = _loc8_;
            _loc8_.Quantity = _loc4_.ItemMall.Quantity;
            if(param1 && Boolean(_loc16_[_loc4_.ItemMall.Identifier]))
            {
               _loc7_.Add(_loc8_);
            }
            else if(!param1)
            {
               _loc7_.Add(_loc8_);
            }
            _loc2_++;
         }
         this.FEquipInventories = _loc7_;
         _loc3_ = uint(this.FEquipInventories.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc15_ = new TEquipSlot(this);
            _loc8_ = this.FEquipInventories.GetInventoryByIndex(_loc2_);
            _loc15_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc15_.OnOver = this.SlotsOnMove;
            _loc15_.OnOut = this.SlotsOnOut;
            _loc15_.OnClick = this.SingleEquipOnClick;
            _loc15_.Context = _loc8_;
            _loc15_.Init();
            this.FEquipSlotList.AddDisplay(_loc15_,this.FScrollBar);
            _loc2_++;
         }
      }
      
      protected function OnTabSwitch(param1:int) : void
      {
         this.FTabIndex = param1;
         this.FCurTabVector = this.FShopData.getArrByType(this.FTabIndex);
         this.MakeEquipList(this.FBHide);
         this.Reset();
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(UIComponentsHintOnOver != null)
         {
            UIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(UIComponentsHintOnOut != null)
         {
            UIComponentsHintOnOut(param1,param2);
         }
      }
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:TEquipSlot = null;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:TInventories = null;
         var _loc10_:TUISlot = null;
         var _loc11_:TInventory = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:TextField = null;
         var _loc16_:int = 0;
         _loc8_ = new Vector.<uint>();
         _loc9_ = new TInventories();
         this.FSelectInventory = param2 as TInventory;
         this.FSelectEquipSlot = param1 as TEquipSlot;
         _loc7_ = this.GetNeedMaterials();
         _loc12_ = 0;
         _loc3_ = this.FEquipSlotList.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FEquipSlotList.GetSlotByIndex(_loc4_);
            if(this.FSelectEquipSlot != _loc5_ && _loc5_.BClick)
            {
               _loc5_.BClick = false;
               break;
            }
            _loc4_++;
         }
         this.FSelectEquipSlot.BClick = true;
         _loc3_ = this.FCurTabVector.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.FCurTabVector[_loc4_].Inventory == this.FSelectInventory)
            {
               this.FCurShopCellData = this.FCurTabVector[_loc4_];
               break;
            }
            _loc4_++;
         }
         _loc3_ = this.FCurShopCellData.ItemMall.Materials.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc13_ = 0;
            _loc14_ = this.FCurShopCellData.ItemMall.Quantitys[_loc4_];
            _loc16_ = 0;
            while(_loc16_ < _loc7_.Count)
            {
               _loc6_ = _loc7_.GetInventoryByIndex(_loc16_) as TInventory;
               if(_loc6_ != null && _loc6_.IDTemplate == this.FCurShopCellData.ItemMall.Materials[_loc4_])
               {
                  _loc13_ += _loc6_.Quantity;
               }
               _loc16_++;
            }
            this.FOwnMaterialNumList[_loc4_] = _loc13_;
            this.FNeedMaterialNumList[_loc4_] = _loc14_;
            _loc8_.push(this.FCurShopCellData.ItemMall.Materials[_loc4_]);
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc8_);
         _loc3_ = this.FMaterialSlotList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc10_ = this.FMaterialSlotList[_loc4_];
            _loc15_ = this.FMateriaNumTextFieldList[_loc4_];
            if(_loc4_ < _loc9_.Count)
            {
               _loc11_ = _loc9_.GetInventoryByTempletID(_loc8_[_loc4_]) as TInventory;
               _loc10_.Context = _loc11_;
               _loc15_.text = this.FOwnMaterialNumList[_loc4_] + "/" + this.FNeedMaterialNumList[_loc4_];
               if(this.FOwnMaterialNumList[_loc4_] >= this.FNeedMaterialNumList[_loc4_])
               {
                  _loc12_++;
                  _loc15_.textColor = CONST_COMMON.TEXT_Green_Color;
               }
               else
               {
                  _loc15_.textColor = CONST_COMMON.TEXT_White_Color;
               }
               _loc15_.visible = true;
            }
            else
            {
               _loc10_.Context = null;
               _loc15_.visible = false;
            }
            _loc4_++;
         }
         this.FMC_EquipBoxSlot.Context = this.FSelectInventory;
         this.FTF_Todaybuy.text = this.LangDescByIdentifer(80002363) + (this.FCurShopCellData.ItemMall.Daybuy > 0 ? this.FCurShopCellData.TodayCanBuyCount.toString() : this.LangDescByIdentifer(80002362));
         this.FTF_Maxbuy.text = this.LangDescByIdentifer(80002364) + (this.FCurShopCellData.ItemMall.Maxbuy > 0 ? this.FCurShopCellData.CanBuyCount.toString() : this.LangDescByIdentifer(80002362));
         this.FBTN_ShowRecruit.visible = this.FCurShopCellData.ItemMall.Heroid > 0;
      }
      
      protected function MaterialFilterOnClick(param1:MouseEvent) : void
      {
         this.FBHide = !this.FBHide;
         this.FBtn_MaterialFilterSelected.visible = this.FBHide;
         this.FBtn_MaterialFilterUnSelected.visible = !this.FBHide;
         this.MakeEquipList(this.FBHide);
      }
      
      protected function onClickPurchase(param1:MouseEvent) : void
      {
         if(Boolean(this.FCurShopCellData) && Boolean(this.FCurShopCellData.ItemMall))
         {
            this.PacketPerform_CS_NewShop_Buy(this.FCurShopCellData.ItemMall.Identifier);
         }
      }
      
      protected function onCloseHander(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnShowRecruit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(Boolean(this.FCurShopCellData) && Boolean(this.FCurShopCellData.Inventory))
         {
            _loc2_ = this.FCurShopCellData.ItemMall.Heroid;
            _loc3_ = this.FCurShopCellData.ItemMall.Tpye;
            if(_loc3_ == CONST_SHOP.TYPE_IS_HERO)
            {
               this.FProcessorWindowRecruit.SetHeroData(_loc2_);
            }
            else if(_loc3_ == CONST_SHOP.TYPE_IS_PET)
            {
               this.FProcessorWindowPetDesc.SetPetData(_loc2_);
            }
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PacketPerform_CS_NewShop_Info();
         this.OnTabSwitch(this.FTabIndex);
      }
      
      protected function Reset() : void
      {
         var _loc1_:TUISlot = null;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         this.FMC_EquipBoxSlot.Context = null;
         this.FCurShopCellData = null;
         this.FSelectInventory = null;
         this.FSelectEquipSlot = null;
         this.FBTN_ShowRecruit.visible = false;
         _loc2_ = this.FMaterialSlotList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.FMaterialSlotList[_loc3_];
            _loc1_.Context = null;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FMateriaNumTextFieldList[_loc3_];
            _loc4_.visible = false;
            _loc3_++;
         }
      }
      
      protected function GetNeedMaterials() : TInventories
      {
         var _loc1_:TInventories = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventories = null;
         _loc6_ = new TInventories();
         _loc5_ = int(CONST_COMMON.CAPACITY_INVENTORIES);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc1_ = this.FCharacter.GetBackpackByIndex(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < _loc1_.Count)
            {
               _loc2_ = _loc1_.GetInventoryByIndex(_loc4_);
               _loc6_.Add(_loc2_);
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      protected function LangDescByIdentifer(param1:uint) : String
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,param1) as TSystemLanguage;
         return _loc2_.Desc;
      }
   }
}

