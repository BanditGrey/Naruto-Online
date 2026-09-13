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
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TLostsacredGenerate;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TTalismanTransition extends TProcessorLobbyWindow
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected const CAPACITY_MC_EquipTransitiont:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
      protected var FMC_EquipTransitionList:Vector.<MovieClip>;
      
      protected var FMC_EffectList:Vector.<MovieClip>;
      
      protected var FMC_EquipTransitionSlotList:Vector.<TUISlot>;
      
      protected var FBtn_Transition:MovieClip;
      
      protected var FMC_TransitionSlot:TUISlot;
      
      protected var FRoleIndex:uint;
      
      protected var FTransitionSlot:TUISlot;
      
      protected var FTF_NeedCost:TextField;
      
      protected var FTF_TransitionPaper:TextField;
      
      protected var FTF_CostNum:TextField;
      
      protected var FMC_List:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTF_TalismanName:TextField;
      
      protected var FTF_PropertyValue:TextField;
      
      protected var FTF_CurrentNum:TextField;
      
      protected var FTransitionPaperNum:uint;
      
      protected var FMC_FloatEffect:MovieClip;
      
      protected var FIndex:uint;
      
      protected var FBtnList:Vector.<MovieClip>;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBin:Vector.<TArticle>;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FCharacter:TCharacter;
      
      protected var FOnClick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public function TTalismanTransition(param1:TUIComponent)
      {
         super(param1);
         this.FInitialized = false;
         this.FBin = new Vector.<TArticle>();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FMC_EquipTransitionList = new Vector.<MovieClip>();
         this.FMC_EquipTransitionSlotList = new Vector.<TUISlot>();
         this.FMC_EffectList = new Vector.<MovieClip>();
         this.FBtnList = new Vector.<MovieClip>();
         this.FCharacter = SLogicsCore.Character;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TALISMAN.RESOURCESID_Swf_Talisman);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISlot = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TALISMAN.RESOURCE_ClassName_MC_Transition) as MovieClip;
         addChild(this.FScene);
         this.x = CONST_TALISMAN.POSX_MC_SCENE;
         this.y = CONST_TALISMAN.POSY_MC_SCENE;
         this.visible = false;
         this.FBtn_Transition = this.FScene[CONST_TALISMAN.RESOURCE_Link_Btn_Transition];
         TGameUtil.setButtonMode(this.FBtn_Transition,false);
         this.FBtn_Transition.mouseEnabled = false;
         this.FBtnList.push(this.FBtn_Transition);
         this.FTF_TransitionPaper = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_TransitionPaper];
         this.FTF_TransitionPaper.mouseEnabled = false;
         this.FTF_NeedCost = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_NeedCost];
         this.FTF_NeedCost.mouseEnabled = false;
         this.FTF_CostNum = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_CostNum];
         this.FTF_CostNum.mouseEnabled = false;
         this.FTF_TalismanName = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_TalismanName];
         this.FTF_TalismanName.mouseEnabled = false;
         this.FTF_PropertyValue = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_PropertyValue];
         this.FTF_PropertyValue.mouseEnabled = false;
         this.FTF_CurrentNum = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_CurrentNum];
         this.FTF_CurrentNum.mouseEnabled = false;
         this.FMC_TransitionSlot = new TUISlot(this);
         this.FMC_TransitionSlot.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_TransitionSlot] as Sprite;
         this.FMC_TransitionSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FMC_TransitionSlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FMC_TransitionSlot.OnOverlay = this.SlotsOnMove;
         this.FMC_TransitionSlot.OnOut = this.SlotsOnOut;
         this.FMC_TransitionSlot.Init();
         this.FMC_List = this.FScene[CONST_TALISMAN.RESOURCE_Link_Mc_List];
         this.FMC_FloatEffect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_FloatEffect];
         _loc1_ = 3;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_EquipTransitions + _loc2_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.EquipTransitionOnClick);
            _loc3_.buttonMode = true;
            this.FMC_EquipTransitionList[_loc2_] = _loc3_;
            this.FMC_EffectList[_loc2_] = _loc3_[CONST_TALISMAN.RESOURCE_Link_MC_Effect];
            _loc4_ = new TUISlot(this);
            _loc4_.Resource = _loc3_[CONST_TALISMAN.RESOURCE_Link_MC_Slot] as Sprite;
            _loc4_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc4_.Tag = _loc2_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.OnOverlay = this.SlotsOnMove;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.Init();
            this.FMC_EquipTransitionSlotList[_loc2_] = _loc4_;
            _loc2_++;
         }
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
         var _loc3_:TUISlot = null;
         super.LogicsPerform();
         if(this.FInitialized)
         {
            _loc2_ = int(this.FMC_EquipTransitionSlotList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FMC_EquipTransitionSlotList[_loc1_];
               _loc3_.Update();
               _loc1_++;
            }
            this.FMC_TransitionSlot.Update();
            _loc2_ = int(this.FMC_SingleEquipList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
            this.FMC_FloatEffect.play();
            if(this.FMC_EffectList[this.FIndex].currentFrame == this.FMC_EffectList[this.FIndex].totalFrames)
            {
               this.FMC_EffectList[this.FIndex].gotoAndStop(1);
               this.SendMessage();
            }
         }
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUISlot = null;
         this.FScrollBar.Clear();
         _loc1_ = this.FMC_EquipTransitionList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = this.FMC_EquipTransitionList[_loc2_];
            _loc4_.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
            _loc5_ = this.FMC_EquipTransitionSlotList[_loc2_];
            _loc5_.Context = null;
            _loc5_.Resource.visible = false;
            _loc2_++;
         }
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
         TGameUtil.setButtonMode(this.FBtn_Transition,false);
         this.FBtn_Transition.mouseEnabled = false;
         this.FMC_TransitionSlot.Context = null;
         this.FMC_TransitionSlot.Resource.visible = false;
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
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc8_ = uint(this.FCharacter.Heros.Count);
         _loc9_ = _loc8_ - 1;
         if(this.FRoleIndex > _loc9_)
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
            if(this.FRoleIndex > _loc9_)
            {
               _loc4_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc2_);
            }
            else
            {
               _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).TalismansMounted.GetInventoryByIndex(_loc2_);
            }
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.Name;
               _loc6_ = _loc4_.UpgradingLevel;
               _loc7_ = _loc4_.Quality;
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc3_.StubReferences.Reference(this);
               _loc3_.OnClick = this.SingleEquipOnClick;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnOver = this.SlotsOnMove;
               _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               this.FMC_SingleEquipList.push(_loc3_);
               _loc3_.SetEquip(_loc4_,_loc5_,STRING_TALISMAN.STRINGS_TalismanUpgrade + _loc6_,_loc7_);
               this.FScrollBar.AddItem(_loc3_);
               _loc10_++;
            }
            _loc2_++;
         }
         if(_loc1_ < CONST_TALISMAN.CAPACITY_EQUIP || _loc1_ == 0)
         {
            _loc1_ = CONST_TALISMAN.CAPACITY_EQUIP;
            _loc2_ = 0;
            while(_loc2_ < _loc1_ - _loc10_)
            {
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               this.FScrollBar.AddItem(_loc3_);
               _loc2_++;
            }
         }
      }
      
      protected function UpdateSlot(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUISlot = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TBins = null;
         var _loc7_:TInventories = null;
         var _loc8_:TInventory = null;
         var _loc9_:TArticle = null;
         var _loc10_:Vector.<uint> = null;
         this.FMC_TransitionSlot.Context = param1 as TInventory;
         this.FMC_TransitionSlot.Resource.visible = true;
         _loc7_ = new TInventories();
         _loc10_ = new Vector.<uint>();
         _loc8_ = param1 as TInventory;
         while(this.FBin.length > 0)
         {
            this.FBin.pop();
         }
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc3_ = uint(_loc6_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc9_ = _loc6_.GetDatebaseByIndex(_loc2_) as TArticle;
            if(_loc9_.MajorType == 4)
            {
               this.FBin.push(_loc9_);
            }
            _loc2_++;
         }
         _loc3_ = this.FBin.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc9_ = this.FBin[_loc2_];
            if(_loc9_.Identifier != _loc8_.IDTemplate && _loc9_.Level == _loc8_.RequirementLevel)
            {
               _loc10_.push(_loc9_.Identifier);
            }
            _loc2_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc10_);
         _loc3_ = this.FMC_EquipTransitionList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_EquipTransitionSlotList[_loc2_];
            _loc8_ = _loc7_.GetInventoryByIndex(_loc2_);
            _loc4_.Context = _loc8_;
            _loc4_.Resource.visible = true;
            _loc2_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:TInventories = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         this.FTF_TransitionPaper.text = "";
         this.FTF_CostNum.text = "";
         this.FTF_NeedCost.text = STRING_TALISMAN.STRINGS_TalismanCost;
         this.FTF_NeedCost.textColor = 15518068;
         this.FTF_TalismanName.text = "";
         this.FTF_PropertyValue.text = "";
         _loc2_ = SLogicsCore.Character.Appliances;
         _loc4_ = uint(_loc2_.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = _loc2_.GetInventoryByIndex(_loc3_);
            if(_loc1_.CategorySecond == CONST_INVENTORY.CATEGORYSECOND_TreasureTransform)
            {
               this.FTransitionPaperNum += _loc1_.Quantity;
            }
            _loc3_++;
         }
         this.FTF_CurrentNum.text = "* " + this.FTransitionPaperNum;
      }
      
      protected function SendMessage() : void
      {
         this.FOnClick(this,this.FMC_TransitionSlot.Context,this.FTransitionSlot.Context);
         this.SetBtnLock(false);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(!this.FBtn_Transition.hasEventListener(MouseEvent.CLICK))
         {
            this.FBtn_Transition.addEventListener(MouseEvent.CLICK,this.FBtn_TransitionClickHandler,false,0,true);
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function FBtn_TransitionClickHandler(param1:Event) : void
      {
         this.FMC_EffectList[this.FIndex].play();
      }
      
      protected function EquipTransitionOnClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:TUISlot = null;
         var _loc8_:TEquipment = null;
         _loc5_ = param1.currentTarget as MovieClip;
         _loc6_ = int(_loc5_.name.split("_")[2]);
         this.FIndex = _loc6_;
         this.FTransitionSlot = this.FMC_EquipTransitionSlotList[_loc6_];
         if(this.FTransitionSlot.Context == null)
         {
            return;
         }
         _loc5_.gotoAndStop(CONST_TALISMAN.MC_Frame_Selected);
         _loc3_ = this.FMC_EquipTransitionList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_EquipTransitionList[_loc2_];
            if(_loc4_ != _loc5_ && _loc4_.currentFrame == CONST_TALISMAN.MC_Frame_Selected)
            {
               _loc4_.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
               break;
            }
            _loc2_++;
         }
         if(this.FTransitionPaperNum > 0)
         {
            this.FTF_NeedCost.textColor = CONST_COMMON.TEXT_Green_Color;
            this.FTF_CostNum.textColor = CONST_COMMON.TEXT_Green_Color;
            TGameUtil.setButtonMode(this.FBtn_Transition,true);
            this.FBtn_Transition.mouseEnabled = true;
         }
         else
         {
            this.FTF_NeedCost.textColor = CONST_COMMON.TEXT_Red_Color;
            this.FTF_CostNum.textColor = CONST_COMMON.TEXT_Red_Color;
            TGameUtil.setButtonMode(this.FBtn_Transition,false);
            this.FBtn_Transition.mouseEnabled = false;
         }
         this.FTF_NeedCost.text = STRING_TALISMAN.STRINGS_TalismanCost;
         this.FTF_CostNum.text = "* " + 1;
         this.FTF_TransitionPaper.text = STRING_TALISMAN.STRING_ItemName;
         _loc7_ = this.FMC_EquipTransitionSlotList[_loc6_];
         _loc8_ = _loc7_.Context as TEquipment;
         this.FTF_TalismanName.text = _loc8_.Name;
         this.FTF_TalismanName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc8_.Quality];
         this.FTF_PropertyValue.text = STRING_TALISMAN.STRINGS_TalismanProperty[_loc8_.CategorySecond - 7] + (_loc8_.BasisProperty + _loc8_.UpgradingBasisProperty);
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TUISlot = null;
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:THero = null;
         var _loc8_:TSingleEquip = null;
         var _loc9_:TSingleEquip = null;
         var _loc10_:uint = 0;
         var _loc11_:TLostsacredGenerate = null;
         _loc8_ = param1 as TSingleEquip;
         _loc4_ = param2 as TInventory;
         _loc11_ = SLogicsCore.LostShenQiLogicData.LostsacredGenerateBins.GetDatebaseByValue("ArtifactId",_loc4_.IDTemplate) as TLostsacredGenerate;
         if(_loc11_)
         {
            _loc8_.BSelect = false;
            EffectGenerateText("此件装备无法转换");
            return;
         }
         _loc10_ = uint(this.FCharacter.Heros.Count);
         if(this.FRoleIndex < _loc10_)
         {
            _loc8_.BSelect = false;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_11) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         if(_loc4_.UpgradingLevel > 0)
         {
            _loc8_.BSelect = false;
            this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_12) as TSystemLanguage;
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         _loc6_ = this.FMC_SingleEquipList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            this.FMC_SingleEquipList[_loc5_].BClick = false;
            _loc5_++;
         }
         _loc8_.BSelect = true;
         _loc8_.BClick = true;
         this.UpdateSlot(param2);
         this.UpdateTransitionSlots();
      }
      
      protected function UpdateTransitionSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.FMC_EquipTransitionList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_EquipTransitionList[_loc1_];
            _loc3_.gotoAndStop(CONST_TALISMAN.MC_Frame_Normal);
            _loc1_++;
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
      
      public function get TransitionOnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set TransitionOnClick(param1:Function) : void
      {
         this.FOnClick = param1;
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
         this.Reset();
         this.UpdateEquip();
         this.UpdateText();
         this.UpdateBackpack();
      }
      
      public function Reset() : void
      {
         this.FSystemLanguage = null;
         this.FTransitionPaperNum = 0;
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

