package Processors.Game.Lobby.Talisman
{
   import Components.ScrollBar.TScrollBar;
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
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.DatebaseVO.VO.TTreasureLevelup;
   import Logics.DatebaseVO.VO.TTreasureUpgrade;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TTalismanLevelUp extends TProcessorLobbyWindow
   {
      
      protected var FScene:MovieClip;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FTF_OldProperty:TextField;
      
      protected var FTF_NewProperty:TextField;
      
      protected var FTF_Cost:TextField;
      
      protected var FTF_GoldNum:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FMC_LevelUpOldSlot:TUISlot;
      
      protected var FMC_LevelUpNewSlot:TUISlot;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FBtn_LevelUp:MovieClip;
      
      protected var FArrowList:Vector.<MovieClip>;
      
      protected var FMC_List:MovieClip;
      
      protected var FBin:TBins;
      
      protected var FRoleIndex:uint;
      
      protected var FInitialized:Boolean;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTF_OldUpgrading:TextField;
      
      protected var FTF_NewUpgrading:TextField;
      
      protected var FTF_OldName:TextField;
      
      protected var FTF_NewName:TextField;
      
      protected var FCharacter:TCharacter;
      
      protected var FMC_FloatEffect:MovieClip;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FContext:Object;
      
      protected var FItemIndex:uint;
      
      protected var FAddvalue:uint;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FTF_PropertyList:Vector.<TextField>;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FNeedGOld:uint;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FLevelUpOnClick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public function TTalismanLevelUp(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FArrowList = new Vector.<MovieClip>(2);
         this.FCharacter = SLogicsCore.Character;
         this.FTF_PropertyList = new Vector.<TextField>();
         this.FBtnList = new Vector.<MovieClip>();
         this.FInitialized = false;
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
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TALISMAN.RESOURCE_ClassName_MC_LevelUp) as MovieClip;
         addChild(this.FScene);
         this.x = CONST_TALISMAN.POSX_MC_SCENE;
         this.y = CONST_TALISMAN.POSY_MC_SCENE;
         this.visible = false;
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FTF_OldProperty = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_OldProperty];
         this.FTF_OldProperty.mouseEnabled = false;
         this.FTF_NewProperty = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_NewProperty];
         this.FTF_NewProperty.mouseEnabled = false;
         this.FTF_OldUpgrading = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_OldUpgrading];
         this.FTF_OldUpgrading.mouseEnabled = false;
         this.FTF_NewUpgrading = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_NewUpgrading];
         this.FTF_NewUpgrading.mouseEnabled = false;
         this.FTF_OldName = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_OldName];
         this.FTF_OldName.mouseEnabled = false;
         this.FTF_NewName = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_NewName];
         this.FTF_NewName.mouseEnabled = false;
         this.FTF_Cost = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Cost];
         this.FTF_Cost.mouseEnabled = false;
         this.FTF_GoldNum = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_GoldNum];
         this.FTF_GoldNum.mouseEnabled = false;
         this.FTF_Gold = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Gold];
         this.FTF_Gold.mouseEnabled = false;
         _loc2_ = this.FArrowList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Arrows + _loc1_];
            this.FArrowList[_loc1_] = _loc3_;
            _loc3_.visible = false;
            this.FTF_PropertyList[_loc1_] = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Property + _loc1_];
            this.FTF_PropertyList[_loc1_].mouseEnabled = false;
            _loc1_++;
         }
         this.FMC_FloatEffect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_FloatEffect];
         this.FMC_List = this.FScene[CONST_TALISMAN.RESOURCE_Link_Mc_List];
         this.FBtn_LevelUp = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_LevelUp];
         TGameUtil.setButtonMode(this.FBtn_LevelUp,false);
         this.FBtn_LevelUp.mouseEnabled = false;
         this.FBtnList.push(this.FBtn_LevelUp);
         this.FMC_Effect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Effect];
         this.FMC_Effect.visible = false;
         this.FMC_LevelUpOldSlot = new TUISlot(this);
         this.FMC_LevelUpOldSlot.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_LevelUpOldSlot] as Sprite;
         this.FMC_LevelUpOldSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_LevelUpOldSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_LevelUpOldSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_LevelUpOldSlot.OnOut = this.SlotsOnOut;
         this.FMC_LevelUpOldSlot.Init();
         this.FMC_LevelUpNewSlot = new TUISlot(this);
         this.FMC_LevelUpNewSlot.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_LevelUpNewSlot] as Sprite;
         this.FMC_LevelUpNewSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_LevelUpNewSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_LevelUpNewSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_LevelUpNewSlot.OnOut = this.SlotsOnOut;
         this.FMC_LevelUpNewSlot.Init();
         this.FPopWindow = new TUIWindowConfirmation(this.Parent.Parent);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
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
         var _loc2_:int = 0;
         if(this.FInitialized)
         {
            this.FMC_LevelUpOldSlot.Update();
            this.FMC_LevelUpNewSlot.Update();
            _loc2_ = int(this.FMC_SingleEquipList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_FloatEffect.play();
            if(this.FMC_Effect.currentFrame == this.FMC_Effect.totalFrames)
            {
               this.FMC_Effect.gotoAndStop(1);
               this.FMC_Effect.visible = false;
               this.SendMessage();
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         this.FScrollBar.Clear();
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
         TGameUtil.setButtonMode(this.FBtn_LevelUp,false);
         this.FBtn_LevelUp.mouseEnabled = false;
         this.FMC_LevelUpOldSlot.Context = null;
         this.FMC_LevelUpOldSlot.Resource.visible = false;
         this.FMC_LevelUpNewSlot.Context = null;
         this.FMC_LevelUpNewSlot.Resource.visible = false;
      }
      
      protected function UpdateBackpack() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TInventories = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TArticle = null;
         var _loc12_:uint = 0;
         _loc9_ = uint(this.FCharacter.Heros.Count);
         _loc10_ = _loc9_ - 1;
         if(this.FRoleIndex > _loc10_)
         {
            _loc1_ = uint(this.FCharacter.Treasures.Count);
         }
         else
         {
            _loc1_ = CONST_TALISMAN.CAPACITY_TalismanNum;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.FRoleIndex > _loc10_)
            {
               _loc4_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc2_);
            }
            else
            {
               _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).TalismansMounted.GetInventoryByIndex(_loc2_);
            }
            if(_loc4_ != null)
            {
               _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc4_.IDTemplate) as TArticle;
               _loc5_ = _loc4_.Name;
               _loc6_ = uint(_loc11_.Level);
               _loc7_ = _loc4_.Quality;
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc3_.StubReferences.Reference(this);
               _loc3_.OnClick = this.SingleEquipOnClick;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnOver = this.SlotsOnMove;
               _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               this.FMC_SingleEquipList.push(_loc3_);
               _loc3_.SetEquip(_loc4_,_loc5_,STRING_TALISMAN.STRINGS_TalismanLevel + _loc6_,_loc7_);
               this.FScrollBar.AddItem(_loc3_);
               _loc12_++;
            }
            _loc2_++;
         }
         if(_loc1_ < CONST_TALISMAN.CAPACITY_EQUIP || _loc1_ == 0)
         {
            _loc1_ = CONST_TALISMAN.CAPACITY_EQUIP;
            _loc2_ = 0;
            while(_loc2_ < _loc1_ - _loc12_)
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
         _loc2_ = this.FArrowList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FArrowList[_loc1_].visible = false;
            this.FTF_PropertyList[_loc1_].text = "";
            _loc1_++;
         }
         this.FTF_OldProperty.text = "";
         this.FTF_NewProperty.text = "";
         this.FTF_Cost.text = "";
         this.FTF_GoldNum.text = "";
         this.FTF_Gold.text = "";
         this.FTF_OldUpgrading.text = "";
         this.FTF_NewUpgrading.text = "";
         this.FTF_OldName.text = "";
         this.FTF_NewName.text = "";
      }
      
      protected function SendMessage() : void
      {
         this.FLevelUpOnClick(this,this.FContext);
         this.SetBtnLock(false);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(!this.FBtn_LevelUp.hasEventListener(MouseEvent.CLICK))
         {
            this.FBtn_LevelUp.addEventListener(MouseEvent.CLICK,this.FFBtn_LevelUpClickHandler,false,0,true);
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function FFBtn_LevelUpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Talisman_Levelup).DescribeString,this.FNeedGOld);
         this.FPopWindow.Text = _loc2_;
         this.FPopWindow.visible = true;
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TEquipment = null;
         _loc2_ = this.FContext as TEquipment;
         this.FMC_LevelUpOldSlot.Context = null;
         this.FMC_Effect.play();
         this.FMC_Effect.visible = true;
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TSingleEquip = null;
         var _loc4_:uint = 0;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TTreasureLevelup = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseEquip = null;
         var _loc14_:uint = 0;
         var _loc15_:TTreasureUpgrade = null;
         var _loc16_:uint = 0;
         var _loc17_:TTreasureUpgrade = null;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:TBins = null;
         var _loc21_:uint = 0;
         var _loc22_:TInventories = null;
         var _loc23_:TEquipment = null;
         var _loc24_:Vector.<uint> = null;
         var _loc25_:TTreasureUpgrade = null;
         var _loc26_:String = null;
         var _loc27_:TLostsacredGenerate = null;
         _loc24_ = new Vector.<uint>();
         _loc22_ = new TInventories();
         _loc3_ = param1 as TSingleEquip;
         _loc4_ = uint(this.FCharacter.Heros.Count);
         _loc5_ = param2 as TInventory;
         _loc27_ = SLogicsCore.LostShenQiLogicData.LostsacredGenerateBins.GetDatebaseByValue("ArtifactId",_loc5_.IDTemplate) as TLostsacredGenerate;
         if(_loc27_)
         {
            _loc3_.BSelect = false;
            EffectGenerateText(STRING_TALISMAN.STRING_str1);
            return;
         }
         _loc21_ = _loc5_.RequirementLevel;
         _loc6_ = _loc5_.UpgradingLevel;
         _loc19_ = _loc5_.IDTemplate;
         if(this.FRoleIndex < _loc4_)
         {
            _loc3_.BSelect = false;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_08) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         if(_loc21_ <= 2)
         {
            _loc3_.BSelect = false;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_09) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         this.FContext = param2 as TInventory;
         _loc20_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TreasureUpgrade);
         _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,_loc19_) as TBaseEquip;
         _loc14_ = uint(_loc13_.MainValue);
         _loc8_ = uint(this.FBin.Count);
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = this.FBin.GetDatebaseByIndex(_loc7_) as TTreasureLevelup;
            if(_loc19_ == _loc9_.Itemid)
            {
               if(_loc6_ == _loc9_.Level)
               {
                  _loc10_ = _loc9_.NeedGold;
                  _loc11_ = _loc9_.UpItem;
                  _loc12_ = _loc9_.UpLevel;
                  break;
               }
            }
            _loc7_++;
         }
         if(_loc11_ <= 0 && (_loc21_ >= 5 && _loc21_ < 10))
         {
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_14) as TSystemLanguage;
            _loc26_ = TUtilityString.Format(this.FSystemLanguage.Desc,_loc21_,_loc21_ + 1);
            EffectGenerateText(_loc26_);
            _loc3_.BSelect = false;
            _loc3_.BClick = false;
            return;
         }
         if(_loc11_ > 0)
         {
            _loc8_ = uint(_loc20_.Count);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc17_ = _loc20_.GetDatebaseByIndex(_loc7_) as TTreasureUpgrade;
               if(_loc17_.Itemid == _loc11_)
               {
                  if(_loc17_.Level == _loc12_)
                  {
                     _loc18_ = _loc17_.AddValue;
                  }
               }
               _loc7_++;
            }
            _loc8_ = uint(_loc20_.Count);
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc15_ = _loc20_.GetDatebaseByIndex(_loc7_) as TTreasureUpgrade;
               if(_loc15_.Itemid == _loc19_)
               {
                  if(_loc15_.Level == _loc6_)
                  {
                     _loc16_ = _loc15_.AddValue;
                  }
               }
               _loc7_++;
            }
            _loc24_.push(_loc11_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc22_,_loc24_);
            _loc23_ = _loc22_.GetInventoryByTempletID(_loc11_) as TEquipment;
            _loc23_.UpgradingLevel = _loc12_;
            _loc23_.UpgradingBasisProperty += _loc18_;
            _loc8_ = this.FMC_SingleEquipList.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               this.FMC_SingleEquipList[_loc7_].BClick = false;
               _loc7_++;
            }
            _loc3_.BSelect = true;
            _loc3_.BClick = true;
            if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate >= _loc10_)
            {
               TGameUtil.setButtonMode(this.FBtn_LevelUp,true);
               this.FBtn_LevelUp.mouseEnabled = true;
            }
            else
            {
               TGameUtil.setButtonMode(this.FBtn_LevelUp,false);
               this.FBtn_LevelUp.mouseEnabled = false;
            }
            _loc8_ = this.FArrowList.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               this.FArrowList[_loc7_].visible = true;
               _loc7_++;
            }
            this.FMC_LevelUpOldSlot.Context = _loc5_;
            this.FMC_LevelUpOldSlot.Resource.visible = true;
            this.FMC_LevelUpNewSlot.Context = _loc23_;
            this.FMC_LevelUpNewSlot.Resource.visible = true;
            this.FTF_PropertyList[0].text = this.FTF_PropertyList[1].text = STRING_TALISMAN.STRINGS_TalismanProperty[_loc23_.CategorySecond - 7];
            this.FTF_OldProperty.text = " + " + (_loc14_ + _loc16_);
            this.FTF_NewProperty.text = " + " + (_loc23_.BasisProperty + _loc18_);
            this.FTF_Cost.text = STRING_TALISMAN.STRINGS_TalismanCost;
            this.FTF_GoldNum.text = "" + _loc10_;
            this.FNeedGOld = _loc10_;
            this.FTF_Gold.text = STRING_TALISMAN.STRINGS_TalismanGold;
            this.FTF_OldUpgrading.text = _loc6_.toString();
            this.FTF_NewUpgrading.text = _loc12_.toString();
            this.FTF_OldName.text = _loc5_.Name;
            this.FTF_NewName.text = _loc23_.Name;
            this.FAddvalue = _loc16_;
         }
         else
         {
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_10) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            _loc3_.BSelect = false;
         }
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
      
      public function get LevelUpOnClick() : Function
      {
         return this.FLevelUpOnClick;
      }
      
      public function set LevelUpOnClick(param1:Function) : void
      {
         this.FLevelUpOnClick = param1;
      }
      
      public function get OnInventoryOver() : Function
      {
         return this.OnInventoryOver;
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
         this.UpdateText();
         this.UpdateEquip();
         this.UpdateBackpack();
      }
      
      public function Reset() : void
      {
         this.FRoleIndex = 0;
         this.FContext = null;
         this.FAddvalue = 0;
         this.FSystemLanguage = null;
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

