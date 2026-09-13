package Processors.Game.Lobby.MakeEquipAdvanced
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBuildConsume;
   import Logics.DatebaseVO.VO.TBuildValue;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEnchantValue;
   import Logics.DatebaseVO.VO.TEquipUpgrade;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EQUIPADVANCED;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_EQUIPADVANCED;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowEquipAdvanced extends TProcessorLobbyWindow
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FScene:MovieClip;
      
      protected var FBtn_EquipAdvanced:MovieClip;
      
      protected var FBtn_AdvEquipAdvanced:MovieClip;
      
      protected var FMC_EquipBox:MovieClip;
      
      protected var FMC_MaterialBox:MovieClip;
      
      protected var FTF_EuipName:TextField;
      
      protected var FTF_EquipLevel:TextField;
      
      protected var FBtn_Close:MovieClip;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_Slot:TUISlot;
      
      protected var FMaterialSlotList:Vector.<TUISlot>;
      
      protected var FMaterialNumList:Vector.<uint>;
      
      protected var FMaterialTextList:Vector.<TextField>;
      
      protected var FInventory:TInventory;
      
      protected var FCharacter:TCharacter;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FEnchantValueBins:TBins;
      
      protected var FSmithyEnchantCoefficient:Number;
      
      protected var FNeedCost:uint;
      
      protected var FTempStr:Vector.<String>;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FEquipAdvanced:Function;
      
      protected var FShowMakeConfirmation:Function;
      
      public function TProcessorWindowEquipAdvanced(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FMaterialSlotList = new Vector.<TUISlot>();
         this.FMaterialTextList = new Vector.<TextField>();
         this.FMaterialNumList = new Vector.<uint>();
         this.FTempStr = new Vector.<String>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_EQUIPADVANCED.RESOURCESID_EQUIPADVANCED);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TextField = null;
         var _loc5_:TConfigValue = null;
         this.FCharacter = SLogicsCore.Character;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_EQUIPADVANCED.RESOURCESID_ClassName_Equip_Advanced) as MovieClip;
         addChild(this.FScene);
         this.FBtn_EquipAdvanced = this.FScene[CONST_EQUIPADVANCED.RESOURCES_Btn_EquipAdvanced];
         this.FBtn_AdvEquipAdvanced = this.FScene[CONST_EQUIPADVANCED.RESOURCES_Btn_AdvEquipAdvanced];
         this.FMC_EquipBox = this.FScene[CONST_EQUIPADVANCED.RESOURCES_MC_EquipBox];
         this.FMC_MaterialBox = this.FScene[CONST_EQUIPADVANCED.RESOURCES_MC_MaterialBox];
         this.FTF_EuipName = this.FMC_EquipBox[CONST_EQUIPADVANCED.RESOURCES_TF_EuipName];
         this.FTF_EquipLevel = this.FMC_EquipBox[CONST_EQUIPADVANCED.RESOURCES_TF_EquipLevel];
         this.FBtn_Close = this.FScene[CONST_EQUIPADVANCED.RESOURCES_Btn_Close];
         TGameUtil.setButtonMode(this.FBtn_Close,true);
         this.FMC_Effect = this.FMC_EquipBox[CONST_EQUIPADVANCED.RESOURCES_MC_Effect];
         this.FMC_Slot = new TUISlot(this);
         this.FMC_Slot.Resource = this.FMC_EquipBox[CONST_EQUIPADVANCED.RESOURCES_MC_Slot];
         this.FMC_Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_Slot.OnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FMC_Slot.OnOverlay = this.SlotsOnMove;
         this.FMC_Slot.OnOut = this.SlotsOnOut;
         this.FMC_Slot.Init();
         _loc1_ = CONST_EQUIPADVANCED.CAPACITY_MC_Slots;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_MaterialBox[CONST_EQUIPADVANCED.RESOURCES_MC_Material_Slot + _loc2_];
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FMaterialSlotList[_loc2_] = _loc3_;
            if(_loc2_ > 0)
            {
               _loc4_ = this.FMC_MaterialBox[CONST_EQUIPADVANCED.RESOURCES_MC_Material_Slot + _loc2_][CONST_EQUIPADVANCED.RESOURCES_TF_NeedNum];
               this.FMaterialTextList[_loc2_ - 1] = _loc4_;
            }
            _loc2_++;
         }
         this.FEnchantValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantValue);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Smithy_Enchant_Coefficient) as TConfigValue;
         this.FSmithyEnchantCoefficient = _loc5_.Value as Number;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(!this.FBtn_EquipAdvanced.hasEventListener(MouseEvent.CLICK))
         {
            this.FBtn_EquipAdvanced.addEventListener(MouseEvent.CLICK,this.BtnEquipAdvancedHandler,false,0,true);
         }
         if(!this.FBtn_Close.hasEventListener(MouseEvent.CLICK))
         {
            this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.BtnCloseHandler,false,0,true);
         }
         if(!this.FBtn_AdvEquipAdvanced.hasEventListener(MouseEvent.CLICK))
         {
            this.FBtn_AdvEquipAdvanced.addEventListener(MouseEvent.CLICK,this.BtnAdvEquipAdvancedHandler,false,0,true);
         }
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.UpdateSlots();
      }
      
      protected function UpdateSlots() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = this.FMaterialSlotList.length;
         if(_loc1_ > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this.FMaterialSlotList[_loc2_];
               _loc3_.Update();
               _loc2_++;
            }
         }
         if(this.FMC_Slot != null)
         {
            this.FMC_Slot.Update();
         }
      }
      
      protected function Initialized() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FMaterialSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMaterialSlotList[_loc1_].Context = null;
            _loc1_++;
         }
         _loc2_ = this.FMaterialTextList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMaterialTextList[_loc1_].text = "";
            _loc1_++;
         }
         this.FMC_Slot.Context = null;
         this.FTF_EuipName.text = "";
         this.FTF_EquipLevel.text = "";
         TGameUtil.setButtonMode(this.FBtn_EquipAdvanced,false);
         TGameUtil.setButtonMode(this.FBtn_AdvEquipAdvanced,false);
      }
      
      protected function UpdateEquipBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventories = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:TEquipUpgrade = null;
         var _loc6_:TInventory = null;
         var _loc7_:TConfigValue = null;
         var _loc8_:TBins = null;
         var _loc9_:TBuildConsume = null;
         var _loc10_:TBins = null;
         var _loc11_:TBuildValue = null;
         var _loc12_:TBins = null;
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:TEquipment = null;
         if(SLogicsCore.Character.VipData.BuyEquipMaterial)
         {
            this.FBtn_EquipAdvanced.x = 75;
            this.FBtn_Close.x = 282;
            this.FBtn_AdvEquipAdvanced.visible = true;
         }
         else
         {
            this.FBtn_EquipAdvanced.x = 115;
            this.FBtn_Close.x = 242;
            this.FBtn_AdvEquipAdvanced.visible = false;
         }
         _loc3_ = new TInventories();
         _loc4_ = new Vector.<uint>();
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,this.FInventory.IDTemplate) as TEquipUpgrade;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue) as TBins;
         _loc7_ = _loc8_.GetDatebaseByIdentifier(CONST_EQUIPADVANCED.EQUIP_CONSUME_RATE) as TConfigValue;
         _loc10_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildConsume) as TBins;
         if(this.FInventory.UpgradingLevel > 0)
         {
            _loc13_ = 0;
            _loc2_ = uint(_loc10_.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc9_ = _loc10_.GetDatebaseByIndex(_loc1_) as TBuildConsume;
               if(_loc9_.Quality == this.FInventory.Quality)
               {
                  _loc13_ += _loc9_.Consume;
                  if(_loc9_.BuildLevel == this.FInventory.UpgradingLevel)
                  {
                     _loc13_ -= _loc9_.Consume;
                     break;
                  }
               }
               _loc1_++;
            }
            _loc15_ = uint(int(_loc13_ * (_loc7_.Value as Number)));
            _loc13_ = 0;
            _loc2_ = uint(_loc10_.Count);
            if(_loc15_ >= 0)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc9_ = _loc10_.GetDatebaseByIndex(_loc1_) as TBuildConsume;
                  if(_loc9_.Quality == this.FInventory.Quality + 1)
                  {
                     _loc13_ += _loc9_.Consume;
                     if(_loc15_ < _loc13_)
                     {
                        _loc14_ = _loc9_.BuildLevel;
                        break;
                     }
                  }
                  _loc1_++;
               }
            }
         }
         _loc4_.push(_loc5_.GotEquipId);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc3_,_loc4_);
         _loc6_ = _loc3_.GetInventoryByTempletID(_loc5_.GotEquipId);
         _loc12_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildValue) as TBins;
         _loc2_ = uint(_loc12_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc11_ = _loc12_.GetDatebaseByIndex(_loc1_) as TBuildValue;
            if(_loc6_.CategorySecond == _loc11_.EquipType && _loc6_.Quality == _loc11_.Quality && _loc14_ == _loc11_.BuildLevel)
            {
               _loc16_ = uint(_loc11_.Value);
            }
            _loc1_++;
         }
         _loc17_ = _loc6_ as TEquipment;
         _loc17_.UpgradingLevel = _loc14_;
         _loc17_.UpgradingBasisProperty = _loc16_;
         this.FMC_Slot.Context = _loc17_;
         this.FTF_EuipName.text = _loc6_.Name;
         this.FTF_EuipName.textColor = QUALITYCOLOR_INDEX[_loc6_.Quality];
         this.FTF_EquipLevel.text = STRING_EQUIPADVANCED.STRINGS_NeedGrade + "\t" + _loc6_.RequirementLevel + STRING_EQUIPADVANCED.STRINGS_Level;
      }
      
      protected function UpdateMaterialBox() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TEquipUpgrade = null;
         var _loc4_:TInventories = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:TAppliance = null;
         var _loc7_:TInventories = null;
         var _loc8_:TUISlot = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<Boolean> = null;
         var _loc13_:TArticle = null;
         var _loc14_:int = 0;
         _loc7_ = this.FCharacter.Materials;
         this.FNeedCost = 0;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,this.FInventory.IDTemplate) as TEquipUpgrade;
         _loc4_ = new TInventories();
         _loc5_ = new Vector.<uint>();
         _loc12_ = new Vector.<Boolean>();
         _loc1_ = this.FMaterialTextList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc10_ = 0;
            _loc11_ = _loc3_.Quantitys[_loc2_];
            _loc14_ = 0;
            while(_loc14_ < _loc7_.Count)
            {
               _loc6_ = _loc7_.GetInventoryByIndex(_loc14_) as TAppliance;
               if(_loc6_ != null && _loc6_.IDTemplate == _loc3_.Materials[_loc2_])
               {
                  _loc10_ += _loc6_.Quantity;
               }
               _loc14_++;
            }
            if(_loc10_ < _loc11_)
            {
               this.FMaterialTextList[_loc2_].textColor = CONST_COMMON.TEXT_White_Color;
               _loc12_[_loc2_] = false;
               _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc3_.Materials[_loc2_]) as TArticle;
               this.FNeedCost += (_loc11_ - _loc10_) * _loc13_.GoldNumberA;
            }
            else
            {
               this.FMaterialTextList[_loc2_].textColor = CONST_COMMON.TEXT_Green_Color;
               _loc12_[_loc2_] = true;
            }
            this.FMaterialTextList[_loc2_].text = _loc10_ + "/" + _loc11_;
            this.FTempStr[_loc2_] = _loc10_ + "/" + _loc11_;
            _loc2_++;
         }
         if(_loc12_[0] && _loc12_[1])
         {
            TGameUtil.setButtonMode(this.FBtn_EquipAdvanced,true);
            TGameUtil.setButtonMode(this.FBtn_AdvEquipAdvanced,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBtn_EquipAdvanced,false);
            TGameUtil.setButtonMode(this.FBtn_AdvEquipAdvanced,true);
         }
         _loc1_ = this.FMaterialTextList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc5_[_loc2_] = _loc3_.Materials[_loc2_];
            _loc2_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc5_);
         _loc1_ = uint(_loc4_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc8_ = this.FMaterialSlotList[_loc2_ + 1];
            _loc9_ = _loc4_.GetInventoryByIndex(_loc2_);
            _loc9_.Quantity = _loc3_.Quantitys[_loc2_];
            _loc8_.Context = _loc9_;
            _loc2_++;
         }
         this.FMaterialSlotList[0].Context = this.FInventory;
      }
      
      protected function UpdateEquipment() : void
      {
         var _loc1_:TEquipment = null;
         var _loc2_:TEnchantValue = null;
         _loc1_ = this.FInventory as TEquipment;
         _loc2_ = this.GetEnchantValue(_loc1_);
         if(_loc2_ != null)
         {
            _loc1_.EnchantValue = int(_loc2_.LevelCoefficient * _loc1_.EnchantCoefficient * _loc2_.TypeCoefficient * (_loc1_.UpgradingLevel + this.FSmithyEnchantCoefficient));
         }
      }
      
      protected function GetEnchantValue(param1:TEquipment) : TEnchantValue
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEnchantValue = null;
         _loc3_ = uint(this.FEnchantValueBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FEnchantValueBins.GetDatebaseByIndex(_loc2_) as TEnchantValue;
            if(_loc4_.Type == param1.CategorySecond && param1.RequirementLevel >= _loc4_.MinEquipLevel && param1.RequirementLevel <= _loc4_.MaxEquipLevel && param1.EnchantLevel == _loc4_.Level)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function BtnEquipAdvancedHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         if(this.FEquipAdvanced != null)
         {
            this.FEquipAdvanced(this,this.FInventory);
         }
      }
      
      protected function BtnCloseHandler(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function BtnAdvEquipAdvancedHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         if(this.FShowMakeConfirmation != null)
         {
            this.FShowMakeConfirmation(this.GetNeedCost());
         }
      }
      
      protected function GetNeedCost() : String
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(SLogicsCore.KaguyaData.GetValueByType(3));
         _loc3_ = _loc2_;
         var _loc4_:uint = this.FNeedCost * _loc3_ / 100;
         if(!_loc4_)
         {
            _loc4_ = this.FNeedCost;
         }
         if(SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            _loc1_ = TUtilityString.Format(STRING_EQUIPADVANCED.STRING_AdvMakeEquip_SureFilledMakeCopyAgine,this.FNeedCost - _loc4_,this.FNeedCost,this.FInventory ? this.FInventory.Name : "");
         }
         else
         {
            _loc1_ = TUtilityString.Format(STRING_EQUIPADVANCED.STRING_AdvMakeEquip_SureFilledMakeCopy,SLogicsCore.KaguyaData.CurLevel,STRING_EQUIPADVANCED.GetDiscountValue(_loc3_),_loc4_,this.FNeedCost - _loc4_,_loc4_,this.FInventory ? this.FInventory.Name : "");
         }
         return _loc1_;
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_MakeEquipAdv);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc5_ = param2 as TAppliance;
            param3.Value = _loc5_.Quantity.toString();
            _loc4_ = 0;
            while(_loc4_ < this.FTempStr.length)
            {
               this.FMaterialTextList[_loc4_].text = this.FTempStr[_loc4_];
               _loc4_++;
            }
         }
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.FOnInventoryOver;
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
      
      public function get EquipAdvanced() : Function
      {
         return this.FEquipAdvanced;
      }
      
      public function set EquipAdvanced(param1:Function) : void
      {
         this.FEquipAdvanced = param1;
      }
      
      public function get ShowMakeConfirmation() : Function
      {
         return this.FShowMakeConfirmation;
      }
      
      public function set ShowMakeConfirmation(param1:Function) : void
      {
         this.FShowMakeConfirmation = param1;
      }
      
      public function Update(param1:Object) : void
      {
         this.FInventory = param1 as TInventory;
         this.Initialized();
         this.UpdateEquipBox();
         this.UpdateMaterialBox();
      }
      
      public function EquipAdvancedOk() : void
      {
         this.UpdateEquipment();
         this.FMC_Effect.gotoAndPlay(1);
         this.Initialized();
      }
      
      public function AdvMakeEquip() : void
      {
         if(this.FEquipAdvanced != null)
         {
            this.FEquipAdvanced(this,this.FInventory);
         }
      }
   }
}

