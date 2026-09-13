package Processors.Game.Lobby.SuperHero
{
   import Components.Pages.*;
   import Components.Slots.*;
   import Externals.SExternalCore;
   import Foundation.Common.*;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
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
   import Logics.Items.*;
   import Logics.NinjaHostel.THeroBaseData;
   import Logics.Skills.*;
   import Logics.Streamization.Characters.*;
   import Logics.Streamization.SuperHero.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.TProcessorLobby;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.*;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.*;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowSuperHero extends TProcessorLobbyWindow
   {
      
      protected static const AttributesIndex:Vector.<uint> = Vector.<uint>([CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Power,CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Intelligence,CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Agile,CONST_COMMON.FIRSTATTRIBUTERATEINDEX_Health]);
      
      protected static const AttributeStateReady:int = 0;
      
      protected static const AttributeStateUnenlist:int = 1;
      
      protected static const AttributeStateEnlist:int = 2;
      
      protected static const AttributeStateAdvancedLookUnadvanced:int = 3;
      
      protected static const AttributeStateAdvancedLookAdvanced:int = 4;
      
      protected static const AttributeStateEnlisting:int = 5;
      
      protected static const MouduleState_Ready:int = 0;
      
      protected static const MouduleState_Runing:int = 1;
      
      protected static const MouduleState_WaitEnlist:int = 2;
      
      protected static const SpeicialHeroID:uint = 11200003;
      
      protected static const SpeicialHeroID_1:uint = 11200004;
      
      protected static const UniversalMaterialID:int = 14107058;
      
      protected static const UI_InitStamp_Y:Number = 61;
      
      protected var FCurrentState:int;
      
      protected var FUniversalMaterialName:String;
      
      protected var FIsVipEnough:Boolean;
      
      protected var FCurHeroId:uint;
      
      protected var FUIHeroSelect:MovieClip;
      
      protected var FUIHeroSelect_Bg:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FUI_Page_TF:TextField;
      
      protected var FMC_HeroBoxs:Vector.<TUISlot>;
      
      protected var FUI_HeroBoxs:Vector.<MovieClip>;
      
      protected var FMC_SelectFlags:Vector.<MovieClip>;
      
      protected var FMC_Locks:Vector.<MovieClip>;
      
      protected var FMC_EnlistFlag:Vector.<MovieClip>;
      
      protected var FTF_HerosName:Vector.<TextField>;
      
      protected var FCurrentSelectFlag:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurrentPageIndex:int;
      
      protected var FSuperHeros:THeros;
      
      protected var FHerosState:Vector.<int>;
      
      protected var FSelectedHero:TSuperHero;
      
      protected var FSelectHeroState:int;
      
      protected var FCurrentShowHeroPicID:int;
      
      protected var FMC_RoleMoudle:MovieClip;
      
      protected var FMC_Whirl:MovieClip;
      
      protected var FMC_AdvancedFlag:MovieClip;
      
      protected var FTF_HeroName:TextField;
      
      protected var FMC_QualityFlag:MovieClip;
      
      protected var FMC_Position:MovieClip;
      
      protected var FMC_LargePicMountPoint:MovieClip;
      
      protected var FRolePicBitMap:Bitmap;
      
      protected var FMC_RoleTalk:MovieClip;
      
      protected var FTF_RoleTalk:TextField;
      
      protected var FIfShowTalk:Boolean;
      
      protected var FAttributeShowState:int;
      
      protected var FIfSwitchPage:Boolean;
      
      protected var FCurrentShowHero:TSuperHero;
      
      protected var FUIAttribute:MovieClip;
      
      protected var FSwitchPageMoive:MovieClip;
      
      protected var FPromotWindow:TUIWindowConfirmation;
      
      protected var FOder:TOder;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      protected var FBtn_Back:MovieClip;
      
      protected var FBtn_AutoPoint:MovieClip;
      
      protected var FTable1UI:MovieClip;
      
      protected var FTable1Animation:MovieClip;
      
      protected var FTable1HeroDescribtion:TextField;
      
      protected var FTable1SkillDescribtion:TextField;
      
      protected var FTable1AttributesValue:Vector.<TextField>;
      
      protected var FTable1AttributesName:Vector.<TextField>;
      
      protected var FTable1GiftName:TextField;
      
      protected var FTable1SkillName:TextField;
      
      protected var FTable1HeroPosition:MovieClip;
      
      protected var FTable1AnimationTwo:MovieClip;
      
      protected var FTable1HeroDescribtionTwo:TextField;
      
      protected var FTable1SkillDescribtionTwo:TextField;
      
      protected var FTable1AttributesValueTwo:Vector.<TextField>;
      
      protected var FTable1AttributesNameTwo:Vector.<TextField>;
      
      protected var FTable1GiftNameTwo:TextField;
      
      protected var FTable1SkillNameTwo:TextField;
      
      protected var FTable1HeroPositionTwo:MovieClip;
      
      protected var FMC_SkillShow:MovieClip;
      
      protected var FMC_SkillShowCopy:MovieClip;
      
      protected var FTable2UI:MovieClip;
      
      protected var FTable2Animation:MovieClip;
      
      protected var FTable2HeroNameBeforAdvanced:TextField;
      
      protected var FTable2AttributesValueBeforAdvanced:Vector.<TextField>;
      
      protected var FTable2AttributesNameBeforAdvanced:Vector.<TextField>;
      
      protected var FTable2PositionBeforAdvanced:TextField;
      
      protected var FTable2SGiftBeforAdvanced:TextField;
      
      protected var FTable2SkillBeforAdvanced:TextField;
      
      protected var FTable2SkillDescribtionBeforAdvanced:TextField;
      
      protected var FTable2HeroNameAfterAdvanced:TextField;
      
      protected var FTable2AttributesValueAfterAdvanced:Vector.<TextField>;
      
      protected var FTable2AttributesNameAfterAdvanced:Vector.<TextField>;
      
      protected var FTable2PositionAfterAdvanced:TextField;
      
      protected var FTable2SGiftAfterAdvanced:TextField;
      
      protected var FTable2SkillAfterAdvanced:TextField;
      
      protected var FTable2SkillDescribtionAfterAdvanced:TextField;
      
      protected var FTable2SlotItem:TUISlot;
      
      protected var FBtn_Polishing:MovieClip;
      
      protected var FBtn_Traven:MovieClip;
      
      protected var FBtn_Upgrade:MovieClip;
      
      protected var FUISoul:MovieClip;
      
      protected var FTF_ItemNeed:TextField;
      
      protected var FTF_ItemNeedVip:TextField;
      
      protected var FTF_SoulNeed:TextField;
      
      protected var FTF_SoulNeedVip:TextField;
      
      protected var FTF_LevelNeed:TextField;
      
      protected var FTF_VipNeed:TextField;
      
      protected var FBtn_GoBack:MovieClip;
      
      protected var FTF_ItemName:TextField;
      
      protected var FTF_OpenWindow:TextField;
      
      protected var FTF_Status:TextField;
      
      protected var FTF_ItemLevel:TextField;
      
      protected var FTF_SoulLevel:TextField;
      
      protected var FMC_Itembg_0:MovieClip;
      
      protected var FMC_Itembg_1:MovieClip;
      
      protected var FMC_Soulbg_0:MovieClip;
      
      protected var FMC_Soulbg_1:MovieClip;
      
      protected var FTF_ItemVipLevel:TextField;
      
      protected var FTF_SoulVipLevel:TextField;
      
      protected var FMC_Bar_item:MovieClip;
      
      protected var FMC_Bar_itemVip:MovieClip;
      
      protected var FMC_Bar_Soul:MovieClip;
      
      protected var FMC_Bar_SoulVip:MovieClip;
      
      protected var FAnimationBottom:MovieClip;
      
      protected var FBtn1UI:MovieClip;
      
      protected var FMcSpeicialHero:MovieClip;
      
      protected var FBtnSpeicialHero:SimpleButton;
      
      protected var FMc_TfInfo:MovieClip;
      
      protected var FBtn1ItemNeedSlot:TUISlot;
      
      protected var FBtn1ItemNeedTF:TextField;
      
      protected var FBtn1ItemNeedBtn:MovieClip;
      
      protected var FBtn1LookNextHero:MovieClip;
      
      protected var FBtn1Enlist:MovieClip;
      
      protected var FBtn1TF_ItemName:TextField;
      
      protected var FBtn1TF_OpenWindow:TextField;
      
      protected var FMC_LoginInGet:MovieClip;
      
      protected var FBtn2UI:MovieClip;
      
      protected var FBtn2HeroUpgrade:MovieClip;
      
      protected var FBtn2ChangeShape:MovieClip;
      
      protected var FBtn3UI:MovieClip;
      
      protected var FBtn3HeroUpgradeBefore:MovieClip;
      
      protected var FBtn3ChangeShape:MovieClip;
      
      protected var FTF_SiliverCoin:TextField;
      
      protected var FTF_GoldCoin:TextField;
      
      protected var FTF_GiftCertificate:TextField;
      
      protected var FTF_HeroSoulBlueSoul:TextField;
      
      protected var FTF_HeroSoulPurpleSoul:TextField;
      
      protected var FTF_HeroSoulGoldSoul:TextField;
      
      protected var FTF_HeroSoulOrangeSoul:TextField;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FBtn_Add:SimpleButton;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FHint:THint;
      
      protected var FHelpHint:THint;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FIsResourcesLoaded:Boolean;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FUnstreamizerSuperHero:TUnstreamizerSuperHero;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FNewMallBins:TBins;
      
      protected var FResultCode:int;
      
      protected var FOnEnlist:Function;
      
      protected var FOnBuyGoods:Function;
      
      protected var FOnEnlistSuccess:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnEffectGenerateText:Function;
      
      private var _Parameter:int = 0;
      
      public function TProcessorWindowSuperHero(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
      }
      
      public static function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TSuperHero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TSuperHero;
         _loc6_ = SResourcesCore.TexturesHeadIcon;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.SmallID);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.SmallID,CONST_MODULES.MODULE_SuperHero);
         }
      }
      
      public function set FParameter(param1:int) : void
      {
         this._Parameter = param1 - 1;
         if(this.FHerosState != null)
         {
            this.FUIPage.PageIndex = this._Parameter;
            this.PageOnChange(null,this._Parameter);
         }
      }
      
      public function get FParameter() : int
      {
         return this._Parameter;
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.HeroSelect_UIDispatch);
         this.FUIDispatchRoutines.push(this.HeroModule_UIDispatch);
         this.FUIDispatchRoutines.push(this.HeroAttribute_UIDispatch);
         this.FUIDispatchRoutines.push(this.HeroItem_UIDispatch);
         this.FUIDispatchRoutines.push(this.Btn_UIDispatch);
      }
      
      protected function ConstructLocationRoutines() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.HeroSelect_Location);
         this.FUILocationRoutines.push(this.HeroModule_Location);
         this.FUILocationRoutines.push(this.HeroAttribute_Location);
         this.FUILocationRoutines.push(this.HeroItem_Location);
         this.FUILocationRoutines.push(this.Btn_Location);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FIsResourcesLoaded)
         {
            this.RefreshHeroPic();
            this.RefreshHeroBigPic();
            this.FBtn1ItemNeedSlot.Update();
            this.FTable2SlotItem.Update();
            this.PlaySwitchPage();
            this.ShowHeroTalk();
            this.LogicsPerform_UpdataAutoPoint();
         }
      }
      
      public function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TArticle = null;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance("UISuperHeroJust") as MovieClip;
         addChild(_loc3_);
         _loc1_ = 0;
         while(_loc1_ < this.FUIDispatchRoutines.length)
         {
            _loc2_ = this.FUIDispatchRoutines[_loc1_];
            _loc2_(_loc3_);
            _loc1_++;
         }
         this.FPromotWindow = new TUIWindowConfirmation(this.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FPromotWindow);
         this.FOder = new TOder();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,UniversalMaterialID) as TArticle;
         this.FUniversalMaterialName = _loc4_.Name;
         this.FBtn_Back = _loc3_["btn_back"];
         this.FBtn_AutoPoint = _loc3_["mc_autoPoint"];
      }
      
      public function UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         _loc1_ = 0;
         while(_loc1_ < this.FUILocationRoutines.length)
         {
            _loc2_ = this.FUILocationRoutines[_loc1_];
            _loc2_();
            _loc1_++;
         }
         this.FPromotWindow.x = (CONST_COMMON.STAGE_Width - this.FPromotWindow.WindowWidth) / 2;
         this.FPromotWindow.y = (CONST_COMMON.STAGE_Height - this.FPromotWindow.WindowHeight) / 2;
         this.FOverlayerHint = new TOverlayerHint(this);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FHint = new THint();
         this.Reset();
         this.FIsResourcesLoaded = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Back,this.OnBtnClose);
         this.FPopWindow = new TUIWindowConfirmation(this.Parent.Parent);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         this.FNewMallBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewMall);
      }
      
      protected function Reset() : void
      {
         this.HeroSelect_Reset();
         this.HeroModule_Reset();
         this.HeroAttribute_Reset();
         this.HeroItem_Reset();
      }
      
      protected function HeroSelect_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUISlot = null;
         this.FUIHeroSelect = param1["MC_HeroSelect"];
         this.FUIHeroSelect_Bg = param1["MC_HeroSelect_Bg"];
         this.FMC_HeroBoxs = new Vector.<TUISlot>();
         this.FMC_SelectFlags = new Vector.<MovieClip>();
         this.FMC_Locks = new Vector.<MovieClip>();
         this.FMC_EnlistFlag = new Vector.<MovieClip>();
         this.FTF_HerosName = new Vector.<TextField>();
         this.FUI_HeroBoxs = new Vector.<MovieClip>();
         _loc3_ = CONST_SUPERHERO.HEROBOX_NUM;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FUIHeroSelect["HeroBox" + (_loc2_ + 1)];
            this.FUI_HeroBoxs.push(_loc4_);
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = _loc4_;
            this.FMC_HeroBoxs.push(_loc5_);
            this.FMC_SelectFlags.push(_loc4_["MC_SelectFlag"]);
            this.FMC_Locks.push(_loc4_["MC_Lock"]);
            this.FMC_EnlistFlag.push(_loc4_["MC_EnlistFlag"]);
            this.FTF_HerosName.push(_loc4_["HeroName"]);
            this.addChild(_loc5_);
            _loc2_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUI_Left_Btn = param1["btn_left"];
         this.FUI_Right_Btn = param1["btn_right"];
         this.FUI_Page_TF = param1["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = param1["btn_left"];
         this.FUIPage.ButtonNext.Substrate = param1["btn_right"];
         this.FUIPage.LabelPage = param1["TF_Page"];
         this.FSuperHeros = new THeros();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FUnstreamizerSuperHero = new TUnstreamizerSuperHero();
         this.InitHeroInfor();
      }
      
      protected function HeroSelect_Location() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(this.FMC_HeroBoxs.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_HeroBoxs[_loc1_];
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = SlotsOnQuerySequenceContext;
            _loc3_.OnClick = this.HeroClicked;
            _loc3_.Init();
            _loc1_++;
         }
         this.FUIPage.PageSize = CONST_SUPERHERO.HEROBOX_NUM;
         this.FUIPage.OnChangePage = this.PageOnChange;
         this.FCurrentPageIndex = 0;
      }
      
      protected function HeroSelect_Reset() : void
      {
         this.SetupUIPage(this.FHerosState.length,0);
         this.HeroSelect_Update();
         this.FMC_Whirl.stop();
         this.FCurrentSelectFlag = this.FMC_SelectFlags[0];
         this.FCurrentSelectFlag.visible = true;
         this.HeroClickedManual();
      }
      
      protected function HeroSelect_Update() : void
      {
         this.InitHeroState();
         this.ShowOnePageHero();
      }
      
      protected function ShowOnePageHero() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TSuperHero = null;
         var _loc5_:int = 0;
         _loc2_ = CONST_SUPERHERO.HEROBOX_NUM;
         _loc5_ = this.FCurrentPageIndex * _loc2_;
         _loc3_ = int(this.FHerosState.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc5_ + _loc1_ < _loc3_)
            {
               this.FUI_HeroBoxs[_loc1_].visible = true;
               this.ShowOneHeroByIndex(_loc1_,_loc5_ + _loc1_);
            }
            else
            {
               this.FUI_HeroBoxs[_loc1_].visible = false;
            }
            _loc1_++;
         }
         this.HideAllSelectFlag();
         this.FUIHeroSelect.gotoAndPlay(1);
      }
      
      protected function ShowOneHeroByIndex(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TSuperHero = null;
         var _loc5_:TextField = null;
         _loc3_ = this.FHerosState[param2];
         this.FMC_Locks[param1].visible = false;
         this.FMC_HeroBoxs[param1].Context = null;
         switch(_loc3_)
         {
            case CONST_SUPERHERO.HEROSTATE_LOWLEVEL:
               _loc4_ = this.FSuperHeros.GetHeroByIndex(param2) as TSuperHero;
               this.FMC_HeroBoxs[param1].Context = _loc4_;
               this.FMC_Locks[param1].visible = true;
               _loc5_ = this.FMC_Locks[param1]["TF_Unlock"];
               if(_loc4_.Identifier == SpeicialHeroID)
               {
                  _loc5_.text = STRING_SUPERHERO.STRING_RechargeReward;
               }
               else if(_loc4_.Identifier == SpeicialHeroID_1)
               {
                  _loc5_.text = STRING_SUPERHERO.STRING_LoginReward;
               }
               else if(_loc4_.EnlistLevelLimit < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
               {
                  _loc5_.text = TUtilityString.Format(STRING_SUPERHERO.STRING_LevelRecruit,_loc4_.EnlistLevelLimit);
               }
               else
               {
                  _loc5_.text = TUtilityString.Format(STRING_SUPERHERO.STRING_LevelRecruitCopy,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc4_.EnlistLevelLimit));
               }
               _loc5_ = this.FTF_HerosName[param1];
               _loc5_.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               _loc5_.text = _loc4_.Name;
               this.FMC_EnlistFlag[param1].visible = false;
               this.FMC_HeroBoxs[param1].SetDefaultFilters(true);
               break;
            case CONST_SUPERHERO.HEROSTATE_UNENLIST:
               _loc4_ = this.FSuperHeros.GetHeroByIndex(param2) as TSuperHero;
               this.FMC_HeroBoxs[param1].Context = _loc4_;
               this.FMC_EnlistFlag[param1].visible = false;
               _loc5_ = this.FTF_HerosName[param1];
               _loc5_.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               _loc5_.text = _loc4_.Name;
               this.FMC_HeroBoxs[param1].SetDefaultFilters(false);
               break;
            case CONST_SUPERHERO.HEROSTATE_ENLIST:
               _loc4_ = this.FSuperHeros.GetHeroByIndex(param2) as TSuperHero;
               this.FMC_HeroBoxs[param1].Context = _loc4_;
               this.FMC_EnlistFlag[param1].gotoAndStop("AlreadyEnlist");
               this.FMC_EnlistFlag[param1].visible = true;
               _loc5_ = this.FTF_HerosName[param1];
               _loc5_.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               _loc5_.text = _loc4_.Name;
               this.FMC_HeroBoxs[param1].SetDefaultFilters(false);
               break;
            case CONST_SUPERHERO.HEROSTATE_ADVANCED:
               _loc4_ = this.FSuperHeros.GetHeroByIndex(param2 + this.FHerosState.length) as TSuperHero;
               this.FMC_HeroBoxs[param1].Context = _loc4_;
               this.FMC_EnlistFlag[param1].gotoAndStop("AlreadyAdvanced");
               this.FMC_EnlistFlag[param1].visible = true;
               _loc5_ = this.FTF_HerosName[param1];
               _loc5_.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               _loc5_.text = _loc4_.Name;
               this.FMC_HeroBoxs[param1].SetDefaultFilters(false);
         }
      }
      
      protected function RefreshHeroPic() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(this.FMC_HeroBoxs.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_HeroBoxs[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function HideAllSelectFlag() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FMC_SelectFlags.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_SelectFlags[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      protected function SetupUIPage(param1:int, param2:int) : void
      {
         this.FUIPage.TotalQuantity = param1;
         this.FUIPage.Update();
         this.FUIPage.PageIndex = param2;
         this.FCurrentPageIndex = param2;
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FCurrentPageIndex = param2;
         this.FCurrentSelectFlag = null;
         this.ShowOnePageHero();
      }
      
      protected function InitHeroInfor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBins = null;
         var _loc4_:TSuperHero = null;
         var _loc5_:TChangeHero = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:TBaseHero = null;
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ChangeHero);
         _loc2_ = _loc3_.Count;
         this.FHerosState = new Vector.<int>(_loc2_ >> 1);
         _loc6_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc3_.GetDatebaseByIndex(_loc1_) as TChangeHero;
            _loc6_.push(_loc5_.Identifier);
            _loc1_++;
         }
         this.FUnstreamizerCharacter.UnstreamizeGenerateSuperHerosByIdentifiers(null,this.FSuperHeros,_loc6_);
         _loc1_ = 0;
         while(_loc1_ < this.FSuperHeros.Count)
         {
            _loc4_ = this.FSuperHeros.GetHeroByIndex(_loc1_) as TSuperHero;
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,_loc4_.Identifier) as TBaseHero;
            _loc4_.BaseAttributePower = _loc7_.Power;
            _loc4_.BaseAttributeAgile = _loc7_.Agile;
            _loc4_.BaseAttributeIntelligence = _loc7_.Intelligence;
            _loc4_.BaseAttributeLife = _loc7_.Life;
            _loc4_.FirstAttributePowerRate = _loc7_.PowerGrow;
            _loc4_.FirstAttributeAgileRate = _loc7_.AgileGrow;
            _loc4_.FirstAttributeIntelligenceRate = _loc7_.IntelligenceGrow;
            _loc4_.FirstAttributeHealthRate = _loc7_.LifeGrow;
            this.FUnstreamizerCharacter.UnstreamizationPerform_SuperHeroByDatabase(_loc4_);
            this.FUnstreamizerSuperHero.Unstreamize(null,_loc4_.EnlistInventory,_loc4_.EnlistCondition);
            _loc1_++;
         }
      }
      
      protected function InitHeroState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSuperHero = null;
         var _loc4_:THeros = null;
         var _loc5_:THero = null;
         var _loc6_:Object = null;
         _loc4_ = SLogicsCore.Character.Heros;
         _loc2_ = int(this.FHerosState.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSuperHeros.GetHeroByIndex(_loc1_) as TSuperHero;
            _loc6_ = this.GetHeroIsRecruitedById(_loc3_.Identifier);
            if(_loc6_ != null)
            {
               if(_loc6_.ReincarnationOneOrTwo >= 1)
               {
                  this.FHerosState[_loc1_] = CONST_SUPERHERO.HEROSTATE_ADVANCED;
               }
               else if(_loc6_.Identifier == _loc3_.RelationHeroID)
               {
                  this.FHerosState[_loc1_] = CONST_SUPERHERO.HEROSTATE_ADVANCED;
               }
               else
               {
                  this.FHerosState[_loc1_] = CONST_SUPERHERO.HEROSTATE_ENLIST;
               }
            }
            else
            {
               _loc3_ = this.FSuperHeros.GetHeroByIdentifier(_loc3_.RelationHeroID) as TSuperHero;
               this.FHerosState[_loc1_] = CONST_SUPERHERO.HEROSTATE_UNENLIST;
               _loc3_ = this.FSuperHeros.GetHeroByIndex(_loc1_) as TSuperHero;
               if(_loc3_.EnlistLevelLimit > SLogicsCore.Character.GetMainLevelCopy())
               {
                  this.FHerosState[_loc1_] = CONST_SUPERHERO.HEROSTATE_LOWLEVEL;
               }
            }
            _loc1_++;
         }
      }
      
      protected function GetHeroIsRecruitedById(param1:uint) : Object
      {
         var _loc2_:TBaseHero = null;
         var _loc3_:THero = null;
         var _loc4_:THeroBaseData = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1) as TBaseHero;
         _loc3_ = SLogicsCore.Character.Heros.GetHeroByInitilzationIdentifier(_loc2_.OrigionId);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc4_ = SLogicsCore.NinjaHostelData.GetHerBaseById(_loc2_.OrigionId);
         if(_loc4_ != null)
         {
            return _loc4_;
         }
         return null;
      }
      
      protected function HeroClicked(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TSuperHero = null;
         var _loc6_:int = 0;
         _loc3_ = this.FMC_HeroBoxs.indexOf(param1 as TUISlot);
         if(this.FCurrentSelectFlag != null)
         {
            if(this.FCurrentSelectFlag == this.FMC_SelectFlags[_loc3_])
            {
               return;
            }
            this.FCurrentSelectFlag.visible = false;
         }
         this.FCurrentSelectFlag = this.FMC_SelectFlags[_loc3_];
         this.FCurrentSelectFlag.visible = true;
         this.FSelectedHero = param2 as TSuperHero;
         this.FSelectHeroState = this.GetHeroState(this.FSelectedHero);
         this.FMC_Whirl.play();
         this.HeroAttribute_Update();
      }
      
      protected function GetHeroState(param1:THero) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TSuperHero = null;
         var _loc5_:int = 0;
         _loc3_ = this.FSuperHeros.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FSuperHeros.GetHeroByIndex(_loc2_) as TSuperHero;
            if(param1 == _loc4_)
            {
               _loc5_ = _loc2_ % this.FHerosState.length;
               break;
            }
            _loc2_++;
         }
         return this.FHerosState[_loc5_];
      }
      
      protected function HeroClickedManual() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:Object = null;
         _loc1_ = this.FMC_SelectFlags.indexOf(this.FCurrentSelectFlag);
         _loc2_ = this.FMC_HeroBoxs[_loc1_];
         _loc3_ = _loc2_.Context;
         this.FCurrentSelectFlag = null;
         this.HeroClicked(_loc2_,_loc3_);
      }
      
      protected function HeroModule_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         this.FMC_RoleMoudle = param1["MC_RoleMoudle"];
         _loc2_ = this.FMC_RoleMoudle["MC_RoleMoudleInner"];
         this.FMC_Whirl = _loc2_["Round"];
         this.FMC_AdvancedFlag = _loc2_["MC_AdvancedFlag"];
         this.FTF_HeroName = _loc2_["MC_TFName"]["TF_Name"];
         this.FMC_QualityFlag = _loc2_["MC_QuilityFlag"];
         this.FMC_LargePicMountPoint = _loc2_["LargePic_MountPoint"];
         this.FMC_Position = _loc2_["MC_Position"];
         this.FRolePicBitMap = new Bitmap();
         this.FMC_LargePicMountPoint.addChild(this.FRolePicBitMap);
         this.FMC_RoleTalk = param1["MC_TalkLayer"];
         this.FTF_RoleTalk = this.FMC_RoleTalk["MC_Talk"]["TF_Talk"];
      }
      
      protected function HeroModule_Location() : void
      {
         this.FMC_RoleTalk.mouseEnabled = false;
         this.FMC_RoleTalk.mouseChildren = false;
         this.FMC_LargePicMountPoint.addEventListener(MouseEvent.MOUSE_OVER,this.HeroModuleMouseOver);
         this.FMC_LargePicMountPoint.addEventListener(MouseEvent.MOUSE_OUT,this.HeroModuleMouseOut);
      }
      
      protected function HeroModule_Reset() : void
      {
         this.FTF_HeroName.text = "";
         this.FMC_AdvancedFlag.visible = false;
         this.FMC_QualityFlag.visible = false;
         this.FRolePicBitMap.bitmapData = null;
         this.FMC_RoleTalk.gotoAndStop(1);
      }
      
      protected function HeroModule_Update(param1:TSuperHero) : void
      {
         var _loc2_:uint = 0;
         this.FMC_AdvancedFlag.visible = this.FSelectHeroState == CONST_SUPERHERO.HEROTYPE_AFTERADVANCE;
         this.FTF_HeroName.text = param1.Name;
         this.FTF_HeroName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
         this.FMC_QualityFlag.gotoAndStop(param1.Assess);
         this.FMC_QualityFlag.visible = true;
         _loc2_ = uint(this.GetPostion(param1.Profession));
         this.FMC_Position.gotoAndStop(_loc2_);
         this.FCurrentShowHeroPicID = param1.LargeID;
      }
      
      protected function RefreshHeroBigPic() : void
      {
         var _loc1_:TResourceRepositoryTexture = null;
         var _loc2_:TTexture = null;
         var _loc3_:TAnimationSequence = null;
         var _loc4_:THero = null;
         if(this.FCurrentShowHero == null)
         {
            return;
         }
         _loc4_ = this.FSelectedHero;
         if(this.FAttributeShowState == AttributeStateAdvancedLookUnadvanced)
         {
            _loc4_ = this.FSuperHeros.GetHeroByIdentifier(this.FSelectedHero.RelationHeroID);
         }
         _loc1_ = SResourcesCore.TexturesLargeIcon;
         _loc2_ = _loc1_.GetTextureByIdentifier(this.FCurrentShowHero.LargeID);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.GetAnimationSequenceByIndex(0);
            this.FRolePicBitMap.bitmapData = _loc3_.GetAnimationFrameByIndex(0).Surface;
         }
         else
         {
            _loc1_.LoadSecondary(this.FCurrentShowHero.LargeID,CONST_MODULES.MODULE_SuperHero);
         }
      }
      
      protected function HeroModuleMouseOver(param1:MouseEvent) : void
      {
         if(this.FCurrentShowHero == null || this.FIfShowTalk)
         {
            return;
         }
         this.FIfShowTalk = true;
         this.FMC_RoleTalk.gotoAndPlay(1);
      }
      
      protected function HeroModuleMouseOut(param1:MouseEvent) : void
      {
         if(this.FCurrentShowHero == null || !this.FIfShowTalk)
         {
            return;
         }
         this.FIfShowTalk = false;
         this.FMC_RoleTalk.gotoAndPlay(10);
      }
      
      protected function ShowHeroTalk() : void
      {
         if(this.FCurrentShowHero == null)
         {
            return;
         }
         if(this.FIfShowTalk)
         {
            if(this.FMC_RoleTalk.currentFrame == 10)
            {
               this.FMC_RoleTalk.stop();
               this.FTF_RoleTalk.text = this.FCurrentShowHero.HeroSpecialTalk;
            }
         }
         else if(this.FMC_RoleTalk.currentFrame == 1)
         {
            this.FMC_RoleTalk.stop();
            this.FTF_RoleTalk.text = "";
         }
      }
      
      protected function HeroAttribute_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:TSystemLanguage = null;
         this.FUIAttribute = param1["AttributeTable"];
         this.FSwitchPageMoive = param1["SwitchPageMoive"];
         this.FTable1AttributesValue = new Vector.<TextField>();
         this.FTable1AttributesName = new Vector.<TextField>();
         _loc4_ = this.FUIAttribute["Attribute1"];
         this.FTable1UI = _loc4_;
         _loc4_ = _loc4_["AttributeTop"];
         this.FTable1Animation = _loc4_["AttributeInnerTable"];
         _loc4_ = this.FTable1Animation["AttributeInnerToo"];
         this.FTable1HeroDescribtion = _loc4_["TF_HeroDescribtion"];
         _loc2_ = 0;
         while(_loc2_ < CONST_SUPERHERO.AttributeNum)
         {
            _loc5_ = _loc4_["Value" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable1AttributesValue.push(_loc5_);
            _loc5_ = _loc4_["Name" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable1AttributesName.push(_loc5_);
            _loc2_++;
         }
         this.FTable1GiftName = _loc4_["Gift"];
         this.FTable1SkillName = _loc4_["Skill"];
         this.FTable1SkillDescribtion = _loc4_["SkillDescribtion"];
         this.FTable1HeroPosition = _loc4_["Position"];
         this.FTable1AttributesValueTwo = new Vector.<TextField>();
         this.FTable1AttributesNameTwo = new Vector.<TextField>();
         _loc4_ = this.FUIAttribute["Attribute1"];
         _loc4_ = _loc4_["AttributeTop"];
         this.FTable1AnimationTwo = _loc4_["AttributeInnerTableTwo"];
         this.FMC_SkillShow = _loc4_["MC_SkillShow"];
         _loc4_ = this.FTable1AnimationTwo["AttributeInnerToo"];
         this.FTable1HeroDescribtionTwo = _loc4_["TF_HeroDescribtion"];
         TGameUtil.setButtonMode(this.FMC_SkillShow,true);
         _loc2_ = 0;
         while(_loc2_ < CONST_SUPERHERO.AttributeNum)
         {
            _loc5_ = _loc4_["Value" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable1AttributesValueTwo.push(_loc5_);
            _loc5_ = _loc4_["Name" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable1AttributesNameTwo.push(_loc5_);
            _loc2_++;
         }
         this.FTable1GiftNameTwo = _loc4_["Gift"];
         this.FTable1SkillNameTwo = _loc4_["Skill"];
         this.FTable1SkillDescribtionTwo = _loc4_["SkillDescribtion"];
         this.FTable1HeroPositionTwo = _loc4_["Position"];
         _loc4_ = this.FUIAttribute["Attribute2"];
         this.FTable2UI = _loc4_;
         this.FTable2Animation = _loc4_["AttributeTop"];
         _loc4_ = this.FTable2Animation["AttributeInnerTable"];
         this.FUISoul = _loc4_["Soul"];
         this.FTF_ItemNeed = _loc4_["ItemNeed"];
         this.FTF_ItemNeedVip = _loc4_["ItemNeedVip"];
         this.FTF_SoulNeed = _loc4_["SoulNeed"];
         this.FTF_SoulNeedVip = _loc4_["SoulNeedVip"];
         this.FTF_LevelNeed = _loc4_["LevelNeed"];
         this.FTF_VipNeed = _loc4_["VipNeed"];
         this.FTF_Status = _loc4_["TF_Status"];
         this.FTF_ItemLevel = _loc4_["ItemLevel"];
         this.FTF_SoulLevel = _loc4_["SoulLevel"];
         this.FMC_Itembg_0 = this.FTable2UI["mc_Itembg_0"];
         this.FMC_Itembg_1 = this.FTable2UI["mc_Itembg_1"];
         this.FMC_Soulbg_0 = this.FTable2UI["mc_Soulbg_0"];
         this.FMC_Soulbg_1 = this.FTable2UI["mc_Soulbg_1"];
         this.FTF_ItemVipLevel = _loc4_["ItemVipLevel"];
         this.FTF_SoulVipLevel = _loc4_["SoulVipLevel"];
         this.FMC_Bar_item = _loc4_["MC_Bar_item"];
         this.FMC_Bar_itemVip = _loc4_["MC_Bar_itemVip"];
         this.FMC_Bar_Soul = _loc4_["MC_Bar_Soul"];
         this.FMC_Bar_SoulVip = _loc4_["MC_Bar_SoulVip"];
         this.FTable2HeroNameBeforAdvanced = _loc4_["NameBeforAdvanced"];
         this.FTable2PositionBeforAdvanced = _loc4_["PositionBefore"];
         this.FTable2SGiftBeforAdvanced = _loc4_["GiftBefore"];
         this.FTable2SkillBeforAdvanced = _loc4_["SkillBefore"];
         this.FTable2SkillDescribtionBeforAdvanced = _loc4_["SkillBeforeDescribtion"];
         this.FTable2AttributesValueBeforAdvanced = new Vector.<TextField>();
         this.FTable2AttributesNameBeforAdvanced = new Vector.<TextField>();
         _loc2_ = 0;
         while(_loc2_ < CONST_SUPERHERO.AttributeNum)
         {
            _loc5_ = _loc4_["ValueBefore" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable2AttributesValueBeforAdvanced.push(_loc5_);
            _loc5_ = _loc4_["NameBefore" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable2AttributesNameBeforAdvanced.push(_loc5_);
            _loc2_++;
         }
         this.FTable2HeroNameAfterAdvanced = _loc4_["NameAfterAdvanced"];
         this.FTable2PositionAfterAdvanced = _loc4_["PositionAfter"];
         this.FTable2SGiftAfterAdvanced = _loc4_["GiftAfter"];
         this.FTable2SkillAfterAdvanced = _loc4_["SkillAfter"];
         this.FTable2SkillDescribtionAfterAdvanced = _loc4_["SkillAfterDescribtion"];
         this.FTable2AttributesValueAfterAdvanced = new Vector.<TextField>();
         this.FTable2AttributesNameAfterAdvanced = new Vector.<TextField>();
         _loc2_ = 0;
         while(_loc2_ < CONST_SUPERHERO.AttributeNum)
         {
            _loc5_ = _loc4_["ValueAfter" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable2AttributesValueAfterAdvanced.push(_loc5_);
            _loc5_ = _loc4_["NameAfter" + (_loc2_ + 1)];
            _loc5_.mouseEnabled = false;
            this.FTable2AttributesNameAfterAdvanced.push(_loc5_);
            _loc2_++;
         }
         this.FTF_ItemName = _loc4_["Describtion"]["TF_ItemName"];
         this.FTF_OpenWindow = _loc4_["Describtion"]["TF_OpenWindow"];
         _loc4_ = this.FUIAttribute["Attribute2"];
         this.FTable2SlotItem = new TUISlot(this);
         this.FTable2SlotItem.Resource = _loc4_["SlotIem"];
         this.FBtn_Polishing = _loc4_["btnpolish"];
         this.FBtn_Traven = _loc4_["btntavern"];
         this.FBtn_Upgrade = _loc4_["Btn_Upgrade"];
         this.FBtn_GoBack = _loc4_["Btn_Goback"];
         this.FMC_SkillShowCopy = _loc4_["MC_SkillShow"];
         TGameUtil.setButtonMode(this.FMC_SkillShowCopy,true);
         _loc4_ = this.FUIAttribute["Attribute1"];
         this.FAnimationBottom = _loc4_["AttributeBottom"];
         _loc4_ = this.FAnimationBottom["Btn1"];
         this.FBtn1UI = _loc4_;
         this.FBtn1UI.visible = false;
         this.FBtn1ItemNeedSlot = new TUISlot(this);
         this.FBtn1ItemNeedSlot.Resource = _loc4_["ItemNeedSlot"];
         this.FMcSpeicialHero = _loc4_["mc_recharge"];
         this.FBtnSpeicialHero = _loc4_["btn_recharge"];
         this.FMcSpeicialHero.visible = false;
         this.FBtnSpeicialHero.visible = false;
         this.FMc_TfInfo = _loc4_["Describtion"];
         this.FBtn1ItemNeedTF = _loc4_["ItemNeedTF"];
         this.FBtn1ItemNeedBtn = _loc4_["ItemNeedBtn"];
         this.FBtn1LookNextHero = _loc4_["Btn_NextHero"];
         this.FBtn1Enlist = _loc4_["Btn_Enlist"];
         this.FBtn1TF_ItemName = _loc4_["Describtion"]["TF_ItemName"];
         this.FBtn1TF_OpenWindow = _loc4_["Describtion"]["TF_OpenWindow"];
         this.FMC_LoginInGet = _loc4_["MC_LoginInGet"];
         _loc4_ = this.FAnimationBottom["Btn2"];
         this.FBtn2UI = _loc4_;
         this.FBtn2UI.visible = false;
         this.FBtn2HeroUpgrade = _loc4_["Btn_Upgrade"];
         this.FBtn2ChangeShape = _loc4_["Btn_ChangeShape"];
         _loc4_ = this.FAnimationBottom["Btn3"];
         this.FBtn3UI = _loc4_;
         this.FBtn3UI.visible = false;
         this.FBtn3HeroUpgradeBefore = _loc4_["Btn_UpgradeBefore"]["Btn_UpgradeBeforeInner"];
         this.FBtn3ChangeShape = _loc4_["Btn_ChangeShape"];
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.MODULE_SuperHero);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
         this.FHelpHint = new THint();
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_TOPNINJIA) as TSystemLanguage;
         this.FHelpHint.Content = _loc6_.Desc;
      }
      
      protected function HeroAttribute_Location() : void
      {
         TJadeCommon.InitSlot(this.FTable2SlotItem,CONST_MODULES.MODULE_SuperHero);
         this.FTable2SlotItem.OnOverlay = this.UIComponentsHintOnOver;
         this.FTable2SlotItem.OnOut = this.UIComponentsHintOnOut;
         this.FTable2SlotItem.Init();
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Polishing,this.View2PolishClick);
         this.FBtn_Polishing.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Traven,this.View2TravenClick);
         this.FBtn_Traven.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Upgrade,this.View2UpgradeClick);
         this.FBtn_Upgrade.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_GoBack,this.View2GoBackClick);
         this.FBtn_GoBack.buttonMode = true;
         this.FTF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow;
         this.FTF_OpenWindow.addEventListener(TextEvent.LINK,this.OpenWindow);
         TJadeCommon.InitSlot(this.FBtn1ItemNeedSlot,CONST_MODULES.MODULE_SuperHero);
         this.FBtn1ItemNeedSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FBtn1ItemNeedSlot.OnOut = this.UIComponentsHintOnOut;
         this.FBtn1ItemNeedSlot.Init();
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn1ItemNeedBtn,this.Btn1ItemNeedBtnClick);
         this.FBtn1ItemNeedBtn.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn1Enlist,this.Btn1EnlistBtnClick);
         this.FBtn1Enlist.buttonMode = true;
         this.FBtnSpeicialHero.addEventListener(MouseEvent.CLICK,this.BtnSpeicialHeroBtnClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn1LookNextHero,this.Btn1NextHeroClick);
         this.FBtn1LookNextHero.buttonMode = true;
         this.FBtn1TF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow;
         this.FBtn1TF_OpenWindow.addEventListener(TextEvent.LINK,this.OpenWindow);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn2HeroUpgrade,this.Btn2HeroUpgradeClick);
         this.FBtn2HeroUpgrade.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn2ChangeShape,this.BtnChangeShapeClick);
         this.FBtn2ChangeShape.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn3HeroUpgradeBefore,this.Btn3HeroUpgradeBeforeClick);
         this.FBtn3HeroUpgradeBefore.buttonModel = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn3ChangeShape,this.BtnChangeShapeClick);
         this.FBtn3ChangeShape.buttonMode = true;
         this.FAttributeShowState = AttributeStateReady;
         this.FTable1GiftName.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsBtnOnOver);
         this.FTable1GiftName.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsBtnOnOut);
         this.FTable1GiftNameTwo.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsBtnOnOver);
         this.FTable1GiftNameTwo.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsBtnOnOut);
         this.FTable2SGiftAfterAdvanced.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsBtnOnOver);
         this.FTable2SGiftAfterAdvanced.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsBtnOnOut);
         this.FTable2SGiftBeforAdvanced.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsBtnOnOver);
         this.FTable2SGiftBeforAdvanced.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsBtnOnOut);
         this.FMC_SkillShow.addEventListener(MouseEvent.CLICK,this.SkillShow);
         this.FMC_SkillShowCopy.addEventListener(MouseEvent.CLICK,this.SkillShow);
      }
      
      protected function HeroAttribute_Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.HideAllUI();
         this.FTable1UI.visible = true;
         this.FTable1Animation.visible = true;
         this.FBtn1UI.visible = true;
         _loc2_ = int(this.FTable1AttributesValue.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTable1AttributesValue[_loc1_].text = "";
            this.FTable1AttributesName[_loc1_].text = "";
            _loc1_++;
         }
         this.FTable1HeroDescribtion.text = "";
         this.FTable1SkillDescribtion.text = "";
         this.FTable1GiftName.text = "";
         this.FTable1SkillName.text = "";
         this.FTable1HeroPosition.gotoAndStop(1);
         this.FBtn1ItemNeedBtn.gotoAndStop("Disable");
         this.FBtn1LookNextHero.gotoAndStop("Disable");
         this.FBtn1Enlist.gotoAndStop("Disable");
         this.FSwitchPageMoive.visible = false;
         this.FBtn1ItemNeedSlot.Context = null;
         this.FBtn1ItemNeedTF.text = "";
      }
      
      protected function HideAllUI() : void
      {
         this.FTable1UI.visible = false;
         this.FTable2UI.visible = false;
         this.FTable1Animation.visible = false;
         this.FTable1AnimationTwo.visible = false;
         this.FBtn1UI.visible = false;
         this.FBtn2UI.visible = false;
         this.FBtn3UI.visible = false;
      }
      
      protected function HeroAttribute_Update() : void
      {
         var _loc1_:int = 0;
         switch(this.FSelectHeroState)
         {
            case CONST_SUPERHERO.HEROSTATE_LOWLEVEL:
               this.FAttributeShowState = AttributeStateUnenlist;
               break;
            case CONST_SUPERHERO.HEROSTATE_UNENLIST:
               this.FAttributeShowState = AttributeStateUnenlist;
               break;
            case CONST_SUPERHERO.HEROSTATE_ENLIST:
               this.FAttributeShowState = AttributeStateEnlist;
               break;
            case CONST_SUPERHERO.HEROSTATE_ADVANCED:
               this.FAttributeShowState = AttributeStateAdvancedLookAdvanced;
         }
         this.StartSwitchPage();
      }
      
      protected function StartSwitchPage() : void
      {
         this.FSwitchPageMoive.visible = true;
         this.FSwitchPageMoive.gotoAndPlay(1);
         this.FTable1Animation.gotoAndPlay(1);
         this.FTable1AnimationTwo.gotoAndPlay(1);
         this.FTable2Animation.gotoAndPlay(1);
         this.FMC_RoleMoudle.gotoAndPlay(1);
         this.FIfSwitchPage = true;
      }
      
      protected function PlaySwitchPage() : void
      {
         if(this.FIfSwitchPage)
         {
            if(this.FSwitchPageMoive.currentFrame == 15)
            {
               this.HeroAttribute_FlushAttribute();
               this.FMC_RoleMoudle.stop();
            }
            else if(this.FSwitchPageMoive.currentFrame == 19)
            {
               this.FSwitchPageMoive.gotoAndStop(1);
               this.FTable1Animation.gotoAndStop(1);
               this.FTable1AnimationTwo.gotoAndStop(1);
               this.FTable2Animation.gotoAndStop(1);
               this.FSwitchPageMoive.visible = false;
               this.HeroModule_Update(this.FCurrentShowHero);
               this.FMC_RoleMoudle.play();
            }
            if(this.FMC_RoleMoudle.currentFrame == 25)
            {
               this.FMC_RoleMoudle.gotoAndStop(1);
               this.FIfSwitchPage = false;
            }
         }
      }
      
      protected function HeroAttribute_FlushAttribute() : void
      {
         var _loc1_:TSuperHero = null;
         this.HideAllUI();
         switch(this.FAttributeShowState)
         {
            case AttributeStateUnenlist:
               this.FTable1UI.visible = true;
               this.FBtn1UI.visible = true;
               this.FTable1AnimationTwo.visible = true;
               this.FCurrentShowHero = this.FSelectedHero;
               this.HeroAttribute_FlushAttributeView1(this.FSelectedHero);
               this.HeroAttributeResetBtn1();
               break;
            case AttributeStateEnlist:
               this.FTable1UI.visible = true;
               this.FBtn2UI.visible = true;
               this.FTable1AnimationTwo.visible = true;
               this.FCurrentShowHero = this.FSelectedHero;
               this.HeroAttribute_FlushAttributeView1(this.FSelectedHero);
               this.HeroAttributeResetBtn2();
               break;
            case AttributeStateAdvancedLookAdvanced:
               this.FTable1UI.visible = true;
               this.FBtn3UI.visible = true;
               this.FTable1Animation.visible = true;
               this.FCurrentShowHero = this.FSelectedHero;
               this.HeroAttribute_FlushAttributeView1(this.FSelectedHero);
               this.HeroAttributeResetBtn3();
               break;
            case AttributeStateAdvancedLookUnadvanced:
               this.FTable1UI.visible = true;
               this.FBtn3UI.visible = true;
               this.FTable1AnimationTwo.visible = true;
               _loc1_ = this.FSuperHeros.GetHeroByIdentifier(this.FSelectedHero.RelationHeroID) as TSuperHero;
               this.FCurrentShowHero = _loc1_;
               this.HeroAttribute_FlushAttributeView1(_loc1_);
               this.HeroAttributeResetBtn3();
               break;
            case AttributeStateEnlisting:
               this.FTable2UI.visible = true;
               this.FCurrentShowHero = this.FSuperHeros.GetHeroByIdentifier(this.FSelectedHero.RelationHeroID) as TSuperHero;
               this.HeroAttribute_FlushAttributeView2();
         }
      }
      
      protected function HeroAttribute_FlushAttributeView1(param1:TSuperHero) : void
      {
         var _loc2_:TSkill = null;
         var _loc3_:int = 0;
         if(this.FAttributeShowState == AttributeStateAdvancedLookAdvanced)
         {
            this.FlushBaseAttributes(param1,this.FTable1AttributesValue,this.FTable1AttributesName);
            _loc2_ = param1.Skills.GetSkillByIndex(0);
            this.FCurHeroId = param1.Identifier;
            this.FTable1GiftName.text = param1.TalentName;
            this.FTable1SkillName.text = _loc2_.Name;
            this.FTable1SkillDescribtion.text = _loc2_.Description;
            this.FTable1HeroDescribtion.text = param1.HeroDescribtion;
            _loc3_ = this.GetPostion(param1.Profession);
            this.FTable1HeroPosition.gotoAndStop(_loc3_);
         }
         else
         {
            this.FlushBaseAttributes(param1,this.FTable1AttributesValueTwo,this.FTable1AttributesNameTwo);
            _loc2_ = param1.Skills.GetSkillByIndex(0);
            this.FTable1GiftNameTwo.text = param1.TalentName;
            this.FTable1SkillNameTwo.text = _loc2_.Name;
            this.FTable1SkillDescribtionTwo.text = _loc2_.Description;
            this.FTable1HeroDescribtionTwo.text = param1.HeroDescribtion;
            this.FCurHeroId = param1.Identifier;
            _loc3_ = this.GetPostion(param1.Profession);
            this.FTable1HeroPositionTwo.gotoAndStop(_loc3_);
         }
      }
      
      protected function HeroAttribute_FlushAttributeView2() : void
      {
         var _loc1_:TSuperHero = null;
         var _loc2_:TSuperHero = null;
         var _loc3_:int = 0;
         var _loc4_:TSkill = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TItem = null;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         this.FMC_Bar_item.visible = true;
         this.FMC_Bar_itemVip.visible = true;
         this.FMC_Bar_Soul.visible = true;
         this.FMC_Bar_SoulVip.visible = true;
         this.FTF_ItemLevel.visible = true;
         this.FTF_ItemVipLevel.visible = true;
         this.FTF_SoulLevel.visible = true;
         this.FTF_SoulVipLevel.visible = true;
         this.FMC_Itembg_1.visible = true;
         this.FMC_Soulbg_1.visible = true;
         this.FTF_ItemNeedVip.visible = true;
         this.FTF_SoulNeedVip.visible = true;
         this.FMC_Itembg_0.x = 27;
         this.FMC_Itembg_0.y = 406;
         this.FMC_Soulbg_0.x = 128;
         this.FMC_Soulbg_0.y = 407;
         this.FTF_ItemNeed.x = 7;
         this.FTF_ItemNeed.y = 378;
         this.FTF_SoulNeed.x = 108;
         this.FTF_SoulNeed.y = 378;
         _loc2_ = this.FSuperHeros.GetHeroByIdentifier(this.FSelectedHero.RelationHeroID) as TSuperHero;
         this.FCurHeroId = _loc2_.Identifier;
         this.FIsVipEnough = Boolean(SLogicsCore.Character.VipLevel >= _loc2_.AdvanceNeedVipLevel);
         _loc1_ = this.FSelectedHero;
         this.FTable2HeroNameBeforAdvanced.text = _loc1_.Name;
         this.FlushBaseAttributes(_loc1_,this.FTable2AttributesValueBeforAdvanced,this.FTable2AttributesNameBeforAdvanced);
         _loc3_ = this.GetPostion(_loc1_.Profession);
         _loc4_ = _loc1_.Skills.GetSkillByIndex(0);
         this.FTable2PositionBeforAdvanced.text = STRING_SUPERHERO.DeploymentNames[_loc3_];
         this.FTable2SGiftBeforAdvanced.text = _loc1_.TalentName;
         this.FTable2SkillBeforAdvanced.text = _loc4_.Name;
         this.FTable2SkillDescribtionBeforAdvanced.text = _loc4_.Description;
         this.FTable2HeroNameAfterAdvanced.text = _loc2_.Name;
         this.FlushBaseAttributes(_loc2_,this.FTable2AttributesValueAfterAdvanced,this.FTable2AttributesNameAfterAdvanced);
         _loc3_ = this.GetPostion(_loc2_.Profession);
         _loc4_ = _loc2_.Skills.GetSkillByIndex(0);
         this.FTable2PositionAfterAdvanced.text = STRING_SUPERHERO.DeploymentNames[_loc3_];
         this.FTable2SGiftAfterAdvanced.text = _loc2_.TalentName;
         this.FTable2SkillAfterAdvanced.text = _loc4_.Name;
         this.FTable2SkillDescribtionAfterAdvanced.text = _loc4_.Description;
         _loc8_ = _loc2_.EnlistInventory.GetInventoryByIndex(0);
         this.FTable2SlotItem.Context = _loc8_;
         this.FTF_ItemName.text = _loc8_.Name;
         this.FTF_ItemName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc8_.Quality];
         _loc9_ = _loc2_.EnlistCondition[1];
         this.FUISoul.gotoAndStop(_loc9_.ID - 2);
         _loc6_ = _loc2_.OriginalEnlistCondition[0].Count;
         _loc7_ = int(_loc8_.Quantity);
         _loc5_ = this.GetMaterialCount(_loc8_.IDTemplate);
         if(_loc8_.IDTemplate != 14111300)
         {
            _loc5_ += this.GetMaterialCount(UniversalMaterialID);
         }
         this.FTF_ItemNeed.text = _loc5_ + "/" + _loc6_;
         this.FTF_ItemNeedVip.text = _loc5_ + "/" + _loc7_;
         if(this.FIsVipEnough)
         {
            this.FMC_Bar_item.visible = true;
            this.FMC_Bar_itemVip.visible = false;
            if(_loc5_ >= _loc7_)
            {
               this.FBtn_Polishing.gotoAndStop("Disable");
            }
            else
            {
               this.FBtn_Polishing.gotoAndStop("Enable");
               _loc10_ = true;
            }
         }
         else
         {
            this.FMC_Bar_item.visible = false;
            this.FMC_Bar_itemVip.visible = true;
            if(_loc5_ >= _loc6_)
            {
               this.FBtn_Polishing.gotoAndStop("Disable");
            }
            else
            {
               this.FBtn_Polishing.gotoAndStop("Enable");
               _loc10_ = true;
            }
         }
         this.FTF_ItemNeed.textColor = _loc5_ >= _loc6_ ? CONST_COMMON.TEXT_Green_Color : CONST_COMMON.TEXT_Red_Color;
         this.FTF_ItemNeedVip.textColor = _loc5_ >= _loc7_ ? CONST_COMMON.TEXT_Green_Color : CONST_COMMON.TEXT_Red_Color;
         _loc6_ = _loc2_.OriginalEnlistCondition[1].Count;
         _loc7_ = _loc9_.Count;
         _loc5_ = int(SLogicsCore.Character.GetHeroSoulByIndex(_loc9_.ID - 3));
         this.FTF_SoulNeed.text = _loc5_ + "/" + _loc6_;
         this.FTF_SoulNeedVip.text = _loc5_ + "/" + _loc7_;
         if(this.FIsVipEnough)
         {
            this.FMC_Bar_Soul.visible = true;
            this.FMC_Bar_SoulVip.visible = false;
            if(_loc5_ < _loc7_)
            {
               _loc10_ = true;
            }
         }
         else
         {
            this.FMC_Bar_Soul.visible = false;
            this.FMC_Bar_SoulVip.visible = true;
            if(_loc5_ < _loc6_)
            {
               _loc10_ = true;
            }
         }
         this.FTF_SoulNeed.textColor = _loc5_ < _loc6_ ? CONST_COMMON.TEXT_Red_Color : CONST_COMMON.TEXT_Green_Color;
         this.FTF_SoulNeedVip.textColor = _loc5_ < _loc7_ ? CONST_COMMON.TEXT_Red_Color : CONST_COMMON.TEXT_Green_Color;
         if(_loc2_.EnlistLevelLimit < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            this.FTF_LevelNeed.text = _loc2_.EnlistLevelLimit.toString();
         }
         else
         {
            this.FTF_LevelNeed.text = STRING_COMMON.GetLevelStrByLevelLineFeed(_loc2_.EnlistLevelLimit);
         }
         this.FTF_VipNeed.text = "VIP" + _loc2_.AdvanceNeedVipLevel.toString();
         this.FTF_ItemVipLevel.text = "V" + _loc2_.AdvanceNeedVipLevel.toString();
         this.FTF_SoulVipLevel.text = "V" + _loc2_.AdvanceNeedVipLevel.toString();
         if(_loc10_)
         {
            this.FBtn_Upgrade.gotoAndStop("Disable");
         }
         else
         {
            this.FBtn_Upgrade.gotoAndStop("Enable");
         }
         this.FBtn_Traven.gotoAndStop("Enable");
         if(this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_UNENLIST || this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_LOWLEVEL)
         {
            this.FBtn_Upgrade.gotoAndStop("Disable");
            this.FBtn_Polishing.gotoAndStop("Disable");
            this.FBtn_Traven.gotoAndStop("Disable");
            this.FTF_SoulNeed.textColor = CONST_COMMON.TEXT_Red_Color;
            this.FTF_SoulNeedVip.textColor = CONST_COMMON.TEXT_Red_Color;
            this.FTF_ItemNeed.textColor = CONST_COMMON.TEXT_Red_Color;
            this.FTF_ItemNeedVip.textColor = CONST_COMMON.TEXT_Red_Color;
         }
         _loc11_ = _loc2_.AdvanceNeedVipLevel != 0;
         this.FTF_Status.text = _loc11_ ? STRING_SUPERHERO.STRING_NeedVip : STRING_SUPERHERO.STRING_NoNeedVip;
         if(!_loc11_)
         {
            this.FMC_Bar_item.visible = false;
            this.FMC_Bar_itemVip.visible = false;
            this.FMC_Bar_Soul.visible = false;
            this.FMC_Bar_SoulVip.visible = false;
            this.FTF_ItemLevel.visible = false;
            this.FTF_ItemVipLevel.visible = false;
            this.FTF_SoulLevel.visible = false;
            this.FTF_SoulVipLevel.visible = false;
            this.FMC_Itembg_1.visible = false;
            this.FMC_Soulbg_1.visible = false;
            this.FTF_ItemNeedVip.visible = false;
            this.FTF_SoulNeedVip.visible = false;
            this.FMC_Itembg_0.x = 20;
            this.FMC_Itembg_0.y = 416;
            this.FMC_Soulbg_0.x = 125;
            this.FMC_Soulbg_0.y = 416;
            this.FTF_ItemNeed.x = 0;
            this.FTF_ItemNeed.y = 388;
            this.FTF_SoulNeed.x = 101;
            this.FTF_SoulNeed.y = 388;
         }
         if(_loc8_.IDTemplate != 14111300)
         {
            this.FTF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow;
            this.FBtn1TF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow;
         }
         else
         {
            this.FTF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow2;
            this.FBtn1TF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow2;
         }
      }
      
      protected function View2PolishClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TNewMall = null;
         var _loc8_:uint = 0;
         if(this.FBtn_Polishing.currentFrameLabel == "Disable")
         {
            return;
         }
         _loc3_ = this.FCurrentShowHero.EnlistInventory.GetInventoryByIndex(0);
         this.FOder.Inventory = _loc3_;
         if(this.FIsVipEnough)
         {
            _loc5_ = int(_loc3_.Quantity);
         }
         else
         {
            _loc5_ = this.FCurrentShowHero.OriginalEnlistCondition[0].Count;
         }
         _loc4_ = this.GetMaterialCount(_loc3_.IDTemplate);
         if(_loc3_.IDTemplate != 14111300)
         {
            _loc4_ += this.GetMaterialCount(UniversalMaterialID);
            _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_SuperHero_BuyItem).DescribeString;
         }
         else
         {
            _loc2_ = STRING_SUPERHERO.STRING_1;
         }
         _loc6_ = _loc5_ - _loc4_;
         this.FOder.Count = _loc6_;
         _loc7_ = this.FNewMallBins.GetDatebaseByValue("Itemid",this.FOder.IDTemplate) as TNewMall;
         if(_loc7_ == null)
         {
            return;
         }
         if(_loc7_.VipPrice <= 0)
         {
            _loc8_ = uint(_loc7_.Price);
         }
         else
         {
            _loc8_ = SLogicsCore.Character.VipData.StonePecent ? uint(_loc7_.VipPrice) : uint(_loc7_.Price);
         }
         this.FOder.MallId = _loc7_.Identifier;
         _loc2_ = TUtilityString.Format(_loc2_,this.FOder.Count * _loc8_,this.FOder.Count,_loc7_.Name);
         this.FPopWindow.Text = _loc2_;
         this.FPopWindow.visible = true;
      }
      
      protected function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NewMall_BuyGoods);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FOder.MallId);
         _loc3_.writeUnsignedInt(this.FOder.Count);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function View2TravenClick(param1:MouseEvent) : void
      {
         if(this.FBtn_Traven.currentFrameLabel == "Disable")
         {
            return;
         }
         if(this.FOnShortcutHyperlinks != null)
         {
            this.OnBtnClose();
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Additional,CONST_SHORTCUTS.TYPE_Additional_Tavern);
         }
      }
      
      protected function EnlistCommon() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = this.FCurrentShowHero.EnlistInventory.GetInventoryByIndex(0);
         _loc3_ = this.GetMaterialCount(_loc2_.IDTemplate);
         if(_loc3_ >= _loc2_.Quantity)
         {
            _loc1_ = TUtilityString.Format(STRING_SUPERHERO.FORMATSTRING_EnlistUseNormalInventory,this.FSelectedHero.Name,_loc2_.Name,_loc2_.Quantity.toString());
         }
         else
         {
            _loc4_ = _loc2_.Quantity - _loc3_;
            _loc1_ = TUtilityString.Format(STRING_SUPERHERO.FORMATSTRING_EnlistUseUniversalMaterial,this.FSelectedHero.Name,_loc2_.Name,_loc3_.toString(),this.FUniversalMaterialName,_loc4_.toString());
         }
         this.FPromotWindow.Text = _loc1_;
         this.FPromotWindow.visible = true;
         this.FPromotWindow.OnOK = this.ConfirmEnlist;
      }
      
      protected function EnlistUpgradeCommon() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = this.FCurrentShowHero.EnlistInventory.GetInventoryByIndex(0);
         if(this.FIsVipEnough)
         {
            _loc6_ = _loc2_.Quantity;
            _loc7_ = _loc2_.IDTemplate;
         }
         else
         {
            _loc6_ = uint(this.FCurrentShowHero.OriginalEnlistCondition[0].Count);
            _loc7_ = uint(this.FCurrentShowHero.OriginalEnlistCondition[0].ID);
         }
         _loc3_ = this.GetMaterialCount(_loc7_);
         if(_loc3_ >= _loc6_)
         {
            _loc1_ = TUtilityString.Format(STRING_SUPERHERO.FORMATSTRING_EnlistUseNormalInventory,this.FSelectedHero.Name,_loc2_.Name,String(_loc6_));
         }
         else
         {
            _loc4_ = _loc6_ - _loc3_;
            _loc1_ = TUtilityString.Format(STRING_SUPERHERO.FORMATSTRING_EnlistUseUniversalMaterial,this.FSelectedHero.Name,_loc2_.Name,_loc3_.toString(),this.FUniversalMaterialName,_loc4_.toString());
         }
         this.FPromotWindow.Text = _loc1_;
         this.FPromotWindow.visible = true;
         this.FPromotWindow.OnOK = this.ConfirmEnlist;
      }
      
      protected function View2UpgradeClick(param1:MouseEvent) : void
      {
         if(this.FBtn_Upgrade.currentFrameLabel == "Disable")
         {
            return;
         }
         this.EnlistUpgradeCommon();
      }
      
      protected function View2GoBackClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(this.FBtn_GoBack.currentFrameLabel == "Disable")
         {
            return;
         }
         if(this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_ENLIST)
         {
            this.FAttributeShowState = AttributeStateEnlist;
         }
         else
         {
            this.FAttributeShowState = AttributeStateUnenlist;
         }
         this.StartSwitchPage();
      }
      
      protected function HeroAttributeResetBtn1() : void
      {
         var _loc1_:TInventory = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = this.FSelectedHero.EnlistInventory.GetInventoryByIndex(0);
         this.FBtn1ItemNeedSlot.Context = _loc1_;
         _loc3_ = int(_loc1_.Quantity);
         _loc2_ = this.GetMaterialCount(_loc1_.IDTemplate);
         if(_loc1_.IDTemplate != 14111300)
         {
            _loc2_ += this.GetMaterialCount(UniversalMaterialID);
            this.FTF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow;
            this.FBtn1TF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow;
         }
         else
         {
            this.FTF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow2;
            this.FBtn1TF_OpenWindow.htmlText = STRING_SUPERHERO.FormatString_OpenWindow2;
         }
         this.FBtn1ItemNeedTF.text = _loc2_ + "/" + _loc3_;
         this.FBtn1TF_ItemName.text = _loc1_.Name;
         this.FBtn1TF_ItemName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc1_.Quality];
         if(_loc2_ >= _loc3_)
         {
            this.FBtn1ItemNeedBtn.gotoAndStop("Disable");
            this.FBtn1Enlist.gotoAndStop("Enable");
            this.FBtn1ItemNeedTF.textColor = CONST_COMMON.TEXT_Green_Color;
         }
         else
         {
            this.FBtn1ItemNeedBtn.buttonMode = true;
            this.FBtn1ItemNeedBtn.gotoAndStop("Enable");
            this.FBtn1Enlist.gotoAndStop("Disable");
            this.FBtn1ItemNeedTF.textColor = CONST_COMMON.TEXT_Red_Color;
         }
         if(this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_LOWLEVEL || this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_ENLIST)
         {
            this.FBtn1ItemNeedBtn.gotoAndStop("Disable");
            this.FBtn1Enlist.gotoAndStop("Disable");
            this.FBtn1ItemNeedTF.textColor = CONST_COMMON.TEXT_Red_Color;
         }
         this.FBtn1LookNextHero.gotoAndStop("Enable");
         this.FMcSpeicialHero.visible = false;
         this.FBtnSpeicialHero.visible = false;
         this.FBtn1Enlist.visible = true;
         this.FMc_TfInfo.visible = true;
         this.FMC_LoginInGet.visible = false;
         if(this.FSelectedHero.Identifier == SpeicialHeroID)
         {
            this.FMcSpeicialHero.visible = true;
            this.FBtnSpeicialHero.visible = true;
            this.FBtn1Enlist.visible = false;
            this.FMc_TfInfo.visible = false;
            this.FMC_LoginInGet.visible = false;
         }
         else if(this.FSelectedHero.Identifier == SpeicialHeroID_1)
         {
            this.FMcSpeicialHero.visible = false;
            this.FBtnSpeicialHero.visible = false;
            this.FBtn1Enlist.visible = false;
            this.FMc_TfInfo.visible = false;
            this.FMC_LoginInGet.visible = true;
         }
      }
      
      protected function Btn1ItemNeedBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TNewMall = null;
         var _loc10_:uint = 0;
         if(this.FBtn1ItemNeedBtn.currentFrameLabel == "Disable")
         {
            return;
         }
         _loc3_ = this.FSelectedHero.EnlistInventory.GetInventoryByIndex(0);
         this.FOder.Inventory = _loc3_;
         _loc5_ = int(_loc3_.Quantity);
         _loc4_ = this.GetMaterialCount(_loc3_.IDTemplate);
         if(_loc3_.IDTemplate != 14111300)
         {
            _loc4_ += this.GetMaterialCount(UniversalMaterialID);
            _loc2_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_SuperHero_BuyItem).DescribeString;
         }
         else
         {
            _loc2_ = STRING_SUPERHERO.STRING_1;
         }
         _loc7_ = _loc5_ - _loc4_;
         this.FOder.Count = _loc7_;
         _loc9_ = this.FNewMallBins.GetDatebaseByValue("Itemid",this.FOder.IDTemplate) as TNewMall;
         if(_loc9_ == null)
         {
            return;
         }
         if(_loc9_.VipPrice <= 0)
         {
            _loc10_ = uint(_loc9_.Price);
         }
         else
         {
            _loc10_ = SLogicsCore.Character.VipData.StonePecent ? uint(_loc9_.VipPrice) : uint(_loc9_.Price);
         }
         this.FOder.MallId = _loc9_.Identifier;
         _loc2_ = TUtilityString.Format(_loc2_,this.FOder.Count * _loc10_,this.FOder.Count,_loc9_.Name);
         this.FPopWindow.Text = _loc2_;
         this.FPopWindow.visible = true;
      }
      
      protected function ConfirmEnlist(param1:Object) : void
      {
         var _loc2_:int = 0;
         switch(this.FSelectHeroState)
         {
            case CONST_SUPERHERO.HEROSTATE_ENLIST:
               _loc2_ = CONST_SUPERHERO.TypeAdvance;
               break;
            case CONST_SUPERHERO.HEROSTATE_UNENLIST:
               _loc2_ = CONST_SUPERHERO.TypeEnlist;
               break;
            default:
               return;
         }
         if(SLogicsCore.NinjaHostelData.GetHerBaseById(this.FSelectedHero.Identifier) != null)
         {
            if(this.FOnEffectGenerateText != null)
            {
               this.FOnEffectGenerateText(STRING_SUPERHERO.FormatString_GetByHostel);
            }
            return;
         }
         if(this.FOnEnlist != null)
         {
            this.FOnEnlist(_loc2_,this.FSelectedHero.Identifier);
            this.FCurrentState = MouduleState_WaitEnlist;
         }
      }
      
      protected function Btn1EnlistBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         if(this.FBtn1Enlist.currentFrameLabel == "Disable")
         {
            return;
         }
         TutorialNextStep(2001);
         this.EnlistCommon();
      }
      
      protected function BtnSpeicialHeroBtnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function Btn1NextHeroClick(param1:MouseEvent) : void
      {
         if(this.FBtn1LookNextHero.currentFrameLabel == "Disable")
         {
            return;
         }
         this.FAttributeShowState = AttributeStateEnlisting;
         this.StartSwitchPage();
      }
      
      protected function HeroAttributeResetBtn2() : void
      {
      }
      
      protected function Btn2HeroUpgradeClick(param1:MouseEvent) : void
      {
         if(this.FBtn2HeroUpgrade.currentFrameLabel == "Disable")
         {
            return;
         }
         this.FAttributeShowState = AttributeStateEnlisting;
         this.StartSwitchPage();
      }
      
      protected function BtnChangeShapeClick(param1:MouseEvent) : void
      {
         if(this.FBtn3ChangeShape.currentFrameLabel == "Disable")
         {
            return;
         }
         if(this.FOnShortcutHyperlinks != null)
         {
            this.OnBtnClose();
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_CopyHero,this.FCurrentShowHero.Identifier);
         }
      }
      
      protected function HeroAttributeResetBtn3() : void
      {
         if(this.FAttributeShowState == AttributeStateAdvancedLookAdvanced)
         {
            this.FBtn3HeroUpgradeBefore.BtnLable.text = STRING_SUPERHERO.STRING_UpgradeBefore;
         }
         else
         {
            this.FBtn3HeroUpgradeBefore.BtnLable.text = STRING_SUPERHERO.STRING_UpgradeEnd;
         }
         this.FBtn3HeroUpgradeBefore.buttonModel = true;
      }
      
      protected function Btn3HeroUpgradeBeforeClick(param1:MouseEvent) : void
      {
         if(this.FBtn3HeroUpgradeBefore.currentFrameLabel == "Disable")
         {
            return;
         }
         if(this.FAttributeShowState == AttributeStateAdvancedLookAdvanced)
         {
            this.FAttributeShowState = AttributeStateAdvancedLookUnadvanced;
         }
         else
         {
            this.FAttributeShowState = AttributeStateAdvancedLookAdvanced;
         }
         this.StartSwitchPage();
      }
      
      protected function FlushBaseAttributes(param1:TSuperHero, param2:Vector.<TextField>, param3:Vector.<TextField>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TextField = null;
         _loc5_ = CONST_SUPERHERO.AttributeNum;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(AttributesIndex[_loc4_]);
            _loc7_ = param2[_loc4_];
            _loc7_.text = param1.GetBaseAttributeByIndex(_loc6_).toFixed(0);
            _loc7_ = param3[_loc4_];
            _loc7_.text = STRING_COMMON.STRING_GrowUpRate + param1.GetFirstAttributeRateByIndex(_loc6_).toFixed(1);
            _loc4_++;
         }
      }
      
      protected function GetPostion(param1:int) : int
      {
         var _loc2_:int = 0;
         if(CONST_CHARACTER.PROFESSION_Agility == param1)
         {
            _loc2_ = 2;
         }
         if(CONST_CHARACTER.PROFESSION_Defending == param1)
         {
            _loc2_ = 1;
         }
         if(CONST_CHARACTER.PROFESSION_Intellect == param1)
         {
            _loc2_ = 3;
         }
         if(CONST_CHARACTER.PROFESSION_Strength == param1)
         {
            _loc2_ = 2;
         }
         if(CONST_CHARACTER.PROFESSION_Warlock == param1)
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      protected function GetMaterialCount(param1:uint) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:int = 0;
         _loc4_ = SLogicsCore.Character.Appliances;
         _loc3_ = _loc4_.Count;
         _loc6_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc2_);
            if(_loc5_.IDTemplate == param1)
            {
               _loc6_ += _loc5_.Quantity;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      protected function HeroItem_UIDispatch(param1:MovieClip) : void
      {
         this.FTF_SiliverCoin = param1["SilverCoin"];
         this.FTF_GoldCoin = param1["Gold"];
         this.FTF_GiftCertificate = param1["GiftCertificate"];
         this.FTF_HeroSoulBlueSoul = param1["Souls1"];
         this.FTF_HeroSoulPurpleSoul = param1["Souls2"];
         this.FTF_HeroSoulGoldSoul = param1["Souls3"];
         this.FTF_HeroSoulOrangeSoul = param1["Souls4"];
      }
      
      protected function HeroItem_Location() : void
      {
      }
      
      protected function HeroItem_Update() : void
      {
         var _loc1_:TCharacter = null;
         _loc1_ = SLogicsCore.Character;
         this.FTF_SiliverCoin.text = _loc1_.CreditSilverCoin.ToString();
         this.FTF_GoldCoin.text = _loc1_.CreditGold.toString();
         this.FTF_GiftCertificate.text = _loc1_.CreditGiftCertificate.toString();
         this.FTF_HeroSoulBlueSoul.text = _loc1_.HeroSoulBlueSoul.toString();
         this.FTF_HeroSoulPurpleSoul.text = _loc1_.HeroSoulPurpleSoul.toString();
         this.FTF_HeroSoulGoldSoul.text = _loc1_.HeroSoulGoldSoul.toString();
         this.FTF_HeroSoulOrangeSoul.text = _loc1_.HeroSoulOrangeSoul.toString();
      }
      
      protected function LogicsPerform_UpdataAutoPoint() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = FUICore.StageWidth;
         _loc2_ = FUICore.StageHeight;
         if(this.FBtn_AutoPoint != null)
         {
            this.FBtn_AutoPoint.x = _loc1_;
            this.FUIHeroSelect.y = UI_InitStamp_Y + (_loc2_ - this.FUIHeroSelect.height) / 2;
            this.FUIHeroSelect_Bg.y = UI_InitStamp_Y + (_loc2_ - this.FUIHeroSelect_Bg.height) / 2;
            this.FUI_Left_Btn.y = this.FUIHeroSelect_Bg.y + 572;
            this.FUI_Right_Btn.y = this.FUIHeroSelect_Bg.y + 572;
            this.FUI_Page_TF.y = this.FUIHeroSelect_Bg.y + 578;
         }
      }
      
      protected function HeroItem_Reset() : void
      {
      }
      
      protected function Btn_UIDispatch(param1:MovieClip) : void
      {
         this.FBtn_Close = param1.mc_autoPoint["BTN_Close"];
         this.FBtn_Help = param1.mc_autoPoint["Btn_Infor"];
         this.FBtn_Add = param1["Btn_Add"];
      }
      
      protected function Btn_Location() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnBtnClose);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHelpMove);
         this.FBtn_Help.addEventListener(MouseEvent.ROLL_OUT,this.OnHelpOut);
         this.FBtn_Add.addEventListener(MouseEvent.CLICK,this.OnAddClick);
      }
      
      protected function OnBtnClose(param1:MouseEvent = null) : void
      {
         ProcessorWindowClose();
         this.Reset();
         this.FCurrentState = MouduleState_Ready;
      }
      
      public function BuyGoodsRet(param1:int) : void
      {
         if(param1 == 0)
         {
            this.HeroAttribute_FlushAttribute();
            this.HeroItem_Update();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         this.FOverlayerAppliance.Context = param2;
         this.FOverlayerAppliance.Render(FUICore.MouseCoordinate);
         this.FOverlayerAppliance.Show();
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         this.FOverlayerAppliance.Hide();
      }
      
      protected function OnHelpMove(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Context = this.FHelpHint;
         this.FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function OnHelpOut(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
      
      protected function OnAddClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function UIComponentsBtnOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:TSuperHero = null;
         _loc2_ = param1.currentTarget as TextField;
         if(this.FCurrentShowHero == null)
         {
            return;
         }
         if(_loc2_ == this.FTable2SGiftBeforAdvanced)
         {
            _loc3_ = this.FSuperHeros.GetHeroByIdentifier(this.FCurrentShowHero.RelationHeroID) as TSuperHero;
         }
         else
         {
            _loc3_ = this.FCurrentShowHero;
         }
         this.FHint.Caption = _loc3_.TalentDesc;
         this.FOverlayerHint.Context = this.FHint;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.visible = true;
      }
      
      protected function UIComponentsBtnOnOut(param1:Object) : void
      {
         this.FOverlayerHint.visible = false;
      }
      
      protected function OpenWindow(param1:TextEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = int(param1.text);
         switch(_loc2_)
         {
            case CONST_SUPERHERO.WindowID_DailyQuest:
               _loc3_ = CONST_SHORTCUTS.POSITION_Activity;
               _loc4_ = CONST_SHORTCUTS.TYPE_Activity_DailyQuest;
               break;
            case CONST_SUPERHERO.WindowID_TreasureMap:
               _loc3_ = CONST_SHORTCUTS.POSITION_Activity;
               _loc4_ = CONST_SHORTCUTS.TYPE_Activity_TreasureMap;
               break;
            case CONST_SUPERHERO.WindowID_Mall:
               _loc3_ = CONST_SHORTCUTS.POSITION_Activity;
               _loc4_ = CONST_SHORTCUTS.TYPE_Activity_Mall;
         }
         if(this.FOnShortcutHyperlinks != null)
         {
            this.OnBtnClose();
            this.FOnShortcutHyperlinks(this,_loc3_,_loc4_);
         }
      }
      
      public function set ResultCode(param1:int) : void
      {
         this.FResultCode = param1;
      }
      
      public function set OnEnlist(param1:Function) : void
      {
         this.FOnEnlist = param1;
      }
      
      public function set OnBuyGoods(param1:Function) : void
      {
         this.FOnBuyGoods = param1;
      }
      
      public function set OnEnlistSuccess(param1:Function) : void
      {
         this.FOnEnlistSuccess = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function set OnEffectGenerateText(param1:Function) : void
      {
         this.FOnEffectGenerateText = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:THero = null;
         var _loc2_:THero = null;
         var _loc3_:TSuperHero = null;
         switch(this.FCurrentState)
         {
            case MouduleState_Ready:
               this.FCurrentState = MouduleState_Runing;
               this.SetupUIPage(this.FHerosState.length,0);
               this.HeroSelect_Update();
               this.HeroItem_Update();
               this.FCurrentSelectFlag = this.FMC_SelectFlags[0];
               this.FCurrentSelectFlag.visible = true;
               this.HeroClickedManual();
               break;
            case MouduleState_Runing:
               this.HeroSelect_Update();
               this.HeroItem_Update();
               this.HeroAttribute_FlushAttribute();
               if(this.FCurrentSelectFlag != null)
               {
                  this.FCurrentSelectFlag.visible = true;
               }
               break;
            case MouduleState_WaitEnlist:
               this.FCurrentState = MouduleState_Ready;
               if(this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_ENLIST)
               {
                  _loc1_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(this.FSelectedHero.Identifier);
                  _loc3_ = this.FSuperHeros.GetHeroByIdentifier(_loc1_.Identifier) as TSuperHero;
                  _loc2_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(_loc3_.RelationHeroID);
                  _loc2_.FightPosition = _loc1_.FightPosition;
                  SLogicsCore.Character.Heros.Delete(_loc1_);
               }
               this.HeroSelect_Update();
               if(this.FSelectHeroState == CONST_SUPERHERO.HEROSTATE_ENLIST)
               {
                  this.FSelectedHero = this.FSuperHeros.GetHeroByIdentifier(this.FSelectedHero.RelationHeroID) as TSuperHero;
               }
               this.FSelectHeroState = this.GetHeroState(this.FSelectedHero);
               this.HeroAttribute_Update();
               this.HeroItem_Update();
               if(this.FOnEnlistSuccess != null)
               {
                  this.FOnEnlistSuccess(this,this.FSelectedHero.Identifier);
               }
         }
      }
      
      public function SlotReset() : void
      {
         if(this.FTable2SlotItem)
         {
            this.FTable2SlotItem.Context = null;
         }
         if(this.FBtn1ItemNeedSlot)
         {
            this.FBtn1ItemNeedSlot.Context = null;
         }
      }
      
      protected function SkillShow(param1:MouseEvent) : void
      {
         if(TProcessorLobby.SkillShowTimeFunction != null)
         {
            TProcessorLobby.SkillShowTimeFunction(this.FCurHeroId);
         }
      }
   }
}

