package Processors.Game.Lobby.Smithy
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEnchantValue;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Processors.Game.Lobby.Smithy.Online.TextFieldLine;
   import Processors.Game.Lobby.Store.data.NewMallCellData;
   import Processors.Game.Lobby.Store.data.TPressorWindowPopBuyFream;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SMITHY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class SmithyWindowEnchant extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_ENCHANT:int = 1;
      
      protected static const MAX_ENCHANT_LEVEL:uint = 40;
      
      protected static const STONE_COUNT:uint = 6;
      
      protected static const ALLMaterial_ID:uint = 14107010;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FCurrentState:int;
      
      protected var FInitialization:Boolean;
      
      protected var FTPressorWindowPopBuyFream:TPressorWindowPopBuyFream = null;
      
      protected var FEquipmentSlot:TUISlot;
      
      protected var FEquipment:TEquipment;
      
      protected var FStoneSlot:Vector.<TUISlot>;
      
      protected var FTextFieldLine:Vector.<TextFieldLine>;
      
      protected var FMC_IconHighLight:Vector.<Sprite>;
      
      protected var FBtn_Enchant:MovieClip;
      
      protected var FBtn_Left:MovieClip;
      
      protected var FBtn_Right:MovieClip;
      
      protected var FBtn_Buy:MovieClip;
      
      protected var FStoneIndex:int;
      
      protected var FStoneMaxCount:uint;
      
      protected var FArticleBins:TBins;
      
      protected var FStoneVect:Vector.<uint>;
      
      protected var FCurProtectStoreId:int;
      
      protected var FStoneInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FInventories:TInventories;
      
      protected var FMC_CurMaterialIcon:MovieClip;
      
      protected var FMC_AllMaterialIcon:MovieClip;
      
      protected var FTF_CurMaterial:TextField;
      
      protected var FTF_AllMaterial:TextField;
      
      protected var FTF_CurValue:TextField;
      
      protected var FTF_NextValue:TextField;
      
      protected var FTF_CurEnchantLevel:TextField;
      
      protected var FTF_MaterialName:TextField;
      
      protected var FTF_UseMaterial:TextField;
      
      protected var FTF_Rate:TextField;
      
      protected var FTF_CurType:TextField;
      
      protected var FTF_NextType:TextField;
      
      protected var FEnchantValue:TEnchantValue;
      
      protected var FEnchantValueBins:TBins;
      
      protected var FSmithyEnchantCoefficient:Number;
      
      protected var FMaterialCount:uint;
      
      protected var FUseMaterialCount:uint;
      
      protected var FUseMaterialName:String;
      
      protected var FAllMaterialCount:uint;
      
      protected var FMaterialInventorys:TInventories;
      
      protected var FIconTipInventory:TInventory;
      
      protected var FCurMaterialId:uint;
      
      protected var FNimei:uint;
      
      protected var FYouDianYiSi:Boolean;
      
      protected var FHeroID:uint;
      
      protected var FEnchantNetwork:Function;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FBackReset:Function;
      
      public function SmithyWindowEnchant(param1:TUIComponent)
      {
         super(param1);
         this.FInventories = SLogicsCore.Character.Appliances;
         this.FTPressorWindowPopBuyFream = new TPressorWindowPopBuyFream(param1.Parent);
         this.FTPressorWindowPopBuyFream.OnOver = this.UIComponentsHintOnOver;
         this.FTPressorWindowPopBuyFream.OnOut = this.UIComponentsHintOnOut;
         this.FTPressorWindowPopBuyFream.SureBtn = this.C_S_BuyGoods;
         this.FTPressorWindowPopBuyFream.CancelBtn = this.Buy_Cancel;
      }
      
      protected function C_S_BuyGoods(param1:NewMallCellData, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMall_BuyGoods);
         _loc3_.Data.writeUnsignedInt(param1.NewMall.Identifier);
         _loc3_.Data.writeUnsignedInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         this.FTPressorWindowPopBuyFream.Visible = false;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TextFieldLine = null;
         var _loc5_:TextField = null;
         var _loc6_:Sprite = null;
         this.addChild(param1);
         this.FTPressorWindowPopBuyFream.Load();
         this.FEquipmentSlot = new TUISlot(this);
         this.FEquipmentSlot.Resource = param1["Wash_Slot"];
         this.FStoneSlot = new Vector.<TUISlot>(STONE_COUNT);
         _loc2_ = 0;
         while(_loc2_ < STONE_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = param1["KeepStone" + _loc2_];
            this.FStoneSlot[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.FTextFieldLine = new Vector.<TextFieldLine>(STONE_COUNT);
         _loc2_ = 0;
         while(_loc2_ < STONE_COUNT)
         {
            _loc4_ = new TextFieldLine();
            _loc5_ = param1["TF_BuyText_" + _loc2_];
            _loc4_.CreationThisClass(_loc5_,_loc2_.toString(),_loc5_.text);
            _loc4_.BackFunc = this.TextFieldLineBackFunction;
            this.FTextFieldLine[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FMC_IconHighLight = new Vector.<Sprite>(STONE_COUNT);
         _loc2_ = 0;
         while(_loc2_ < STONE_COUNT)
         {
            _loc6_ = param1["MC_IconHighLight_" + _loc2_];
            _loc6_.mouseEnabled = false;
            this.FMC_IconHighLight[_loc2_] = _loc6_;
            _loc2_++;
         }
         this.FBtn_Enchant = param1["SingleEnchant"];
         this.FBtn_Left = param1["Btn_Left"];
         this.FBtn_Right = param1["Btn_Right"];
         this.FBtn_Buy = param1["Btn_BuyStone"];
         this.FTF_CurMaterial = param1["tf_CurMaterial"];
         this.FTF_AllMaterial = param1["tf_AllMaterial"];
         this.FTF_CurValue = param1["tf_CurValue"];
         this.FTF_NextValue = param1["tf_NextValue"];
         this.FTF_CurEnchantLevel = param1["tf_CurEnchantLevel"];
         this.FTF_MaterialName = param1["tf_MaterialName"];
         this.FTF_UseMaterial = param1["tf_UseMaterial"];
         this.FTF_Rate = param1["tf_Rate"];
         this.FTF_CurType = param1["tf_CurType"];
         this.FTF_NextType = param1["tf_NextType"];
         this.FMC_CurMaterialIcon = param1["mc_CurMaterialIcon"];
         this.FMC_AllMaterialIcon = param1["mc_AllMaterialIcon"];
         this.FMC_AllMaterialIcon.gotoAndStop("icon" + ALLMaterial_ID);
      }
      
      public function Perform_UILocation() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Vector.<uint> = null;
         var _loc3_:TConfigValue = null;
         TJadeCommon.InitSlot(this.FEquipmentSlot,CONST_MODULES.MODULE_Smithy);
         this.FEquipmentSlot.OnClick = this.OnSlotClick;
         this.FEquipmentSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FEquipmentSlot.OnOut = this.UIComponentsHintOnOut;
         this.FEquipmentSlot.Init();
         _loc1_ = 0;
         while(_loc1_ < STONE_COUNT)
         {
            TJadeCommon.InitSlot(this.FStoneSlot[_loc1_],CONST_MODULES.MODULE_Smithy);
            this.FStoneSlot[_loc1_].OnOverlay = this.UIComponentsHintOnOver;
            this.FStoneSlot[_loc1_].OnOut = this.UIComponentsHintOnOut;
            this.FStoneSlot[_loc1_].Init();
            _loc1_++;
         }
         this.FMC_CurMaterialIcon.addEventListener(MouseEvent.MOUSE_MOVE,this.OnIconMouseMove);
         this.FMC_CurMaterialIcon.addEventListener(MouseEvent.ROLL_OUT,this.OnIconMouseOut);
         this.FMC_AllMaterialIcon.addEventListener(MouseEvent.MOUSE_MOVE,this.OnIconMouseMove);
         this.FMC_AllMaterialIcon.addEventListener(MouseEvent.ROLL_OUT,this.OnIconMouseOut);
         this.FBtn_Enchant.addEventListener(MouseEvent.CLICK,this.OnBtnEnchantClick);
         TGameUtil.setButtonMode(this.FBtn_Left,true);
         TGameUtil.setButtonMode(this.FBtn_Right,true);
         TGameUtil.setButtonMode(this.FBtn_Buy,true);
         this.FBtn_Left.addEventListener(MouseEvent.CLICK,this.OnBtnLeftClick);
         this.FBtn_Right.addEventListener(MouseEvent.CLICK,this.OnBtnRightClick);
         this.FBtn_Buy.addEventListener(MouseEvent.CLICK,this.OnBtnBuyClick);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FEnchantValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantValue);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Smithy_Enchant_Coefficient) as TConfigValue;
         this.FSmithyEnchantCoefficient = _loc3_.Value as Number;
         this.FStoneVect = this.GetArticleIdByMinorType(CONST_INVENTORY.CATEGORYSECOND_EnchantStone);
         this.FStoneIndex = 0;
         this.FStoneMaxCount = this.FStoneVect.length;
         this.FStoneInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FStoneInventories,this.FStoneVect);
         _loc2_ = this.GetArticleIdByMinorType(CONST_INVENTORY.CATEGORYSECOND_EnchantMaterial);
         this.FMaterialInventorys = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FMaterialInventorys,_loc2_);
         this.UpdateStone();
         this.CheckBtn();
         this.FInitialization = true;
      }
      
      protected function GetStoneIdByEquipLevel() : uint
      {
         var _loc1_:TEnchantValue = null;
         var _loc2_:TEnchantValue = null;
         _loc1_ = this.GetEnchantValue();
         return 1;
      }
      
      protected function GetArticleIdByMinorType(param1:uint) : Vector.<uint>
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TArticle = null;
         var _loc5_:Vector.<uint> = null;
         _loc5_ = new Vector.<uint>();
         _loc3_ = uint(this.FArticleBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FArticleBins.GetDatebaseByIndex(_loc2_) as TArticle;
            if(_loc4_.MinorType == param1)
            {
               _loc5_.push(_loc4_.Identifier);
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(this.FInitialization && Visible)
         {
            this.FEquipmentSlot.Update();
            _loc1_ = 0;
            while(_loc1_ < STONE_COUNT)
            {
               this.FStoneSlot[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      protected function ResetBtn() : void
      {
         TGameUtil.setButtonMode(this.FBtn_Enchant,false);
         if(this.FBackReset != null)
         {
            this.FBackReset();
         }
      }
      
      protected function SendEquipment(param1:TEquipment) : void
      {
         this.FEquipment = param1;
         TGameUtil.setButtonMode(this.FBtn_Enchant,this.FEquipment != null);
         this.UpdateEquipmentSlot();
      }
      
      protected function UpdateEquipmentSlot() : void
      {
         var _loc1_:TEnchantValue = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TArticle = null;
         this.FEquipmentSlot.Context = this.FEquipment;
         if(this.FEquipment == null)
         {
            this.FMaterialCount = 0;
            this.FTF_CurMaterial.text = this.FMaterialCount.toString();
            this.FTF_CurValue.text = "0";
            this.FTF_NextValue.text = "0";
            this.FTF_CurEnchantLevel.text = "0";
            this.FTF_UseMaterial.text = "0";
            this.FTF_Rate.text = "0";
            this.FTF_CurType.text = "";
            this.FTF_NextType.text = "";
            this.FCurMaterialId = 0;
            this.FCurProtectStoreId = 0;
         }
         else
         {
            _loc1_ = this.GetEnchantValue();
            if(_loc1_ == null)
            {
               this.FCurProtectStoreId = 0;
               this.SendEquipment(null);
               EffectGenerateText(STRING_SMITHY.STRING_EnchantEquipLimit);
               return;
            }
            this.FCurProtectStoreId = _loc1_.ProtectStone;
            this.FCurMaterialId = this.GetMateriaId(_loc1_.EnchantStones);
            this.FMaterialCount = this.GetItemCount(this.FCurMaterialId);
            _loc4_ = this.FArticleBins.GetDatebaseByIdentifier(this.FCurMaterialId) as TArticle;
            this.FUseMaterialCount = _loc1_.EnchantConsume;
            this.FUseMaterialName = _loc4_.Name;
            _loc2_ = BASEATTRIBUTENAMES.indexOf(this.FEquipment.BasisPropertyCategory);
            _loc3_ = STRINGS_BASEATTRIBUTENAMES[_loc2_];
            this.FTF_CurType.text = _loc3_ + ":";
            this.FTF_NextType.text = _loc3_ + ":";
            this.FTF_CurMaterial.text = this.FMaterialCount.toString();
            this.FTF_CurValue.text = "+" + this.FEquipment.EnchantValue.toString();
            this.FTF_NextValue.text = "+" + int(_loc1_.LevelCoefficient * this.FEquipment.EnchantCoefficient * _loc1_.TypeCoefficient * (this.FEquipment.UpgradingLevel + this.FSmithyEnchantCoefficient)).toString();
            this.FTF_CurEnchantLevel.text = this.FEquipment.EnchantLevel.toString();
            this.FTF_MaterialName.text = STRING_COMMON.COMMON_COST + _loc4_.Name;
            this.FTF_UseMaterial.text = this.FUseMaterialCount.toString();
            if(this.HasKeepStone(_loc1_.ProtectStone))
            {
               this.FTF_Rate.text = "100%";
            }
            else
            {
               this.FTF_Rate.text = Number(_loc1_.EnchantSuccessrate / 10) + "%";
            }
            this.FMC_CurMaterialIcon.gotoAndStop("icon" + this.FCurMaterialId);
         }
         this.FAllMaterialCount = this.GetItemCount(ALLMaterial_ID);
         this.FTF_AllMaterial.text = this.FAllMaterialCount.toString();
         this.UpdateRefreshNew();
      }
      
      protected function ResetEquipmentSlot() : void
      {
         this.FEquipment = null;
         this.UpdateEquipmentSlot();
      }
      
      protected function GetEnchantValue() : TEnchantValue
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TEnchantValue = null;
         _loc2_ = uint(this.FEnchantValueBins.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEnchantValueBins.GetDatebaseByIndex(_loc1_) as TEnchantValue;
            if(_loc3_.Type == this.FEquipment.CategorySecond && this.FEquipment.RequirementLevel >= _loc3_.MinEquipLevel && this.FEquipment.RequirementLevel <= _loc3_.MaxEquipLevel && this.FEquipment.EnchantLevel + 1 == _loc3_.Level)
            {
               return _loc3_;
            }
            _loc1_++;
         }
         return null;
      }
      
      protected function GetMateriaId(param1:Vector.<uint>) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc5_ = 0;
         _loc3_ = param1.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_];
            if(_loc4_ != ALLMaterial_ID)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return ALLMaterial_ID;
      }
      
      protected function HasKeepStone(param1:uint) : Boolean
      {
         return this.GetItemCount(param1) > 0;
      }
      
      protected function GetMaterialInventory(param1:uint) : TInventory
      {
         return this.FMaterialInventorys.GetInventoryByTempletID(param1);
      }
      
      protected function OnBtnEnchantClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FEquipment == null)
         {
            return;
         }
         if(this.FEquipment.EnchantLevel >= MAX_ENCHANT_LEVEL)
         {
            EffectGenerateText(STRING_SMITHY.STRING_MAXEnchant);
            return;
         }
         if(this.FAllMaterialCount + this.FMaterialCount < this.FUseMaterialCount)
         {
            _loc2_ = TUtilityString.Format(STRING_SMITHY.STRING_NOTENOUGHMATERIAL,this.FUseMaterialName);
            EffectGenerateText(_loc2_);
            return;
         }
         if(this.FEnchantNetwork != null)
         {
            this.FEnchantNetwork(this.FEquipment.Identifier0,this.FEquipment.Identifier1);
            this.FCurrentState = STATE_ENCHANT;
         }
      }
      
      protected function OnBtnAnyTimeEnchantClick(param1:MouseEvent) : void
      {
      }
      
      protected function OnBtnLeftClick(param1:MouseEvent) : void
      {
         --this.FStoneIndex;
         if(this.FStoneIndex < 0)
         {
            this.FStoneIndex = 0;
         }
         this.UpdateStone();
         this.CheckBtn();
      }
      
      protected function OnBtnRightClick(param1:MouseEvent) : void
      {
         ++this.FStoneIndex;
         if(this.FStoneIndex > this.FStoneMaxCount - STONE_COUNT)
         {
            this.FStoneIndex = this.FStoneMaxCount - STONE_COUNT;
         }
         this.UpdateStone();
         this.CheckBtn();
      }
      
      protected function UpdateStone() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TInventory = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < STONE_COUNT)
         {
            _loc3_ = _loc1_ + this.FStoneIndex;
            _loc2_ = this.FStoneInventories.GetInventoryByIndex(_loc3_);
            this.FStoneSlot[_loc1_].Context = _loc2_;
            if(this.FNimei == _loc3_)
            {
               _loc4_ = true;
            }
            else
            {
               _loc4_ = false;
            }
            this.FMC_IconHighLight[_loc1_].visible = _loc4_;
            if(_loc4_)
            {
               if(_loc2_.Quantity > 0)
               {
                  _loc4_ = false;
               }
               else
               {
                  _loc4_ = true;
               }
            }
            this.FTextFieldLine[_loc1_].Thistf.visible = _loc4_;
            this.FStoneSlot[_loc1_].Resource.filters = _loc2_.Quantity > 0 ? [] : [TGameUtil.GaryColorFilters];
            _loc1_++;
         }
      }
      
      public function FromNewMallMessage(param1:int) : void
      {
         if(param1 != 0)
         {
            this.FYouDianYiSi = false;
         }
         else if(this.FYouDianYiSi)
         {
            this.IntegrationCa();
            this.UpdateStone();
            this.CheckBtn();
            this.FYouDianYiSi = false;
         }
      }
      
      protected function UpdateRefreshNew() : void
      {
         this.FNimei = this.Getindex();
         if(this.FNimei == 777)
         {
            return;
         }
         this.FStoneIndex = this.FNimei;
         if(this.FStoneIndex > this.FStoneMaxCount - STONE_COUNT)
         {
            this.FStoneIndex = this.FStoneMaxCount - STONE_COUNT;
         }
         this.UpdateStone();
         this.CheckBtn();
      }
      
      protected function Getindex() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:TInventory = null;
         if(this.FCurProtectStoreId == 0)
         {
            return 777;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FStoneInventories.Count)
         {
            _loc2_ = this.FStoneInventories.GetInventoryByIndex(_loc1_);
            if(this.FCurProtectStoreId == _loc2_.IDTemplate)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 777;
      }
      
      protected function TextFieldLineBackFunction(param1:String) : void
      {
         var _loc2_:NewMallCellData = null;
         this.FYouDianYiSi = true;
         _loc2_ = SLogicsCore.NewMallLogicData.GetNewMallDateByPaream(this.FStoneInventories.GetInventoryByIndex(uint(param1) + this.FStoneIndex).IDTemplate,1);
         this.FTPressorWindowPopBuyFream.CurData = _loc2_;
         this.FTPressorWindowPopBuyFream.Visible = true;
      }
      
      protected function Buy_Cancel(param1:NewMallCellData, param2:uint) : void
      {
         this.FYouDianYiSi = false;
      }
      
      protected function CheckBtn() : void
      {
         this.FBtn_Left.visible = Boolean(this.FStoneIndex != 0);
         this.FBtn_Right.visible = Boolean(this.FStoneIndex != this.FStoneMaxCount - STONE_COUNT);
      }
      
      protected function OnBtnBuyClick(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Mall,6);
         }
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
         var _loc3_:TUISlot = null;
         _loc3_ = param1 as TUISlot;
         if(param2 != null)
         {
            this.UIComponentsHintOnOut(param1,param2 as TInventory);
         }
         this.FEquipment = null;
         this.ResetBtn();
         this.UpdateEquipmentSlot();
      }
      
      protected function OnIconMouseMove(param1:MouseEvent) : void
      {
         switch(param1.currentTarget.name)
         {
            case "mc_CurMaterialIcon":
               if(this.FEquipment == null)
               {
                  return;
               }
               this.FIconTipInventory = this.GetMaterialInventory(this.FCurMaterialId);
               break;
            case "mc_AllMaterialIcon":
               this.FIconTipInventory = this.GetMaterialInventory(ALLMaterial_ID);
         }
         if(this.FIconTipInventory != null && this.FOnSlotMouseOver != null)
         {
            this.FOnSlotMouseOver(this,this.FIconTipInventory);
         }
      }
      
      protected function OnIconMouseOut(param1:MouseEvent) : void
      {
         if(this.FIconTipInventory != null)
         {
            this.UIComponentsHintOnOut(this,this.FIconTipInventory);
            this.FIconTipInventory = null;
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOver != null)
         {
            this.FOnSlotMouseOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOut != null)
         {
            this.FOnSlotMouseOut(param1,param2);
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
      
      protected function GetItemCount(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         var _loc5_:uint = 0;
         _loc5_ = 0;
         _loc3_ = uint(this.FInventories.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FInventories.GetInventoryByIndex(_loc2_);
            if(_loc4_.IDTemplate == param1)
            {
               _loc5_ += _loc4_.Quantity;
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      public function set EnchantNetwork(param1:Function) : void
      {
         this.FEnchantNetwork = param1;
      }
      
      public function set OnSlotMouseOver(param1:Function) : void
      {
         this.FOnSlotMouseOver = param1;
      }
      
      public function set OnSlotMouseOut(param1:Function) : void
      {
         this.FOnSlotMouseOut = param1;
      }
      
      public function set StrengthenResult(param1:uint) : void
      {
         this.FStrengthenResult = param1;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FInitialization && param1)
         {
            this.IntegrationCa();
            this.UpdateStone();
         }
         if(this.FEquipmentSlot != null && param1)
         {
            this.OnSlotClick(this.FEquipmentSlot,this.FEquipmentSlot.Context);
         }
      }
      
      protected function IntegrationCa() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < this.FStoneInventories.Count)
         {
            _loc2_ = this.FStoneInventories.GetInventoryByIndex(_loc1_);
            _loc2_.Quantity = this.GetItemCount(_loc2_.IDTemplate);
            _loc1_++;
         }
      }
      
      public function Update() : void
      {
         var _loc1_:TEnchantValue = null;
         switch(this.FCurrentState)
         {
            case STATE_READY:
               break;
            case STATE_ENCHANT:
               if(this.FStrengthenResult == 0)
               {
                  EffectGenerateText(STRING_SMITHY.STRING_ENCHANT_SUCCESS);
                  _loc1_ = this.GetEnchantValue();
                  this.FEquipment.EnchantLevel += 1;
                  this.FEquipment.EnchantValue = int(_loc1_.LevelCoefficient * this.FEquipment.EnchantCoefficient * _loc1_.TypeCoefficient * (this.FEquipment.UpgradingLevel + this.FSmithyEnchantCoefficient));
                  if(this.FEquipment.EnchantLevel >= MAX_ENCHANT_LEVEL)
                  {
                     EffectGenerateText(STRING_SMITHY.STRING_MAXEnchant);
                     this.OnSlotClick();
                  }
                  if(this.FUpdateHeroPower != null && this.FHeroID != 0)
                  {
                     this.FUpdateHeroPower(this,this.FHeroID);
                  }
               }
               else
               {
                  EffectGenerateText(STRING_SMITHY.STRING_ENCHANT_LOSS);
               }
               this.FCurrentState = STATE_READY;
               this.UpdateEquipmentSlot();
         }
      }
      
      public function Reset() : void
      {
         this.ResetEquipmentSlot();
         this.ResetBtn();
      }
      
      public function set BackReset(param1:Function) : void
      {
         this.FBackReset = param1;
      }
      
      public function ReciveEquipment(param1:TEquipment, param2:uint) : void
      {
         this.FHeroID |= param2;
         if(param1.EnchantLevel >= MAX_ENCHANT_LEVEL)
         {
            EffectGenerateText(STRING_SMITHY.STRING_MAXEnchant);
            return;
         }
         if(param1.EnchantCoefficient <= 0)
         {
            EffectGenerateText(STRING_SMITHY.STRING_EnchantEquipLimit);
            return;
         }
         this.SendEquipment(param1);
      }
   }
}

