package Processors.Game.Lobby.Account
{
   import Externals.SExternalCore;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.SWF.*;
   import Foundation.Resources.XML.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import LocalStorages.SLocalStoragelCore;
   import Logics.*;
   import Logics.Affairs.TAffair;
   import Logics.Agent.SParametersCore;
   import Logics.Characters.*;
   import Logics.ChatOptions.*;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.THeroExp;
   import Logics.DatebaseVO.VO.TRandomName;
   import Logics.DatebaseVO.VO.TStarMap;
   import Logics.DatebaseVO.VO.TStarPoint;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.Skills.TSkill;
   import Logics.Skills.TSkills;
   import Logics.Spaces.LogicsSpace;
   import Logics.Streamization.Characters.*;
   import Logics.Streamization.GeneralStar.TUnstreamizerGeneralStar;
   import Logics.Streamization.Skills.TUnstreamizerSkill;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Processors.Game.Lobby.Account.SelectEffects.TCharacterBox;
   import Processors.Game.Lobby.Account.SelectEffects.TRotationCharacter;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   
   use namespace LogicsSpace;
   
   public class TProcessorAccount extends TProcessorLobbyPlate
   {
      
      protected static const STRING_VIRTUALNAMES:String = STRING_COMMON.STRING_VIRTUALNAMES;
      
      protected static const AFFAIRID_TimingWaitLoaded:uint = 1;
      
      protected static const AFFAIRID_TimingWaitRequestData:uint = 2;
      
      protected static const AFFAIRID_TimingWaitRequestFistMovie:uint = 3;
      
      protected static const AFFAIRID_TimingCharBaseInfosUpdate:uint = 4;
      
      protected static const TIME_RequestMovieData:int = 500;
      
      protected static const TIME_RequestMoviePeriod:int = 500;
      
      protected static const TIME_RequestData:int = 100;
      
      protected static const TIME_RequestPeriod:int = 50;
      
      protected static const Type_LargeIcon:int = 4;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected static const GENDER_Female:uint = CONST_CHARACTER.GENDER_Female;
      
      protected static const GENDER_Male:uint = CONST_CHARACTER.GENDER_Male;
      
      protected static const BASESINFOINDEX_Character:Vector.<uint> = CONST_CHARACTER.BASESINFOINDEX_Character;
      
      protected static const BASEINFOINDEX_SilverCoin:uint = CONST_CHARACTER.BASEINFOINDEX_SilverCoin;
      
      protected static const BASEINFOINDEX_GiftCertificate:uint = CONST_CHARACTER.BASEINFOINDEX_GiftCertificate;
      
      protected static const BASEINFOINDEX_MilitaryOrders:uint = CONST_CHARACTER.BASEINFOINDEX_MilitaryOrders;
      
      protected static const BASEINFOINDEX_Gold:uint = CONST_CHARACTER.BASEINFOINDEX_Gold;
      
      protected static const BASEINFOINDEX_Soul:uint = CONST_CHARACTER.BASEINFOINDEX_Soul;
      
      protected static const BASEINFOINDEX_Prestige:uint = CONST_CHARACTER.BASEINFOINDEX_Prestige;
      
      protected static const BASEINFOINDEX_StrengthenCD:uint = CONST_CHARACTER.BASEINFOINDEX_StrengthenCD;
      
      protected static const BASEINFOINDEX_BlueSoul:uint = CONST_CHARACTER.BASEINFOINDEX_BlueSoul;
      
      protected static const BASEINFOINDEX_PurpleSoul:uint = CONST_CHARACTER.BASEINFOINDEX_PurpleSoul;
      
      protected static const BASEINFOINDEX_GoldSoul:uint = CONST_CHARACTER.BASEINFOINDEX_GoldSoul;
      
      protected static const BASEINFOINDEX_OrangeSoul:uint = CONST_CHARACTER.BASEINFOINDEX_OrangeSoul;
      
      protected static const BASEINFOINDEX_Experience:uint = CONST_CHARACTER.BASEINFOINDEX_Experience;
      
      protected static const BASEINFOINDEX_ExperienceTarget:uint = CONST_CHARACTER.BASEINFOINDEX_ExperienceTarget;
      
      protected static const BASEINFOINDEX_Integral:uint = CONST_CHARACTER.BASEINFOINDEX_Integral;
      
      protected static const BASEINFOINDEX_VipLevel:uint = CONST_CHARACTER.BASEINFOINDEX_VipLevel;
      
      protected static const BASEINFOINDEX_CharacterLevel:uint = CONST_CHARACTER.BASEINFOINDEX_CharacterLevel;
      
      protected static const BASEINFOINDEX_CharacterState:uint = CONST_CHARACTER.BASEINFOINDEX_CharacterState;
      
      protected static const BASEINFOINDEX_VipExp:uint = CONST_CHARACTER.BASEINFOINDEX_VipExp;
      
      protected static const BASEINFOINDEX_FamilyID:uint = CONST_CHARACTER.BASEINFOINDEX_FamilyID;
      
      protected static const BASEINFOINDEX_MilitaryOrdersBuff:uint = CONST_CHARACTER.BASEINFOINDEX_MilitaryOrdersBuff;
      
      protected static const BASEINFOINDEX_HeroAddTimes:uint = CONST_CHARACTER.BASEINFOINDEX_HeroAddTimes;
      
      protected static const CAPACITY_Roles:uint = 6;
      
      public static const PROFESSIONS:Vector.<uint> = Vector.<uint>([1,2,3,4,5,6]);
      
      public static const PROFESSIONS_ID:Vector.<uint> = Vector.<uint>([0,11100003,11100004,11100001,11100002,11100005,11100006]);
      
      public static const SILHOUETTELIST:String = CONST_ACCOUNT.RESOURCE_MC_SilhouetteList;
      
      public static const SILHOUETTE:String = CONST_ACCOUNT.RESOURCE_MC_Silhouette;
      
      public static const BIGICONLIST:String = CONST_ACCOUNT.RESOURCE_MC_BigIconList;
      
      public static const BIGICON:String = CONST_ACCOUNT.RESOURCE_MC_BigIcon;
      
      public static const Icon:String = CONST_ACCOUNT.Icon;
      
      public static const PROFESSION_NAME:String = CONST_ACCOUNT.RESOURCE_MC_ProfessionName;
      
      public static const EXPLAIN:String = CONST_ACCOUNT.RESOURCE_MC_Explain;
      
      public static const EXPLAINBOX:String = CONST_ACCOUNT.RESOURCE_MC_ExplainBox;
      
      public static const SCENEPOSITION_MAINCITY:int = CONST_COMMON.SCENEPOSITION_MAINCITY;
      
      public static const KEYS_COUNTER_PRIORITY_COPYCLASSROOM:Vector.<uint> = CONST_COUNTER.KEYS_COUNTER_PRIORITY_COPYCLASSROOM;
      
      public static const KEY_COUNTER_MilitaryOrdersLimit:uint = CONST_COUNTER.KEY_COUNTER_MilitaryOrdersLimit;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      protected var FUnstreamizerSkill:TUnstreamizerSkill;
      
      protected var FUnStreamizerRoleNPC:TUnstreamizerRoleNPC;
      
      protected var FUnStreamizerGeneralStar:TUnstreamizerGeneralStar;
      
      protected var FBaseHeros:TBins;
      
      protected var FProcessorCharBaseInfos:Vector.<Function>;
      
      protected var FProcessorCharBaseInfosUpdate:Vector.<Function>;
      
      protected var FMC_Account:Sprite;
      
      protected var FBtn_CreateRole:SimpleButton;
      
      protected var FBtn_RandomName:SimpleButton;
      
      protected var FTF_UserName:TextField;
      
      protected var FTF_VirtualName:TextField;
      
      protected var FCharacter:TCharacter;
      
      protected var FEsotericPoints:TEsotericPoints;
      
      protected var FLastNames:Vector.<String>;
      
      protected var FMaleNames:Vector.<String>;
      
      protected var FFemaleNames:Vector.<String>;
      
      protected var FVirtualNames:Vector.<String>;
      
      protected var FTempVirtualNamesA:Vector.<String>;
      
      protected var FProfession:int;
      
      protected var FGender:int;
      
      protected var FProfessionFrame:int;
      
      protected var FRotationCharacter:TRotationCharacter;
      
      protected var FExplainBox:MovieClip;
      
      protected var FHerosID:Vector.<uint>;
      
      protected var FInitialize:Boolean;
      
      protected var FNpcBitmap:Bitmap;
      
      protected var FRequestFrontRoutines:Vector.<Function>;
      
      protected var FRequestRearRoutines:Vector.<Function>;
      
      protected var FRequestsMovie:Vector.<Function>;
      
      protected var FTickRequestData:int;
      
      protected var FShiYanRequestFrontRoutines:Vector.<Function>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FOnLoadFollowUp:Function;
      
      protected var FOnCreateRole:Function;
      
      protected var FOnStartFreshGuide:Function;
      
      protected var FOnUserUpdateBaseInfo:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnUserUpdateStrengthenCD:Function;
      
      protected var FOnUserLevelUpEffect:Function;
      
      protected var FOnUserLevelUp:Function;
      
      protected var FOnUpdateHerosBaseAttributeReq:Function;
      
      protected var FOnUpdateHerosTotalFightingPower:Function;
      
      protected var FOnUpdateVipInfo:Function;
      
      protected var FOnInitQuests:Function;
      
      protected var FOnInitMilitaryInfor:Function;
      
      protected var FOnUpdataSeverTime:Function;
      
      protected var FOnInitAllNpc:Function;
      
      protected var FOnInitMallInfo:Function;
      
      protected var FOnInitPvpMallInfo:Function;
      
      protected var FOnCheckAntiAddiction:Function;
      
      protected var FOnProcessorPlayView:Function;
      
      protected var FOnUpdateAllHeroEquipmentMountedSuitCount:Function;
      
      protected var FOnEnabledCheckSpeedUp:Function;
      
      protected var FOnInitVipInfo:Function;
      
      protected var FOnEnterFamily:Function;
      
      protected var FOnInitCrossServerMallInfo:Function;
      
      protected var FOnOpenSocketLoading:Function;
      
      protected var FOnCloseSocketLoading:Function;
      
      protected var FOnDailyQusetInfoReq:Function;
      
      protected var FOnActivityInfoReq:Function;
      
      protected var FOnBigDipperInfoReq:Function;
      
      protected var FMainHeroQualityOnChange:Function;
      
      protected var FRequestMilitaryInfor:Function;
      
      protected var FOnUserTotalFightingPowerReq:Function;
      
      public function TProcessorAccount(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
         this.FUnstreamizerSkill = new TUnstreamizerSkill();
         this.FUnStreamizerRoleNPC = new TUnstreamizerRoleNPC();
         this.FUnStreamizerGeneralStar = new TUnstreamizerGeneralStar();
         this.ConstructCharBaseInfos();
         this.ConstructRequestRoutines();
         this.FProcessorCharBaseInfosUpdate = new Vector.<Function>();
         this.FHerosID = new Vector.<uint>();
         this.FVirtualNames = new Vector.<String>();
         this.FTempVirtualNamesA = new Vector.<String>();
         this.FCharacter = SLogicsCore.Character;
         this.FEsotericPoints = this.FCharacter.EsotericPoints;
         this.FProfession = CONST_CHARACTER.PROFESSION_Strength;
         this.FGender = GENDER_Female;
         this.FNpcBitmap = new Bitmap();
         this.FInitialize = false;
      }
      
      protected function ConstructCharBaseInfos() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(BASESINFOINDEX_Character.length);
         this.FProcessorCharBaseInfos = new Vector.<Function>(_loc2_);
         this.FProcessorCharBaseInfos[BASEINFOINDEX_SilverCoin] = this.ProcessorCharBaseInfoSilverCoin;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_GiftCertificate] = this.ProcessorCharBaseInfoGiftCertificate;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_MilitaryOrders] = this.ProcessorCharBaseInfoMilitaryOrders;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_Gold] = this.ProcessorCharBaseInfoGold;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_Soul] = this.ProcessorCharBaseInfoSoul;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_Prestige] = this.ProcessorCharBaseInfoPrestige;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_StrengthenCD] = this.ProcessorCharBaseInfoStrengthenCD;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_BlueSoul] = this.ProcessorCharBaseInfoBlueSoul;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_PurpleSoul] = this.ProcessorCharBaseInfoPurpleSoul;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_GoldSoul] = this.ProcessorCharBaseInfoGoldSoul;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_OrangeSoul] = this.ProcessorCharBaseInfoOrangeSoul;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_Experience] = this.ProcessorCharBaseInfoExperience;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_ExperienceTarget] = this.ProcessorCharBaseInfoExperienceTarget;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_Integral] = this.ProcessorCharBaseInfoIntegral;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_VipLevel] = this.ProcessorCharBaseInfoVipLevel;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_CharacterLevel] = this.ProcessorCharBaseInfoCharacterLevel;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_CharacterState] = this.ProcessorCharBaseInfoCharacterState;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_VipExp] = this.ProcessorCharBaseInfoVipExp;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_FamilyID] = this.ProcessorCharBaseInfoFamily;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_MilitaryOrdersBuff] = this.ProcessorCharBaseInfoMilitaryOrdersBuff;
         this.FProcessorCharBaseInfos[BASEINFOINDEX_HeroAddTimes] = this.ProcessorCharBaseInfoHeroAddTimes;
      }
      
      protected function ConstructRequestRoutines() : void
      {
         this.FRequestFrontRoutines = new Vector.<Function>();
         this.FRequestFrontRoutines.push(this.ProcessorUpdataSeverTime,this.LoadLocalStoragelCore,this.ProcessorCloseSocketLoading,this.ProcessorCreateRole,this.ProcessorOnEnterTown,this.CharacterInitQuests,this.CharacterLoadQuestReq,this.ProcessorOnUserUpdateBaseInfo,this.CharacterLimitCopyHeroReq,this.CharacterVipInfoReq,this.CharacterLoadMilitaryOrdersLimit,this.CharacterLoadMilitaryReq,this.CharacterLoadInventories,this.ProcessorOnUpdateAllHeroEquipmentMountedSuitCount,this.ProcessorOnActiveInfoReq,this.CharacterLoadGeneralStar,this.ProcessorOnInitAllNpc,this.ProcessorOnRequestMilitaryInfor,this.ProcessorOnBigDipperInfoReq,this.PacketPerform_CS_LoadBaseDataReq,this.PacketPerform_CS_InteractionLogReq,this.PacketPerform_CS_NijiaStarUpdateReq,this.ProcessorOnUserTotalFightingPowerReq,this.CharacterLoadDailytask,this.ProcessorOnUserUpdateStrengthenCD,this.PACKETID_C2S_World_Tree_Get_Info,this.PerformPacket_CS_SingleFightRankReq,this.CharacterGetOrganizationInfo,this.CharacterLoadPet,this.CharacterLoadSign
         ,this.ProcessorOnInitMallInfo,this.ProcessorOnInitPvpMallInfo,this.CharacterLoadFriend,this.CharacterLoadMail,this.ProcessorOnStartFreshGuide,this.ProcessorOnCheckAntiAddiction,this.ProcessorOnEnabledCheckSpeedUp,this.PacketPerform_CS_EntrantStatus,this.ProcessorOnInitCrossServerMallInfo,this.PerformPacket_CS_LoadTitleList_Req,this.PerformPacket_CS_SeasonStatusReq,this.PerformPacket_CS_ActivityPetLoad_Req,this.PacketPerform_CS_InitEnergyReq,this.PacketPerform_CS_InitDailyWelfare,this.PacketPerform_CS_NarutoRoadTaskId,this.PacketPerform_CS_GroupBattlt_LeagueInfoNtf_Req,this.PacketPerform_CS_TongLingReq,this.PerformPacket_CS_Left_Btl_Cnt_Req,this.PacketPerform_CS_IsOpenTopTeamIcon,this.BloodSoulPurgatoryReq,this.NijiaMysticInitReq,this.BloodSoulPurgatoryCustomsInitiReq,this.SixFairyCustomsInitReq,this.RebirthRealmInitializeReq,this.PacketPerform_CS_Progress_Req,this.PacketPerform_CS_Data_Req,this.PacketPerform_CS_Data2_Req,this.PacketPerform_CS_ObligatoryCourses_Req,this.PacketPerform_CS_NinjaHostel_Init_Req
         ,this.FeteBloodInitializeReq,this.BaiDuSuperVip,this.OhtsutsukiKaguyaInitilization,this.TransmigrationTrial_Req,this.TabooGetBackPagkeInformation,this.PACKETID_C2S_Awaken_Get_OnOff_Skill_Info,this.TransmigrationAccessory_Req,this.UnderTown_Req,this.OnLine_Req,this.PacketPerform_CS_NewInfo,this.RequestOnlineExtendInFormation,this.PACKETID_C2S_MAZE_Get_Info,this.MiOnLine_Req,this.PacketPerform_CS_ConsumeVipInfo,this.WorldMatchRewardReq);
         this.FRequestRearRoutines = new Vector.<Function>();
         this.FRequestsMovie = new Vector.<Function>();
         this.FRequestsMovie.push(this.ProcessorLoadFollowUp,this.ProcessorOnInitRequests);
      }
      
      protected function ProcessorOnInitRequests() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         SExternalCore.BrazilLog(5);
         _loc2_ = int(this.FRequestFrontRoutines.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRequestFrontRoutines[_loc1_];
            if(_loc3_ != null)
            {
               _loc3_();
            }
            _loc1_++;
         }
         FAffairGenerator.Generate(AFFAIRID_TimingWaitRequestData);
         this.FTickRequestData = STimingCore.TickCount;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBins = null;
         var _loc4_:TRandomName = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         this.FBaseHeros = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RandomName);
         _loc4_ = _loc3_.GetDatebaseByIndex(0) as TRandomName;
         _loc2_ = int(_loc4_.LastNames.length);
         this.FLastNames = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FLastNames[_loc1_] = _loc4_.LastNames[_loc1_];
            _loc1_++;
         }
         _loc2_ = int(_loc4_.MaleNames.length);
         this.FMaleNames = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMaleNames[_loc1_] = _loc4_.MaleNames[_loc1_];
            _loc1_++;
         }
         _loc2_ = int(_loc4_.FemaleNames.length);
         this.FFemaleNames = new Vector.<String>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FFemaleNames[_loc1_] = _loc4_.FemaleNames[_loc1_];
            _loc1_++;
         }
         this.FMC_Account = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACCOUNT.RESOURCE_ClassName_MC_Account) as Sprite;
         addChild(this.FMC_Account);
         this.FExplainBox = this.FMC_Account[EXPLAINBOX];
         this.FRotationCharacter = new TRotationCharacter(this);
         this.FRotationCharacter.OnPlaySilhouette = this.OnPlaySilhouette;
         this.FRotationCharacter.AddCharacterBox();
         _loc8_ = CONST_ACCOUNT.RESOURCE_MC_NameBox;
         _loc9_ = CONST_ACCOUNT.RESOURCE_Link_Btn_CreateRole;
         this.FBtn_CreateRole = this.FMC_Account[_loc8_][_loc9_] as SimpleButton;
         _loc9_ = CONST_ACCOUNT.RESOURCE_Link_Btn_RandomName;
         this.FBtn_RandomName = this.FMC_Account[_loc8_][_loc9_] as SimpleButton;
         _loc9_ = CONST_ACCOUNT.RESOURCE_Link_TF_UserName;
         this.FTF_UserName = this.FMC_Account[_loc8_][_loc9_] as TextField;
         this.FTF_UserName.restrict = "[a-zA-Z0-9#一-龥]";
         this.FTF_UserName.maxChars = 6;
         this.FTF_VirtualName = this.FMC_Account[CONST_ACCOUNT.RESOURCE_Link_TF_VirtualName];
         this.Initialization();
         this.FInitialize = true;
         _loc2_ = 60;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc10_ = this.CreatVirtualNames();
            this.FVirtualNames.push(TUtilityString.Format(STRING_VIRTUALNAMES,_loc10_));
            this.FTempVirtualNamesA.push(_loc10_);
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.ButtonRandomNameOnClick(null);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_CharInfoNtf,this.PacketPerform_SC_CharInfoNtf);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_CharUpgradeNtf,this.PacketPerform_SC_CharUpgradeNtf);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_CharBaseAttributeRet,this.PacketPerform_SC_CharBaseAttributeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_CharBaseInfoUpdate,this.PacketPerform_SC_CharBaseInfoUpdate);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_MainHeroSkillInfoNtf,this.PacketPerform_SC_MainHeroSkillInfoNtf);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_CharForbiddenNtf,this.PacketPerform_SC_CharForbiddenNtf);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_UserFightVauleRet,this.PacketPerform_SC_UserFightVauleRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Account_HeroEquipInfoNtf,this.PacketPerform_SC_HeroEquipInfoNtf);
      }
      
      protected function PacketPerform_SC_CharInfoNtf(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:THero = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerCharacter.UnstreamizeBasicProperties(_loc2_,this.FCharacter,null);
         this.FUnstreamizerCharacter.UnstreamizeHeros(_loc2_,this.FCharacter.Heros,null);
         _loc3_ = this.FCharacter.GetMainHero();
         if(_loc3_ != null)
         {
            _loc3_.Name = this.FCharacter.NickName;
         }
         this.Visible = false;
         this.ProcessorCreateRole();
         this.ProcessorOnEnterTown();
         this.ProcessorOnInitRequests();
      }
      
      protected function PacketPerform_SC_CharUpgradeNtf(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:THeros = null;
         var _loc8_:TBaseHero = null;
         _loc4_ = param1.Data;
         _loc7_ = this.FCharacter.Heros;
         _loc3_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.readUnsignedInt();
            _loc6_ = _loc7_.GetHeroByIdentifier(_loc5_);
            _loc6_.Level = _loc4_.readUnsignedInt();
            _loc6_.Experience.High = _loc4_.readUnsignedInt();
            _loc6_.Experience.Low = _loc4_.readUnsignedInt();
            if(this.FBaseHeros == null)
            {
               this.FBaseHeros = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
            }
            _loc8_ = this.FBaseHeros.GetDatebaseByIdentifier(_loc5_) as TBaseHero;
            this.ProcessorOnUserUpdateBaseInfo();
            this.ProcessorUpdateHeroPower(_loc5_);
            if(_loc8_.IsMain)
            {
               if(this.FCharacter.RoleSencePosition == SCENEPOSITION_MAINCITY)
               {
                  if(this.FOnUserLevelUpEffect != null && _loc6_.Level < 3050)
                  {
                     this.FOnUserLevelUpEffect(this);
                  }
               }
               if(this.FOnUserLevelUp != null)
               {
                  this.FOnUserLevelUp(this);
               }
               if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_JOYFUN || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_EUROPE || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_BRAZIL || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_FRENCH || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_DE || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_ESP || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_FB_OTHER || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_IT)
               {
                  if(_loc6_.Level == 20)
                  {
                     SExternalCore.JoyFunLog(2);
                  }
                  else if(_loc6_.Level == 40)
                  {
                     SExternalCore.JoyFunLog(3);
                  }
                  else if(_loc6_.Level == 70)
                  {
                     SExternalCore.JoyFunLog(4);
                  }
                  else if(_loc6_.Level == 10)
                  {
                     SExternalCore.JoyFunLog(5);
                  }
               }
               SExternalCore.GameRolePostLog(_loc6_.Level);
               this.PacketPerform_CS_TongLingCheck();
            }
            _loc2_++;
         }
      }
      
      protected function PacketPerform_SC_CharBaseAttributeRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:THero = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc4_ = param1.Data;
         _loc6_ = _loc4_.readUnsignedInt();
         _loc5_ = this.FCharacter.Heros.GetHeroByIdentifier(_loc6_);
         this.FUnstreamizerCharacter.UnstreamizeBaseAttributes(_loc4_,_loc5_,null);
         if(this.FOnUpdateHerosBaseAttributeReq != null)
         {
            this.FOnUpdateHerosBaseAttributeReq(this);
         }
      }
      
      protected function PacketPerform_SC_CharBaseInfoUpdate(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         _loc6_ = param1.Data;
         _loc3_ = int(_loc6_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = int(_loc6_.readUnsignedByte());
            _loc7_ = this.FProcessorCharBaseInfos[_loc4_];
            if(_loc7_ != null)
            {
               _loc7_(_loc6_);
            }
            switch(_loc4_)
            {
               case BASEINFOINDEX_SilverCoin:
               case BASEINFOINDEX_GiftCertificate:
               case BASEINFOINDEX_MilitaryOrders:
               case BASEINFOINDEX_Gold:
               case BASEINFOINDEX_Soul:
               case BASEINFOINDEX_Prestige:
               case BASEINFOINDEX_BlueSoul:
               case BASEINFOINDEX_PurpleSoul:
               case BASEINFOINDEX_GoldSoul:
               case BASEINFOINDEX_OrangeSoul:
               case BASEINFOINDEX_ExperienceTarget:
               case BASEINFOINDEX_Experience:
               case BASEINFOINDEX_MilitaryOrdersBuff:
                  _loc8_ = this.ProcessorOnUserUpdateBaseInfo;
                  break;
               case BASEINFOINDEX_VipLevel:
               case BASEINFOINDEX_VipExp:
                  _loc8_ = this.ProcessorOnUpdateVipInfo;
                  break;
               case BASEINFOINDEX_FamilyID:
                  _loc8_ = this.ProcessorOnReflushFamily;
            }
            if(_loc8_ != null)
            {
               _loc5_ = this.FProcessorCharBaseInfosUpdate.indexOf(_loc8_);
               if(_loc5_ < 0)
               {
                  this.FProcessorCharBaseInfosUpdate.push(_loc8_);
               }
            }
            _loc2_++;
         }
         if(!this.FInitialize)
         {
            return;
         }
         FAffairGenerator.Generate(AFFAIRID_TimingCharBaseInfosUpdate);
      }
      
      protected function PacketPerform_SC_MainHeroSkillInfoNtf(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:THero = null;
         var _loc6_:TSkill = null;
         var _loc7_:TSkills = null;
         var _loc8_:uint = 0;
         _loc4_ = param1.Data;
         _loc5_ = this.FCharacter.GetMainHero();
         _loc7_ = _loc5_.Skills;
         _loc3_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc8_ = _loc4_.readUnsignedInt();
            _loc6_ = _loc7_.GetSkillByIdentifier(_loc8_);
            if(_loc6_ == null)
            {
               _loc6_ = SLogicsCore.PoolSkill.Acquire(_loc8_);
               this.FUnstreamizerSkill.UnstreamizeGenerateSkill(null,_loc6_,null);
               _loc7_.Add(_loc6_);
            }
            _loc2_++;
         }
         _loc7_.Sort();
      }
      
      protected function PacketPerform_SC_CharForbiddenNtf(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readBoolean();
         _loc4_ = _loc2_.readUnsignedInt();
         this.FCharacter.ChatForbidden = _loc3_;
         this.FCharacter.ChatForbiddanceExpiration = _loc4_;
      }
      
      protected function PacketPerform_SC_UserFightVauleRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc3_:UInt64 = new UInt64();
         var _loc4_:UInt64 = new UInt64();
         _loc2_ = param1.Data;
         _loc3_.High = _loc2_.readUnsignedInt();
         _loc3_.Low = _loc2_.readUnsignedInt();
         _loc4_.High = _loc2_.readUnsignedInt();
         _loc4_.Low = _loc2_.readUnsignedInt();
         _loc5_ = _loc2_.readUnsignedInt();
         this.FCharacter.SetFightingPower(_loc3_,_loc4_);
         if(this.FOnUpdateHerosTotalFightingPower != null)
         {
            this.FOnUpdateHerosTotalFightingPower(this,_loc5_);
         }
      }
      
      protected function PacketPerform_SC_HeroEquipInfoNtf(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:THero = null;
         var _loc7_:THeros = null;
         var _loc8_:TBaseHero = null;
         _loc4_ = param1.Data;
         _loc7_ = this.FCharacter.Heros;
         _loc3_ = int(_loc4_.readUnsignedShort());
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.readUnsignedInt();
            _loc6_ = _loc7_.GetHeroByIdentifier(_loc5_);
            this.FUnstreamizerCharacter.UnstreamizeEquipmentsMounted(_loc4_,_loc6_,null);
            _loc2_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         super.LogicsPerform();
         if(!this.FInitialize)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         _loc1_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
         if(_loc1_ < EffectMulti_DelayTicks)
         {
            return;
         }
         _loc4_ = "";
         this.FVirtualNames.shift();
         _loc4_ = this.CreatVirtualNames();
         this.FVirtualNames.push(TUtilityString.Format(STRING_VIRTUALNAMES,_loc4_));
         _loc4_ = "";
         _loc3_ = this.FVirtualNames.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc2_ >= 6)
            {
               break;
            }
            _loc4_ += this.FVirtualNames[_loc2_];
            _loc2_++;
         }
         this.FTF_VirtualName.htmlText = _loc4_;
         this.FEffDelayReferenceTick = STimingCore.TickCount;
         if(this.FNpcBitmap.bitmapData == null)
         {
            TGameUtil.ShowImageByID(Type_LargeIcon,this.FNpcBitmap,PROFESSIONS_ID[this.FProfessionFrame]);
         }
         this.LogicsPerform_UpdataAutoPoint();
      }
      
      protected function LogicsPerform_UpdataAutoPoint() : void
      {
         var _loc1_:Number = NaN;
         if(Boolean(stage) && Boolean(this.FMC_Account))
         {
            _loc1_ = stage.stageHeight;
            if(_loc1_ > CONST_COMMON.STAGE_Max_Height)
            {
               _loc1_ = CONST_COMMON.STAGE_Max_Height;
            }
            if(_loc1_ < CONST_COMMON.STAGE_Min_Height)
            {
               _loc1_ = CONST_COMMON.STAGE_Min_Height;
            }
            this.FMC_Account[CONST_ACCOUNT.RESOURCE_MC_NameBox].y = _loc1_ - 93;
         }
      }
      
      protected function LoadLocalStoragelCore() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         _loc2_ = CONST_INSPECTOR.LOCAL_STORAGEL_NAME + "." + SParametersCore.AgentID.toString() + "." + SParametersCore.ServerID.toString() + "." + SParametersCore.OperatorUserID;
         _loc2_ = _loc2_.replace(/[~%&\;:"',<>?#]+/g,"");
         SLocalStoragelCore.SavePath = _loc2_;
         _loc1_ = SLocalStoragelCore.Fetch();
         SLogicsCore.AntiAddiction.LogicsSpace::Coerce(_loc1_);
      }
      
      protected function CharacterLoadInventories() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_LoadBag);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CharacterLoadMail() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Mail_InitDataReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CharacterLoadGeneralStar() : void
      {
         var _loc1_:TStarPoint = null;
         var _loc2_:int = 0;
         var _loc3_:TStarMap = null;
         var _loc4_:TStarPoint = null;
         if(this.FCharacter.StarMapIndex != 0)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPoint,this.FCharacter.StarMapIndex) as TStarPoint;
            _loc2_ = _loc1_.MapId;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarMap,_loc2_ + 17200000) as TStarMap;
            this.FCharacter.MainHero.Quality = _loc3_.Quality;
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPoint,this.FCharacter.StarMapIndex + 1) as TStarPoint;
            if(_loc4_ == null)
            {
               this.FCharacter.MainHero.Quality = _loc3_.Quality + 1;
            }
         }
         if(this.FMainHeroQualityOnChange != null)
         {
            this.FMainHeroQualityOnChange(this);
         }
      }
      
      protected function CharacterLoadFriend() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Friend_LoadFriend);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CharacterInitQuests() : void
      {
         if(this.FOnInitQuests != null)
         {
            this.FOnInitQuests(this);
         }
      }
      
      protected function CharacterLoadQuestReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_SC_Task_QuestInforReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CharacterGetOrganizationInfo() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_GetGulidInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CharacterLoadPet() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_PetInfoRequest);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorUpdataSeverTime() : void
      {
         if(this.FOnUpdataSeverTime != null)
         {
            this.FOnUpdataSeverTime(this);
         }
      }
      
      protected function CharacterLimitCopyHeroReq() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc2_ = int(KEYS_COUNTER_PRIORITY_COPYCLASSROOM.length);
         _loc3_ = new Vector.<uint>(_loc2_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_[_loc1_] = KEYS_COUNTER_PRIORITY_COPYCLASSROOM[_loc1_];
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_CopyClassRoom_Req,0,0,_loc3_);
            _loc1_++;
         }
      }
      
      protected function CharacterLoadDailytask() : void
      {
         if(this.FOnDailyQusetInfoReq != null)
         {
            this.FOnDailyQusetInfoReq(this);
         }
      }
      
      protected function ProcessorOnActiveInfoReq() : void
      {
         if(this.FOnActivityInfoReq != null)
         {
            this.FOnActivityInfoReq(this);
         }
      }
      
      protected function CharacterLoadMilitaryOrdersLimit() : void
      {
         var _loc1_:Vector.<uint> = null;
         _loc1_ = new Vector.<uint>(1);
         _loc1_[0] = KEY_COUNTER_MilitaryOrdersLimit;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MilitaryOrdersLimit_Req,0,0,_loc1_);
      }
      
      protected function ProcessorOnBigDipperInfoReq() : void
      {
         if(this.FOnBigDipperInfoReq != null)
         {
            this.FOnBigDipperInfoReq();
         }
      }
      
      protected function PacketPerform_CS_LoadBaseDataReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Mentorship_LoadBaseDataReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_InteractionLogReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Mentorship_InteractionLogReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_NijiaSoulUpdateReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaStar_NijiaSoulUpdateReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_NijiaStarUpdateReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaStar_NijiaStarUpdateReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorUserFightVauleReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Account_UserFightVauleReq);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Sprite = null;
         this.FBtn_RandomName.addEventListener(MouseEvent.CLICK,this.ButtonRandomNameOnClick,false,0,true);
         this.FBtn_CreateRole.addEventListener(MouseEvent.CLICK,this.ButtonCreateRoleOnClick,false,0,true);
         this.ButtonRandomNameOnClick(null);
      }
      
      override protected function AffairRegisterRoutines() : void
      {
         super.AffairRegisterRoutines();
         FAffairRoutines.Register(AFFAIRID_TimingWaitLoaded,this.AffairPerform_TimingWaitLoaded);
         FAffairRoutines.Register(AFFAIRID_TimingWaitRequestFistMovie,this.AffairPerform_TimingWaitRequestFistMovie);
         FAffairRoutines.Register(AFFAIRID_TimingWaitRequestData,this.AffairPerform_TimingWaitRequestData);
         FAffairRoutines.Register(AFFAIRID_TimingCharBaseInfosUpdate,this.AffairPerform_TimingCharBaseInfosUpdate);
      }
      
      protected function AffairPerform_TimingWaitLoaded(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.PerformAffair_TimingWaitLoaded();
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
         }
      }
      
      protected function AffairPerform_TimingWaitRequestFistMovie(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.PerformAffair_TimingWaitRequestData(this.FRequestsMovie,TIME_RequestMovieData,TIME_RequestMoviePeriod);
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
            this.FInitialize = true;
         }
      }
      
      protected function AffairPerform_TimingWaitRequestData(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.PerformAffair_TimingWaitRequestData(this.FRequestRearRoutines,TIME_RequestData,TIME_RequestPeriod);
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
         }
      }
      
      protected function PerformAffair_TimingWaitLoaded() : Boolean
      {
         var _temp_1:* = SResourcesCore.PrimaryCount;
         0;
         _temp_1;
         FAffairGenerator.Generate(AFFAIRID_TimingWaitRequestFistMovie);
         this.FTickRequestData = STimingCore.TickCount;
         return false;
      }
      
      protected function PerformAffair_TimingWaitRequestData(param1:Vector.<Function>, param2:int, param3:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Function = null;
         _loc4_ = int(STimingCore.TickCount);
         _loc4_ = _loc4_ - this.FTickRequestData;
         if(_loc4_ > param2)
         {
            if(_loc4_ % param3 >= param3 / 2)
            {
               _loc5_ = param1.shift();
               if(_loc5_ != null)
               {
                  _loc5_();
               }
            }
            if(param1.length == 0)
            {
               param1 = null;
               return false;
            }
         }
         return true;
      }
      
      protected function AffairPerform_TimingCharBaseInfosUpdate(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.PerformAffair_TimingWaitCharBaseInfosUpdate();
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
         }
      }
      
      protected function PerformAffair_TimingWaitCharBaseInfosUpdate() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         _loc1_ = int(this.FProcessorCharBaseInfosUpdate.length);
         if(_loc1_ > 0)
         {
            _loc2_ = this.FProcessorCharBaseInfosUpdate.shift();
            if(_loc2_ != null)
            {
               _loc2_();
               return false;
            }
            return this.PerformAffair_TimingWaitCharBaseInfosUpdate();
         }
         return true;
      }
      
      protected function ProcessorCharBaseInfoSilverCoin(param1:ByteArray) : void
      {
         this.FCharacter.CreditSilverCoin.High = param1.readUnsignedInt();
         this.FCharacter.CreditSilverCoin.Low = param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoGiftCertificate(param1:ByteArray) : void
      {
         this.FCharacter.CreditGiftCertificate = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoMilitaryOrders(param1:ByteArray) : void
      {
         this.FCharacter.CreditMilitaryOrders = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoGold(param1:ByteArray) : void
      {
         this.FCharacter.CreditGold = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoSoul(param1:ByteArray) : void
      {
         this.FCharacter.GeneralsSoul = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoPrestige(param1:ByteArray) : void
      {
         this.FCharacter.Prestige = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoStrengthenCD(param1:ByteArray) : void
      {
         var _loc2_:TTimeCoolDown = null;
         _loc2_ = this.FCharacter.TimeCoolDowns.GetDigestByIdentifier(CONST_COMMON.TIME_COOLDOWN_Strengthen);
         _loc2_.TimingTime = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoBlueSoul(param1:ByteArray) : void
      {
         this.FCharacter.HeroSoulBlueSoul = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoPurpleSoul(param1:ByteArray) : void
      {
         this.FCharacter.HeroSoulPurpleSoul = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoGoldSoul(param1:ByteArray) : void
      {
         this.FCharacter.HeroSoulGoldSoul = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoOrangeSoul(param1:ByteArray) : void
      {
         this.FCharacter.HeroSoulOrangeSoul = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoExperience(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TPacket = null;
         var _loc5_:THero = null;
         var _loc6_:THeros = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         _loc7_ = int(param1.readUnsignedInt());
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         _loc6_ = this.FCharacter.Heros;
         _loc3_ = _loc6_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc6_.GetHeroByIndex(_loc2_);
            if(_loc5_.Mounted)
            {
               _loc8_ = int(_loc5_.Experience.High);
               _loc9_ = int(_loc5_.Experience.Low);
               _loc10_ = this.VerificationHeroLevel(_loc5_,_loc7_);
               if(_loc10_)
               {
                  this.FHerosID.push(_loc5_.Identifier);
                  _loc5_.Experience.High = _loc8_;
                  _loc5_.Experience.Low = _loc9_;
               }
            }
            _loc2_++;
         }
         _loc3_ = int(this.FHerosID.length);
         if(_loc3_ > 0)
         {
            _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Account_CharUpgradeReq);
            param1 = _loc4_.Data;
            param1.writeShort(_loc3_);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               param1.writeUnsignedInt(this.FHerosID[_loc2_]);
               _loc2_++;
            }
            SNetworkCore.Transceiver.PacketTransmit(_loc4_);
            this.FHerosID.length = 0;
         }
      }
      
      protected function VerificationHeroLevel(param1:THero, param2:int) : Boolean
      {
         var _loc3_:THeroExp = null;
         var _loc4_:UInt64 = null;
         var _loc5_:UInt64 = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = int(param1.Level);
         _loc4_ = param1.Experience;
         if(_loc7_ >= 3050)
         {
            _loc5_ = this.FCharacter.ConfigAllExp;
         }
         else
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc7_) as THeroExp;
            _loc5_ = _loc3_.NeedExp;
         }
         _loc4_.Add(param2);
         return _loc4_.EqualMax(_loc5_);
      }
      
      protected function ProcessorCharBaseInfoExperienceTarget(param1:ByteArray) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:THero = null;
         var _loc4_:uint = 0;
         var _loc5_:THeroExp = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:UInt64 = null;
         var _loc9_:Boolean = false;
         _loc6_ = int(param1.readUnsignedInt());
         _loc7_ = int(param1.readUnsignedInt());
         _loc4_ = param1.readUnsignedInt();
         _loc3_ = this.FCharacter.Heros.GetHeroByIdentifier(_loc4_);
         _loc9_ = this.VerificationHeroLevel(_loc3_,_loc7_);
         if(_loc9_)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Account_CharUpgradeReq);
            param1 = _loc2_.Data;
            param1.writeShort(1);
            param1.writeUnsignedInt(_loc4_);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
      }
      
      protected function ProcessorCharBaseInfoIntegral(param1:ByteArray) : void
      {
         this.FCharacter.CreditIntegral = param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoVipLevel(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc2_ = int(param1.readUnsignedInt());
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         this.FCharacter.VipData.CoercePropertieVipLevel(_loc2_);
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingZhenXingOpen_Rep);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingOpenLocation_Rep);
         _loc4_ = _loc3_.Data;
         _loc4_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         this.PacketPerform_CS_ObligatoryCourses_Req();
      }
      
      protected function ProcessorCharBaseInfoCharacterLevel(param1:ByteArray) : void
      {
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoCharacterState(param1:ByteArray) : void
      {
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         param1.readUnsignedInt();
      }
      
      protected function ProcessorCharBaseInfoVipExp(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.readUnsignedInt());
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         this.FCharacter.VipData.CoercePropertieVipExp(_loc2_);
      }
      
      protected function ProcessorCharBaseInfoFamily(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.readUnsignedInt());
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         this.FCharacter.Country = _loc2_;
      }
      
      protected function ProcessorCharBaseInfoMilitaryOrdersBuff(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.readUnsignedInt());
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         this.FCharacter.CreditMilitaryOrdersBuff = _loc2_;
      }
      
      protected function ProcessorCharBaseInfoHeroAddTimes(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.readUnsignedInt());
         param1.readUnsignedInt();
         param1.readUnsignedInt();
         this.FCharacter.BuyHeroSlot = _loc2_;
      }
      
      protected function ProcessorOnUserUpdateBaseInfo() : void
      {
         if(this.FOnUserUpdateBaseInfo != null)
         {
            this.FOnUserUpdateBaseInfo(this);
         }
      }
      
      protected function ProcessorUpdateHeroPower(param1:uint) : void
      {
         if(this.FUpdateHeroPower != null)
         {
            this.FUpdateHeroPower(this,param1);
         }
      }
      
      protected function ProcessorOnUserUpdateStrengthenCD() : void
      {
         if(this.FOnUserUpdateStrengthenCD != null)
         {
            this.FOnUserUpdateStrengthenCD(this);
         }
      }
      
      protected function ProcessorOnReflushFamily() : void
      {
         if(this.FOnEnterFamily != null)
         {
            this.FOnEnterFamily(this);
         }
      }
      
      protected function ProcessorOnCheckAntiAddiction() : void
      {
         if(this.FOnCheckAntiAddiction != null)
         {
            this.FOnCheckAntiAddiction(this);
         }
      }
      
      protected function PerformPacket_CS_SingleFightRankReq() : void
      {
      }
      
      protected function ProcessorOnInitFristMovie() : void
      {
         if(SParametersCore.IsNewUser)
         {
            if(this.FOnProcessorPlayView != null)
            {
               this.FOnProcessorPlayView(this,CONST_PLOT.PLOT_MODE_Movie,CONST_PLOT.RESOURCESID_Swf_StartMovie);
               MusicPlayNext(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SCENE_Nodal,15101000,false);
            }
         }
      }
      
      protected function ProcessorOnInitAllNpc() : void
      {
         if(this.FOnInitAllNpc != null)
         {
            this.FOnInitAllNpc(this);
         }
      }
      
      protected function CharacterLoadMilitaryReq() : void
      {
         if(this.FOnInitMilitaryInfor != null)
         {
            this.FOnInitMilitaryInfor(this);
         }
      }
      
      protected function ProcessorOnStartFreshGuide() : void
      {
         if(this.FOnStartFreshGuide != null)
         {
            this.FOnStartFreshGuide(this);
         }
      }
      
      protected function ProcessorOnUpdateAllHeroEquipmentMountedSuitCount() : void
      {
         if(this.FOnUpdateAllHeroEquipmentMountedSuitCount != null)
         {
            this.FOnUpdateAllHeroEquipmentMountedSuitCount(this);
         }
      }
      
      protected function ProcessorOnEnabledCheckSpeedUp() : void
      {
         if(this.FOnEnabledCheckSpeedUp != null)
         {
            this.FOnEnabledCheckSpeedUp(this);
         }
      }
      
      protected function ProcessorOnRequestMilitaryInfor() : void
      {
         if(this.FRequestMilitaryInfor != null)
         {
            this.FRequestMilitaryInfor(this);
         }
      }
      
      protected function PacketPerform_CS_EntrantStatus() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_EntrantStatus);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnInitCrossServerMallInfo() : void
      {
         if(this.FOnInitCrossServerMallInfo != null)
         {
            this.FOnInitCrossServerMallInfo(this);
         }
      }
      
      protected function PerformPacket_CS_LoadTitleList_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Title_LoadTitleList_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_ActivityPetLoad_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLing_AllMsg_one);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_InitEnergyReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Magic_InitEnergyReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_InitDailyWelfare() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyWelfare_LoadInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyWelfare_DailyGetBackRecordReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_NarutoRoadTaskId() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_LoadTaskReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_GroupBattlt_LeagueInfoNtf_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_GroupBattlt_LeagueInfoNtf_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BloodSoulPurgatoryReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_Initili_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_IsOpenTopTeamIcon() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Icon_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_Left_Btl_Cnt_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopTeam_Left_Btl_Cnt_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_Progress_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoHelper_Progress_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function NijiaMysticInitReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_InitReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BloodSoulPurgatoryCustomsInitiReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BloodSoulPurgatory_Customs_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function SixFairyCustomsInitReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SixFairyMan_CustomsInitili_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function RebirthRealmInitializeReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RebirthRealm_AttributeInitili_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function FeteBloodInitializeReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_FBB_C2S_LoadDB_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ArenaRewardStatusReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_RewardStatusRet);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_TongLingReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingAnimal_Rep);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_TongLingCheck() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingZhenXingOpen_Rep);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingOpenLocation_Rep);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_SeasonStatusReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_SeasonStatusReq);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CharacterLoadSign() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Sign_Load);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_NewInfo() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Reward_NewInfo);
         _loc1_ = _loc2_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PACKETID_C2S_MAZE_Get_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_MAZE_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function RequestOnlineExtendInFormation() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Backpack_OnlineExtendInforMation_Req);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function BaiDuSuperVip() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaiDuMM_JIHUO_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaiDuMM_GetReward_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_C2S_World_Tree_Get_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_World_Tree_Get_Info);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OhtsutsukiKaguyaInitilization() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Dark_Bright_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function TransmigrationTrial_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationTrial_BaseInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PACKETID_C2S_Awaken_Get_OnOff_Skill_Info() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Get_OnOff_Skill_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function TabooGetBackPagkeInformation() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Skill_Get_Bag);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Skill_Get_Learn);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Taboo_Tower_Get_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function UnderTown_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Dungeons_Get_BaseInfo);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnLine_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_OnLineLiBao_InforMation);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function MiOnLine_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_OnLineMicroLogin_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function TransmigrationAccessory_Req() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationAccessory_BaseInfo_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PacketPerform_CS_Data2_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Data2_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PacketPerform_CS_Data_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Prerogative_Data_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ObligatoryCourses_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_ObligatoryCoursesReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_NinjaHostel_Init_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaHostel_Init_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_ConsumeVipInfo() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_ConsumeVip_InfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function WorldMatchRewardReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatch_UserInfo);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnInitMallInfo() : void
      {
         if(this.FOnInitMallInfo != null)
         {
            this.FOnInitMallInfo(this);
         }
      }
      
      protected function ProcessorOnInitPvpMallInfo() : void
      {
         if(this.FOnInitPvpMallInfo != null)
         {
            this.FOnInitPvpMallInfo(this);
         }
      }
      
      protected function CharacterVipInfoReq() : void
      {
         if(this.FOnInitVipInfo != null)
         {
            this.FOnInitVipInfo(this);
         }
      }
      
      protected function ProcessorOnUpdateVipInfo() : void
      {
         if(this.FOnUpdateVipInfo != null)
         {
            this.FOnUpdateVipInfo(this);
         }
      }
      
      protected function ProcessorLoadFollowUp() : void
      {
         if(this.FOnLoadFollowUp != null)
         {
            this.FOnLoadFollowUp(this);
         }
      }
      
      protected function ProcessorCreateRole() : void
      {
         if(this.FOnCreateRole != null)
         {
            this.FOnCreateRole(this);
         }
      }
      
      protected function ProcessorOnUserTotalFightingPowerReq() : void
      {
         if(this.FOnUserTotalFightingPowerReq != null)
         {
            this.FOnUserTotalFightingPowerReq(this,CONST_ACCOUNT.TYPE_FirstFightPowerReq);
         }
      }
      
      protected function ProcessorOnEnterTown() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_Enter_Town);
         _loc2_ = _loc1_.Data;
         _loc2_.writeUnsignedInt(this.FCharacter.TownID);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CreatVirtualNames() : String
      {
         var _loc1_:uint = 0;
         var _loc2_:Vector.<String> = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _loc1_ = TUtilityMath.RandomRange(0,this.FLastNames.length - 1);
         _loc3_ = this.FLastNames[_loc1_];
         _loc1_ = TUtilityMath.RandomRange(0,1);
         switch(_loc1_)
         {
            case GENDER_Female:
               _loc2_ = this.FFemaleNames;
               break;
            case GENDER_Male:
               _loc2_ = this.FMaleNames;
         }
         _loc1_ = TUtilityMath.RandomRange(0,_loc2_.length - 1);
         _loc4_ = _loc2_[_loc1_];
         return _loc3_ + _loc4_;
      }
      
      protected function ButtonRandomNameOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Vector.<String> = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         _loc2_ = TUtilityMath.RandomRange(0,this.FLastNames.length - 1);
         _loc4_ = this.FLastNames[_loc2_];
         switch(this.FGender)
         {
            case GENDER_Female:
               _loc3_ = this.FFemaleNames;
               break;
            case GENDER_Male:
               _loc3_ = this.FMaleNames;
         }
         _loc2_ = TUtilityMath.RandomRange(0,_loc3_.length - 1);
         _loc5_ = _loc3_[_loc2_];
         this.FTF_UserName.text = _loc4_ + _loc5_;
      }
      
      protected function ButtonCreateRoleOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc3_ = _loc2_.Data;
         _loc4_ = this.FTF_UserName.text;
         _loc5_ = uint(this.FProfession);
         _loc7_ = this.FTempVirtualNamesA.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(this.FTempVirtualNamesA[_loc6_] == _loc4_)
            {
               EffectGenerateText(STRING_COMMON.STRING_NameRepeat);
               return;
            }
            _loc6_++;
         }
         TUtilityString.FlushUTF(_loc3_,_loc4_);
         _loc3_.writeByte(_loc5_);
         _loc3_.writeByte(this.FGender);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function SelectRoleOnClick(param1:int) : void
      {
         if(param1 == PROFESSIONS[2] || param1 == PROFESSIONS[3])
         {
            this.FProfession = CONST_CHARACTER.PROFESSION_Strength;
         }
         else if(param1 == PROFESSIONS[0] || param1 == PROFESSIONS[1])
         {
            this.FProfession = CONST_CHARACTER.PROFESSION_Agility;
         }
         else if(param1 == PROFESSIONS[4] || param1 == PROFESSIONS[5])
         {
            this.FProfession = CONST_CHARACTER.PROFESSION_Intellect;
         }
         this.FGender = param1 % 2;
         if(this.FTF_UserName != null)
         {
            if(TUtilityString.Empty(this.FTF_UserName.text))
            {
               this.ButtonRandomNameOnClick(null);
            }
         }
      }
      
      protected function OnPlaySilhouette(param1:TCharacterBox, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         this.FProfessionFrame = param1.ProfessionFrame;
         if(this.FProfessionFrame == 7)
         {
            this.FProfessionFrame = 1;
         }
         else if(this.FProfessionFrame == 0)
         {
            this.FProfessionFrame = 3;
         }
         _loc3_ = this.FMC_Account[BIGICONLIST];
         _loc3_[BIGICON].gotoAndStop(this.FProfessionFrame);
         _loc3_[BIGICON][Icon].addChild(this.FNpcBitmap);
         this.FNpcBitmap.bitmapData = null;
         _loc4_ = this.FMC_Account[PROFESSION_NAME];
         _loc4_.gotoAndStop(this.FProfessionFrame);
         if(param2)
         {
            _loc3_.gotoAndPlay(1);
            this.SelectRoleOnClick(this.FProfessionFrame);
            this.FExplainBox[EXPLAIN].gotoAndStop(this.FProfessionFrame);
            this.FExplainBox.gotoAndPlay(1);
         }
         else
         {
            _loc3_.gotoAndStop(1);
         }
      }
      
      protected function ProcessorOpenSocketLoading() : void
      {
         if(this.FOnOpenSocketLoading != null)
         {
            this.FOnOpenSocketLoading(this);
         }
      }
      
      protected function ProcessorCloseSocketLoading() : void
      {
         if(this.FOnCloseSocketLoading != null)
         {
            this.FOnCloseSocketLoading(this);
         }
      }
      
      public function get OnLoadFollowUp() : Function
      {
         return this.FOnLoadFollowUp;
      }
      
      public function set OnLoadFollowUp(param1:Function) : void
      {
         this.FOnLoadFollowUp = param1;
      }
      
      public function get OnCreateRole() : Function
      {
         return this.FOnCreateRole;
      }
      
      public function set OnCreateRole(param1:Function) : void
      {
         this.FOnCreateRole = param1;
      }
      
      public function get OnUserUpdateBaseInfo() : Function
      {
         return this.FOnUserUpdateBaseInfo;
      }
      
      public function set OnUserUpdateBaseInfo(param1:Function) : void
      {
         this.FOnUserUpdateBaseInfo = param1;
      }
      
      public function get UpdateHeroPower() : Function
      {
         return this.FUpdateHeroPower;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function get OnUserUpdateStrengthenCD() : Function
      {
         return this.FOnUserUpdateStrengthenCD;
      }
      
      public function set OnUserUpdateStrengthenCD(param1:Function) : void
      {
         this.FOnUserUpdateStrengthenCD = param1;
      }
      
      public function get OnUserLevelUp() : Function
      {
         return this.FOnUserLevelUp;
      }
      
      public function set OnUserLevelUp(param1:Function) : void
      {
         this.FOnUserLevelUp = param1;
      }
      
      public function get OnUserLevelUpEffect() : Function
      {
         return this.FOnUserLevelUpEffect;
      }
      
      public function set OnUserLevelUpEffect(param1:Function) : void
      {
         this.FOnUserLevelUpEffect = param1;
      }
      
      public function get OnCharacterBaseAttribute() : Function
      {
         return this.FOnUpdateHerosBaseAttributeReq;
      }
      
      public function set OnCharacterBaseAttribute(param1:Function) : void
      {
         this.FOnUpdateHerosBaseAttributeReq = param1;
      }
      
      public function get OnUpdateHerosTotalFightingPower() : Function
      {
         return this.FOnUpdateHerosTotalFightingPower;
      }
      
      public function set OnUpdateHerosTotalFightingPower(param1:Function) : void
      {
         this.FOnUpdateHerosTotalFightingPower = param1;
      }
      
      public function get OnUpdataSeverTime() : Function
      {
         return this.FOnUpdataSeverTime;
      }
      
      public function set OnUpdataSeverTime(param1:Function) : void
      {
         this.FOnUpdataSeverTime = param1;
      }
      
      public function get OnCheckAntiAddiction() : Function
      {
         return this.FOnCheckAntiAddiction;
      }
      
      public function set OnCheckAntiAddiction(param1:Function) : void
      {
         this.FOnCheckAntiAddiction = param1;
      }
      
      public function get OnProcessorPlayView() : Function
      {
         return this.FOnProcessorPlayView;
      }
      
      public function set OnProcessorPlayView(param1:Function) : void
      {
         this.FOnProcessorPlayView = param1;
      }
      
      public function set OnStartFreshGuide(param1:Function) : void
      {
         this.FOnStartFreshGuide = param1;
      }
      
      public function set OnInitMilitaryInfor(param1:Function) : void
      {
         this.FOnInitMilitaryInfor = param1;
      }
      
      public function get OnInitAllNpc() : Function
      {
         return this.FOnInitAllNpc;
      }
      
      public function set OnInitAllNpc(param1:Function) : void
      {
         this.FOnInitAllNpc = param1;
      }
      
      public function get OnUpdateAllHeroEquipmentMountedSuitCount() : Function
      {
         return this.FOnUpdateAllHeroEquipmentMountedSuitCount;
      }
      
      public function set OnUpdateAllHeroEquipmentMountedSuitCount(param1:Function) : void
      {
         this.FOnUpdateAllHeroEquipmentMountedSuitCount = param1;
      }
      
      public function get OnEnabledCheckSpeedUp() : Function
      {
         return this.FOnEnabledCheckSpeedUp;
      }
      
      public function set OnEnabledCheckSpeedUp(param1:Function) : void
      {
         this.FOnEnabledCheckSpeedUp = param1;
      }
      
      public function get OnOpenSocketLoading() : Function
      {
         return this.FOnOpenSocketLoading;
      }
      
      public function set OnOpenSocketLoading(param1:Function) : void
      {
         this.FOnOpenSocketLoading = param1;
      }
      
      public function get OnCloseSocketLoading() : Function
      {
         return this.FOnCloseSocketLoading;
      }
      
      public function set OnCloseSocketLoading(param1:Function) : void
      {
         this.FOnCloseSocketLoading = param1;
      }
      
      public function get OnInitMallInfo() : Function
      {
         return this.FOnInitMallInfo;
      }
      
      public function set OnInitMallInfo(param1:Function) : void
      {
         this.FOnInitMallInfo = param1;
      }
      
      public function set OnInitPvpMallInfo(param1:Function) : void
      {
         this.FOnInitPvpMallInfo = param1;
      }
      
      public function get OnInitVipInfo() : Function
      {
         return this.FOnInitVipInfo;
      }
      
      public function set OnInitVipInfo(param1:Function) : void
      {
         this.FOnInitVipInfo = param1;
      }
      
      public function get OnUpdateVipInfo() : Function
      {
         return this.FOnUpdateVipInfo;
      }
      
      public function set OnUpdateVipInfo(param1:Function) : void
      {
         this.FOnUpdateVipInfo = param1;
      }
      
      public function get OnEnterFamily() : Function
      {
         return this.FOnEnterFamily;
      }
      
      public function set OnEnterFamily(param1:Function) : void
      {
         this.FOnEnterFamily = param1;
      }
      
      public function get OnDailyQusetInfoReq() : Function
      {
         return this.FOnDailyQusetInfoReq;
      }
      
      public function set OnDailyQusetInfoReq(param1:Function) : void
      {
         this.FOnDailyQusetInfoReq = param1;
      }
      
      public function get OnActivityInfoReq() : Function
      {
         return this.FOnActivityInfoReq;
      }
      
      public function set OnActivityInfoReq(param1:Function) : void
      {
         this.FOnActivityInfoReq = param1;
      }
      
      public function get OnInitQuests() : Function
      {
         return this.FOnInitQuests;
      }
      
      public function set OnInitQuests(param1:Function) : void
      {
         this.FOnInitQuests = param1;
      }
      
      public function get MainHeroQualityOnChange() : Function
      {
         return this.FMainHeroQualityOnChange;
      }
      
      public function set MainHeroQualityOnChange(param1:Function) : void
      {
         this.FMainHeroQualityOnChange = param1;
      }
      
      public function set RequestMilitaryInfor(param1:Function) : void
      {
         this.FRequestMilitaryInfor = param1;
      }
      
      public function get OnBigDipperInfoReq() : Function
      {
         return this.FOnBigDipperInfoReq;
      }
      
      public function set OnBigDipperInfoReq(param1:Function) : void
      {
         this.FOnBigDipperInfoReq = param1;
      }
      
      public function get OnInitCrossServerMallInfo() : Function
      {
         return this.FOnInitCrossServerMallInfo;
      }
      
      public function set OnInitCrossServerMallInfo(param1:Function) : void
      {
         this.FOnInitCrossServerMallInfo = param1;
      }
      
      public function get OnUserTotalFightingPowerReq() : Function
      {
         return this.FOnUserTotalFightingPowerReq;
      }
      
      public function set OnUserTotalFightingPowerReq(param1:Function) : void
      {
         this.FOnUserTotalFightingPowerReq = param1;
      }
      
      override public function ChatOptionsSetup(param1:TChatOptions) : void
      {
         param1.ChatStatus = CONST_CHAT.MODE_Hidden;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.ProcessorCloseSocketLoading();
      }
      
      override public function Unmount() : void
      {
         this.FRotationCharacter.Release();
         this.removeChild(this.FMC_Account);
         this.ProcessorCloseSocketLoading();
      }
      
      public function UserEnterTownRequest() : void
      {
         this.ProcessorOnEnterTown();
      }
   }
}

