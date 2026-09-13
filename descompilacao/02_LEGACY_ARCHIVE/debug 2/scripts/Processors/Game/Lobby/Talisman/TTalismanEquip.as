package Processors.Game.Lobby.Talisman
{
   import Components.ComboBox.TComboBox;
   import Components.Pages.TUIPage;
   import Components.Slots.TUISlot;
   import Components.Standard.TUIButton;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
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
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIHero;
   import Rendering.Overlayers.Inventories.TOverShenQiEWaiAttriTip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TALISMAN;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TALISMAN;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class TTalismanEquip extends TProcessorLobbyWindow
   {
      
      protected static const CAPACITY_Equip:uint = 6;
      
      protected static const TALISMAN_StartIndex:uint = 7;
      
      protected static const TALISMAN_TextWidth:uint = 96;
      
      protected static const TALISMAN_TextPosX:uint = 32;
      
      protected var FScene:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FEquipSlots:Vector.<TUISlot>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_HeroPosition:MovieClip;
      
      protected var FLevelList:Vector.<DisplayObject>;
      
      protected var FTypeList:Vector.<DisplayObject>;
      
      protected var FLevelComboBox:TComboBox;
      
      protected var FTypeComboBox:TComboBox;
      
      protected var FLevelIndex:uint;
      
      protected var FTypeIndex:uint;
      
      protected var FTF_PropertyList:Vector.<TextField>;
      
      protected var FTF_Page:TextField;
      
      protected var FRoleIndex:uint;
      
      protected var FMC_Role:MovieClip;
      
      protected var FPage_Index:int;
      
      protected var FInitialized:Boolean;
      
      protected var FCharacter:TCharacter;
      
      protected var FTargetSlot:TUISlot;
      
      protected var FInventory:TInventory;
      
      protected var FUIHero:TUIHero;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FSystemLanguageBin:TBins;
      
      protected var FUpgradingTextList:Vector.<TextField>;
      
      protected var FTalismanTextList:Vector.<MovieClip>;
      
      protected var FNameTextList:Vector.<TextField>;
      
      protected var FBmpIconList:Vector.<MovieClip>;
      
      protected var FMC_BmpList:Vector.<MovieClip>;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FRoleModel:TRoleModel = null;
      
      protected var FOverShenQiEWaiAttriTip:TOverShenQiEWaiAttriTip;
      
      protected var FCurInventories:TInventories;
      
      protected var FSlotOnClick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public var OnGoToKillHeros:Function;
      
      protected var Fcurhero:THero;
      
      protected var FIsShowEffectNiaja:Boolean = false;
      
      protected var FEffectFatherSpr:Sprite;
      
      protected var FEffectBitmap:Bitmap;
      
      public function TTalismanEquip(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FUIPage = new TUIPage(this);
         this.FTF_PropertyList = new Vector.<TextField>(CONST_TALISMAN.CAPACITY_TF_Property);
         this.FUISlots = new Vector.<TUISlot>(CONST_TALISMAN.CAPACITY_MC_Slots);
         this.FEquipSlots = new Vector.<TUISlot>(CONST_TALISMAN.CAPACITY_MC_Talisman);
         this.FUpgradingTextList = new Vector.<TextField>();
         this.FTalismanTextList = new Vector.<MovieClip>();
         this.FNameTextList = new Vector.<TextField>();
         this.FBmpIconList = new Vector.<MovieClip>();
         this.FMC_BmpList = new Vector.<MovieClip>();
         this.FInitialized = false;
         this.FEffectFatherSpr = new Sprite();
         this.FEffectBitmap = new Bitmap();
         this.FEffectFatherSpr.addChild(this.FEffectBitmap);
         this.FOverShenQiEWaiAttriTip = new TOverShenQiEWaiAttriTip(param1.Parent);
         this.FOverShenQiEWaiAttriTip.visible = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TALISMAN.RESOURCESID_Swf_Talisman);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TUISlot = null;
         var _loc6_:Array = null;
         var _loc7_:DisplayObject = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TALISMAN.RESOURCE_ClassName_MC_Equip) as MovieClip;
         this.x = CONST_TALISMAN.POSX_MC_SCENE;
         this.y = CONST_TALISMAN.POSY_MC_SCENE;
         addChild(this.FScene);
         _loc3_ = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_PageLeft];
         this.FUIPage.ButtonPrevious.Substrate = _loc3_;
         _loc3_ = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_PageRight];
         this.FUIPage.ButtonNext.Substrate = _loc3_;
         this.FUIPage.OnChangePage = this.ChangePage;
         this.FTF_Page = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Page];
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.PageSize = CONST_TALISMAN.CAPACITY_MC_Slots;
         this.FUIPage.Init();
         this.FButtonPrevious = this.FUIPage.ButtonPrevious;
         this.FButtonNext = this.FUIPage.ButtonNext;
         this.FTF_Page = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Page];
         this.FMC_Role = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Role];
         this.FMC_HeroPosition = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_HeroPosition];
         this.FMC_Effect = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Effect];
         this.FPage_Index = 0;
         _loc2_ = int(this.FTF_PropertyList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FScene[CONST_TALISMAN.RESOURCE_Link_TF_Property + _loc1_];
            _loc4_.mouseEnabled = false;
            this.FTF_PropertyList[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = int(CONST_TALISMAN.CAPACITY_MC_Slots);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Slots + _loc1_] as Sprite;
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.Tag = _loc1_;
            _loc5_.OnClick = this.EquipOnOnClick;
            _loc5_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc5_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc5_.OnOverlay = this.SlotsOnMove;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.Init();
            this.FUISlots[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc2_ = int(this.FEquipSlots.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Equip + _loc1_] as Sprite;
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.Tag = _loc1_;
            _loc5_.OnClick = this.EquipOffOnClick;
            _loc5_.OnQuerySequenceContext = this.SlotsOnBigQuerySequenceContext;
            _loc5_.OnOverlay = this.SlotsOnMove;
            _loc5_.OnOut = this.SlotsOnOut;
            _loc5_.Init();
            this.FEquipSlots[_loc1_] = _loc5_;
            this.FTalismanTextList[_loc1_] = _loc5_.Resource[CONST_TALISMAN.RESOURCE_Link_TalismanText];
            this.FUpgradingTextList[_loc1_] = _loc5_.Resource[CONST_TALISMAN.RESOURCE_Link_TalismanText][CONST_TALISMAN.RESOURCE_Link_TF_Upgrading];
            this.FUpgradingTextList[_loc1_].mouseEnabled = false;
            this.FNameTextList[_loc1_] = _loc5_.Resource[CONST_TALISMAN.RESOURCE_Link_TalismanText][CONST_TALISMAN.RESOURCE_Link_TF_Name];
            this.FNameTextList[_loc1_].mouseEnabled = false;
            this.FBmpIconList[_loc1_] = _loc5_.Resource[CONST_TALISMAN.RESOURCE_Link_MC_Bmp_Icon];
            _loc1_++;
         }
         _loc2_ = 4;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_BmpList[_loc1_] = this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_Bmp + _loc1_];
            _loc1_++;
         }
         this.FLevelList = new Vector.<DisplayObject>();
         _loc6_ = STRING_TALISMAN.STRINGS_TalismanLevels;
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc7_ = this.MakeComboItem(_loc6_[_loc1_]);
            this.FLevelList.push(_loc7_);
            _loc1_++;
         }
         this.FLevelComboBox = new TComboBox(this,this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_TalismanLevel],this.FLevelList,71,this.OnLevelSelect);
         this.FTypeList = new Vector.<DisplayObject>();
         _loc6_ = STRING_TALISMAN.STRINGS_TalismanType;
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc7_ = this.MakeComboItem(_loc6_[_loc1_]);
            this.FTypeList.push(_loc7_);
            _loc1_++;
         }
         this.FTypeComboBox = new TComboBox(this,this.FScene[CONST_TALISMAN.RESOURCE_Link_MC_TalismanType],this.FTypeList,71,this.OnTypeSelect);
         this.FUIHero = new TUIHero(this);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FMC_HeroPosition.addChild(this.FEffectFatherSpr);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverShenQiEWaiAttriTip);
         this.FInitialized = true;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.addChalleng_btn(SLogicsCore.Character.GetMainLevel());
         this.FScene.MC_ShenQiAttri.addEventListener(MouseEvent.MOUSE_MOVE,this.ShenQiAttriMOVE);
         this.FScene.MC_ShenQiAttri.addEventListener(MouseEvent.MOUSE_OUT,this.ShenQiAttriOUT);
      }
      
      public function NimeiA() : void
      {
         if(SLogicsCore.Character.MainHero.Level >= SLogicsCore.LostShenQiLogicData.ShenQiOpenLevel)
         {
            if(this.FScene.MC_ShenQiAttri)
            {
               this.FScene.MC_ShenQiAttri.visible = true;
            }
         }
         else if(this.FScene.MC_ShenQiAttri)
         {
            this.FScene.MC_ShenQiAttri.visible = false;
         }
      }
      
      protected function ShenQiAttriMOVE(param1:MouseEvent) : void
      {
         if(this.FOverShenQiEWaiAttriTip != null)
         {
            if(!this.Fcurhero)
            {
               return;
            }
            this.FOverShenQiEWaiAttriTip.Context = this.Fcurhero;
            this.FOverShenQiEWaiAttriTip.Render(FUICore.MouseCoordinate);
            this.FOverShenQiEWaiAttriTip.Show();
         }
      }
      
      protected function ShenQiAttriOUT(param1:MouseEvent) : void
      {
         if(this.FOverShenQiEWaiAttriTip != null)
         {
            this.FOverShenQiEWaiAttriTip.Hide();
         }
      }
      
      private function addChalleng_btn(param1:int = -1) : void
      {
         if(param1 >= 30)
         {
            TGameUtil.setButtonMode(this.FScene.MC_Challenge_Btn,true);
            this.FScene.MC_Challenge_Btn.addEventListener(MouseEvent.CLICK,this.OnClickGoToKillHerosHandler);
            this.FScene.MC_Challenge_Btn.visible = true;
         }
         else if(param1 < 30)
         {
            this.FScene.MC_Challenge_Btn.visible = false;
         }
      }
      
      protected function OnClickGoToKillHerosHandler(param1:MouseEvent) : void
      {
         if(this.OnGoToKillHeros != null)
         {
            this.OnGoToKillHeros(this);
         }
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
         if(this.FInitialized == true)
         {
            _loc2_ = int(CONST_TALISMAN.CAPACITY_MC_Slots);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FUISlots[_loc1_];
               _loc3_.Update();
               _loc1_++;
            }
            _loc2_ = int(this.FEquipSlots.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FEquipSlots[_loc1_];
               _loc3_.Update();
               _loc1_++;
            }
            this.FUIHero.Update();
            this.FMC_Effect.play();
         }
         this.upDateEffectImage();
         super.LogicsPerform();
      }
      
      protected function OnLevelSelect(param1:Object, param2:uint) : void
      {
         this.FLevelIndex = param2;
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
      }
      
      protected function OnTypeSelect(param1:Object, param2:int) : void
      {
         if(param2 == 0)
         {
            this.FTypeIndex = param2;
         }
         else
         {
            this.FTypeIndex = param2 + CONST_TALISMAN.CAPACITY_EQUIP;
         }
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TALISMAN.RESOURCE_ClassName_ComboBoxItem) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function UpdatePageInfo() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FPage_Index * CONST_TALISMAN.CAPACITY_MC_Slots;
         if(_loc1_ >= this.FCurInventories.Count)
         {
            --this.FPage_Index;
            if(this.FPage_Index < 0)
            {
               this.FPage_Index = 0;
            }
         }
         this.FUIPage.TotalQuantity = this.FCurInventories.Count;
         this.FUIPage.PageIndex = this.FPage_Index;
         this.FUIPage.Update();
      }
      
      protected function UpdateSlotsInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUISlot = null;
         _loc3_ = CONST_TALISMAN.CAPACITY_MC_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = this.FUISlots[_loc1_];
            _loc4_.Context = null;
            _loc4_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.FPage_Index * CONST_TALISMAN.CAPACITY_MC_Slots;
         _loc3_ = uint(this.FCurInventories.Count);
         this.FCurInventories.SortCopy();
         _loc1_ = 0;
         while(_loc1_ < CONST_TALISMAN.CAPACITY_MC_Slots)
         {
            if(_loc3_ <= _loc2_ + _loc1_)
            {
               break;
            }
            _loc4_ = this.FUISlots[_loc1_];
            _loc4_.Context = this.FCurInventories.GetInventoryByIndex(_loc2_ + _loc1_);
            _loc4_.Resource.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateBackpack() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = null;
         _loc4_ = new TInventories();
         if(this.FLevelIndex == 0 && this.FTypeIndex == 0)
         {
            _loc4_ = this.FCharacter.Treasures;
         }
         else
         {
            _loc2_ = uint(this.FCharacter.Treasures.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FCharacter.Treasures.GetInventoryByIndex(_loc1_);
               if(this.CheckLevel(_loc3_) && this.CheckType(_loc3_))
               {
                  _loc4_.Add(_loc3_);
               }
               _loc1_++;
            }
         }
         this.FCurInventories = _loc4_;
      }
      
      protected function CheckLevel(param1:TInventory) : Boolean
      {
         if(this.FLevelIndex == 0)
         {
            return true;
         }
         if(param1.RequirementLevel == this.FLevelIndex)
         {
            return true;
         }
         return false;
      }
      
      protected function CheckType(param1:TInventory) : Boolean
      {
         if(this.FTypeIndex == 0)
         {
            return true;
         }
         if(param1.CategorySecond == this.FTypeIndex)
         {
            return true;
         }
         return false;
      }
      
      protected function UpdateRole() : void
      {
         var _loc1_:THero = null;
         _loc1_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         this.Fcurhero = _loc1_;
         this.FUIHero.Context = _loc1_;
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TInventory = null;
         var _loc5_:THero = null;
         _loc5_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         _loc2_ = uint(_loc5_.TalismansMounted.Capacity);
         this.addChalleng_btn(SLogicsCore.Character.GetMainLevel());
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEquipSlots[_loc1_];
            _loc3_.Context = null;
            this.FUpgradingTextList[_loc1_].text = "";
            this.FNameTextList[_loc1_].text = "";
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEquipSlots[_loc1_];
            _loc4_ = _loc5_.TalismansMounted.GetInventoryByIndex(_loc1_);
            _loc3_.Context = _loc4_;
            if(_loc4_ != null)
            {
               this.FBmpIconList[_loc1_].filters = [new GlowFilter(CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality],0.9,17,15,3)];
               if(_loc4_.UpgradingLevel > 0)
               {
                  this.FUpgradingTextList[_loc1_].text = "+" + _loc4_.UpgradingLevel;
                  this.FNameTextList[_loc1_].x = TALISMAN_TextPosX;
               }
               else
               {
                  this.FNameTextList[_loc1_].x = (TALISMAN_TextWidth - this.FNameTextList[_loc1_].width) / 2;
               }
               this.FNameTextList[_loc1_].text = _loc4_.Name;
               this.FNameTextList[_loc1_].textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FTalismanTextList[_loc1_].visible = true;
               this.FMC_BmpList[_loc1_].visible = false;
            }
            else
            {
               this.FTalismanTextList[_loc1_].visible = false;
               this.FMC_BmpList[_loc1_].visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePropertyText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:THero = null;
         var _loc5_:Number = NaN;
         if(this.FRoleIndex >= this.FCharacter.Heros.Count)
         {
            return;
         }
         _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         _loc2_ = uint(_loc4_.TalismansMounted.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FTF_PropertyList[_loc1_];
            _loc5_ = _loc4_.GetFirstAttributeByIndex(_loc1_);
            if(_loc5_ > 0)
            {
               _loc3_.text = "+ " + _loc5_;
               _loc3_.textColor = CONST_COMMON.TEXT_Green_Color;
            }
            else
            {
               _loc3_.text = "+ " + _loc5_;
               _loc3_.textColor = CONST_COMMON.TEXT_White_Color;
            }
            _loc1_++;
         }
      }
      
      protected function ChangePage(param1:Object, param2:uint) : void
      {
         this.FPage_Index = param2;
         this.UpdateBackpack();
         this.UpdateSlotsInfo();
      }
      
      protected function CharacterUpdateBaseAttributes() : void
      {
         if(this.FInitialized)
         {
            this.UpdatePropertyText();
         }
      }
      
      protected function CheckEquipmentMouted(param1:Function, param2:TInventory) : void
      {
         var _loc3_:THero = null;
         var _loc4_:THeros = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TInventory = null;
         _loc4_ = this.FCharacter.Heros;
         _loc3_ = _loc4_.GetHeroByIndex(this.FRoleIndex);
         _loc6_ = CONST_TALISMAN.CAPACITY_TalismanNum;
         if(param2.Category == 4)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc3_.TalismansMounted.GetInventoryByIndex(_loc5_);
               if(_loc7_ != null && _loc7_ != param2 && _loc7_.CategorySecond == param2.CategorySecond)
               {
                  if(param1 != null)
                  {
                     param1(this,param2,_loc7_);
                  }
                  return;
               }
               _loc5_++;
            }
            if(param1 != null)
            {
               param1(this,param2,null);
            }
         }
         else if(param1 != null)
         {
            param1(this,param2,null);
         }
      }
      
      protected function EquipOnOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:THero = null;
         this.FTargetSlot = param1 as TUISlot;
         this.FInventory = param2 as TInventory;
         _loc4_ = this.FCharacter.StarMapIndex;
         if(this.FInventory == null)
         {
            return;
         }
         this.FSystemLanguage = this.FSystemLanguageBin.GetDatebaseByIdentifier(CONST_SYSTEMLANGUAGE.TALISMAN_STRING_07) as TSystemLanguage;
         _loc6_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         _loc3_ = _loc6_.Quality;
         if(this.FTargetSlot.Context == null)
         {
            return;
         }
         if(this.FInventory.Quality > _loc3_)
         {
            EffectGenerateText(this.FSystemLanguage.Desc);
            return;
         }
         this.FSlotOnClick(this,this.FInventory,CONST_TALISMAN.TalismanOn_Type,_loc6_.Identifier);
         this.CheckEquipmentMouted(this.FOnInventoryOut,this.FInventory);
         TutorialNextStep(1100);
      }
      
      protected function EquipOffOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:THero = null;
         var _loc4_:TEquipment = null;
         _loc3_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex);
         this.FTargetSlot = param1 as TUISlot;
         this.FInventory = param2 as TInventory;
         if(this.FInventory == null)
         {
            return;
         }
         this.FSlotOnClick(this,this.FInventory,CONST_TALISMAN.TalismanOff_Type,_loc3_.Identifier);
         this.CheckEquipmentMouted(this.FOnInventoryOut,this.FInventory);
      }
      
      protected function SlotsOnBigQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 1) : void
      {
         this.SlotsOnQuerySequenceContext(param1,param2,param3,param4);
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
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOver,param2);
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         this.CheckEquipmentMouted(this.FOnInventoryOut,param2);
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         this.FRoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(this.FRoleModel.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(this.FRoleModel.Model,CONST_MODULES.MODULE_Talisman);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
         if(_loc5_.Identifier != SLogicsCore.Character.MainHero.Identifier)
         {
            if(_loc5_.ReincarnationOneOrTwo >= 1)
            {
               this.FIsShowEffectNiaja = true;
               this.FEffectFatherSpr.visible = true;
            }
            else
            {
               this.FIsShowEffectNiaja = false;
               this.FEffectFatherSpr.visible = false;
            }
         }
         else
         {
            this.FIsShowEffectNiaja = false;
            this.FEffectFatherSpr.visible = false;
         }
      }
      
      protected function upDateEffectImage() : void
      {
         if(this.FIsShowEffectNiaja)
         {
            TGameUtil.ShowEffectById(this.FEffectBitmap,CONST_COMMON.Nija_Reincarnation_Effect_NotMain);
            this.FEffectBitmap.visible = true;
         }
         else
         {
            if(this.FEffectBitmap.bitmapData)
            {
               this.FEffectBitmap.bitmapData.dispose();
               this.FEffectBitmap.bitmapData = null;
            }
            this.FEffectBitmap.visible = false;
         }
      }
      
      public function get SlotOnClick() : Function
      {
         return this.FSlotOnClick;
      }
      
      public function set SlotOnClick(param1:Function) : void
      {
         this.FSlotOnClick = param1;
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
      
      public function Update(param1:uint, param2:uint = 0) : void
      {
         this.FRoleIndex = param1;
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
         this.UpdateRole();
         this.UpdateEquip();
         this.UpdatePropertyText();
      }
      
      public function UpdateCharacterBaseAttributes() : void
      {
         this.CharacterUpdateBaseAttributes();
      }
      
      public function SetZearo() : void
      {
         this.FPage_Index = 0;
      }
      
      public function UpdateEquipSlots() : void
      {
         this.UpdateEquip();
         this.UpdateBackpack();
         this.UpdatePageInfo();
         this.UpdateSlotsInfo();
         this.UpdatePropertyText();
      }
      
      public function Reset() : void
      {
         this.FInventory = null;
         this.FTargetSlot = null;
         this.FSystemLanguage = null;
      }
   }
}

