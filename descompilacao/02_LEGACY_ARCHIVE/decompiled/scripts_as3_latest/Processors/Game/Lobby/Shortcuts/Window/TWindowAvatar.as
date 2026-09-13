package Processors.Game.Lobby.Shortcuts.Window
{
   import Externals.SExternalCore;
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Agent.SParametersCore;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Pet.*;
   import Logics.Signals.TSignal;
   import Logics.Vip.TVip;
   import Processors.Game.Battle.Effect.TEffectControl;
   import Processors.Game.Common.Effects.Display.TEffectBaseFlicker;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Common.Effects.Texts.TEffectTextParameters;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TWindowAvatar extends TUIComponent
   {
      
      protected static const SIZE_Avatar_Width:int = 393;
      
      protected static const SIZE_Avatar_Height:int = 225;
      
      protected static const SHINE_TIME:int = 60 * 1000;
      
      protected static const CAPACITY_Credits:int = CONST_CHARACTER.CAPACITY_Credits - 3;
      
      protected static const CREDITINDEX_Gold:int = CONST_CHARACTER.CREDITINDEX_Gold;
      
      protected static const CREDITINDEX_SilverCoin:int = CONST_CHARACTER.CREDITINDEX_SilverCoin;
      
      protected static const CREDITINDEX_GiftCertificate:int = CONST_CHARACTER.CREDITINDEX_GiftCertificate;
      
      protected static const CHARACTER_BaseModeID:uint = CONST_CHARACTER.CHARACTER_BaseModeID;
      
      protected static const INDEX_ProgressBarMilitaryOrder:uint = 2;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected static const FORMAT_BuyMilitaryOrders01:String = STRING_SHORTCUTS.FORMAT_BuyMilitaryOrders01;
      
      protected static const FORMAT_BuyMilitaryOrders02:String = STRING_SHORTCUTS.FORMAT_BuyMilitaryOrders02;
      
      public static const FORMAT_SilverCoin:String = STRING_SHORTCUTS.FORMAT_SilverCoin;
      
      public static const FORMAT_Gold:String = STRING_SHORTCUTS.FORMAT_Gold;
      
      public static const FORMAT_GiftCertificate:String = STRING_SHORTCUTS.FORMAT_GiftCertificate;
      
      public static const KEY_COUNTER_MilitaryOrdersLimit:uint = CONST_COUNTER.KEY_COUNTER_MilitaryOrdersLimit;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 4;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var FCharacter:TCharacter;
      
      protected var FMC_Avatar:Sprite;
      
      protected var FMC_AutoBattle:MovieClip;
      
      protected var FMC_Group:Sprite;
      
      protected var FMC_Country:MovieClip;
      
      protected var FMC_HeadPortrait:MovieClip;
      
      protected var FMC_ProgressBarMilitaryOrder:Sprite;
      
      protected var FMC_MilitaryOrderBuff:MovieClip;
      
      protected var FTF_Nickname:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_MilitaryOrders:TextField;
      
      protected var FBtn_MilitaryOrders:SimpleButton;
      
      protected var FBtn_VIP:MovieClip;
      
      protected var FBtn_ConsumeVip:MovieClip;
      
      protected var FTF_VIPCaption:TextField;
      
      protected var FTF_ConsumeVip:TextField;
      
      protected var FBtn_Recharge:SimpleButton;
      
      protected var FMC_FightingPower:MovieClip;
      
      protected var FTF_FightingPower:TextField;
      
      protected var FMC_Promote:MovieClip;
      
      protected var FSilverCoin:UInt64;
      
      protected var FTFCredits:Vector.<TextField>;
      
      protected var FEffectFlickerCredits:Vector.<TEffectBaseFlicker>;
      
      protected var FMC_Pet:Sprite;
      
      protected var FTF_PetName:TextField;
      
      protected var FTF_PetStarLevel:TextField;
      
      protected var FPetImage:Sprite;
      
      protected var FPetBitmap:Bitmap;
      
      protected var FMC_EffectNinjaLevel:MovieClip;
      
      protected var FPetTextureID:uint;
      
      protected var FIsStarLoader:Boolean;
      
      protected var FTotalFightingPower:Number;
      
      protected var FFightingPower:Number;
      
      protected var FHintCharacter:THint;
      
      protected var FHintSilverCoin:THint;
      
      protected var FHintGold:THint;
      
      protected var FHintGiftCertificate:THint;
      
      protected var FHintMilitaryOrders:THint;
      
      protected var FHintBtnMilitaryOrders:THint;
      
      protected var FHintMilitaryOrdersBuff:THint;
      
      protected var FHintMCPet:THint;
      
      protected var FOnHead:Function;
      
      protected var FOnSummonPet:Function;
      
      protected var FOnVIP:Function;
      
      protected var FWelfareOnClick:Function;
      
      protected var FObligatoryCoursesOnClick:Function;
      
      protected var FBaiDuMeimei:Function;
      
      protected var FOhtsutsukiKaguya:Function = null;
      
      protected var FVkClickFunction:Function = null;
      
      protected var FMC_1377ClickFun:Function = null;
      
      protected var FRankIconClick:Function;
      
      protected var FOnVipClickFun:Function;
      
      protected var FOnMicrologin:Function;
      
      protected var FOnConsumeVip:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHelpHintOnMove:Function;
      
      protected var FHelpHintOnOut:Function;
      
      protected var FKaguyaOnOver:Function;
      
      protected var FKaguyaOnOut:Function;
      
      protected var FOnEffectGenerateText:Function;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FOrderPerBuyValue:uint;
      
      protected var FOrderBuyGold:Vector.<uint>;
      
      protected var FVipData:TVip;
      
      protected var FVipLevel:uint;
      
      protected var FCounterMilitaryOrdersLimit:uint;
      
      protected var FEffectBaseGlowVIP:TEffectBaseGlow;
      
      protected var FEffectBaseGlowSVIP:TEffectBaseGlow;
      
      protected var FMC_FightingEffect:MovieClip;
      
      protected var FWidth:int;
      
      protected var FHeight:int;
      
      protected var FIsInitialization:Boolean;
      
      protected var FTextParameters:TEffectTextParameters;
      
      protected var FHelpHint:THint;
      
      protected var FIsPlayed:Boolean;
      
      protected var FIsShow:Boolean;
      
      protected var FTotleTime:uint;
      
      protected var FHelpStr:String;
      
      protected var FMC_Prerogative:MovieClip;
      
      protected var FMC_AccountSecure:MovieClip;
      
      protected var FPlatformID:TPlatformID;
      
      protected var FMC_ObligatoryCourses:MovieClip;
      
      protected var FBaiDuMeimeiMc:MovieClip = null;
      
      protected var FMC_OhtsutsukiKaguya:MovieClip = null;
      
      protected var TF_OhtsutsukiKaguya:TextField = null;
      
      protected var MC_MC_Kaguya:MovieClip = null;
      
      protected var FBTN_FullScreen:MovieClip;
      
      protected var FBTN_NormalScreen:MovieClip;
      
      protected var FIsShine:Boolean;
      
      protected var FGlowFilter:TEffectBaseGlowTwo;
      
      protected var FGlowFilter2:TEffectBaseGlowTwo;
      
      protected var FMC_VKSiMiDa:MovieClip;
      
      protected var FLevelVector:Vector.<uint>;
      
      protected var FMC_1377Icon:MovieClip;
      
      protected var FMC_OnlineGiftfather:MovieClip;
      
      protected var FMC_OnlineGift:SimpleButton;
      
      protected var FTF_DaoJiShi:TextField;
      
      protected var FMC_RankIcon:MovieClip;
      
      protected var FMC_Vip:MovieClip;
      
      protected var FEffectsBaseGlowBtn:TEffectBaseGlow;
      
      protected var FBTN_AccountLock:MovieClip;
      
      protected var FNeedVipLevel:int;
      
      protected var FPlatIdVector:Vector.<uint>;
      
      protected var FMC_MicroLogin:MovieClip;
      
      protected var FBTN_MicroLogin:SimpleButton;
      
      protected var FOnPromote:Function;
      
      protected var FOnEnterAutoBattle:Function;
      
      protected var FOpenOnLineGift:Function;
      
      public var AccountLockOnClick:Function;
      
      protected var FOnlineGiftKaiGuan:uint;
      
      protected var FOnlineGiftOpenLevel:uint;
      
      protected var IsPlayer:Boolean;
      
      protected var FRankOpenLevel:int;
      
      public function TWindowAvatar(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FSilverCoin = new UInt64();
         this.FTFCredits = new Vector.<TextField>(CAPACITY_Credits);
         this.FEffectFlickerCredits = new Vector.<TEffectBaseFlicker>(CAPACITY_Credits);
         this.FPetBitmap = new Bitmap();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         this.FUIWindowConfirmation.OnOK = this.OnBuyMilitary;
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         this.FHintCharacter = new THint();
         this.FHintSilverCoin = new THint();
         this.FHintGold = new THint();
         this.FHintGiftCertificate = new THint();
         this.FHintMilitaryOrders = new THint();
         this.FHintBtnMilitaryOrders = new THint();
         this.FHintMilitaryOrdersBuff = new THint();
         this.FHintMCPet = new THint();
         this.FTextParameters = new TEffectTextParameters();
         this.FVipData = this.FCharacter.VipData;
         this.FVipLevel = this.FCharacter.VipLevel;
         this.FCounterMilitaryOrdersLimit = 0;
         this.FHelpHint = new THint();
         this.FWidth = 0;
         this.FHeight = 0;
         this.FIsInitialization = false;
         this.FIsPlayed = false;
         this.FFightingPower = 0;
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Sprite = null;
         var _loc3_:TConfigValue = null;
         var _loc4_:TEffectBaseFlicker = null;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FMC_Avatar = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHORTCUTS.RESOURCE_ClassName_Avatar) as Sprite;
         addChild(this.FMC_Avatar);
         this.FMC_AutoBattle = this.FMC_Avatar["mc_autoBattle"];
         if(this.FMC_AutoBattle != null)
         {
            this.FMC_AutoBattle.visible = false;
            TGameUtil.setButtonMode(this.FMC_AutoBattle.btn_look,true);
            this.FMC_AutoBattle.btn_look.addEventListener(MouseEvent.CLICK,this.OnLookAutoBattle);
         }
         this.FMC_EffectNinjaLevel = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_ClassName_MC_EffectNinjaLevel];
         addChild(this.FMC_EffectNinjaLevel);
         this.FMC_EffectNinjaLevel.mouseEnabled = false;
         this.FMC_EffectNinjaLevel.visible = false;
         this.FMC_Group = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_Group];
         this.FMC_Group.mouseEnabled = false;
         this.FMC_Country = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_Country];
         this.FMC_Country.mouseEnabled = false;
         this.FMC_Country.visible = false;
         this.FMC_HeadPortrait = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_HeadPortrait];
         this.FMC_ProgressBarMilitaryOrder = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_ProgressBarMilitaryOrder];
         this.FMC_MilitaryOrderBuff = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_MilitaryOrderBuff];
         this.FTF_Nickname = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_TF_Nickname];
         this.FTF_Level = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_TF_Level];
         this.FTF_Level.mouseEnabled = false;
         _loc2_ = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_PanelCredits];
         this.TFCreditSilverCoin = _loc2_[CONST_SHORTCUTS.RESOURCE_Link_TF_SilverCoin];
         this.TFCreditGold = _loc2_[CONST_SHORTCUTS.RESOURCE_Link_TF_Gold];
         this.TFCreditGiftCertificate = _loc2_[CONST_SHORTCUTS.RESOURCE_Link_TF_GiftCertificate];
         this.FBtn_Recharge = _loc2_[CONST_SHORTCUTS.RESOURCE_Link_Btn_Recharge];
         this.FMC_OnlineGiftfather = _loc2_["MC_OnlineGift"];
         if(this.FMC_OnlineGiftfather)
         {
            this.FMC_OnlineGift = this.FMC_OnlineGiftfather["MC_OnlineGift"];
            this.FTF_DaoJiShi = this.FMC_OnlineGiftfather["TF_DaoJiShi"];
            this.FMC_OnlineGiftfather.visible = false;
         }
         this.FTF_MilitaryOrders = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_TF_MilitaryOrders];
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_Credits)
         {
            _loc4_ = new TEffectBaseFlicker();
            this.FEffectFlickerCredits[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FBtn_MilitaryOrders = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_Btn_MilitaryOrders];
         this.FBtn_VIP = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_Btn_VIP];
         TGameUtil.setMovieClipButton(this.FBtn_VIP,true,false);
         this.FTF_VIPCaption = this.FBtn_VIP[CONST_SHORTCUTS.RESOURCE_Link_TF_VipCaption];
         this.FTF_VIPCaption.mouseEnabled = false;
         this.FBtn_ConsumeVip = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_Btn_ConsumeVIP];
         TGameUtil.setButtonMode(this.FBtn_ConsumeVip,true);
         this.FTF_ConsumeVip = this.FBtn_ConsumeVip[CONST_SHORTCUTS.RESOURCE_Link_TF_VipCaption];
         this.FMC_FightingPower = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_FightingCapacity];
         this.FTF_FightingPower = this.FMC_FightingPower[CONST_SHORTCUTS.RESOURCE_Link_TF_FightingPower];
         this.FTF_FightingPower.text = "0";
         this.FMC_Promote = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_Promote];
         TGameUtil.setButtonMode(this.FMC_Promote,true);
         this.FMC_Promote.mouseEnabled = true;
         this.FMC_FightingEffect = this.FMC_Avatar[CONST_SHORTCUTS.RESOURCE_Link_MC_FightingEffect];
         this.FMC_FightingEffect.mouseEnabled = false;
         this.FHintCharacter.Caption = STRING_SHORTCUTS.CAPTION_Character;
         this.FHintMilitaryOrders.Caption = STRING_SHORTCUTS.CAPTION_MilitaryOrders;
         this.FHintMCPet.Caption = STRING_SHORTCUTS.CAPTION_Pet;
         this.FMC_Pet = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHORTCUTS.RESOURCE_ClassName_Pet) as Sprite;
         addChild(this.FMC_Pet);
         this.FMC_Pet.visible = false;
         this.FMC_Pet.mouseChildren = false;
         this.FMC_Pet.buttonMode = true;
         this.FMC_Pet.x = 0;
         this.FMC_Pet.y = this.FMC_Avatar.height - 15;
         this.FTF_PetName = this.FMC_Pet[CONST_SHORTCUTS.RESOURCE_Link_TF_PetName];
         this.FTF_PetStarLevel = this.FMC_Pet[CONST_SHORTCUTS.RESOURCE_Link_TF_PetStarLevel];
         this.FPetImage = this.FMC_Pet[CONST_SHORTCUTS.RESOURCE_Link_MC_Icon];
         this.FPetImage.addChild(this.FPetBitmap);
         this.FMC_Prerogative = this.FMC_Avatar["MC_Prerogative"];
         this.FMC_Prerogative.visible = false;
         this.FMC_Avatar["MC_PlatformEffect"].visible = false;
         this.FMC_Avatar["MC_PlatformEffect"].gotoAndStop(1);
         this.FMC_RankIcon = this.FMC_Avatar["MC_Rank"];
         this.FMC_RankIcon.visible = false;
         this.FMC_Vip = this.FMC_Avatar["MC_vip"];
         this.FMC_Vip.visible = false;
         this.FMC_AccountSecure = this.FMC_Avatar["MC_AccountSecure"];
         if(this.FMC_AccountSecure)
         {
            this.FMC_AccountSecure.visible = false;
            this.FMC_AccountSecure.addEventListener(MouseEvent.CLICK,this.MCAccountSecureOnClick,false,0,true);
         }
         this.FMC_ObligatoryCourses = this.FMC_Avatar["MC_ObligatoryCourses"];
         this.FMC_ObligatoryCourses.visible = false;
         this.FBaiDuMeimeiMc = this.FMC_Avatar["MC_BaiDuSuperVip"];
         this.FMC_OhtsutsukiKaguya = this.FMC_Avatar["MC_OhtsutsukiKaguya"];
         this.MC_MC_Kaguya = this.FMC_Avatar["MC_Kaguya"];
         this.TF_OhtsutsukiKaguya = this.MC_MC_Kaguya["TF_OhtsutsukiKaguya"];
         this.FMC_VKSiMiDa = this.FMC_Avatar["MC_VKSiMiDa"];
         if(this.FMC_VKSiMiDa)
         {
            this.FMC_VKSiMiDa.visible = false;
            TGameUtil.setButtonMode(this.FMC_VKSiMiDa,true);
         }
         this.FMC_1377Icon = this.FMC_Avatar["MC_1377Icon"];
         if(this.FMC_1377Icon)
         {
            this.FMC_1377Icon.visible = false;
            this.FGlowFilter2 = new TEffectBaseGlowTwo();
            this.FGlowFilter2.SetParameters(this.FMC_1377Icon,FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowFilter2.IsRunOver = false;
         }
         this.FMC_OhtsutsukiKaguya.visible = false;
         this.MC_MC_Kaguya.visible = false;
         TGameUtil.setButtonMode(this.FMC_OhtsutsukiKaguya,true);
         TGameUtil.setButtonMode(this.FBaiDuMeimeiMc,true);
         this.FBTN_FullScreen = this.FMC_Avatar["BTN_FullScreen"];
         this.FBTN_NormalScreen = this.FMC_Avatar["BTN_NormalScreen"];
         if(Boolean(this.FBTN_NormalScreen) && Boolean(this.FBTN_FullScreen))
         {
            TGameUtil.setButtonMode(this.FBTN_FullScreen,true);
            TGameUtil.setButtonMode(this.FBTN_NormalScreen,true);
            this.FBTN_FullScreen.visible = true;
            this.FBTN_NormalScreen.visible = false;
            setTimeout(this.SetBtnShine,SHINE_TIME);
            FUICore.UIStage.addEventListener(KeyboardEvent.KEY_DOWN,this.UIStageOnKeyDown);
            this.FGlowFilter = new TEffectBaseGlowTwo();
            this.FGlowFilter.SetParameters(this.FBTN_FullScreen,FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowFilter.IsRunOver = false;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ORDER_PER_BUY_VALUE) as TConfigValue;
         this.FOrderPerBuyValue = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ORDER_BUY_GOLD) as TConfigValue;
         this.FOrderBuyGold = _loc3_.Value as Vector.<uint>;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.OhtsutsukiKaguya_Openlevel) as TConfigValue;
         SLogicsCore.KaguyaData.OpenLevel = _loc3_.Value as uint;
         SLogicsCore.KaguyaData.TNPowerConfig = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerConfig) as TBins;
         SLogicsCore.KaguyaData.NPowerPrivilege = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NightPowerPrivilege) as TBins;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ORDER_BUY_MaxValue) as TConfigValue;
         if(_loc3_)
         {
            this.FCharacter.XingDongLiMaxValue = _loc3_.Value as uint;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380012) as TConfigValue;
         if(_loc3_)
         {
            this.FLevelVector = _loc3_.Value as Vector.<uint>;
         }
         this.ShowOrHideBtn();
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000001) as TConfigValue;
         this.FOnlineGiftOpenLevel = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000002) as TConfigValue;
         this.FOnlineGiftKaiGuan = _loc3_.Value as uint;
         this.FEffectsBaseGlowBtn = new TEffectBaseGlow();
         this.FEffectsBaseGlowBtn.SetParameters(this.FMC_OhtsutsukiKaguya,15911245,1);
         this.FEffectsBaseGlowBtn.visible = false;
         SExternalCore.ChangeScreenSize = this.NormalScreenOnClick;
         this.FBTN_AccountLock = this.FMC_Avatar["BTN_AccountLock"];
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91000022) as TConfigValue;
         if(Boolean(this.FBTN_AccountLock) && Boolean(_loc3_))
         {
            TGameUtil.setButtonMode(this.FBTN_AccountLock,true);
            this.FBTN_AccountLock.visible = _loc3_.Value == 0 ? false : true;
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91700002) as TConfigValue;
         this.FRankOpenLevel = _loc3_.Value as int;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380117) as TConfigValue;
         this.FNeedVipLevel = _loc3_.Value as int;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380116) as TConfigValue;
         this.FPlatIdVector = _loc3_.Value as Vector.<uint>;
         this.FMC_MicroLogin = this.FMC_Avatar["MC_Micrologin"];
         this.FBTN_MicroLogin = this.FMC_MicroLogin["MC_Micrologin"];
         this.FMC_MicroLogin.visible = false;
      }
      
      protected function ISVK() : void
      {
         if(Boolean(this.FMC_VKSiMiDa) && Boolean(SParametersCore.Isvk))
         {
            if(SLogicsCore.Character.GetMainLevel() >= this.FLevelVector[0])
            {
               this.FMC_VKSiMiDa.visible = true;
            }
         }
         if(Boolean(this.FMC_1377Icon) && Boolean(SParametersCore.Is1377Display))
         {
            this.FMC_1377Icon.visible = true;
         }
      }
      
      public function IsShowOhtsutsukiKaguya() : void
      {
         if(this.IsPlayer)
         {
            this.PlayerOhtsutsukiKaguyaEffect();
         }
         else if(SLogicsCore.Character.GetMainLevel() >= SLogicsCore.KaguyaData.OpenLevel)
         {
            this.FMC_OhtsutsukiKaguya.visible = true;
            this.MC_MC_Kaguya.visible = true;
         }
         else
         {
            this.FMC_OhtsutsukiKaguya.visible = false;
            this.MC_MC_Kaguya.visible = false;
         }
         this.ISVK();
      }
      
      protected function FMC_OnlineGiftClick(param1:MouseEvent) : void
      {
         if(this.FOpenOnLineGift != null)
         {
            this.FOpenOnLineGift();
         }
      }
      
      public function IconIsShow(param1:Boolean) : void
      {
         if(!this.FOnlineGiftKaiGuan)
         {
            this.FMC_OnlineGiftfather.visible = false;
            return;
         }
         if(this.FOnlineGiftOpenLevel > SLogicsCore.Character.GetMainLevel())
         {
            this.FMC_OnlineGiftfather.visible = false;
            return;
         }
         if(!param1)
         {
            this.FMC_OnlineGiftfather.visible = false;
            return;
         }
         this.FMC_OnlineGiftfather.visible = true;
      }
      
      public function MiIconIsShow(param1:Boolean) : void
      {
         this.FMC_MicroLogin.visible = param1;
      }
      
      public function SetBtnShine() : void
      {
         this.FGlowFilter.IsRunOver = true;
      }
      
      protected function Logic_Time() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(this.FMC_OhtsutsukiKaguya)
         {
            if(this.FMC_OhtsutsukiKaguya.visible)
            {
               if(SLogicsCore.KaguyaData.OpenState == 0)
               {
                  this.TF_OhtsutsukiKaguya.text = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_03;
               }
               else if(SLogicsCore.KaguyaData.IsLongTime == 7)
               {
                  this.TF_OhtsutsukiKaguya.text = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_04;
               }
               else
               {
                  this.TF_OhtsutsukiKaguya.text = TGameUtil.fomatTime_Copy(SLogicsCore.KaguyaData.EndTime - STimingCore.GetServerTick());
               }
            }
         }
         if(Boolean(this.FMC_OnlineGiftfather) && this.FMC_OnlineGiftfather.visible)
         {
            _loc1_ = STimingCore.GetServerTick() + SLogicsCore.ZhenAoYiLogicData.OnLineGiftCurTime;
            _loc1_ = SLogicsCore.ZhenAoYiLogicData.OnLineGiftTime - _loc1_;
            if(_loc1_ > 0)
            {
               _loc2_ = TGameUtil.fomatTime(_loc1_);
            }
            else
            {
               _loc2_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_26).DescribeString;
            }
            this.FTF_DaoJiShi.text = _loc2_;
         }
         if(Boolean(this.FMC_MicroLogin) && this.FMC_MicroLogin.visible)
         {
            _loc1_ = STimingCore.GetServerTick() + SLogicsCore.ZhenAoYiLogicData.OnMiLineGiftCurTime;
            _loc1_ = SLogicsCore.ZhenAoYiLogicData.OnMiLineGiftTime - _loc1_;
            if(_loc1_ > 0)
            {
               _loc2_ = TGameUtil.fomatTime(_loc1_);
            }
            else
            {
               _loc2_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_26).DescribeString;
            }
            this.FMC_MicroLogin["TF_DaoJiShi"].text = _loc2_;
         }
      }
      
      protected function UpdateShine() : void
      {
         if(Boolean(this.FBTN_FullScreen) && Boolean(this.FGlowFilter))
         {
            if(!this.FGlowFilter.IsRunOver)
            {
               this.FGlowFilter.Run();
            }
            else
            {
               this.FGlowFilter.Stop();
            }
            if(stage.displayState == StageDisplayState.NORMAL)
            {
               this.FBTN_NormalScreen.visible = false;
               this.FBTN_FullScreen.visible = true;
            }
            else
            {
               this.FBTN_NormalScreen.visible = true;
               this.FBTN_FullScreen.visible = false;
            }
         }
         if(Boolean(this.FMC_1377Icon) && Boolean(SParametersCore.Is1377Display))
         {
            if(!SParametersCore.PassWord1377 || SParametersCore.PassWord1377 == "")
            {
               if(!this.FGlowFilter2.IsRunOver)
               {
                  this.FGlowFilter2.Run();
               }
            }
            else if(this.FGlowFilter2.IsRunOver)
            {
               this.FGlowFilter2.Stop();
            }
         }
         if(this.FMC_OhtsutsukiKaguya)
         {
            if(Boolean(SLogicsCore.KaguyaData) && Boolean(SLogicsCore.KaguyaData.CheckStatus()))
            {
               this.FEffectsBaseGlowBtn.Run();
               this.FEffectsBaseGlowBtn.visible = true;
            }
            else
            {
               this.FEffectsBaseGlowBtn.Stop();
               this.FEffectsBaseGlowBtn.visible = false;
            }
         }
      }
      
      public function MainHeroUpLevel() : void
      {
         this.IsPlayer = false;
         if(SLogicsCore.Character.GetMainLevel() == SLogicsCore.KaguyaData.OpenLevel)
         {
            if(SLogicsCore.Character.RoleSencePosition == CONST_COMMON.SCENEPOSITION_MAINCITY)
            {
               this.PlayerOhtsutsukiKaguyaEffect();
            }
            else
            {
               this.IsPlayer = true;
            }
         }
         this.ISVK();
      }
      
      protected function PlayerOhtsutsukiKaguyaEffect() : void
      {
         var _loc1_:int = this.FMC_OhtsutsukiKaguya.x;
         var _loc2_:int = this.FMC_OhtsutsukiKaguya.y;
         this.MC_MC_Kaguya.visible = true;
         this.FMC_OhtsutsukiKaguya.visible = true;
         this.FMC_OhtsutsukiKaguya.x = (FUICore.StageWidth - this.FMC_OhtsutsukiKaguya.x - this.FMC_OhtsutsukiKaguya.width) / 2;
         this.FMC_OhtsutsukiKaguya.y = (FUICore.StageHeight - this.FMC_OhtsutsukiKaguya.y - this.FMC_OhtsutsukiKaguya.height) / 2;
         TEffectControl.ShowMoveEffect(this.FMC_OhtsutsukiKaguya,_loc1_,_loc2_,400,this.EndBigEffect);
      }
      
      public function EndBigEffect(param1:Object) : void
      {
      }
      
      protected function ShowOrHideBtn() : void
      {
         if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_BAIDU)
         {
            this.setFBaiDuMeimeiMcState(true);
         }
         else
         {
            this.setFBaiDuMeimeiMcState(false);
         }
      }
      
      protected function OnCheckOpenRankIcon() : void
      {
         if(this.FMC_RankIcon.visible)
         {
            return;
         }
         if(this.FRankOpenLevel <= SLogicsCore.Character.GetMainLevel())
         {
            this.FMC_RankIcon.visible = true;
            return;
         }
      }
      
      protected function UpdateVipIsshow() : void
      {
         if(this.FIsInitialization)
         {
            if(this.FCharacter.VipLevel >= this.FNeedVipLevel && this.FPlatIdVector.indexOf(SParametersCore.AgentID) >= 0)
            {
               this.FMC_Vip.visible = true;
            }
         }
      }
      
      protected function Resources_UILocations() : void
      {
         var _loc1_:TSystemLanguage = null;
         this.FMC_Promote.addEventListener(MouseEvent.CLICK,this.ButtonPromoteOnClick,false,0,true);
         this.TFCreditSilverCoin.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_SilverCoinOnMove,false,0,true);
         this.TFCreditSilverCoin.addEventListener(MouseEvent.MOUSE_OUT,this.TF_CreditOnOut,false,0,true);
         this.TFCreditGold.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_GoldOnMove,false,0,true);
         this.TFCreditGold.addEventListener(MouseEvent.MOUSE_OUT,this.TF_CreditOnOut,false,0,true);
         this.TFCreditGiftCertificate.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_GiftCertificateOnMove,false,0,true);
         this.TFCreditGiftCertificate.addEventListener(MouseEvent.MOUSE_OUT,this.TF_CreditOnOut,false,0,true);
         this.FTF_MilitaryOrders.addEventListener(MouseEvent.MOUSE_MOVE,this.TF_MilitaryOrdersOnMove,false,0,true);
         this.FMC_HeadPortrait.buttonMode = true;
         this.FMC_HeadPortrait.addEventListener(MouseEvent.CLICK,this.HeadOnMouseClick,false,0,true);
         this.FMC_HeadPortrait.addEventListener(MouseEvent.MOUSE_MOVE,this.MC_HeadPortraitOnMove,false,0,true);
         this.FMC_HeadPortrait.addEventListener(MouseEvent.MOUSE_OUT,this.MC_HeadPortraitOnOut,false,0,true);
         this.FTF_MilitaryOrders.addEventListener(MouseEvent.MOUSE_OUT,this.TFMilitaryOrdersOnOut,false,0,true);
         this.FBtn_MilitaryOrders.addEventListener(MouseEvent.CLICK,this.BtnMilitaryOrdersOnClick,false,0,true);
         this.FBtn_MilitaryOrders.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnMilitaryOrdersOnMove,false,0,true);
         this.FBtn_MilitaryOrders.addEventListener(MouseEvent.MOUSE_OUT,this.BtnMilitaryOrdersOnOut,false,0,true);
         this.FMC_MilitaryOrderBuff.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnMilitaryOrdersBuffOnMove,false,0,true);
         this.FMC_MilitaryOrderBuff.addEventListener(MouseEvent.MOUSE_OUT,this.BtnMilitaryOrdersBuffOnOut,false,0,true);
         this.FBtn_VIP.addEventListener(MouseEvent.CLICK,this.BtnVIPOnClick,false,0,true);
         this.FBtn_ConsumeVip.addEventListener(MouseEvent.CLICK,this.OnConsumeVIPClick,false,0,true);
         this.FBtn_Recharge.addEventListener(MouseEvent.CLICK,this.BtnRechargeOnClick,false,0,true);
         this.FMC_Prerogative.addEventListener(MouseEvent.CLICK,this.MCPrerogativeOnClick,false,0,true);
         this.FMC_RankIcon.addEventListener(MouseEvent.CLICK,this.MCRankIconOnClick,false,0,true);
         this.FMC_Vip.addEventListener(MouseEvent.CLICK,this.OnVipClick,false,0,true);
         this.FMC_ObligatoryCourses.addEventListener(MouseEvent.CLICK,this.MCObligatoryCoursesOnClick,false,0,true);
         this.FBaiDuMeimeiMc.addEventListener(MouseEvent.CLICK,this.BaiDuMMqqClick,false,0,true);
         this.FMC_OhtsutsukiKaguya.addEventListener(MouseEvent.CLICK,this.OhtsutsukiKaguyaClick);
         this.FMC_OhtsutsukiKaguya.addEventListener(MouseEvent.MOUSE_MOVE,this.KaguyaOnMove);
         this.FMC_OhtsutsukiKaguya.addEventListener(MouseEvent.MOUSE_OUT,this.KOut);
         if(this.FMC_VKSiMiDa)
         {
            this.FMC_VKSiMiDa.addEventListener(MouseEvent.CLICK,this.VKClick);
         }
         if(this.FMC_1377Icon)
         {
            this.FMC_1377Icon.addEventListener(MouseEvent.CLICK,this.MC_1377Click);
         }
         this.FMC_Pet.addEventListener(MouseEvent.CLICK,this.MCPetOnClick,false,0,true);
         this.FMC_Pet.addEventListener(MouseEvent.MOUSE_MOVE,this.MCPetOnMove,false,0,true);
         this.FMC_Pet.addEventListener(MouseEvent.MOUSE_OUT,this.MCPetOnOut,false,0,true);
         this.FMC_FightingPower.addEventListener(MouseEvent.MOUSE_MOVE,this.MCFightingPowerOnMove,false,0,true);
         this.FMC_FightingPower.addEventListener(MouseEvent.MOUSE_OUT,this.MCFightingPowerOnOut,false,0,true);
         this.FMC_OnlineGift.addEventListener(MouseEvent.CLICK,this.FMC_OnlineGiftClick,false,0,true);
         if(this.FBTN_FullScreen)
         {
            this.FBTN_FullScreen.addEventListener(MouseEvent.CLICK,this.FullScreenOnClick,false,0,true);
            this.FBTN_FullScreen.addEventListener(MouseEvent.MOUSE_MOVE,this.FullScreenOnOver,false,0,true);
            this.FBTN_FullScreen.addEventListener(MouseEvent.ROLL_OUT,this.FullScreenOnOut,false,0,true);
         }
         if(this.FBTN_NormalScreen)
         {
            this.FBTN_NormalScreen.addEventListener(MouseEvent.CLICK,this.NormalScreenOnClick,false,0,true);
            this.FBTN_NormalScreen.addEventListener(MouseEvent.MOUSE_MOVE,this.NormalScreenOnOver,false,0,true);
            this.FBTN_NormalScreen.addEventListener(MouseEvent.ROLL_OUT,this.NormalScreenOnOut,false,0,true);
         }
         if(this.FBTN_AccountLock)
         {
            this.FBTN_AccountLock.addEventListener(MouseEvent.CLICK,this.ProcessorAccountLockOnClick,false,0,true);
         }
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.TOTALFIGHTPOINT_INTRO) as TSystemLanguage;
         this.FHelpStr = _loc1_.Desc;
      }
      
      protected function Reset() : void
      {
         this.FTF_Nickname.text = "";
         this.FTF_Level.text = "0";
         this.TFCreditSilverCoin.text = "0";
         this.TFCreditGold.text = "0";
         this.TFCreditGiftCertificate.text = "0";
         this.FTF_MilitaryOrders.text = "0/0";
      }
      
      protected function LogicsPerform_CreditsEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:UInt64 = null;
         var _loc6_:TEffectBaseFlicker = null;
         if(this.FIsInitialization)
         {
            _loc2_ = CAPACITY_Credits;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc6_ = this.FEffectFlickerCredits[_loc1_];
               if(_loc1_ == CREDITINDEX_SilverCoin)
               {
                  _loc5_ = this.FSilverCoin;
                  if(_loc5_.ToNumber() != this.FCharacter.CreditSilverCoin.ToNumber() && _loc6_.IsRunOver)
                  {
                     if(this.FCharacter.CreditSilverCoin.ToNumber() > STRING_COMMON.SilverCoinUnit)
                     {
                        _loc4_ = Math.floor(this.FCharacter.CreditSilverCoin.ToNumber() * STRING_COMMON.SilverCoinCoefficient) + STRING_COMMON.STRING_Thousand;
                     }
                     else
                     {
                        _loc4_ = this.FCharacter.CreditSilverCoin.ToString();
                     }
                     this.TFCreditSilverCoin.text = _loc4_;
                     _loc5_.High = this.FCharacter.CreditSilverCoin.High;
                     _loc5_.Low = this.FCharacter.CreditSilverCoin.Low;
                     _loc6_.SetParameters(this.GetTFCreditByIndex(_loc1_),4294936064);
                  }
               }
               else
               {
                  _loc3_ = parseInt(this.GetTFCreditByIndex(_loc1_).text);
                  if(_loc3_ != uint(this.FCharacter.GetCreditByIndex(_loc1_)) && _loc6_.IsRunOver)
                  {
                     this.GetTFCreditByIndex(_loc1_).text = (this.FCharacter.GetCreditByIndex(_loc1_) as uint).toString();
                     _loc6_.SetParameters(this.GetTFCreditByIndex(_loc1_),4294936064);
                  }
               }
               _loc1_++;
            }
            this.UpdateEffectsGlow();
         }
      }
      
      protected function UpdateEffectsGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEffectBaseFlicker = null;
         _loc2_ = int(this.FEffectFlickerCredits.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectFlickerCredits[_loc1_];
            if(!_loc3_.IsRunOver)
            {
               _loc3_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtnEffectBaseGlow() : void
      {
         if(this.FEffectBaseGlowVIP != null && this.FEffectBaseGlowVIP.IsRunOver)
         {
            this.FEffectBaseGlowVIP.Run();
         }
         if(this.FEffectBaseGlowSVIP != null && this.FEffectBaseGlowSVIP.IsRunOver)
         {
            this.FEffectBaseGlowSVIP.Run();
         }
      }
      
      protected function UpdateTime() : void
      {
         if(this.FMC_AutoBattle != null)
         {
            if(this.FIsShow)
            {
               if(this.FTotleTime > 0)
               {
                  this.FMC_AutoBattle.tf_info.text = STRING_WORLDMAP.STRINGS_AutoBattle + TGameUtil.fomatTime(this.FTotleTime - STimingCore.GetServerTick());
               }
               else
               {
                  this.FMC_AutoBattle.tf_info.text = STRING_WORLDMAP.STRINGS_AutoBattleEnd;
               }
            }
         }
      }
      
      protected function LogicsPerform_FightingPowerEffect() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         if(!this.FIsInitialization)
         {
            return;
         }
         _loc2_ = this.FTotalFightingPower;
         _loc1_ = parseInt(this.FTF_FightingPower.text);
         if(_loc1_ == _loc2_)
         {
            return;
         }
         _loc3_ = Math.ceil(Math.abs(_loc2_ - _loc1_) / 4);
         if(_loc1_ < _loc2_)
         {
            _loc1_ += _loc3_;
            this.FMC_FightingEffect.play();
         }
         else if(_loc1_ > _loc2_)
         {
            _loc1_ -= _loc3_;
         }
         this.FTF_FightingPower.text = _loc1_.toString();
      }
      
      protected function UpdateCharacterInfo() : void
      {
         var _loc1_:THero = null;
         var _loc2_:uint = 0;
         if(this.FIsInitialization)
         {
            _loc1_ = this.FCharacter.MainHero;
            _loc2_ = _loc1_.Identifier % CHARACTER_BaseModeID;
            this.FMC_HeadPortrait.gotoAndStop("ID" + _loc1_.Identifier);
            this.FTF_Nickname.text = this.FCharacter.NickName;
            this.FTF_Level.text = _loc1_.GetLevelStrByLevel(_loc1_.Level);
            this.FTF_VIPCaption.text = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Vip,this.FCharacter.VipLevel);
         }
      }
      
      protected function UpdateCharacterCountry() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInitialization)
         {
            _loc1_ = int(this.FCharacter.Country);
            if(_loc1_ != 0)
            {
               this.FMC_Country.gotoAndStop(this.FCharacter.Country);
               this.FMC_Country.visible = true;
            }
         }
      }
      
      protected function UpdateCharacterFightingPower() : void
      {
         if(this.FIsInitialization)
         {
            if(this.FCharacter.GetFightingPowerPVE())
            {
               this.FTotalFightingPower = this.FCharacter.GetFightingPowerPVE().ToNumber();
            }
         }
      }
      
      protected function UpdateCharacterFightingPowerUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc3_ = this.FTotalFightingPower;
         _loc2_ = this.FFightingPower;
         if(_loc2_ < this.FTotalFightingPower)
         {
            this.FTextParameters.Font.Color = CONST_COMMON.QUALITYCOLOR_INDEX[2];
            _loc1_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_FightPowerUp,this.FTotalFightingPower - _loc2_);
         }
         else
         {
            if(_loc2_ <= this.FTotalFightingPower)
            {
               return;
            }
            this.FTextParameters.Font.Color = CONST_COMMON.QUALITYCOLOR_INDEX[6];
            _loc1_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_FightPowerDown,_loc2_ - this.FTotalFightingPower);
         }
         if(this.FOnEffectGenerateText != null)
         {
            this.FOnEffectGenerateText(_loc1_,this.FTextParameters);
         }
         this.FFightingPower = _loc3_;
      }
      
      protected function CharacterUpdateCredits() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TConfigValue = null;
         var _loc4_:Number = NaN;
         if(this.FIsInitialization)
         {
            _loc1_ = this.FCharacter.CreditMilitaryOrders;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ORDER_RECOVER_LIMIT) as TConfigValue;
            _loc2_ = _loc3_.Value as uint;
            _loc2_ += this.FVipData.ActionLimit;
            this.FTF_MilitaryOrders.text = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_MilitaryOrders,_loc1_,_loc2_);
            _loc4_ = _loc1_ / _loc2_;
            if(_loc4_ > 1)
            {
               _loc4_ = 1;
            }
            this.FMC_ProgressBarMilitaryOrder.scaleX = _loc4_;
            this.FMC_MilitaryOrderBuff.visible = Boolean(this.FCharacter.CreditMilitaryOrdersBuff != 0);
         }
      }
      
      protected function UpdatePetInfo() : void
      {
         var _loc1_:TPet = null;
         _loc1_ = this.FCharacter.Pet;
         if(_loc1_.RelexBoo)
         {
            this.FMC_Pet.visible = false;
         }
         else
         {
            this.FTF_PetName.text = _loc1_.Name;
            this.FTF_PetStarLevel.text = _loc1_.Star.toString();
            if(this.FPetTextureID != _loc1_.SmallIcon)
            {
               this.FPetTextureID = _loc1_.SmallIcon;
               this.FIsStarLoader = true;
            }
            this.FMC_Pet.visible = true;
         }
      }
      
      protected function SlotsOnQuerySequenceContext() : void
      {
         var _loc1_:TResourceRepositoryTexture = null;
         var _loc2_:TTexture = null;
         var _loc3_:TAnimationSequence = null;
         var _loc4_:TAnimationFrame = null;
         var _loc5_:uint = 0;
         if(!this.FIsStarLoader)
         {
            return;
         }
         _loc1_ = SResourcesCore.TexturesPet;
         _loc2_ = _loc1_.GetTextureByIdentifier(this.FPetTextureID);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.GetAnimationSequenceByIdentifier(0);
            _loc4_ = _loc3_.GetAnimationFrameByTick(STimingCore.TickCount);
            if(_loc4_ == null)
            {
               return;
            }
            this.FPetBitmap.bitmapData = _loc4_.Surface;
            this.FIsStarLoader = false;
         }
         else
         {
            _loc1_.LoadSecondary(this.FPetTextureID,CONST_MODULES.MODULE_Avatar);
         }
      }
      
      protected function UpdateCounterMilitaryOrdersLimit() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MilitaryOrdersLimit_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         if(_loc2_ == KEY_COUNTER_MilitaryOrdersLimit)
         {
            this.FCounterMilitaryOrdersLimit = _loc3_;
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         _loc3_ = this.FMC_EffectNinjaLevel.visible;
         if(_loc3_ != param2)
         {
            if(param2)
            {
               this.FMC_EffectNinjaLevel.play();
            }
            else
            {
               this.FMC_EffectNinjaLevel.stop();
            }
            this.FMC_EffectNinjaLevel.visible = param2;
         }
      }
      
      protected function UpdateBounds() : void
      {
         if(!this.FIsInitialization)
         {
            return;
         }
         if(this.FIsInitialization)
         {
            this.FWidth = SIZE_Avatar_Width;
            this.FHeight = SIZE_Avatar_Height;
            if(this.FMC_Pet.visible)
            {
               this.FHeight += this.FMC_Pet.height;
            }
         }
         else
         {
            this.FWidth = 0;
            this.FHeight = 0;
         }
      }
      
      protected function ButtonPromoteOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ChatChannel_01) as TSystemLanguage;
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            this.FOnEffectGenerateText(_loc2_.Desc);
            return;
         }
         if(this.FOnPromote != null)
         {
            this.FOnPromote(this);
         }
      }
      
      protected function TF_MilitaryOrdersOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintMilitaryOrders);
         }
      }
      
      protected function TFMilitaryOrdersOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function TF_SilverCoinOnMove(param1:MouseEvent) : void
      {
         this.FHintSilverCoin.Caption = TUtilityString.Format(FORMAT_SilverCoin,this.FCharacter.CreditSilverCoin.ToString());
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintSilverCoin);
         }
      }
      
      protected function TF_GoldOnMove(param1:MouseEvent) : void
      {
         this.FHintGold.Caption = TUtilityString.Format(FORMAT_Gold,this.FCharacter.CreditGold);
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintGold);
         }
      }
      
      protected function TF_GiftCertificateOnMove(param1:MouseEvent) : void
      {
         this.FHintGiftCertificate.Caption = TUtilityString.Format(FORMAT_GiftCertificate,this.FCharacter.CreditGiftCertificate);
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintGiftCertificate);
         }
      }
      
      protected function TF_CreditOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function HeadOnMouseClick(param1:MouseEvent) : void
      {
         if(this.FOnHead != null)
         {
            this.FOnHead(this,null);
         }
      }
      
      protected function MC_HeadPortraitOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintCharacter);
         }
      }
      
      protected function MC_HeadPortraitOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function BtnMilitaryOrdersOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(this.FVipLevel != this.FCharacter.VipLevel)
         {
            this.FCharacter.MilitaryBuyCount = this.FVipData.BuyActionLimit;
         }
         if(this.FOnEffectGenerateText != null)
         {
            _loc3_ = this.FCharacter.MilitaryBuyCount - this.FCounterMilitaryOrdersLimit;
            if(this.FCharacter.CreditMilitaryOrders >= this.FCharacter.XingDongLiMaxValue)
            {
               this.FOnEffectGenerateText(STRING_SHORTCUTS.STRING_BuyMilitaryOrdersMaxValuet);
               return;
            }
            if(_loc3_ <= 0)
            {
               this.FOnEffectGenerateText(STRING_SHORTCUTS.STRING_BuyMilitaryOrdersLimit);
               return;
            }
            _loc2_ = this.FOrderBuyGold.length - _loc3_;
            if(this.FOrderBuyGold[this.FCounterMilitaryOrdersLimit] > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
            {
               this.FUIWindowRecharge.visible = true;
               return;
            }
            _loc4_ = TUtilityString.Format(FORMAT_BuyMilitaryOrders02,_loc3_,this.FOrderBuyGold[this.FCounterMilitaryOrdersLimit]);
            this.FUIWindowConfirmation.Text = _loc4_;
            this.FUIWindowConfirmation.visible = true;
         }
      }
      
      protected function BtnMilitaryOrdersOnMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(this.FVipLevel != this.FCharacter.VipLevel)
         {
            this.FCharacter.MilitaryBuyCount = this.FVipData.BuyActionLimit;
         }
         if(this.FHintOnMove != null)
         {
            _loc3_ = this.FCharacter.MilitaryBuyCount - this.FCounterMilitaryOrdersLimit;
            if(_loc3_ <= 0)
            {
               this.FHintBtnMilitaryOrders.Caption = STRING_SHORTCUTS.STRING_BuyMilitaryOrdersLimit;
            }
            else
            {
               this.FHintBtnMilitaryOrders.Caption = TUtilityString.Format(FORMAT_BuyMilitaryOrders01,_loc3_,this.FOrderBuyGold[this.FCounterMilitaryOrdersLimit],this.FOrderPerBuyValue);
            }
            this.FHintOnMove(this,this.FHintBtnMilitaryOrders);
         }
      }
      
      protected function BtnMilitaryOrdersOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function BtnMilitaryOrdersBuffOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FHintOnMove != null)
         {
            _loc2_ = STRING_SHORTCUTS.STRING_MilitaryOrdersBuffTip;
            _loc2_ = _loc2_.split("%count%").join(this.FCharacter.CreditMilitaryOrdersBuff);
            this.FHintMilitaryOrdersBuff.Caption = _loc2_;
            this.FHintOnMove(this,this.FHintMilitaryOrdersBuff);
         }
      }
      
      protected function BtnMilitaryOrdersBuffOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function BtnVIPOnClick(param1:MouseEvent) : void
      {
         if(this.FOnVIP != null)
         {
            this.FOnVIP(this);
         }
      }
      
      protected function OnConsumeVIPClick(param1:MouseEvent) : void
      {
         if(this.FOnConsumeVip != null)
         {
            this.FOnConsumeVip();
         }
      }
      
      protected function BtnRechargeOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function MCPrerogativeOnClick(param1:MouseEvent) : void
      {
         if(this.FWelfareOnClick != null)
         {
            this.FWelfareOnClick(this,this.FPlatformID);
         }
      }
      
      protected function MCAccountSecureOnClick(param1:MouseEvent) : void
      {
         SExternalCore.AccountSecure();
         if(this.FMC_1377ClickFun != null)
         {
            this.FMC_1377ClickFun();
         }
      }
      
      protected function MCObligatoryCoursesOnClick(param1:MouseEvent) : void
      {
         if(this.FObligatoryCoursesOnClick != null)
         {
            this.FObligatoryCoursesOnClick(this);
         }
      }
      
      protected function BaiDuMMqqClick(param1:MouseEvent) : void
      {
         if(this.FBaiDuMeimei != null)
         {
            this.FBaiDuMeimei(this);
         }
      }
      
      protected function OhtsutsukiKaguyaClick(param1:MouseEvent) : void
      {
         if(this.FOhtsutsukiKaguya != null)
         {
            this.FOhtsutsukiKaguya(this);
         }
      }
      
      protected function MCRankIconOnClick(param1:MouseEvent) : void
      {
         if(this.FRankIconClick != null)
         {
            this.FRankIconClick();
         }
      }
      
      protected function MCPetOnClick(param1:MouseEvent) : void
      {
         if(this.FOnSummonPet != null)
         {
            this.FOnSummonPet(this);
         }
      }
      
      protected function MCPetOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintMCPet);
         }
      }
      
      protected function MCPetOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function MCFightingPowerOnMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(this.FHelpStr,this.FCharacter.GetFightingPowerPVE().ToString(),this.FCharacter.GetFightingPowerPVP().ToString());
         this.FHelpHint.Content = _loc2_;
         if(this.FHelpHintOnMove != null)
         {
            this.FHelpHintOnMove(this,this.FHelpHint);
         }
      }
      
      protected function MCFightingPowerOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
      }
      
      protected function OnBuyMilitary(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Mall_Buy);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(CONST_MALL.MOBILITY);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnLookAutoBattle(param1:MouseEvent) : void
      {
         if(this.FOnEnterAutoBattle != null)
         {
            this.FOnEnterAutoBattle(this);
         }
      }
      
      public function FullScreenOnClick(param1:MouseEvent = null) : void
      {
         stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
         stage.align = "C";
         this.FBTN_NormalScreen.visible = true;
         this.FBTN_FullScreen.visible = false;
         this.FGlowFilter.IsRunOver = true;
      }
      
      protected function FullScreenOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = STRING_SHORTCUTS.STRING_NORMAL_SCREEN;
         this.FHelpHint.Content = _loc2_;
         if(this.FHelpHintOnMove != null)
         {
            this.FHelpHintOnMove(this,this.FHelpHint);
         }
      }
      
      protected function FullScreenOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
      }
      
      public function NormalScreenOnClick(param1:MouseEvent = null) : void
      {
         stage.displayState = StageDisplayState.NORMAL;
         stage.align = StageAlign.TOP_LEFT;
         this.FBTN_NormalScreen.visible = false;
         this.FBTN_FullScreen.visible = true;
      }
      
      protected function NormalScreenOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = STRING_SHORTCUTS.STRING_FULL_SCREEN;
         this.FHelpHint.Content = _loc2_;
         if(this.FHelpHintOnMove != null)
         {
            this.FHelpHintOnMove(this,this.FHelpHint);
         }
      }
      
      protected function NormalScreenOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
      }
      
      protected function ProcessorAccountLockOnClick(param1:MouseEvent) : void
      {
         if(this.AccountLockOnClick != null)
         {
            this.AccountLockOnClick();
         }
      }
      
      protected function OnVipClick(param1:MouseEvent) : void
      {
         if(this.FOnVipClickFun != null)
         {
            this.FOnVipClickFun();
         }
      }
      
      protected function OnClickMicrologin(param1:MouseEvent) : void
      {
         if(this.FOnMicrologin != null)
         {
            this.FOnMicrologin();
         }
      }
      
      public function get ShortcutWidth() : int
      {
         this.UpdateBounds();
         return this.FWidth;
      }
      
      public function get ShortcutHeight() : int
      {
         this.UpdateBounds();
         return this.FHeight;
      }
      
      protected function GetTFCreditByIndex(param1:int) : TextField
      {
         return this.FTFCredits[param1];
      }
      
      protected function SetTFCreditByIndex(param1:int, param2:TextField) : void
      {
         this.FTFCredits[param1] = param2;
      }
      
      protected function get TFCreditGold() : TextField
      {
         return this.FTFCredits[CREDITINDEX_Gold] as TextField;
      }
      
      protected function set TFCreditGold(param1:TextField) : void
      {
         this.FTFCredits[CREDITINDEX_Gold] = param1;
      }
      
      protected function get TFCreditSilverCoin() : TextField
      {
         return this.FTFCredits[CREDITINDEX_SilverCoin] as TextField;
      }
      
      protected function set TFCreditSilverCoin(param1:TextField) : void
      {
         this.FTFCredits[CREDITINDEX_SilverCoin] = param1;
      }
      
      protected function get TFCreditGiftCertificate() : TextField
      {
         return this.FTFCredits[CREDITINDEX_GiftCertificate] as TextField;
      }
      
      protected function set TFCreditGiftCertificate(param1:TextField) : void
      {
         this.FTFCredits[CREDITINDEX_GiftCertificate] = param1;
      }
      
      public function get OnHead() : Function
      {
         return this.FOnHead;
      }
      
      public function set OnHead(param1:Function) : void
      {
         this.FOnHead = param1;
      }
      
      public function get OnSummonPet() : Function
      {
         return this.FOnSummonPet;
      }
      
      public function set OnSummonPet(param1:Function) : void
      {
         this.FOnSummonPet = param1;
      }
      
      public function get OnVIP() : Function
      {
         return this.FOnVIP;
      }
      
      public function set OnVIP(param1:Function) : void
      {
         this.FOnVIP = param1;
      }
      
      public function get OnConsumeVip() : Function
      {
         return this.FOnConsumeVip;
      }
      
      public function set OnConsumeVip(param1:Function) : void
      {
         this.FOnConsumeVip = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function set KaguyaOnOver(param1:Function) : void
      {
         this.FKaguyaOnOver = param1;
      }
      
      public function get KaguyaOnOver() : Function
      {
         return this.FKaguyaOnOver;
      }
      
      public function set KaguyaOnOut(param1:Function) : void
      {
         this.FKaguyaOnOut = param1;
      }
      
      public function get KaguyaOnOut() : Function
      {
         return this.FKaguyaOnOut;
      }
      
      public function get HelpHintOnMove() : Function
      {
         return this.FHelpHintOnMove;
      }
      
      public function set HelpHintOnMove(param1:Function) : void
      {
         this.FHelpHintOnMove = param1;
      }
      
      public function get HelpHintOnOut() : Function
      {
         return this.FHelpHintOnOut;
      }
      
      public function set HelpHintOnOut(param1:Function) : void
      {
         this.FHelpHintOnOut = param1;
      }
      
      public function get OnEffectGenerateText() : Function
      {
         return this.FOnEffectGenerateText;
      }
      
      public function set OnEffectGenerateText(param1:Function) : void
      {
         this.FOnEffectGenerateText = param1;
      }
      
      public function get OnPromote() : Function
      {
         return this.FOnPromote;
      }
      
      public function set OnPromote(param1:Function) : void
      {
         this.FOnPromote = param1;
      }
      
      public function get OnEnterAutoBattle() : Function
      {
         return this.FOnEnterAutoBattle;
      }
      
      public function set OnEnterAutoBattle(param1:Function) : void
      {
         this.FOnEnterAutoBattle = param1;
      }
      
      public function set WelfareOnClick(param1:Function) : void
      {
         this.FWelfareOnClick = param1;
      }
      
      public function set ObligatoryCoursesOnClick(param1:Function) : void
      {
         this.FObligatoryCoursesOnClick = param1;
      }
      
      public function set BaiDuMeimei(param1:Function) : void
      {
         this.FBaiDuMeimei = param1;
      }
      
      public function set OhtsutsukiKaguya(param1:Function) : void
      {
         this.FOhtsutsukiKaguya = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.Reset();
         this.FIsInitialization = true;
      }
      
      public function Update() : void
      {
         this.SlotsOnQuerySequenceContext();
         this.LogicsPerform_CreditsEffect();
         this.LogicsPerform_FightingPowerEffect();
         this.UpdateCounterMilitaryOrdersLimit();
         this.UpdateBtnEffectBaseGlow();
         this.UpdateTime();
         this.Logic_Time();
         this.UpdateShine();
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutAvatarModes) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         _loc2_ = param1.GetShortcutModeByIndex(TLobbyShortcutAvatarModes.CAPACITY_Shortcuts - 1);
         switch(_loc2_)
         {
            case TLobbyShortcutMode.SHORTCUTMODE_Show:
               _loc3_ = true;
               break;
            case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
               _loc3_ = false;
         }
         this.Visible = _loc3_;
      }
      
      public function TerminationButtonEffect(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.FEffectBaseGlowVIP == null)
            {
               this.FEffectBaseGlowVIP = new TEffectBaseGlow();
               if(!this.FEffectBaseGlowVIP.IsRunOver)
               {
                  this.FEffectBaseGlowVIP.SetParameters(this.FBtn_VIP,15911245,1);
                  this.FEffectBaseGlowVIP.Run();
               }
            }
         }
         else if(this.FEffectBaseGlowVIP != null)
         {
            this.FEffectBaseGlowVIP.Stop();
            this.FEffectBaseGlowVIP.Dispose();
            this.FEffectBaseGlowVIP = null;
         }
      }
      
      public function TerminationButtonEffectCopy(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.FEffectBaseGlowSVIP == null)
            {
               this.FEffectBaseGlowSVIP = new TEffectBaseGlow();
               if(!this.FEffectBaseGlowSVIP.IsRunOver)
               {
                  this.FEffectBaseGlowSVIP.SetParameters(this.FBtn_ConsumeVip,15911245,1);
                  this.FEffectBaseGlowSVIP.Run();
               }
            }
         }
         else if(this.FEffectBaseGlowSVIP != null)
         {
            this.FEffectBaseGlowSVIP.Stop();
            this.FEffectBaseGlowSVIP.Dispose();
            this.FEffectBaseGlowSVIP = null;
         }
      }
      
      public function UserUpdateCharBaseInfo() : void
      {
         this.UpdateCharacterInfo();
         this.UpdateCharacterFightingPower();
         this.UpdatePetInfo();
         this.UpdateCharacterCountry();
         this.CharacterUpdateCredits();
         this.OnCheckOpenRankIcon();
         this.UpdateVipIsshow();
      }
      
      public function UserUpdateCharacterCountry() : void
      {
         this.UpdateCharacterCountry();
      }
      
      public function UserUpdateFightingPower() : void
      {
         this.UpdateCharacterFightingPower();
      }
      
      public function UpdateTextEffect(param1:uint = 0) : void
      {
         this.UpdateCharacterFightingPower();
         if(!Boolean(param1))
         {
            this.UpdateCharacterFightingPowerUI();
         }
         else
         {
            this.FFightingPower = this.FTotalFightingPower;
         }
      }
      
      public function UserUpdateConsumeVip() : void
      {
         if(this.FIsInitialization)
         {
            this.FTF_ConsumeVip.text = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_SVip,SLogicsCore.ConsumeVipData.VipLevel);
         }
      }
      
      public function UserUpdatePet() : void
      {
         this.UpdatePetInfo();
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1,param2);
      }
      
      public function UpdateMilitaryOrdersLimit() : void
      {
         ++this.FCounterMilitaryOrdersLimit;
      }
      
      public function BuyActionTimes() : void
      {
         this.BtnMilitaryOrdersOnClick(null);
      }
      
      public function SetIntoAutoBattle(param1:Object, param2:Boolean, param3:uint) : void
      {
         if(this.FMC_AutoBattle == null)
         {
            return;
         }
         this.FIsShow = param2;
         this.FTotleTime = param3;
         if(param2)
         {
            this.FMC_AutoBattle.visible = true;
         }
         else
         {
            this.FMC_AutoBattle.visible = false;
         }
      }
      
      public function SetPrerogativeButton() : void
      {
         var _loc1_:Boolean = false;
         this.FPlatformID = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PlatformID,SParametersCore.AgentID) as TPlatformID;
         if(this.FPlatformID != null)
         {
            _loc1_ = Boolean(this.FPlatformID.Open);
         }
         else
         {
            _loc1_ = false;
         }
         this.FMC_Prerogative.visible = _loc1_;
         if(!this.FMC_AccountSecure)
         {
         }
      }
      
      public function IsPlayEffect(param1:Boolean) : void
      {
         if(this.FMC_Prerogative.visible == false)
         {
            return;
         }
         if(this.FMC_Avatar["MC_PlatformEffect"] != null)
         {
            if(param1)
            {
               this.FMC_Avatar["MC_PlatformEffect"].gotoAndPlay(1);
            }
            else
            {
               this.FMC_Avatar["MC_PlatformEffect"].gotoAndStop(1);
            }
            this.FMC_Avatar["MC_PlatformEffect"].visible = param1;
         }
      }
      
      public function SetObligatoryCoursesCount(param1:Object, param2:uint) : void
      {
         this.FMC_ObligatoryCourses.visible = Boolean(param2 != 0);
         this.FMC_ObligatoryCourses["TF_Count"].text = String(param2);
      }
      
      public function setFBaiDuMeimeiMcState(param1:Boolean) : void
      {
         this.FBaiDuMeimeiMc.visible = param1;
      }
      
      protected function KaguyaOnMove(param1:MouseEvent) : void
      {
         if(this.FKaguyaOnOver != null)
         {
            this.FKaguyaOnOver();
         }
      }
      
      protected function KOut(param1:MouseEvent) : void
      {
         if(this.FKaguyaOnOut != null)
         {
            this.FKaguyaOnOut();
         }
      }
      
      protected function UIStageOnKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == CONST_KEYCODE.KEY_ESCAPE)
         {
            stage.displayState = StageDisplayState.NORMAL;
            stage.align = StageAlign.TOP_LEFT;
            this.FBTN_NormalScreen.visible = false;
            this.FBTN_FullScreen.visible = true;
         }
      }
      
      public function set VkClickFunction(param1:Function) : void
      {
         this.FVkClickFunction = param1;
      }
      
      protected function VKClick(param1:MouseEvent) : void
      {
         if(this.FVkClickFunction != null)
         {
            this.FVkClickFunction();
         }
      }
      
      protected function MC_1377Click(param1:MouseEvent) : void
      {
         if(this.FMC_1377ClickFun != null)
         {
            this.FMC_1377ClickFun();
         }
      }
      
      public function set MC_1377ClickFun(param1:Function) : void
      {
         this.FMC_1377ClickFun = param1;
      }
      
      public function set OpenOnLineGift(param1:Function) : void
      {
         this.FOpenOnLineGift = param1;
      }
      
      public function set RankIconClick(param1:Function) : void
      {
         this.FRankIconClick = param1;
      }
      
      public function set OnVipClickFun(param1:Function) : void
      {
         this.FOnVipClickFun = param1;
      }
      
      public function set OnMicrologin(param1:Function) : void
      {
         this.FOnMicrologin = param1;
      }
   }
}

