package Processors.Game.Lobby.Medal
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TRuneEnchantValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Medal.Component.TUIMedalSlot;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MEDAL;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorMedalUpgrade extends TProcessorLobbyWindow
   {
      
      protected static const PosX_FUIWindowCostGoldConfirmation:uint = 112;
      
      protected static const PosY_FUIWindowCostGoldConfirmation:uint = 100;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected var FScene:MovieClip;
      
      protected var FTF_CostNum:TextField;
      
      protected var FTF_CostNum1:TextField;
      
      protected var FTF_OwnNum:TextField;
      
      protected var FTF_OwnNum1:TextField;
      
      protected var FTF_NeedCost:TextField;
      
      protected var FTF_NeedCost1:TextField;
      
      protected var FTF_TalismanUpgrading:TextField;
      
      protected var FBtn_Upgrade:MovieClip;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FTF_OldProperty:TextField;
      
      protected var FTF_NewProperty:TextField;
      
      protected var FTF_OldProperty_1:TextField;
      
      protected var FTF_NewProperty_1:TextField;
      
      protected var FMC_UpgradeSlot:TUIMedalSlot;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FBin:TBins;
      
      protected var FRoleIndex:uint;
      
      protected var FInitialized:Boolean;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FCharacter:TCharacter;
      
      protected var FMC_FloatEffect:MovieClip;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FContext:Object;
      
      protected var FItemIndex:uint;
      
      protected var FAddvalue:uint;
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FMedalNameList:Vector.<TextField>;
      
      protected var FUpgradePaperNum:uint;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FCostInventorieName:String;
      
      protected var FCostItemCount:uint;
      
      protected var FOwnItemNum:uint;
      
      protected var FNeedRuneNum:uint;
      
      protected var FOwnRuneNum:uint;
      
      protected var FTF_CostName:TextField;
      
      protected var FTF_CostName_1:TextField;
      
      protected var FUpgradeOnclick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FOnTipsOver:Function;
      
      protected var FOnTipsOut:Function;
      
      protected var WoQu:Boolean;
      
      public function TProcessorMedalUpgrade(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FCharacter = SLogicsCore.Character;
         this.FMedalNameList = new Vector.<TextField>(3);
         this.FBtnList = new Vector.<MovieClip>();
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MEDAL.RESOURCES_ID_Swf);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_MEDAL.RESOURCE_ClassName_MC_Medal_Upgrade) as MovieClip;
         addChild(this.FScene);
         this.x = CONST_MEDAL.POSX_MC_SCENE;
         this.y = CONST_MEDAL.POSY_MC_SCENE;
         this.visible = false;
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FBtn_Upgrade = this.FScene[CONST_MEDAL.RESOURCE_Link_Btn_Upgrade];
         this.FBtn_Upgrade.isClick = false;
         TGameUtil.setButtonMode(this.FBtn_Upgrade,false);
         this.FBtnList.push(this.FBtn_Upgrade);
         this.FTF_OldProperty = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_OldProperty];
         this.FTF_OldProperty.mouseEnabled = false;
         this.FTF_NewProperty = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_NewProperty];
         this.FTF_NewProperty.mouseEnabled = false;
         this.FTF_OldProperty_1 = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_OldProperty_1];
         this.FTF_OldProperty_1.mouseEnabled = false;
         this.FTF_NewProperty_1 = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_NewProperty_1];
         this.FTF_NewProperty_1.mouseEnabled = false;
         this.FTF_CostNum = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_CostNum];
         this.FTF_CostNum.mouseEnabled = false;
         this.FTF_CostNum1 = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_CostNum_1];
         this.FTF_CostNum1.mouseEnabled = false;
         this.FTF_OwnNum = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_OwnNum];
         this.FTF_OwnNum.mouseEnabled = false;
         this.FTF_OwnNum1 = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_OwnNum_1];
         this.FTF_OwnNum1.mouseEnabled = false;
         this.FTF_NeedCost = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_NeedCost];
         this.FTF_NeedCost.mouseEnabled = false;
         this.FTF_NeedCost1 = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_NeedCost_1];
         this.FTF_NeedCost1.mouseEnabled = false;
         this.FTF_CostName = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_CostName];
         this.FTF_CostName.mouseEnabled = false;
         this.FTF_CostName_1 = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_CostName_1];
         this.FTF_CostName_1.mouseEnabled = false;
         this.FMC_UpgradeSlot = new TUIMedalSlot(this.FScene[CONST_MEDAL.RESOURCE_Link_MC_UpgradeSlot]);
         this.FMC_FloatEffect = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_FloatEffect];
         _loc2_ = this.FMedalNameList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMedalNameList[_loc1_] = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_TalismanNames + _loc1_];
            _loc1_++;
         }
         this.FTF_TalismanUpgrading = this.FScene[CONST_MEDAL.RESOURCE_Link_TF_TalismanUpgrading];
         this.FTF_TalismanUpgrading.mouseEnabled = false;
         this.FMC_Effect = this.FScene[CONST_MEDAL.RESOURCE_Link_MC_Effect];
         this.FMC_List = this.FScene[CONST_MEDAL.RESOURCE_Link_Mc_List];
         this.FScrollBar = new TScrollBar(this.FMC_List,348,false,0);
         this.FInitialized = true;
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FSystemLanguageBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FInitialized == true)
         {
            this.FMC_UpgradeSlot.Update();
            _loc2_ = this.FMC_SingleEquipList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_FloatEffect.play();
         }
      }
      
      protected function SetEuuipInfo() : void
      {
         var Count:uint = 0;
         var Index:int = 0;
         var SingleEquip:TSingleEquip = null;
         var Inventory:TInventory = null;
         var MedalName:String = null;
         var MedalLevel:uint = 0;
         var MedalQuality:uint = 0;
         var HerosNum:uint = 0;
         var TempNum:uint = 0;
         var Inventories:TInventories = null;
         var SetInfo:Function = function():void
         {
            if(Inventory != null)
            {
               SingleEquip = FMC_SingleEquipList[Index];
               if(SingleEquip != null)
               {
                  MedalName = Inventory.Name;
                  MedalLevel = Inventory.UpgradingLevel;
                  MedalQuality = Inventory.Quality;
                  SingleEquip.SetEquip(Inventory,MedalName,STRING_TALISMAN.STRINGS_TalismanUpgrade + MedalLevel,MedalQuality);
                  if(Inventory.Identifier0 == FIdentifier0 && Inventory.Identifier1 == FIdentifier1)
                  {
                     SingleEquip.OnSelect();
                  }
               }
            }
         };
         HerosNum = uint(this.FCharacter.Heros.Count);
         TempNum = HerosNum - 1;
         Inventories = new TInventories();
         if(this.FRoleIndex > TempNum)
         {
            Count = uint(this.FCharacter.Medals.Count);
            Index = 0;
            while(Index < Count)
            {
               Inventory = this.FCharacter.Medals.GetInventoryByIndex(Index);
               SetInfo();
               Index++;
            }
         }
         else
         {
            Count = CONST_MEDAL.CAPACITY_MedalNum;
            Index = 0;
            while(Index < Count)
            {
               Inventory = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).MedalsMounted.GetInventoryByIndex(Index);
               if(Inventory != null)
               {
                  Inventories.Add(Inventory);
               }
               Index++;
            }
            Count = uint(Inventories.Count);
            Index = 0;
            while(Index < Count)
            {
               Inventory = Inventories.GetInventoryByIndex(Index);
               SetInfo();
               Index++;
            }
         }
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         this.FScrollBar.Clear();
         _loc10_ = 0;
         _loc8_ = uint(this.FCharacter.Heros.Count);
         _loc9_ = _loc8_ - 1;
         _loc1_ = this.FMC_SingleEquipList.length;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ > -1)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_--;
         }
         this.FMC_SingleEquipList.length = 0;
         if(this.FRoleIndex > _loc9_)
         {
            _loc1_ = uint(this.FCharacter.Medals.Count);
         }
         else
         {
            _loc1_ = CONST_MEDAL.CAPACITY_MedalNum;
         }
         this.WoQu = false;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.FRoleIndex > _loc9_)
            {
               _loc4_ = this.FCharacter.Medals.GetInventoryByIndex(_loc2_);
            }
            else
            {
               _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).MedalsMounted.GetInventoryByIndex(_loc2_);
            }
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.Name;
               _loc6_ = _loc4_.UpgradingLevel;
               _loc7_ = _loc4_.Quality;
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc3_.StubReferences.Reference(this);
               _loc3_.OnClick = this.SingleEquipOnClick;
               _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnOver = this.SlotsOnMove;
               this.FMC_SingleEquipList.push(_loc3_);
               _loc3_.SetEquip(_loc4_,_loc5_,STRING_COMMON.FORMAT_Level + _loc6_,_loc7_);
               this.FScrollBar.AddItem(_loc3_);
               _loc10_++;
               if(_loc4_.Identifier0 == this.FIdentifier0 && _loc4_.Identifier1 == this.FIdentifier1)
               {
                  this.WoQu = true;
                  _loc3_.OnSelect();
               }
            }
            _loc2_++;
         }
         if(_loc1_ < CONST_MEDAL.CAPACITY_EQUIP || _loc1_ == 0)
         {
            _loc1_ = CONST_MEDAL.CAPACITY_EQUIP;
            _loc2_ = 0;
            while(_loc2_ < _loc1_ - _loc10_)
            {
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               this.FScrollBar.AddItem(_loc3_);
               _loc2_++;
            }
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventories = null;
         var _loc4_:TInventory = null;
         this.FTF_OldProperty.text = "";
         this.FTF_NewProperty.text = "";
         this.FTF_OldProperty_1.text = "";
         this.FTF_NewProperty_1.text = "";
         this.FTF_CostNum.text = "";
         this.FTF_OwnNum.text = "";
         this.FTF_CostNum1.text = "";
         this.FTF_OwnNum1.text = "";
         this.FTF_CostName.text = "";
         this.FTF_CostName_1.text = "";
         this.FTF_NeedCost.textColor = 15518068;
         this.FTF_NeedCost1.textColor = 15518068;
         this.FTF_TalismanUpgrading.text = "";
         _loc2_ = this.FMedalNameList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMedalNameList[_loc1_].text = "";
            _loc1_++;
         }
         _loc3_ = SLogicsCore.Character.Appliances;
         _loc2_ = uint(_loc3_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_.GetInventoryByIndex(_loc1_);
            if(_loc4_.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_TreasureUpgrade)
            {
               this.FUpgradePaperNum += _loc4_.Quantity;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         this.FBtn_Upgrade.isClick = false;
         TGameUtil.setButtonMode(this.FBtn_Upgrade,false);
         if(!this.WoQu)
         {
            this.FMC_UpgradeSlot.Context = null;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Upgrade.addEventListener(MouseEvent.CLICK,this.FBtn_UpgradeClickHandler,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function FBtn_UpgradeClickHandler(param1:MouseEvent) : void
      {
         if(this.FMC_UpgradeSlot.Context == null || this.FBtn_Upgrade.isClick == false)
         {
            return;
         }
         this.CostConfirm(null);
      }
      
      protected function CostConfirm(param1:Object) : void
      {
         var _loc2_:TEquipment = null;
         _loc2_ = this.FContext as TEquipment;
         this.FIdentifier0 = _loc2_.Identifier0;
         this.FIdentifier1 = _loc2_.Identifier1;
         this.FUpgradeOnclick(this,this.FContext);
         this.SetBtnLock(false);
         this.FMC_Effect.play();
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TRuneEnchantValue = null;
         var _loc5_:TRuneEnchantValue = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:TSingleEquip = null;
         var _loc13_:TSingleEquip = null;
         var _loc14_:TInventory = null;
         var _loc15_:uint = 0;
         var _loc16_:TInventories = null;
         var _loc17_:TEquipment = null;
         var _loc18_:Vector.<uint> = null;
         var _loc19_:Boolean = false;
         var _loc20_:TArticle = null;
         _loc18_ = new Vector.<uint>();
         _loc16_ = SLogicsCore.Character.Appliances as TInventories;
         this.FContext = param2 as TInventory;
         _loc3_ = param2 as TInventory;
         _loc12_ = param1 as TSingleEquip;
         _loc19_ = false;
         _loc8_ = _loc3_.IDTemplate;
         _loc15_ = _loc3_.UpgradingLevel;
         _loc9_ = _loc15_ + 1;
         _loc11_ = uint(this.FBin.Count);
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc5_ = this.FBin.GetDatebaseByIndex(_loc10_) as TRuneEnchantValue;
            if(_loc15_ == _loc5_.Level)
            {
               _loc4_ = _loc5_;
            }
            if(_loc9_ == _loc5_.Level)
            {
               _loc19_ = true;
               break;
            }
            _loc10_++;
         }
         if(!_loc19_)
         {
            this.WoQu = false;
            this.UpdateBtn();
            _loc12_.BSelect = false;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_13) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         _loc11_ = uint(this.FBin.Count);
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc5_ = this.FBin.GetDatebaseByIndex(_loc10_) as TRuneEnchantValue;
            if(_loc9_ == _loc5_.Level)
            {
               this.FCostItemCount = _loc5_.EnchantStoneNum;
               this.FOwnItemNum = _loc16_.GetAllCountByTempletID(_loc5_.EnchantStone);
               this.FNeedRuneNum = _loc5_.RuneNum;
               _loc20_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.EnchantStone) as TArticle;
               this.FCostInventorieName = _loc20_.Name;
               break;
            }
            _loc10_++;
         }
         this.FMC_UpgradeSlot.Context = _loc3_;
         _loc7_ = (_loc3_ as TEquipment).BasisProperty;
         _loc6_ = (_loc3_ as TEquipment).MainAdditionalValue;
         this.FOwnRuneNum = 0;
         _loc11_ = uint(this.FCharacter.Medals.Count);
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc14_ = this.FCharacter.Medals.GetInventoryByIndex(_loc10_);
            if(_loc14_ != _loc3_ && _loc14_.IDTemplate == _loc3_.IDTemplate && _loc14_.UpgradingLevel == 0)
            {
               ++this.FOwnRuneNum;
            }
            _loc10_++;
         }
         _loc11_ = this.FMC_SingleEquipList.length;
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            this.FMC_SingleEquipList[_loc10_].BClick = false;
            _loc10_++;
         }
         _loc12_.BSelect = true;
         _loc10_ = BASEATTRIBUTENAMES.indexOf((_loc3_ as TEquipment).BasisPropertyCategory);
         this.FTF_OldProperty.text = STRINGS_BASEATTRIBUTENAMES[_loc10_] + (_loc4_ ? _loc7_ * (_loc4_.Mainattribute / 100) : _loc7_);
         this.FTF_OldProperty_1.text = STRINGS_BASEATTRIBUTENAMES[_loc10_] + _loc7_ * (_loc5_.Mainattribute / 100);
         _loc10_ = BASEATTRIBUTENAMES.indexOf((_loc3_ as TEquipment).MainAdditionalCategory);
         this.FTF_NewProperty.text = STRINGS_BASEATTRIBUTENAMES[_loc10_] + (_loc4_ ? parseFloat((_loc6_ * _loc4_.Assattribute).toFixed(2)) : _loc6_ * 100) + "%";
         this.FTF_NewProperty_1.text = STRINGS_BASEATTRIBUTENAMES[_loc10_] + parseFloat((_loc6_ * _loc5_.Assattribute).toFixed(2)) + "%";
         this.FTF_NeedCost.textColor = this.FTF_CostNum.textColor = this.FNeedRuneNum <= this.FOwnRuneNum ? CONST_COMMON.TEXT_Green_Color : CONST_COMMON.TEXT_Red_Color;
         this.FTF_NeedCost1.textColor = this.FTF_CostNum1.textColor = this.FCostItemCount <= this.FOwnItemNum ? CONST_COMMON.TEXT_Green_Color : CONST_COMMON.TEXT_Red_Color;
         if(this.FCostItemCount <= this.FOwnItemNum && this.FNeedRuneNum <= this.FOwnRuneNum)
         {
            TGameUtil.setButtonMode(this.FBtn_Upgrade,true);
            this.FBtn_Upgrade.isClick = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBtn_Upgrade,false);
            this.FBtn_Upgrade.isClick = false;
         }
         _loc11_ = this.FMedalNameList.length;
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            this.FMedalNameList[_loc10_].text = _loc3_.Name;
            this.FMedalNameList[_loc10_].textColor = QUALITYCOLOR_INDEX[_loc3_.Quality];
            _loc10_++;
         }
         this.FTF_CostNum1.text = "* " + this.FCostItemCount;
         this.FTF_OwnNum1.text = "* " + this.FOwnItemNum;
         this.FTF_NeedCost1.text = STRING_TALISMAN.STRINGS_TalismanCost;
         this.FTF_TalismanUpgrading.text = "+" + _loc15_;
         this.FTF_CostName.text = this.FTF_CostName_1.text = this.FCostInventorieName;
         this.FTF_OwnNum.text = "* " + this.FOwnRuneNum;
         this.FTF_CostNum.text = "* " + this.FNeedRuneNum;
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2,null);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2,null);
         }
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Talisman);
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
      
      public function get Bin() : TBins
      {
         return this.FBin;
      }
      
      public function set Bin(param1:TBins) : void
      {
         this.FBin = param1;
      }
      
      public function get UpgradeOnclick() : Function
      {
         return this.FUpgradeOnclick;
      }
      
      public function set UpgradeOnclick(param1:Function) : void
      {
         this.FUpgradeOnclick = param1;
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
      
      public function get OnTipsOver() : Function
      {
         return this.FOnTipsOver;
      }
      
      public function set OnTipsOver(param1:Function) : void
      {
         this.FOnTipsOver = param1;
      }
      
      public function get OnTipsOut() : Function
      {
         return this.FOnTipsOut;
      }
      
      public function set OnTipsOut(param1:Function) : void
      {
         this.FOnTipsOut = param1;
      }
      
      public function Update(param1:uint, param2:uint = 0) : void
      {
         this.FRoleIndex = param1;
         this.FItemIndex = param2;
         this.Reset();
         this.UpdateBtn();
         this.UpdateText();
         this.UpdateEquip();
      }
      
      public function UpdateUpgradeEquip() : void
      {
         this.Reset();
         this.UpdateBtn();
         this.UpdateText();
         this.SetEuuipInfo();
      }
      
      public function Reset() : void
      {
         this.FContext = null;
         this.FItemIndex = 0;
         this.FAddvalue = 0;
         if(this.WoQu)
         {
         }
         this.FUpgradePaperNum = 0;
         this.FSystemLanguage = null;
      }
      
      public function ResetCopy() : void
      {
         this.WoQu = false;
         this.FIdentifier0 = 0;
         this.FIdentifier1 = 0;
      }
      
      public function SetBtnLock(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.FBtnList.length)
         {
            TGameUtil.LockOrUnlockButton(this.FBtnList[_loc2_],param1);
            _loc2_++;
         }
      }
   }
}

