package Processors.Game.Lobby.CrossServerWar
{
   import Externals.SExternalCore;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.CrossServerWar.TChallengePlayer;
   import Logics.CrossServerWar.TChallengePlayers;
   import Logics.CrossServerWar.TCrossServerReport;
   import Logics.CrossServerWar.TCrossServerReports;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TGSPVP_BattleZone;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowCrossServerWar extends TProcessorLobbyWindow
   {
      
      protected static const CONST_AUTOBATTLE_Time:uint = 10;
      
      protected static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      protected static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected static const CAPACITY_CommonHeros:uint = 6;
      
      protected static const CAPACITY_SuperHeros:uint = 4;
      
      protected static const CAPACITY_Reports:uint = 5;
      
      protected static const LEVELFLOORVEC:Array = [[0,1,2,3,4,5],[6,7,8,9,10],[11,12,13,14],[15,16],[17]];
      
      protected static const GAP_Width:uint = 83;
      
      protected static const START_POSY_HeroHead:Vector.<int> = Vector.<int>([40,80,115,187,222]);
      
      protected var FMC_DetailInfo:Sprite;
      
      protected var FTF_Silver:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FTF_GiftCertificate:TextField;
      
      protected var FTF_YesterdayRank:TextField;
      
      protected var FTF_CurrentRank:TextField;
      
      protected var FTF_PVPFightPower:TextField;
      
      protected var FTF_Group:TextField;
      
      protected var FTF_TodayScore:TextField;
      
      protected var FTF_YesterdayAdvancedScore:TextField;
      
      protected var FTF_ChallengeCount:TextField;
      
      protected var FTF_ChallengeEndTime:TextField;
      
      protected var FTF_TokenCount:TextField;
      
      protected var FBTN_AddChallengeCount:SimpleButton;
      
      protected var FTF_Join:TextField;
      
      protected var FMC_ChallengeList:MovieClip;
      
      protected var FMC_CommonFightAll:Sprite;
      
      protected var FMC_SuperFightAll:Sprite;
      
      protected var FTF_BattleZone:TextField;
      
      protected var FMC_Report:MovieClip;
      
      protected var FTF_TomorrowJoin:TextField;
      
      protected var FBTN_Join:MovieClip;
      
      protected var FBTN_Cheers:MovieClip;
      
      protected var FBTN_SoulExchange:MovieClip;
      
      protected var FBTN_ChallengeRankings:SimpleButton;
      
      protected var FBTN_Challenge:SimpleButton;
      
      protected var FBTN_AutoChallenge:MovieClip;
      
      protected var FBTN_LookAll:MovieClip;
      
      protected var FBTN_SuperChallenge:MovieClip;
      
      protected var FBTN_TokenExchange:MovieClip;
      
      protected var FMC_AutoTime:MovieClip;
      
      protected var FTF_AutoTime:TextField;
      
      protected var FMC_Self:Sprite;
      
      protected var FMC_RivalParent:MovieClip;
      
      protected var FMC_Rival:Sprite;
      
      protected var FBMP_Self:Bitmap;
      
      protected var FBMP_Rival:Bitmap;
      
      protected var FSelfBigPicId:uint;
      
      protected var FRivalBigPicId:uint;
      
      protected var FMC_SuperChallengePlayers:MovieClip;
      
      protected var FMC_SuperChallengePlayersParent:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FStepChallengeHeroHeads:Vector.<TUIHeroHead>;
      
      protected var FSkipChallengeHeroHeads:Vector.<TUIHeroHead>;
      
      protected var FCurChallengeHeroHeads:Vector.<TUIHeroHead>;
      
      protected var FStepChallengePlayers:TChallengePlayers;
      
      protected var FSkipChallengePlayers:TChallengePlayers;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FCharacter:TCharacter;
      
      protected var FCurrentShowHero:THero;
      
      protected var FStepFloor:uint;
      
      protected var FSkipFloor:uint;
      
      protected var FChallengePlayer:TChallengePlayer;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowInformationSkip:TUIWindowConfirmation;
      
      protected var FTextReportVect:Vector.<TextField>;
      
      protected var FBtnReportVect:Vector.<MovieClip>;
      
      protected var FAddCountCost:uint;
      
      protected var FSkipChallengeCost:uint;
      
      protected var FEndTime:uint;
      
      protected var FDate:Date;
      
      protected var FCurChallengerPlayers:TChallengePlayers;
      
      protected var FCrossServerReports:TCrossServerReports;
      
      protected var FHelpHint:THint;
      
      protected var FAddCountHint:THint;
      
      protected var FAutoTime:uint;
      
      protected var FOnOpenScoreRanking:Function;
      
      protected var FOnOpenStepChallenge:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      protected var FOnEliteApply:Function;
      
      protected var FOnChallengePlayer:Function;
      
      protected var FOnOpenSoulExchange:Function;
      
      protected var FOnOpenTokenExchange:Function;
      
      protected var FOnOpenToast:Function;
      
      protected var FOnAddChallengeCount:Function;
      
      protected var FHelpOnOver:Function;
      
      protected var FHelpOnOut:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowCrossServerWar(param1:TUIComponent)
      {
         super(param1);
         this.FStepChallengeHeroHeads = new Vector.<TUIHeroHead>(CAPACITY_CommonHeros);
         this.FSkipChallengeHeroHeads = new Vector.<TUIHeroHead>(CAPACITY_SuperHeros);
         this.FTextReportVect = new Vector.<TextField>(CAPACITY_Reports);
         this.FBtnReportVect = new Vector.<MovieClip>(CAPACITY_Reports);
         this.FStepChallengePlayers = SLogicsCore.StepChallengePlayers;
         this.FSkipChallengePlayers = SLogicsCore.SkipChallengePlayers;
         this.FCharacter = SLogicsCore.Character;
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FHelpHint = new THint();
         this.FAddCountHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CROSSSERVERWAR.RESOURCESID_Swf_CrossServerWar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIHeroHead = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CROSSSERVERWAR.RESOURCE_ClassName_MC_CrossServerWar) as Sprite;
         addChild(_loc1_);
         this.FMC_ChallengeList = _loc1_["MC_ChallengeList"];
         this.FMC_DetailInfo = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_DetailInfo];
         this.FTF_Silver = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Silver];
         this.FTF_Gold = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Gold];
         this.FTF_GiftCertificate = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_GiftCertificate];
         this.FTF_YesterdayRank = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_YesterdayRank];
         this.FTF_CurrentRank = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_CurrentRank];
         this.FTF_PVPFightPower = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_PVPFightPower];
         this.FTF_Group = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Group];
         this.FTF_TodayScore = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_TodayScore];
         this.FTF_YesterdayAdvancedScore = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_YesterdayAdvancedScore];
         this.FTF_ChallengeCount = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_ChallengeCount];
         this.FTF_ChallengeEndTime = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_ChallengeEndTime];
         this.FTF_TokenCount = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_TokenCount];
         this.FBTN_AddChallengeCount = this.FMC_DetailInfo[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_AddChallengeCount];
         this.FBTN_Join = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Join];
         this.FTF_Join = this.FBTN_Join["TF_Join"];
         TGameUtil.setButtonMode(this.FBTN_Join,true);
         this.FBTN_Cheers = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Cheers];
         TGameUtil.setButtonMode(this.FBTN_Cheers,true);
         this.FBTN_SoulExchange = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_SoulExchange];
         TGameUtil.setButtonMode(this.FBTN_SoulExchange,true);
         this.FBTN_TokenExchange = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_TokenExchange];
         TGameUtil.setButtonMode(this.FBTN_TokenExchange,true);
         this.FBTN_ChallengeRankings = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_ChallengeRankings];
         this.FBTN_Challenge = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Challenge];
         this.FBTN_AutoChallenge = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_AutoChallenge];
         this.FBTN_LookAll = this.FMC_ChallengeList[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_LookAll];
         TGameUtil.setButtonMode(this.FBTN_LookAll,true);
         this.FMC_AutoTime = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_AutoTime];
         this.FTF_AutoTime = this.FMC_AutoTime[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_AutoTime];
         this.FBTN_SuperChallenge = this.FMC_ChallengeList[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_SuperChallenge];
         TGameUtil.setButtonMode(this.FBTN_SuperChallenge,true);
         this.FMC_Self = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Self] as Sprite;
         this.FMC_RivalParent = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Rival];
         this.FMC_Rival = this.FMC_RivalParent[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Rival] as Sprite;
         this.FMC_SuperChallengePlayersParent = this.FMC_ChallengeList[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_SuperChallengePlayers];
         this.FMC_SuperChallengePlayers = this.FMC_SuperChallengePlayersParent[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_SuperChallengePlayers];
         _loc3_ = CAPACITY_CommonHeros;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TUIHeroHead(this);
            _loc4_.Resource = this.FMC_ChallengeList[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Hero + _loc2_];
            _loc4_.OnClick = this.ProcessorUIHeroHeadOnClick;
            _loc4_.OnOver = this.ProcessorUIHeroHeadOnOver;
            _loc4_.OnOut = this.ProcessorUIHeroHeadOnOut;
            _loc4_.Init();
            this.FStepChallengeHeroHeads[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc3_ = CAPACITY_SuperHeros;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TUIHeroHead(this);
            _loc4_.Resource = this.FMC_SuperChallengePlayers[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Hero + _loc2_];
            _loc4_.OnClick = this.ProcessorUIHeroHeadOnClick;
            _loc4_.OnOver = this.ProcessorUIHeroHeadOnOver;
            _loc4_.OnOut = this.ProcessorUIHeroHeadOnOut;
            _loc4_.Init();
            this.FSkipChallengeHeroHeads[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FBTN_Close = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Close][CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Close][CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Help];
         this.FBMP_Self = new Bitmap();
         this.FMC_Self[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_LargePicMountPoint].addChild(this.FBMP_Self);
         this.FMC_Self[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_LargePicMountPoint].mouseEnabled = false;
         this.FBMP_Rival = new Bitmap();
         this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_LargePicMountPoint].addChild(this.FBMP_Rival);
         this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_LargePicMountPoint].mouseEnabled = false;
         this.FSelfBigPicId = this.FCharacter.GetMainHero().LargeID;
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FUIWindowInformationSkip = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformationSkip.OnOK = this.WindowInformationSkipOnOK;
         this.FUIWindowInformationSkip.x = (STAGE_Width - this.FUIWindowInformationSkip.WindowWidth) / 2;
         this.FUIWindowInformationSkip.y = (STAGE_Height - this.FUIWindowInformationSkip.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformationSkip);
         this.FMC_CommonFightAll = this.FMC_ChallengeList["MC_HeroSelect_Bg"]["MC_FightAll"];
         this.FMC_SuperFightAll = this.FMC_SuperChallengePlayersParent["MC_FightAll"];
         this.FTF_BattleZone = _loc1_["TF_BattleZone"];
         this.FTF_BattleZone.text = "";
         this.FMC_Report = _loc1_["MC_Report"];
         _loc3_ = CAPACITY_Reports;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FTextReportVect[_loc2_] = this.FMC_Report["TF_FightReport_" + _loc2_];
            this.FTextReportVect[_loc2_].text = "";
            this.FBtnReportVect[_loc2_] = this.FMC_Report["BTN_FightReport_" + _loc2_];
            TGameUtil.setButtonMode(this.FBtnReportVect[_loc2_],true);
            _loc2_++;
         }
         this.FTF_TomorrowJoin = _loc1_["TF_TomorrowJoin"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         this.FBTN_AddChallengeCount.addEventListener(MouseEvent.CLICK,this.AddChallengeCountOnClick,false,0,true);
         this.FBTN_AddChallengeCount.addEventListener(MouseEvent.MOUSE_OUT,this.AddChallengeCountOnOut,false,0,true);
         this.FBTN_AddChallengeCount.addEventListener(MouseEvent.MOUSE_MOVE,this.AddChallengeCountOnMove,false,0,true);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.BTNHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.BTNHelpOnOut,false,0,true);
         this.FBTN_ChallengeRankings.addEventListener(MouseEvent.CLICK,this.BTNChallengeRankingsOnClick,false,0,true);
         this.FBTN_SuperChallenge.addEventListener(MouseEvent.CLICK,this.BTNSuperChallengeOnClick,false,0,true);
         this.FBTN_SuperChallenge.addEventListener(MouseEvent.MOUSE_MOVE,this.BTNSuperChallengeOnOver,false,0,true);
         this.FBTN_SuperChallenge.addEventListener(MouseEvent.ROLL_OUT,this.BTNSuperChallengeOnOut,false,0,true);
         this.FBTN_LookAll.addEventListener(MouseEvent.CLICK,this.BTNLookAllOnClick,false,0,true);
         this.FBTN_Join.addEventListener(MouseEvent.CLICK,this.BTNJoinOnClick,false,0,true);
         this.FBTN_Challenge.addEventListener(MouseEvent.CLICK,this.BTNChallengeOnClick,false,0,true);
         this.FBTN_AutoChallenge.addEventListener(MouseEvent.CLICK,this.BTNAutoChallengeOnClick,false,0,true);
         this.FBTN_Cheers.addEventListener(MouseEvent.CLICK,this.BTNCheersOnClick,false,0,true);
         this.FBTN_SoulExchange.addEventListener(MouseEvent.CLICK,this.BTNSoulExchangeOnClick,false,0,true);
         this.FBTN_TokenExchange.addEventListener(MouseEvent.CLICK,this.BTNTokenExchangeOnClick,false,0,true);
         _loc3_ = CAPACITY_Reports;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FBtnReportVect[_loc2_];
            _loc4_.addEventListener(MouseEvent.CLICK,this.BTNLookReportOnClick,false,0,true);
            _loc2_++;
         }
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GSPVP_DailyCloseBattleTime) as TConfigValue;
         this.FEndTime = _loc1_.Value[0];
         this.FDate = new Date(STimingCore.GetServerTime() * 1000);
         this.FDate.setHours(23,59,59,999);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GSPVP_DailyChallengeNum_Price) as TConfigValue;
         this.FAddCountCost = _loc1_.Value as uint;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GSPVP_DailyHighEnemyGroup_Buy) as TConfigValue;
         this.FSkipChallengeCost = _loc1_.Value as uint;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:THero = null;
         var _loc2_:Number = NaN;
         if(!this.Visible)
         {
            return;
         }
         if(STimingCore.GetServerTime() * 1000 > this.FDate.valueOf())
         {
            this.FDate = new Date(STimingCore.GetServerTime() * 1000);
         }
         if(this.FEliteRecord != null)
         {
            _loc2_ = this.FDate.setHours(this.FEndTime,0,0,0);
            this.FTF_ChallengeEndTime.text = TGameUtil.fomatTime(_loc2_ / 1000 - STimingCore.GetServerTime());
         }
         this.UpdateSelfBigBitmap();
         this.UpdateRivalBigBitmap();
         this.UpdateAutoBattleTime();
         super.LogicsPerform();
      }
      
      protected function ResetRecord() : void
      {
         this.FTF_Silver.text = "";
         this.FTF_Gold.text = "";
         this.FTF_GiftCertificate.text = "";
         this.FTF_YesterdayRank.text = "";
         this.FTF_CurrentRank.text = "";
         this.FTF_PVPFightPower.text = "";
         this.FTF_Group.text = "";
         this.FTF_TodayScore.text = "";
         this.FTF_YesterdayAdvancedScore.text = "";
         this.FTF_ChallengeCount.text = "";
         this.FTF_ChallengeEndTime.text = "";
      }
      
      protected function UpdateStepChallengeList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TChallengePlayer = null;
         var _loc8_:TUIHeroHead = null;
         _loc6_ = -1;
         _loc2_ = uint(this.FStepChallengePlayers.Count);
         _loc1_ = 0;
         loop0:
         while(_loc1_ < _loc2_)
         {
            _loc7_ = this.FStepChallengePlayers.GetChallengePlayerByIndex(_loc1_);
            if(!_loc7_.IsDefeated)
            {
               _loc5_ = _loc1_;
               _loc4_ = LEVELFLOORVEC.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc6_ = int(LEVELFLOORVEC[_loc3_].indexOf(_loc5_));
                  if(_loc6_ > -1)
                  {
                     this.FStepFloor = _loc3_;
                     break loop0;
                  }
                  _loc3_++;
               }
            }
            _loc1_++;
         }
         _loc2_ = CAPACITY_CommonHeros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc8_ = this.FStepChallengeHeroHeads[_loc1_];
            _loc8_.Context = null;
            _loc8_.Resource.visible = false;
            _loc1_++;
         }
         if(_loc6_ == -1)
         {
            _loc5_ = this.FStepChallengePlayers.Count - 1;
            _loc4_ = LEVELFLOORVEC.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc6_ = int(LEVELFLOORVEC[_loc3_].indexOf(_loc5_));
               if(_loc6_ > -1)
               {
                  this.FStepFloor = _loc3_;
               }
               _loc3_++;
            }
            this.FMC_CommonFightAll.visible = true;
         }
         else
         {
            this.FMC_CommonFightAll.visible = false;
            this.UpdateStepChallengeHeroHeadInfo();
         }
      }
      
      protected function UpdateStepChallengeHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TChallengePlayer = null;
         _loc2_ = uint(LEVELFLOORVEC[this.FStepFloor].length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(LEVELFLOORVEC[this.FStepFloor][_loc1_] >= this.FStepChallengePlayers.Count)
            {
               break;
            }
            _loc3_ = this.FStepChallengeHeroHeads[_loc1_];
            _loc3_.HideSelect();
            _loc4_ = this.FStepChallengePlayers.GetChallengePlayerByIndex(LEVELFLOORVEC[this.FStepFloor][_loc1_]);
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
         this.LocationHeroHeads();
      }
      
      protected function SelectDefaultHeroHead() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TChallengePlayer = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         _loc7_ = true;
         _loc6_ = this.FChallengePlayer == null ? 0 : this.FChallengePlayer.Type;
         if(this.FCurChallengerPlayers == null)
         {
            this.FCurChallengerPlayers = this.FStepChallengePlayers;
            this.FCurChallengeHeroHeads = this.FStepChallengeHeroHeads;
         }
         if(_loc6_ == CONST_CROSSSERVERWAR.TYPE_CommonChallenge)
         {
            _loc2_ = uint(LEVELFLOORVEC[this.FStepFloor].length);
         }
         else
         {
            _loc2_ = CAPACITY_SuperHeros;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc6_ == CONST_CROSSSERVERWAR.TYPE_CommonChallenge)
            {
               _loc5_ = int(LEVELFLOORVEC[this.FStepFloor][_loc1_]);
            }
            else
            {
               _loc5_ = _loc1_ + this.FSkipFloor * CAPACITY_SuperHeros;
            }
            if(_loc5_ >= this.FCurChallengerPlayers.Count)
            {
               break;
            }
            _loc4_ = this.FCurChallengerPlayers.GetChallengePlayerByIndex(_loc5_);
            _loc3_ = this.FCurChallengeHeroHeads[_loc1_];
            if(!_loc4_.IsDefeated)
            {
               _loc3_.DefaultSelect();
               _loc7_ = false;
               break;
            }
            _loc1_++;
         }
         if(_loc7_)
         {
            this.ResetRivalInfo();
         }
      }
      
      protected function LocationHeroHeads() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TChallengePlayer = null;
         _loc2_ = uint(LEVELFLOORVEC[this.FStepFloor].length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(LEVELFLOORVEC[this.FStepFloor][_loc1_] >= this.FStepChallengePlayers.Count)
            {
               break;
            }
            _loc3_ = this.FStepChallengeHeroHeads[_loc1_];
            _loc3_.Resource.visible = true;
            _loc3_.Resource.y = START_POSY_HeroHead[this.FStepFloor] - this.FMC_ChallengeList.y + GAP_Width * _loc1_;
            _loc1_++;
         }
      }
      
      protected function UpdateSkipChallengeList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TChallengePlayer = null;
         var _loc4_:Boolean = false;
         var _loc5_:TUIHeroHead = null;
         _loc4_ = true;
         _loc2_ = uint(this.FSkipChallengePlayers.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSkipChallengePlayers.GetChallengePlayerByIndex(_loc1_);
            if(!_loc3_.IsDefeated)
            {
               this.FSkipFloor = uint(_loc1_ / 4);
               _loc4_ = false;
               break;
            }
            _loc1_++;
         }
         if(_loc4_)
         {
            this.FSkipFloor = this.FSkipChallengePlayers.Count / 4;
            this.FMC_SuperChallengePlayers.visible = false;
            this.FMC_SuperFightAll.visible = true;
         }
         else
         {
            this.FMC_SuperChallengePlayers.visible = true;
            this.FMC_SuperFightAll.visible = false;
            this.UpdateSkipChallengeHeroHeadInfo();
         }
      }
      
      protected function UpdateSkipChallengeHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TChallengePlayer = null;
         var _loc5_:uint = 0;
         _loc2_ = CAPACITY_SuperHeros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSkipChallengeHeroHeads[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = CAPACITY_SuperHeros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc1_ + this.FSkipFloor * CAPACITY_SuperHeros;
            if(_loc5_ >= this.FSkipChallengePlayers.Count)
            {
               break;
            }
            _loc3_ = this.FSkipChallengeHeroHeads[_loc1_];
            _loc3_.HideSelect();
            _loc4_ = this.FSkipChallengePlayers.GetChallengePlayerByIndex(_loc5_);
            _loc3_.Context = _loc4_;
            _loc3_.Resource.visible = true;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateRecord() : void
      {
         this.FTF_Silver.text = this.FCharacter.CreditSilverCoin.ToNumber().toString();
         this.FTF_Gold.text = this.FCharacter.CreditGold.toString();
         this.FTF_GiftCertificate.text = this.FCharacter.CreditGiftCertificate.toString();
         this.FTF_YesterdayRank.text = this.FEliteRecord.RankYestoday.toString();
         this.FTF_CurrentRank.text = this.FEliteRecord.RankToday.toString();
         this.FTF_PVPFightPower.text = this.FEliteRecord.FightingPower.toString();
         this.FTF_Group.text = STRING_CROSSSERVERWAR.CrossServerWar_Group[this.FEliteRecord.GroupLevel];
         this.FTF_YesterdayAdvancedScore.text = this.FEliteRecord.ScoreYestoday.toString();
         this.FTF_TodayScore.text = this.FEliteRecord.ScoreToday.toString();
         this.FTF_ChallengeCount.text = this.FEliteRecord.CurFightTimes.toString();
         this.FTF_TokenCount.text = this.FEliteRecord.TokenCount.toString();
      }
      
      protected function ResetRivalInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Name].text = "";
         this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Level].text = "";
         this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Server].text = "";
         this.FRivalBigPicId = 0;
         this.FMC_RivalParent.gotoAndStop(1);
         if(this.FCurChallengerPlayers == null)
         {
            return;
         }
         if(this.FCurChallengerPlayers == this.FStepChallengePlayers)
         {
            _loc2_ = CAPACITY_CommonHeros;
            this.FCurChallengeHeroHeads = this.FStepChallengeHeroHeads;
         }
         else
         {
            _loc2_ = CAPACITY_SuperHeros;
            this.FCurChallengeHeroHeads = this.FSkipChallengeHeroHeads;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FCurChallengeHeroHeads[_loc1_];
            _loc3_.Resource.visible = false;
            _loc1_++;
         }
      }
      
      protected function UpdateHeroInfo(param1:TChallengePlayer = null) : void
      {
         this.FMC_Self[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Name].text = this.FCharacter.NickName;
         this.FMC_Self[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Level].text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FCharacter.GetMainLevel());
         this.FMC_Self[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Server].text = "";
         if(param1 != null)
         {
            this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Name].text = param1.TargetName;
            this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Level].text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.TargetLevel);
            this.FMC_Rival[CONST_CROSSSERVERWAR.RESOURCE_Link_TF_Server].text = param1.TargetServerName;
         }
      }
      
      protected function UpdateSelfBigBitmap() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FSelfBigPicId != 0)
         {
            _loc1_ = TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FBMP_Self,CONST_MODULES.MODULE_CrossServerWar,this.FSelfBigPicId);
         }
      }
      
      protected function UpdateRivalBigBitmap() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FRivalBigPicId != 0)
         {
            _loc1_ = TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FBMP_Rival,CONST_MODULES.MODULE_CrossServerWar,this.FRivalBigPicId);
         }
         else
         {
            this.FBMP_Rival.bitmapData = null;
         }
      }
      
      protected function UpdateAutoBattleTime() : void
      {
         var _loc1_:int = 0;
         this.FMC_AutoTime.visible = this.FEliteRecord.IsAutoBattle;
         if(this.FEliteRecord.IsAutoBattle)
         {
            _loc1_ = this.FAutoTime - STimingCore.GetServerTick();
            if(_loc1_ <= CONST_AUTOBATTLE_Time)
            {
               this.FTF_AutoTime.text = _loc1_ + "";
            }
            if(_loc1_ <= 0)
            {
               this.FAutoTime = int.MAX_VALUE;
               this.BTNChallengeOnClick(null);
            }
         }
      }
      
      protected function PlaySkipChallengeEffect() : void
      {
         this.FMC_SuperChallengePlayersParent.play();
      }
      
      protected function UpdateReportUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TCrossServerReport = null;
         _loc2_ = CAPACITY_Reports;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTextReportVect[_loc1_];
            _loc5_ = this.FBtnReportVect[_loc1_];
            _loc4_.visible = false;
            _loc5_.visible = false;
            _loc1_++;
         }
         if(this.FCrossServerReports != null)
         {
            _loc2_ = uint(this.FCrossServerReports.Count);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(_loc1_ >= CAPACITY_Reports)
               {
                  break;
               }
               _loc4_ = this.FTextReportVect[_loc1_];
               _loc5_ = this.FBtnReportVect[_loc1_];
               _loc3_ = _loc2_ - _loc1_ - 1;
               _loc6_ = this.FCrossServerReports.GetCrossServerReportByIndex(_loc3_);
               _loc4_.htmlText = this.MakeHtmlTextInfo(_loc6_);
               _loc4_.visible = true;
               _loc5_.visible = true;
               _loc1_++;
            }
         }
      }
      
      protected function MakeHtmlTextInfo(param1:TCrossServerReport) : String
      {
         var _loc2_:String = null;
         _loc2_ = STRING_CROSSSERVERWAR.STRING_Report_Fight;
         if(param1.IsWin)
         {
            _loc2_ += STRING_CROSSSERVERWAR.STRING_Report_Win;
         }
         else
         {
            _loc2_ += STRING_CROSSSERVERWAR.STRING_Report_Lost;
         }
         _loc2_ = _loc2_.split("%when%").join(this.GetReportWhen(param1.Time));
         return _loc2_.split("%who%").join(param1.Name);
      }
      
      protected function GetReportWhen(param1:uint) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:Date = null;
         var _loc6_:Date = null;
         _loc2_ = "";
         _loc3_ = STimingCore.GetServerTick() - param1;
         _loc4_ = _loc3_ / (24 * 60 * 60);
         if(_loc4_ < 7)
         {
            _loc5_ = new Date(STimingCore.GetServerTime() * 1000);
            _loc6_ = new Date(STimingCore.GetClientShowTime(param1) * 1000);
            if(_loc5_.day == _loc6_.day)
            {
               _loc2_ = STRING_CROSSSERVERWAR.STRING_Report_WhenVect[_loc4_];
            }
            else
            {
               _loc2_ = STRING_CROSSSERVERWAR.STRING_Report_WhenVect[_loc4_ + 1];
            }
         }
         else
         {
            _loc2_ = STRING_CROSSSERVERWAR.STRING_Report_WhenVect[STRING_CROSSSERVERWAR.STRING_Report_WhenVect.length - 1];
         }
         return _loc2_;
      }
      
      protected function AddChallengeCountOnClick(param1:MouseEvent) : void
      {
         if(this.FUIWindowInformation.IsSelected)
         {
            if(this.FOnAddChallengeCount != null)
            {
               this.FOnAddChallengeCount(this);
            }
         }
         else
         {
            this.FUIWindowInformation.Text = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_AddChallengeCountCost,this.FAddCountCost);
            this.FUIWindowInformation.Visible = true;
         }
      }
      
      protected function AddChallengeCountOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function AddChallengeCountOnMove(param1:MouseEvent) : void
      {
         this.FAddCountHint.Caption = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_RestAddChallengeCount,this.FEliteRecord.LeftBuyCount);
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FAddCountHint);
         }
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         this.FMC_RivalParent.gotoAndStop(1);
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function BTNHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_CrossServer) as TSystemLanguage;
         this.FHelpHint.Content = _loc2_.Desc;
         if(this.FHelpOnOver != null)
         {
            this.FHelpOnOver(this,this.FHelpHint);
         }
      }
      
      protected function BTNHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpOnOut != null)
         {
            this.FHelpOnOut(this);
         }
      }
      
      protected function ProcessorUIHeroHeadOnClick(param1:Object, param2:TChallengePlayer) : void
      {
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TUIHeroHead = null;
         if(param2 == null)
         {
            return;
         }
         if(param2.IsDefeated)
         {
            return;
         }
         this.FMC_RivalParent.play();
         _loc3_ = param2.TargetHeros.GetHeroByIndex(0);
         this.FRivalBigPicId = _loc3_.LargeID;
         this.UpdateHeroInfo(param2);
         this.FChallengePlayer = param2;
         if(param2.Type == CONST_CROSSSERVERWAR.TYPE_CommonChallenge)
         {
            this.FCurChallengeHeroHeads = this.FStepChallengeHeroHeads;
            _loc5_ = CAPACITY_CommonHeros;
            this.FCurChallengerPlayers = this.FStepChallengePlayers;
         }
         else
         {
            this.FCurChallengeHeroHeads = this.FSkipChallengeHeroHeads;
            _loc5_ = CAPACITY_SuperHeros;
            this.FCurChallengerPlayers = this.FSkipChallengePlayers;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = this.FCurChallengeHeroHeads[_loc4_];
            if(param2 == _loc6_.Context)
            {
               _loc6_.ShowSelect();
            }
            else
            {
               _loc6_.HideSelect();
            }
            _loc4_++;
         }
      }
      
      protected function ProcessorUIHeroHeadOnOver(param1:Object, param2:TChallengePlayer) : void
      {
         if(this.FUIComponentsOnOver != null)
         {
            this.FUIComponentsOnOver(this,param2);
         }
      }
      
      protected function ProcessorUIHeroHeadOnOut(param1:Object, param2:TChallengePlayer) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(this,param2);
         }
      }
      
      protected function BTNChallengeRankingsOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenScoreRanking != null)
         {
            this.FOnOpenScoreRanking(this);
         }
      }
      
      protected function BTNSuperChallengeOnClick(param1:MouseEvent) : void
      {
         if(Boolean(this.FEliteRecord.IsJoinSkip))
         {
            this.PlaySkipChallengeEffect();
            this.UpdateSkipChallenge();
         }
         else
         {
            this.FUIWindowInformationSkip.Text = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_SkipChallengeCost,this.FSkipChallengeCost);
            this.FUIWindowInformationSkip.Visible = true;
         }
      }
      
      protected function BTNSuperChallengeOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_06) as TSystemLanguage;
         this.FHelpHint.Content = _loc2_.Desc;
         if(this.FHelpOnOver != null)
         {
            this.FHelpOnOver(this,this.FHelpHint);
         }
      }
      
      protected function BTNSuperChallengeOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpOnOut != null)
         {
            this.FHelpOnOut(this);
         }
      }
      
      protected function BTNLookAllOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenStepChallenge != null)
         {
            this.FOnOpenStepChallenge(this);
         }
      }
      
      protected function BTNJoinOnClick(param1:MouseEvent) : void
      {
         if(this.FOnEliteApply != null)
         {
            this.FOnEliteApply(this);
         }
      }
      
      protected function BTNChallengeOnClick(param1:MouseEvent) : void
      {
         if(this.FChallengePlayer == null || this.FChallengePlayer.IsDefeated)
         {
            return;
         }
         if(this.FEliteRecord.CurFightTimes <= 0)
         {
            this.AddChallengeCountOnClick(null);
            return;
         }
         if(this.FOnChallengePlayer != null)
         {
            this.FOnChallengePlayer(this,this.FChallengePlayer);
            this.FBTN_Challenge.filters = [TGameUtil.GaryColorFilters];
            this.FBTN_Challenge.mouseEnabled = false;
         }
      }
      
      protected function BTNAutoChallengeOnClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FEliteRecord.CurFightTimes <= 0)
         {
            EffectGenerateText(STRING_CROSSSERVERWAR.STRING_CancelAutoBattle_2);
            return;
         }
         this.FEliteRecord.IsAutoBattle = !this.FEliteRecord.IsAutoBattle;
         this.UpdateStateAutoBtn();
      }
      
      protected function UpdateStateAutoBtn() : void
      {
         if(this.FEliteRecord.IsAutoBattle)
         {
            this.FAutoTime = STimingCore.GetServerTick() + CONST_AUTOBATTLE_Time;
            this.FBTN_AutoChallenge.TF_Info.text = STRING_CROSSSERVERWAR.STRING_StopAutoBattle;
         }
         else
         {
            this.FBTN_AutoChallenge.TF_Info.text = STRING_CROSSSERVERWAR.STRING_StartAutoBattle;
         }
      }
      
      protected function BTNCheersOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenToast != null)
         {
            this.FOnOpenToast(this);
         }
      }
      
      protected function BTNSoulExchangeOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenSoulExchange != null)
         {
            this.FOnOpenSoulExchange(this);
         }
      }
      
      protected function BTNTokenExchangeOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenTokenExchange != null)
         {
            this.FOnOpenTokenExchange(this);
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FOnAddChallengeCount != null)
         {
            this.FOnAddChallengeCount(this);
         }
      }
      
      protected function WindowInformationSkipOnOK(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossServerWar_SpanFightOpenReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function BTNLookReportOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         _loc2_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = uint(this.FCrossServerReports.Count);
         _loc3_ = this.FCrossServerReports.GetCrossServerReportByIndex(_loc4_ - _loc2_ - 1).ReportID;
         SExternalCore.NavigateToFightReport(_loc3_);
      }
      
      public function get OnOpenScoreRanking() : Function
      {
         return this.FOnOpenScoreRanking;
      }
      
      public function set OnOpenScoreRanking(param1:Function) : void
      {
         this.FOnOpenScoreRanking = param1;
      }
      
      public function get OnOpenStepChallenge() : Function
      {
         return this.FOnOpenStepChallenge;
      }
      
      public function set OnOpenStepChallenge(param1:Function) : void
      {
         this.FOnOpenStepChallenge = param1;
      }
      
      public function get UIComponentsOnOver() : Function
      {
         return this.FUIComponentsOnOver;
      }
      
      public function set UIComponentsOnOver(param1:Function) : void
      {
         this.FUIComponentsOnOver = param1;
      }
      
      public function get UIComponentsOnOut() : Function
      {
         return this.FUIComponentsOnOut;
      }
      
      public function set UIComponentsOnOut(param1:Function) : void
      {
         this.FUIComponentsOnOut = param1;
      }
      
      public function get OnEliteApply() : Function
      {
         return this.FOnEliteApply;
      }
      
      public function set OnEliteApply(param1:Function) : void
      {
         this.FOnEliteApply = param1;
      }
      
      public function get OnChallengePlayer() : Function
      {
         return this.FOnChallengePlayer;
      }
      
      public function set OnChallengePlayer(param1:Function) : void
      {
         this.FOnChallengePlayer = param1;
      }
      
      public function get OnOpenSoulExchange() : Function
      {
         return this.FOnOpenSoulExchange;
      }
      
      public function set OnOpenSoulExchange(param1:Function) : void
      {
         this.FOnOpenSoulExchange = param1;
      }
      
      public function get OnOpenTokenExchange() : Function
      {
         return this.FOnOpenTokenExchange;
      }
      
      public function set OnOpenTokenExchange(param1:Function) : void
      {
         this.FOnOpenTokenExchange = param1;
      }
      
      public function get OnOpenToast() : Function
      {
         return this.FOnOpenToast;
      }
      
      public function set OnOpenToast(param1:Function) : void
      {
         this.FOnOpenToast = param1;
      }
      
      public function get OnAddChallengeCount() : Function
      {
         return this.FOnAddChallengeCount;
      }
      
      public function set OnAddChallengeCount(param1:Function) : void
      {
         this.FOnAddChallengeCount = param1;
      }
      
      public function get HelpOnOver() : Function
      {
         return this.FHelpOnOver;
      }
      
      public function set HelpOnOver(param1:Function) : void
      {
         this.FHelpOnOver = param1;
      }
      
      public function get HelpOnOut() : Function
      {
         return this.FHelpOnOut;
      }
      
      public function set HelpOnOut(param1:Function) : void
      {
         this.FHelpOnOut = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      override protected function ProcessorResize() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         _loc1_ = uint(stage.stageWidth);
         _loc2_ = uint(stage.stageHeight);
         if(_loc1_ > CONST_COMMON.STAGE_Max_Width)
         {
            _loc1_ = CONST_COMMON.STAGE_Max_Width;
         }
         else if(_loc1_ < CONST_COMMON.STAGE_Min_Width)
         {
            _loc1_ = CONST_COMMON.STAGE_Min_Width;
         }
         if(_loc2_ > CONST_COMMON.STAGE_Max_Height)
         {
            _loc2_ = CONST_COMMON.STAGE_Max_Height;
         }
         else if(_loc2_ < CONST_COMMON.STAGE_Min_Height)
         {
            _loc2_ = CONST_COMMON.STAGE_Min_Height;
         }
         if(this.FMC_ChallengeList != null)
         {
            this.FMC_ChallengeList.x = _loc1_ - this.FMC_ChallengeList.width;
         }
         if(this.FTF_BattleZone != null)
         {
            this.FTF_BattleZone.x = _loc1_ - this.FTF_BattleZone.width - 45;
         }
         if(this.FMC_Report != null)
         {
            this.FMC_Report.x = (_loc1_ - this.FMC_Report.width) / 2 + 10;
            this.FMC_Report.y = _loc2_ - this.FMC_Report.height - 20;
         }
      }
      
      public function UpdateStepChallenge() : void
      {
         this.UpdateStepChallengeList();
         this.UpdateSkipChallengeList();
         this.SelectDefaultHeroHead();
         this.UpdateHeroInfo();
         this.UpdateApply();
      }
      
      public function UpdateEliteRecord() : void
      {
         this.UpdateRecord();
      }
      
      public function UpdateApply() : void
      {
         var _loc1_:TGSPVP_BattleZone = null;
         var _loc2_:Date = null;
         var _loc3_:uint = 0;
         _loc2_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc3_ = new Date(STimingCore.GetClientShowTime(this.FEliteRecord.SeasonEndTime) * 1000).date;
         if(_loc2_.date == _loc3_ - 1)
         {
            this.FTF_TomorrowJoin.text = STRING_CROSSSERVERWAR.STRING_SeasonLastDay;
            TGameUtil.setButtonMode(this.FBTN_Join,false);
            this.FBTN_Join.mouseEnabled = false;
         }
         else if(this.FEliteRecord.ApplyStatus)
         {
            TGameUtil.setButtonMode(this.FBTN_Join,false);
            this.FBTN_Join.mouseEnabled = false;
            this.FTF_Join.text = STRING_CROSSSERVERWAR.STRING_HasJoin;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Join,true);
            this.FBTN_Join.mouseEnabled = true;
            this.FTF_Join.text = STRING_CROSSSERVERWAR.STRING_Join;
         }
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_GSPVP_BattleZone,this.FEliteRecord.BattleID) as TGSPVP_BattleZone;
         if(_loc1_ != null)
         {
            this.FTF_BattleZone.text = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_BattleZone,_loc1_.BzName,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FEliteRecord.SeasonEndTime) * 1000)));
         }
      }
      
      public function UnlockedSkipChallenge() : void
      {
         this.PlaySkipChallengeEffect();
         this.UpdateSkipChallenge();
      }
      
      public function UpdateSkipChallenge() : void
      {
         this.UpdateSkipChallengeList();
         this.UpdateRecord();
      }
      
      public function UpdateChallengeCount() : void
      {
         this.FTF_ChallengeCount.text = this.FEliteRecord.CurFightTimes.toString();
      }
      
      public function UpdateReport(param1:TCrossServerReports) : void
      {
         this.FCrossServerReports = param1;
         this.UpdateReportUI();
      }
      
      public function UpdateBTNChallenge() : void
      {
         if(!this.FBTN_Challenge.mouseEnabled)
         {
            this.FBTN_Challenge.filters = [];
            this.FBTN_Challenge.mouseEnabled = true;
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(param1)
         {
            this.ProcessorResize();
            if(this.FBTN_AutoChallenge)
            {
               TGameUtil.setButtonMode(this.FBTN_AutoChallenge,Boolean(SLogicsCore.KaguyaData.GetMaxValueByType(11)));
            }
         }
      }
      
      public function ResetAutoBattleTime(param1:Boolean) : void
      {
         if(this.FEliteRecord.IsAutoBattle)
         {
            if(Boolean(param1 && this.FChallengePlayer) && Boolean(!this.FChallengePlayer.IsDefeated) && this.FEliteRecord.CurFightTimes > 0)
            {
               this.FAutoTime = STimingCore.GetServerTick() + CONST_AUTOBATTLE_Time;
            }
            else
            {
               this.FEliteRecord.IsAutoBattle = false;
               if(!param1)
               {
                  EffectGenerateText(STRING_CROSSSERVERWAR.STRING_CancelAutoBattle_0);
               }
               else if(this.FEliteRecord.CurFightTimes <= 0)
               {
                  EffectGenerateText(STRING_CROSSSERVERWAR.STRING_CancelAutoBattle_1);
               }
               this.UpdateStateAutoBtn();
            }
         }
      }
   }
}

