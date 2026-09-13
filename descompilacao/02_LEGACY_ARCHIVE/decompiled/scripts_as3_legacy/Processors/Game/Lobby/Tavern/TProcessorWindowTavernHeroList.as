package Processors.Game.Lobby.Tavern
{
   import Components.ComboBox.TComboBox;
   import Components.Slots.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Inventories.*;
   import Logics.Tavern.*;
   import Logics.Vip.TVip;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowTavernHeroList extends TUIComponent
   {
      
      protected static const ONEKEYTen_COUNT:uint = 10;
      
      protected static const ONEKEYWin_COUNT:uint = 30;
      
      protected static const TAMP_HEROLIST_WIDTH:uint = 50;
      
      protected static const TAMP_HEROLIST_HEIGHT:uint = 50;
      
      protected static const Random_Max:uint = 3;
      
      protected static const HERO_Count:uint = 3;
      
      protected static const CONST_HEROLIST_MAX:uint = 10;
      
      protected static const CONST_CARDLIST_MAX:uint = 2;
      
      protected static const CONST_BTN_MAX:uint = 2;
      
      protected static const INDEX_Station_Front:int = 1;
      
      protected static const INDEX_Station_Middle:int = 2;
      
      protected static const INDEX_Station_After:int = 3;
      
      protected static const INITBTN_POS_X:int = 619 - 300;
      
      protected static const INITBTN_POS_Y:int = 327;
      
      protected static const INITBTN_STAMP_WIDTH:int = -90;
      
      protected static const BTN_QUALITY_BULE:uint = 3;
      
      protected static const BTN_QUALITY_PURPLE:uint = 4;
      
      protected static const BTN_QUALITY_GOLD:uint = 5;
      
      protected static const BTN_QUALITY_ORANGE:uint = 6;
      
      protected static const COLOR_QUALITY_BULE:uint = 6094297;
      
      protected static const COLOR_QUALITY_PURPLE:uint = 14245117;
      
      protected static const COLOR_QUALITY_GOLD:uint = 16763904;
      
      protected static const COLOR_QUALITY_ORANGE:uint = 16724736;
      
      protected static const MoraBtnType_Noraml:uint = 0;
      
      protected static const MoraBtnType_Advanced:uint = 1;
      
      protected static const MoraBtnType_OneKeyTen:uint = 2;
      
      protected static const MoraBtnType_OneKeyWin:uint = 3;
      
      protected static const MoraBtnType_OneKeyViolent:uint = 4;
      
      public static const WineType:Vector.<String> = STRING_TAVERN.WineType;
      
      public static const WineTen:String = STRING_TAVERN.WineTen;
      
      public static const WineWin:String = STRING_TAVERN.WineWin;
      
      public static const WineViolent:String = STRING_TAVERN.WineViolent;
      
      public static const SureWineWin:String = STRING_TAVERN.SureWineWin;
      
      protected var FScene:MovieClip;
      
      protected var FMoraBtn_Win:MovieClip;
      
      protected var FMoraBtn_10:MovieClip;
      
      protected var FMoraBtn_Blue:MovieClip;
      
      protected var FMoraBtn_Purple:MovieClip;
      
      protected var FMoraBtn_Gold:MovieClip;
      
      protected var FMoraBtn_Orange:MovieClip;
      
      protected var FMoraBtn_KeyViolent:MovieClip;
      
      protected var FMC_ViolentTimerList:MovieClip;
      
      protected var FViolentTimerList:TComboBox;
      
      protected var FCountIndex:uint;
      
      protected var FCurPage:uint;
      
      protected var FTotlePage:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FVipData:TVip;
      
      protected var FHeroBitmapVect:Vector.<Bitmap>;
      
      protected var FHeroBitmapIds:Vector.<uint>;
      
      protected var FExpCardBitmapVect:Vector.<Bitmap>;
      
      protected var FArticleBins:TBins;
      
      protected var FExpCardBins:TBins;
      
      protected var FTavernGradeBins:TBins;
      
      protected var FTavernWarriorBins:TBins;
      
      protected var FRoldModelBins:TBins;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FSystemLanguageBins:TBins;
      
      protected var FTavernPayConfig:TBins;
      
      protected var FExpCardVects:Vector.<TExchangeExpCard>;
      
      protected var FCurWarriorVects:Vector.<TTavernWarrior>;
      
      protected var FCurGrade:TTavernGrade;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FMoras:TMoras;
      
      protected var FMoraBtnOpenHint:THint;
      
      protected var FMoraBtnHint:TPayConfig;
      
      protected var FMoraBtnIndex:int;
      
      protected var FIsLookOnly:Boolean;
      
      protected var FNormalPayConfig:TTavernPayConfig;
      
      protected var FAdvancedPayConfig:TTavernPayConfig;
      
      protected var FPayWinCost:uint;
      
      protected var FShowIndex:uint;
      
      protected var FRandomIndex:uint;
      
      protected var FRandId:int;
      
      protected var FRandVect:Vector.<int>;
      
      protected var FShowSoulEffectIndex:uint;
      
      protected var FWarriors:TWarriors;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FWindowConfirmationSure:TUIWindowConfirmation;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FSetRecruitData:Function;
      
      protected var FSetChangeCardData:Function;
      
      protected var FEnterMora:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FEffectGenerateText:Function;
      
      protected var FEnableWindowTavern:Function;
      
      protected var FTutorialNextStep:Function;
      
      public function TProcessorWindowTavernHeroList(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:TConfigValue = null;
         super(param1);
         this.FScene = param2;
         this.FMoraBtnOpenHint = new THint();
         this.FMoraBtnHint = new TPayConfig();
         this.FMoraBtnIndex = -1;
         this.FRandVect = new Vector.<int>(HERO_Count);
         TGameUtil.setButtonMode(this.FScene.btn_left,true);
         this.FScene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeftBtn);
         TGameUtil.setButtonMode(this.FScene.btn_right,true);
         this.FScene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRightBtn);
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FExpCardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Exchange_ExpCard);
         this.FTavernGradeBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Tavern_Grade);
         this.FTavernWarriorBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Tavern_Warrior);
         this.FRoldModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FSystemLanguageBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SystemLanguage);
         this.FTavernPayConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Tavern_PayConfig);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TAVERN_Match_Cheat) as TConfigValue;
         this.FPayWinCost = _loc3_.Value.value;
         this.FCharacter = SLogicsCore.Character;
         this.FVipData = this.FCharacter.VipData;
         this.FHeroBitmapVect = new Vector.<Bitmap>();
         this.FHeroBitmapIds = new Vector.<uint>();
         this.FExpCardBitmapVect = new Vector.<Bitmap>();
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.InitHeroList();
      }
      
      protected function InitHeroList() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Bitmap = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TUISlot = null;
         var _loc5_:Vector.<DisplayObject> = null;
         var _loc6_:Array = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_HEROLIST_MAX)
         {
            _loc3_ = this.FScene["mc_general_" + _loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnHeroSelect);
            TGameUtil.setButtonMode(_loc3_.btn_bg,true);
            _loc2_ = new Bitmap();
            _loc3_.mc_HeadIcon.addChild(_loc2_);
            _loc3_.mc_HeadIcon.mouseEnabled = false;
            _loc3_.mc_militaryType.mouseEnabled = false;
            _loc3_.mc_soul.mouseEnabled = false;
            _loc3_.tf_generalName.mouseEnabled = false;
            _loc3_.tf_generalSoul.mouseEnabled = false;
            this.FHeroBitmapVect.push(_loc2_);
            _loc1_++;
         }
         this.FIDTemplates = new Vector.<uint>(CONST_CARDLIST_MAX);
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUISlots = new Vector.<TUISlot>(CONST_CARDLIST_MAX);
         _loc1_ = 0;
         while(_loc1_ < CONST_CARDLIST_MAX)
         {
            _loc3_ = this.FScene["mc_card_" + _loc1_].mc_bg.mc_slot;
            this.FScene["mc_card_" + _loc1_].addEventListener(MouseEvent.CLICK,this.OnExpCardSelect);
            TGameUtil.setButtonMode(this.FScene["mc_card_" + _loc1_].mc_bg,true);
            this.FScene["mc_card_" + _loc1_].tf_generalName.mouseEnabled = false;
            this.FScene["mc_card_" + _loc1_].tf_generalSoul.mouseEnabled = false;
            this.FScene["mc_card_" + _loc1_].mc_soul.mouseEnabled = false;
            _loc4_ = this.GetSlot();
            _loc4_.Resource = _loc3_;
            _loc4_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc4_.Init();
            _loc4_.OnOverlay = this.OnUIOverlay;
            _loc4_.OnOut = this.OnUIOut;
            this.FUISlots[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FMoraBtn_Win = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyWin) as MovieClip;
         this.FMoraBtn_Win.visible = false;
         this.FScene.addChild(this.FMoraBtn_Win);
         TGameUtil.setButtonMode(this.FMoraBtn_Win,true);
         this.FMoraBtn_Win.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_Win.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_Win.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMoraBtn_10 = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyTen) as MovieClip;
         this.FMoraBtn_10.visible = false;
         this.FScene.addChild(this.FMoraBtn_10);
         TGameUtil.setButtonMode(this.FMoraBtn_10,true);
         this.FMoraBtn_10.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_10.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_10.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMoraBtn_Blue = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyBlue) as MovieClip;
         this.FMoraBtn_Blue.visible = false;
         this.FScene.addChild(this.FMoraBtn_Blue);
         TGameUtil.setButtonMode(this.FMoraBtn_Blue,true);
         this.FMoraBtn_Blue.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_Blue.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_Blue.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMoraBtn_Purple = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyPurple) as MovieClip;
         this.FMoraBtn_Purple.visible = false;
         this.FScene.addChild(this.FMoraBtn_Purple);
         TGameUtil.setButtonMode(this.FMoraBtn_Purple,true);
         this.FMoraBtn_Purple.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_Purple.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_Purple.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMoraBtn_Gold = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyGold) as MovieClip;
         this.FMoraBtn_Gold.visible = false;
         this.FScene.addChild(this.FMoraBtn_Gold);
         TGameUtil.setButtonMode(this.FMoraBtn_Gold,true);
         this.FMoraBtn_Gold.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_Gold.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_Gold.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMoraBtn_Orange = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyOrange) as MovieClip;
         this.FMoraBtn_Orange.visible = false;
         this.FScene.addChild(this.FMoraBtn_Orange);
         TGameUtil.setButtonMode(this.FMoraBtn_Orange,true);
         this.FMoraBtn_Orange.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_Orange.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_Orange.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMoraBtn_KeyViolent = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_KeyViolent) as MovieClip;
         this.FMoraBtn_KeyViolent.visible = false;
         this.FScene.addChild(this.FMoraBtn_KeyViolent);
         this.FMoraBtn_KeyViolent.addEventListener(MouseEvent.CLICK,this.OnMoraBtnClick);
         this.FMoraBtn_KeyViolent.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMoraBtnMouseMove);
         this.FMoraBtn_KeyViolent.addEventListener(MouseEvent.MOUSE_OUT,this.OnMoraBtnMouseOut);
         this.FMC_ViolentTimerList = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCESID_CLASSNAME_ViolentTimerList) as MovieClip;
         _loc5_ = new Vector.<DisplayObject>();
         _loc6_ = STRING_TAVERN.STRINGS_TAVERNCOUNT;
         _loc8_ = _loc6_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc8_)
         {
            _loc7_ = this.MakeComboItem(_loc6_[_loc1_]);
            _loc5_.push(_loc7_);
            _loc1_++;
         }
         this.FViolentTimerList = new TComboBox(Parent,this.FMC_ViolentTimerList,_loc5_,61,this.OnCountSelect);
         this.FScene.addChild(this.FMC_ViolentTimerList);
         this.FCountIndex = 0;
         this.FMoraBtn_KeyViolent["TF_Count"].text = "*" + CONST_TAVERN.COMBOBOX_COUNTLIST[this.FCountIndex];
         this.FWarriors = new TWarriors();
         this.FWarriors.SetWarriorsBins(this.FTavernWarriorBins,this.FExpCardBins);
      }
      
      protected function MakeComboItem(param1:String) : DisplayObject
      {
         var _loc2_:MovieClip = null;
         _loc2_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TAVERN.RESOURCE_ClassName_ComboBoxItem) as MovieClip;
         _loc2_.tf_into.text = param1;
         return _loc2_;
      }
      
      protected function OnCountSelect(param1:Object, param2:int) : void
      {
         this.FCountIndex = param2;
         this.FMoraBtn_KeyViolent["TF_Count"].text = "*" + CONST_TAVERN.COMBOBOX_COUNTLIST[this.FCountIndex];
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Tavern);
         }
      }
      
      protected function GetStandPositionWithProfession(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case CONST_CHARACTER.PROFESSION_Agility:
            case CONST_CHARACTER.PROFESSION_Strength:
               _loc2_ = uint(INDEX_Station_Middle);
               break;
            case CONST_CHARACTER.PROFESSION_Defending:
               _loc2_ = uint(INDEX_Station_Front);
               break;
            case CONST_CHARACTER.PROFESSION_Intellect:
               _loc2_ = uint(INDEX_Station_After);
         }
         return _loc2_;
      }
      
      public function CheckBtn() : void
      {
         this.FScene.btn_left.visible = Boolean(this.FCurPage != 1);
         this.FScene.btn_right.visible = Boolean(this.FCurPage != this.FTotlePage);
      }
      
      protected function GetSlot() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(this);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      public function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TArticle = null;
         var _loc3_:TRoleModel = null;
         var _loc4_:TBaseHero = null;
         var _loc5_:uint = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:uint = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:uint = 0;
         if(this.FHeroBitmapIds != null)
         {
            this.FHeroBitmapIds.length = 0;
         }
         this.FCurGrade = this.FTavernGradeBins.GetDatebaseByValue("Page",this.FCurPage) as TTavernGrade;
         this.FScene["TF_LevelDec"].text = this.FCurGrade.Level;
         this.FCurWarriorVects = this.FWarriors.GetWarriorWithPage(this.FCurPage);
         _loc1_ = 0;
         while(_loc1_ < CONST_HEROLIST_MAX)
         {
            _loc6_ = this.FScene["mc_general_" + _loc1_];
            if(this.FCurWarriorVects == null)
            {
               _loc6_.visible = false;
            }
            else if(_loc1_ < this.FCurWarriorVects.length)
            {
               _loc5_ = uint(this.FCurWarriorVects[_loc1_].AwardId);
               _loc3_ = this.FRoldModelBins.GetDatebaseByIdentifier(_loc5_) as TRoleModel;
               _loc4_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc5_) as TBaseHero;
               this.FHeroBitmapIds.push(_loc3_.RoleHead);
               _loc6_.mc_recruited.visible = this.GetHeroIsRecruitedById(_loc4_.OrigionId);
               _loc7_ = this.GetStandPositionWithProfession(_loc4_.Profession);
               _loc6_.mc_militaryType.gotoAndStop(_loc7_);
               _loc6_.mc_soul.gotoAndStop(this.FCurWarriorVects[_loc1_].Awardsouls.Type);
               _loc9_ = this.GetColorWithQuality(_loc4_.Quality);
               _loc6_.tf_generalName.text = this.FCurWarriorVects[_loc1_].RecruitName;
               _loc6_.tf_generalName.textColor = _loc9_;
               _loc6_.tf_generalSoul.text = this.FCurWarriorVects[_loc1_].RecruitSoul;
               _loc6_.tf_generalSoul.textColor = _loc9_;
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc1_++;
         }
         this.FIDTemplates.length = 0;
         this.FExpCardVects = this.FWarriors.GetExpCardWithPage(this.FCurPage);
         _loc1_ = 0;
         while(_loc1_ < CONST_CARDLIST_MAX)
         {
            _loc6_ = this.FScene["mc_card_" + _loc1_];
            if(_loc1_ < this.FExpCardVects.length)
            {
               _loc2_ = this.FArticleBins.GetDatebaseByIdentifier(this.FExpCardVects[_loc1_].Item) as TArticle;
               _loc9_ = this.GetColorWithQuality(this.FExpCardVects[_loc1_].Quality);
               _loc6_.tf_generalName.text = _loc2_.Name;
               _loc6_.tf_generalName.textColor = _loc9_;
               _loc6_.tf_generalSoul.text = String(this.FExpCardVects[_loc1_].Value);
               _loc6_.tf_generalSoul.textColor = _loc9_;
               _loc6_.mc_soul.gotoAndStop(this.FExpCardVects[_loc1_].Quality);
               this.FIDTemplates.push(this.FExpCardVects[_loc1_].Item);
               _loc6_.visible = true;
            }
            else
            {
               _loc6_.visible = false;
            }
            _loc1_++;
         }
         this.FInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         _loc1_ = 0;
         while(_loc1_ < this.FInventories.Count)
         {
            this.FUISlots[_loc1_].Context = this.FInventories.GetInventoryByIndex(_loc1_);
            _loc1_++;
         }
         this.FMoraBtn_Win.visible = false;
         this.FMoraBtn_10.visible = false;
         this.FMoraBtn_Blue.visible = false;
         this.FMoraBtn_Purple.visible = false;
         this.FMoraBtn_Gold.visible = false;
         this.FMoraBtn_Orange.visible = false;
         this.FMoraBtn_KeyViolent.visible = false;
         if(this.FCurGrade.Tips != null && this.FCurGrade.Tips.length > 0 && this.FCharacter.GetMainLevel() < this.FCurGrade.Level)
         {
            this.FScene.tf_moraLog.text = this.FCurGrade.Tips;
            this.FScene.tf_moraLog.visible = true;
            this.FIsLookOnly = true;
            return;
         }
         this.FScene.tf_moraLog.visible = false;
         this.FIsLookOnly = false;
         _loc1_ = 0;
         while(_loc1_ < CONST_BTN_MAX)
         {
            _loc8_ = null;
            if(this.FCurGrade.WineLvs[_loc1_] == BTN_QUALITY_BULE)
            {
               _loc8_ = this.FMoraBtn_Blue;
            }
            else if(this.FCurGrade.WineLvs[_loc1_] == BTN_QUALITY_PURPLE)
            {
               _loc8_ = this.FMoraBtn_Purple;
            }
            else if(this.FCurGrade.WineLvs[_loc1_] == BTN_QUALITY_GOLD)
            {
               _loc8_ = this.FMoraBtn_Gold;
            }
            else if(this.FCurGrade.WineLvs[_loc1_] == BTN_QUALITY_ORANGE)
            {
               _loc8_ = this.FMoraBtn_Orange;
            }
            if(_loc8_ != null)
            {
               _loc8_.visible = true;
               _loc8_.x = INITBTN_POS_X + _loc1_ * INITBTN_STAMP_WIDTH + this.FScene.x;
               _loc8_.y = INITBTN_POS_Y;
               _loc8_.name = "mc_MornBtn_" + _loc1_;
            }
            if(_loc1_ == 1)
            {
               TGameUtil.setButtonMode(_loc8_,this.FVipData.HigherDrink);
            }
            else
            {
               TGameUtil.setButtonMode(_loc8_,true);
            }
            _loc1_++;
         }
         this.FMoraBtn_10.visible = true;
         this.FMoraBtn_10.x = INITBTN_POS_X + 2 * INITBTN_STAMP_WIDTH + this.FScene.x;
         this.FMoraBtn_10.y = INITBTN_POS_Y;
         this.FMoraBtn_10.name = "mc_MornBtn_" + 2;
         TGameUtil.setButtonMode(this.FMoraBtn_10,this.FVipData.OneWine);
         this.FMoraBtn_Win.visible = true;
         this.FMoraBtn_Win.x = INITBTN_POS_X + 3 * INITBTN_STAMP_WIDTH + this.FScene.x;
         this.FMoraBtn_Win.y = INITBTN_POS_Y;
         this.FMoraBtn_Win.name = "mc_MornBtn_" + 3;
         TGameUtil.setButtonMode(this.FMoraBtn_Win,this.FVipData.OneWinWine);
         this.FMoraBtn_KeyViolent.visible = Boolean(this.FCurGrade.IsViolent);
         this.FMoraBtn_KeyViolent.x = INITBTN_POS_X + 4 * INITBTN_STAMP_WIDTH + this.FScene.x;
         this.FMoraBtn_KeyViolent.y = INITBTN_POS_Y;
         this.FMoraBtn_KeyViolent.name = "mc_MornBtn_" + 4;
         TGameUtil.setButtonMode(this.FMoraBtn_KeyViolent,SLogicsCore.KaguyaData.CurLevel >= 3);
         this.FMC_ViolentTimerList.visible = Boolean(this.FCurGrade.IsViolent);
         this.FMC_ViolentTimerList.x = this.FMoraBtn_KeyViolent.x;
         this.FMC_ViolentTimerList.y = this.FMoraBtn_KeyViolent.y + this.FMoraBtn_KeyViolent.height;
      }
      
      protected function GetColorWithQuality(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case BTN_QUALITY_BULE:
               _loc2_ = COLOR_QUALITY_BULE;
               break;
            case BTN_QUALITY_PURPLE:
               _loc2_ = COLOR_QUALITY_PURPLE;
               break;
            case BTN_QUALITY_GOLD:
               _loc2_ = COLOR_QUALITY_GOLD;
               break;
            case BTN_QUALITY_ORANGE:
               _loc2_ = COLOR_QUALITY_ORANGE;
               break;
            default:
               _loc2_ = COLOR_QUALITY_BULE;
         }
         return _loc2_;
      }
      
      protected function GetSoulValueByType(param1:uint) : int
      {
         switch(param1)
         {
            case BTN_QUALITY_BULE:
               return this.FCharacter.HeroSoulBlueSoul;
            case BTN_QUALITY_PURPLE:
               return this.FCharacter.HeroSoulPurpleSoul;
            case BTN_QUALITY_GOLD:
               return this.FCharacter.HeroSoulGoldSoul;
            case BTN_QUALITY_ORANGE:
               return this.FCharacter.HeroSoulOrangeSoul;
            default:
               return 0;
         }
      }
      
      protected function GetIsCanRecruit(param1:TTavernWarrior) : Boolean
      {
         if(this.FIsLookOnly)
         {
            return false;
         }
         if(this.GetHeroIsRecruitedById(param1.AwardId))
         {
            return false;
         }
         if(this.GetSoulValueByType(param1.Awardsouls.Type) < param1.RecruitSoul)
         {
            return false;
         }
         return true;
      }
      
      protected function GetHeroIsRecruitedById(param1:uint) : Boolean
      {
         var _loc2_:TBaseHero = null;
         _loc2_ = this.FBaseHeroBins.GetDatebaseByIdentifier(param1) as TBaseHero;
         if(this.FCharacter.Heros.GetHeroByInitilzationIdentifier(_loc2_.OrigionId) != null)
         {
            return true;
         }
         if(SLogicsCore.NinjaHostelData.GetHerBaseById(_loc2_.OrigionId) != null)
         {
            return true;
         }
         return false;
      }
      
      protected function MakePayConfig(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TSystemLanguage = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.FNormalPayConfig = this.FTavernPayConfig.GetDatebaseByIdentifier(this.FCurGrade.PayConfigsVect.NORMAL) as TTavernPayConfig;
         this.FAdvancedPayConfig = this.FTavernPayConfig.GetDatebaseByIdentifier(this.FCurGrade.PayConfigsVect.ADVANCED) as TTavernPayConfig;
         switch(param1)
         {
            case MoraBtnType_Noraml:
               _loc2_ = uint(this.FCurGrade.WineLvs[0]);
               this.FMoraBtnHint.Title = WineType[_loc2_];
               this.FMoraBtnHint.Value = this.FNormalPayConfig.Value + STRING_COMMON.ITEMNAME_Coin;
               _loc4_ = int(CONST_SYSTEMLANGUAGE.TAVERN_STRING_01);
               _loc5_ = "";
               break;
            case MoraBtnType_Advanced:
               _loc2_ = uint(this.FCurGrade.WineLvs[1]);
               this.FMoraBtnHint.Title = WineType[_loc2_];
               this.FMoraBtnHint.Value = this.FAdvancedPayConfig.Value + STRING_COMMON.ITEMNAME_Coin;
               _loc4_ = int(CONST_SYSTEMLANGUAGE.TAVERN_STRING_02);
               _loc5_ = this.FVipData.HigherDrink ? "" : this.FVipData.VipOpenLevel_HigherDrink.toString();
               break;
            case MoraBtnType_OneKeyTen:
               this.FMoraBtnHint.Title = WineTen;
               this.FMoraBtnHint.Value = this.FAdvancedPayConfig.Value * ONEKEYTen_COUNT + STRING_COMMON.ITEMNAME_Coin;
               _loc4_ = int(CONST_SYSTEMLANGUAGE.TAVERN_STRING_03);
               _loc5_ = this.FVipData.OneWine ? "" : this.FVipData.VipOpenLevel_OneWine.toString();
               break;
            case MoraBtnType_OneKeyWin:
               this.FMoraBtnHint.Title = WineWin;
               this.FMoraBtnHint.Value = this.FAdvancedPayConfig.Value * ONEKEYTen_COUNT + STRING_COMMON.ITEMNAME_Coin + "," + this.FPayWinCost * ONEKEYWin_COUNT + STRING_COMMON.ITEMNAME_Gold;
               _loc4_ = int(CONST_SYSTEMLANGUAGE.TAVERN_STRING_04);
               _loc5_ = this.FVipData.OneWinWine ? "" : this.FVipData.VipOpenLevel_OneWinWine.toString();
               break;
            case MoraBtnType_OneKeyViolent:
               this.FMoraBtnHint.Title = WineViolent;
               this.FMoraBtnHint.Value = this.FAdvancedPayConfig.Value * CONST_TAVERN.COMBOBOX_COUNTLIST[this.FCountIndex] + STRING_COMMON.ITEMNAME_Coin;
               _loc4_ = int(CONST_SYSTEMLANGUAGE.TAVERN_STRING_06);
               _loc5_ = SLogicsCore.KaguyaData.CurLevel >= 3 ? "" : "" + 3;
         }
         _loc3_ = this.FSystemLanguageBins.GetDatebaseByIdentifier(_loc4_) as TSystemLanguage;
         if(param1 == MoraBtnType_OneKeyViolent)
         {
            this.FMoraBtnHint.OpenType = 1;
            _loc6_ = TUtilityString.Format(_loc3_.Desc,CONST_TAVERN.COMBOBOX_COUNTLIST[this.FCountIndex],WineType[Math.max(this.FCurGrade.WineLvs[0],this.FCurGrade.WineLvs[1])]);
         }
         else
         {
            this.FMoraBtnHint.OpenType = 0;
            _loc6_ = _loc3_.Desc;
         }
         this.FMoraBtnHint.ID = param1;
         this.FMoraBtnHint.Context = _loc6_;
         this.FMoraBtnHint.OpenLevel = _loc5_;
      }
      
      protected function CheckEnoughCredit(param1:uint) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         switch(param1)
         {
            case MoraBtnType_Noraml:
               _loc2_ = uint(this.FNormalPayConfig.Value);
               _loc3_ = 0;
               break;
            case MoraBtnType_Advanced:
               _loc2_ = uint(this.FAdvancedPayConfig.Value);
               _loc3_ = 0;
               break;
            case MoraBtnType_OneKeyTen:
               _loc2_ = this.FAdvancedPayConfig.Value * ONEKEYTen_COUNT;
               _loc3_ = 0;
               break;
            case MoraBtnType_OneKeyWin:
               _loc2_ = this.FAdvancedPayConfig.Value * ONEKEYTen_COUNT;
               _loc3_ = this.FPayWinCost * ONEKEYWin_COUNT;
         }
         if(this.FCharacter.CreditSilverCoin.ToNumber() < _loc2_)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
            }
            return false;
         }
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < _loc3_)
         {
            this.FUIWindowRecharge.Visible = true;
            return false;
         }
         return true;
      }
      
      protected function GetWarriorIndexByHeroId(param1:uint) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FCurWarriorVects.length)
         {
            if(this.FCurWarriorVects[_loc2_].Identifier == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      protected function StartRandomChoose() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Boolean = false;
         if(this.FScene["mc_general_" + this.FRandId] != null)
         {
            this.FScene["mc_general_" + this.FRandId].btn_bg.gotoAndStop(1);
         }
         do
         {
            this.FRandId = Math.random() * this.FCurWarriorVects.length;
            _loc2_ = false;
            _loc1_ = 0;
            while(_loc1_ < this.FRandVect.length)
            {
               if(this.FRandVect[_loc1_] == this.FRandId)
               {
                  _loc2_ = true;
               }
               _loc1_++;
            }
         }
         while(_loc2_);
         this.FRandomIndex++;
         if(this.FRandomIndex >= Random_Max)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FCurWarriorVects.length)
            {
               if(this.FCurWarriorVects[_loc1_].Identifier == this.FMoras.GetMoraByIndex(this.FShowIndex).TavernHeroId)
               {
                  this.FRandId = _loc1_;
                  break;
               }
               _loc1_++;
            }
         }
         this.FScene["mc_general_" + this.FRandId].btn_bg.gotoAndStop(2);
         if(this.FRandomIndex >= Random_Max)
         {
            this.FRandVect[this.FShowIndex] = this.FRandId;
            this.FRandomIndex = 0;
            this.FShowIndex++;
            this.FRandId = -1;
            if(this.FShowIndex >= HERO_Count)
            {
               setTimeout(this.EndShow,1000);
               return;
            }
         }
         setTimeout(this.StartRandomChoose,250);
      }
      
      protected function EndShow() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FRandVect.length)
         {
            this.FScene["mc_general_" + this.FRandVect[_loc1_]].btn_bg.gotoAndStop(1);
            this.FRandVect[_loc1_] = 0;
            _loc1_++;
         }
         if(this.FEnterMora != null)
         {
            this.FEnterMora(this.FMoras);
         }
      }
      
      protected function OnHeroSelect(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TTavernWarrior = null;
         var _loc4_:Boolean = false;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(11)));
         _loc3_ = this.FCurWarriorVects[_loc2_];
         _loc4_ = this.GetIsCanRecruit(_loc3_);
         if(_loc3_ != null && this.FSetRecruitData != null)
         {
            this.FSetRecruitData(_loc3_,_loc4_);
         }
      }
      
      protected function OnExpCardSelect(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TExchangeExpCard = null;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(8)));
         _loc3_ = this.FExpCardVects[_loc2_];
         if(this.FSetChangeCardData != null)
         {
            this.FSetChangeCardData(_loc3_,!this.FIsLookOnly);
         }
      }
      
      protected function OnLeftBtn(param1:MouseEvent) : void
      {
         this.FCurPage--;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnRightBtn(param1:MouseEvent = null) : void
      {
         this.FCurPage++;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnMoraBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:String = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FTutorialNextStep != null)
         {
            this.FTutorialNextStep(1400);
         }
         if(this.FNormalPayConfig == null || this.FAdvancedPayConfig == null)
         {
            return;
         }
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(11)));
         if(!this.CheckEnoughCredit(_loc2_))
         {
            return;
         }
         if(this.FEnableWindowTavern != null)
         {
            this.FEnableWindowTavern(false);
         }
         if(_loc2_ == MoraBtnType_OneKeyWin)
         {
            if(this.FWindowConfirmationSure == null)
            {
               this.FWindowConfirmationSure = new TUIWindowConfirmation(Parent);
               TUtilityUIWindow.SetupWindowConfirmation(this.FWindowConfirmationSure);
               this.FWindowConfirmationSure.OnOK = this.SureOneKeyWinMora;
               this.FWindowConfirmationSure.OnCancel = this.CancelOneKeyWinMora;
               this.FWindowConfirmationSure.x = (CONST_COMMON.STAGE_Width - this.FWindowConfirmationSure.Scene.width) / 2;
               this.FWindowConfirmationSure.y = (CONST_COMMON.STAGE_Height - this.FWindowConfirmationSure.Scene.height) / 2;
            }
            this.FAdvancedPayConfig = this.FTavernPayConfig.GetDatebaseByIdentifier(this.FCurGrade.PayConfigsVect.ADVANCED) as TTavernPayConfig;
            _loc5_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Tavern_OneKeyWin).DescribeString,this.FPayWinCost * ONEKEYWin_COUNT,this.FAdvancedPayConfig.Value * ONEKEYTen_COUNT);
            this.FWindowConfirmationSure.Text = _loc5_;
            this.FWindowConfirmationSure.Visible = true;
            return;
         }
         if(_loc2_ != MoraBtnType_OneKeyViolent)
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernMoraReq);
            _loc4_ = _loc3_.Data;
            _loc4_.writeByte(_loc2_);
            _loc4_.writeInt(this.FCurGrade.Identifier);
         }
         else
         {
            _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernOneKeyViolentReq);
            _loc4_ = _loc3_.Data;
            _loc4_.writeInt(this.FCurGrade.Identifier);
            _loc4_.writeInt(CONST_TAVERN.COMBOBOX_COUNTLIST[this.FCountIndex]);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function SureOneKeyWinMora(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernMoraReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(MoraBtnType_OneKeyWin);
         _loc3_.writeInt(this.FCurGrade.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function CancelOneKeyWinMora(param1:Object) : void
      {
         if(this.FEnableWindowTavern != null)
         {
            this.FEnableWindowTavern(true);
         }
      }
      
      protected function OnMoraBtnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(11)));
         if(_loc2_ != this.FMoraBtnIndex)
         {
            this.MakePayConfig(_loc2_);
            this.FMoraBtnIndex = _loc2_;
         }
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FMoraBtnHint);
         }
      }
      
      protected function OnMoraBtnMouseOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FMoraBtnIndex = -1;
            this.FHintOnOut(param1);
         }
      }
      
      protected function OnUIOverlay(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function OnUIOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.visible = param1;
      }
      
      override public function get Visible() : Boolean
      {
         if(this.FScene == null)
         {
            return false;
         }
         return this.FScene.visible;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set SetRecruitData(param1:Function) : void
      {
         this.FSetRecruitData = param1;
      }
      
      public function get SetRecruitData() : Function
      {
         return this.FSetRecruitData;
      }
      
      public function set SetChangeCardData(param1:Function) : void
      {
         this.FSetChangeCardData = param1;
      }
      
      public function get SetChangeCardData() : Function
      {
         return this.FSetChangeCardData;
      }
      
      public function set EnterMora(param1:Function) : void
      {
         this.FEnterMora = param1;
      }
      
      public function get EnterMora() : Function
      {
         return this.FEnterMora;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set EffectGenerateText(param1:Function) : void
      {
         this.FEffectGenerateText = param1;
      }
      
      public function get EffectGenerateText() : Function
      {
         return this.FEffectGenerateText;
      }
      
      public function set EnableWindowTavern(param1:Function) : void
      {
         this.FEnableWindowTavern = param1;
      }
      
      public function get EnableWindowTavern() : Function
      {
         return this.FEnableWindowTavern;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
      }
      
      public function CheckTavernHeroList() : void
      {
         var _loc1_:* = 0;
         var _loc2_:TTavernGrade = null;
         _loc1_ = int(this.FTavernGradeBins.Count - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = this.FTavernGradeBins.GetDatebaseByIndex(_loc1_) as TTavernGrade;
            if(Boolean(_loc2_) && Boolean(_loc2_.IsTavern) && SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.GetMainLevel()) >= _loc2_.Level)
            {
               this.FTotlePage = _loc2_.Page;
               this.FCurGrade = _loc2_;
               break;
            }
            _loc1_--;
         }
         if(this.FTotlePage == 2)
         {
            this.FTotlePage = 3;
            this.FCurPage = 2;
         }
         else
         {
            this.FCurPage = this.FTotlePage;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      public function set SetFCurPage(param1:int) : void
      {
         this.FCurPage = param1;
      }
      
      public function ResetTavern() : void
      {
         this.UpdataUI();
      }
      
      public function ShowChooseMoraHero(param1:TMoras) : void
      {
         this.FMoras = param1;
         this.FRandId = -1;
         this.FShowIndex = 0;
         this.FRandomIndex = 0;
         this.FRandVect.length = 0;
         this.StartRandomChoose();
      }
      
      public function UpdataTavernHeroHeadBitmap() : void
      {
         var _loc1_:uint = 0;
         if(this.FCurWarriorVects != null)
         {
            _loc1_ = 0;
            while(_loc1_ < CONST_HEROLIST_MAX)
            {
               if(_loc1_ < this.FHeroBitmapIds.length)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroBitmapVect[_loc1_],CONST_MODULES.MODULE_Tavern,this.FHeroBitmapIds[_loc1_]);
               }
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this.FUISlots.length)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function GetCoordinateByHeroId(param1:uint) : TCoordinate
      {
         var _loc2_:uint = 0;
         var _loc3_:TCoordinate = null;
         var _loc4_:MovieClip = null;
         _loc2_ = uint(this.GetWarriorIndexByHeroId(param1));
         _loc4_ = this.FScene["mc_general_" + _loc2_];
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc4_);
         _loc3_.X = _loc3_.X + TAMP_HEROLIST_WIDTH;
         _loc3_.Y = _loc3_.Y + TAMP_HEROLIST_HEIGHT;
         return _loc3_;
      }
      
      public function ShowOneKeyHeroById(param1:uint) : void
      {
         var Mc:MovieClip = null;
         var ResetMc:Function = null;
         var HeroId:uint = param1;
         ResetMc = function():void
         {
            Mc.btn_bg.gotoAndStop(1);
         };
         this.FShowSoulEffectIndex = this.GetWarriorIndexByHeroId(HeroId);
         Mc = this.FScene["mc_general_" + this.FShowSoulEffectIndex];
         Mc.btn_bg.gotoAndStop(2);
         setTimeout(ResetMc,300);
      }
      
      public function EnableBtn(param1:Boolean) : void
      {
         this.FScene.mouseEnabled = param1;
         this.FScene.mouseChildren = param1;
      }
   }
}

