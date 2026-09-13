package Processors.Game.Lobby.Palace
{
   import Externals.SExternalCore;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TCrossServerReport;
   import Logics.CrossServerWar.TCrossServerReports;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TGSPVP_BattleZone;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Palace.TPalaceData;
   import Logics.Palace.TPalaceTop3Report;
   import Logics.Palace.TPalaceTop3Reports;
   import Logics.Palace.TTargetFighter;
   import Logics.Palace.TTargetFighters;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Palace.Components.TUIPalaceHero;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_PALACE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import Resources.Strings.STRING_PALACE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowPalace extends TProcessorWindowTemplate
   {
      
      protected static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      protected static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected const STRING_TipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.DRAGON_STRING_06,CONST_SYSTEMLANGUAGE.DRAGON_STRING_07,CONST_SYSTEMLANGUAGE.DRAGON_STRING_08,CONST_SYSTEMLANGUAGE.DRAGON_STRING_09]);
      
      protected var FMC_PublicBox:MovieClip;
      
      protected var FTF_SilverCoin:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FTF_GiftCertificate:TextField;
      
      protected var FTF_YestodayRank:TextField;
      
      protected var FTF_CurrentRank:TextField;
      
      protected var FTF_FightingPower:TextField;
      
      protected var FTF_ChallengeCount:TextField;
      
      protected var FBTN_AddChallengeCount:SimpleButton;
      
      protected var FMC_CDTime:MovieClip;
      
      protected var FBTN_ClearCD:SimpleButton;
      
      protected var FTF_CDTime:TextField;
      
      protected var FMC_Challenge:MovieClip;
      
      protected var FTF_ChallengeEndTime:TextField;
      
      protected var FMC_Report:MovieClip;
      
      protected var FMC_LookRankings:SimpleButton;
      
      protected var FMC_RightUp:MovieClip;
      
      protected var FTF_BattleZone:TextField;
      
      protected var FRankingBoxVec:Vector.<MovieClip>;
      
      protected var FUIPalaceHeros:Vector.<TUIPalaceHero>;
      
      protected var FTextReportVect:Vector.<TextField>;
      
      protected var FBtnReportVect:Vector.<MovieClip>;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FUIWindowClearCD:TUIWindowConfirmation;
      
      protected var FPalaceData:TPalaceData;
      
      protected var FHint:THint;
      
      protected var FCDtime:uint;
      
      protected var FEndTime:uint;
      
      protected var FInitialized:Boolean;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FStarTime:uint;
      
      protected var FCloseTimeArr:Vector.<uint>;
      
      protected var FTodayDate:Date;
      
      protected var FBuyFightCount:uint;
      
      protected var FAddCountCost:uint;
      
      protected var FClearCDCost:uint;
      
      protected var FAddCountHint:THint;
      
      protected var FLookCDTime:uint;
      
      protected var FTapCDTime:uint;
      
      protected var FIsLightButton:Boolean;
      
      protected var FLookHeroInfoOnClick:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      protected var FLookRankingOnClick:Function;
      
      protected var FRoleOnClick:Function;
      
      protected var FOnAddChallengeCount:Function;
      
      protected var FOnClearChallengeCD:Function;
      
      public function TProcessorWindowPalace(param1:TUIComponent)
      {
         super(param1);
         this.FRankingBoxVec = new Vector.<MovieClip>(CONST_PALACE.CAPACITY_Boxes);
         this.FUIPalaceHeros = new Vector.<TUIPalaceHero>(CONST_PALACE.CAPACITY_Heros);
         this.FTextReportVect = new Vector.<TextField>(CONST_PALACE.CAPACITY_Reports);
         this.FBtnReportVect = new Vector.<MovieClip>(CONST_PALACE.CAPACITY_Reports);
         this.FHint = new THint();
         this.FAddCountHint = new THint();
         this.FPalaceData = SLogicsCore.PalaceData;
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FInitialized = false;
         this.FIsLightButton = false;
         this.FTodayDate = new Date();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PALACE.RESOURCESID_Swf_Palace);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TUIPalaceHero = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_PALACE.RESOURCE_ClassName_MC_Palace) as Sprite;
         UIDispatch();
         this.FMC_PublicBox = FMainUI["MC_PublicBox"];
         this.FMC_RightUp = FMainUI["MC_RightUp"];
         this.FTF_SilverCoin = this.FMC_PublicBox["TF_SilverCoin"];
         this.FTF_Gold = this.FMC_PublicBox["TF_Gold"];
         this.FTF_GiftCertificate = this.FMC_PublicBox["TF_GiftCertificate"];
         this.FTF_YestodayRank = this.FMC_PublicBox["TF_YestodayRank"];
         this.FTF_CurrentRank = this.FMC_PublicBox["TF_CurrentRank"];
         this.FTF_FightingPower = this.FMC_PublicBox["TF_FightingPower"];
         this.FTF_ChallengeCount = this.FMC_PublicBox["TF_ChallengeCount"];
         this.FBTN_AddChallengeCount = this.FMC_PublicBox["BTN_AddChallengeCount"];
         this.FMC_CDTime = this.FMC_PublicBox["MC_CDTime"];
         this.FBTN_ClearCD = this.FMC_CDTime["BTN_ClearCD"];
         this.FTF_CDTime = this.FMC_CDTime["TF_CDTime"];
         this.FMC_Challenge = this.FMC_PublicBox["MC_Challenge"];
         this.FTF_ChallengeEndTime = this.FMC_PublicBox["TF_ChallengeEndTime"];
         this.FTF_BattleZone = this.FMC_RightUp["TF_BattleZone"];
         this.FMC_Report = FMainUI["MC_Report"];
         this.FMC_LookRankings = FMainUI["MC_LookRankings"];
         _loc2_ = CONST_PALACE.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_RightUp["MC_Box_" + _loc1_] as MovieClip;
            if(_loc1_ > 0)
            {
               _loc3_.gotoAndStop(_loc1_ + 1);
            }
            this.FRankingBoxVec[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc2_ = CONST_PALACE.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIPalaceHero(this);
            _loc4_.Resource = FMainUI["MC_Hero_" + _loc1_] as MovieClip;
            _loc4_.LookHeroInfoOnClick = this.ProcessorLookHeroInfoOnClick;
            _loc4_.RoleOnClick = this.ProcessorRoleOnClick;
            _loc4_.Init();
            this.FUIPalaceHeros[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = CONST_PALACE.CAPACITY_Reports;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTextReportVect[_loc1_] = this.FMC_Report["TF_FightReport_" + _loc1_];
            this.FTextReportVect[_loc1_].text = "";
            this.FBtnReportVect[_loc1_] = this.FMC_Report["BTN_FightReport_" + _loc1_];
            this.FBtnReportVect[_loc1_].visible = false;
            TGameUtil.setButtonMode(this.FBtnReportVect[_loc1_],true);
            _loc1_++;
         }
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (STAGE_Width - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (STAGE_Height - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FUIWindowInformation.SetCheckBox(true);
         this.FUIWindowClearCD = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowClearCD.OnOK = this.WindowClearOnOK;
         this.FUIWindowClearCD.x = (STAGE_Width - this.FUIWindowClearCD.WindowWidth) / 2;
         this.FUIWindowClearCD.y = (STAGE_Height - this.FUIWindowClearCD.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowClearCD);
         this.FUIWindowClearCD.SetCheckBox(true);
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         UILocations();
         _loc2_ = CONST_PALACE.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRankingBoxVec[_loc1_];
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
            _loc1_++;
         }
         _loc2_ = CONST_PALACE.CAPACITY_Reports;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBtnReportVect[_loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.BTNLookReportOnClick,false,0,true);
            _loc1_++;
         }
         this.FMC_LookRankings.addEventListener(MouseEvent.CLICK,this.MC_LookRankingOnClick,false,0,true);
         this.FBTN_ClearCD.addEventListener(MouseEvent.CLICK,this.ClearChallengeCDOnClick,false,0,true);
         this.FBTN_AddChallengeCount.addEventListener(MouseEvent.CLICK,this.AddChallengeCountOnClick,false,0,true);
         this.FBTN_AddChallengeCount.addEventListener(MouseEvent.MOUSE_OUT,this.AddChallengeCountOnOut,false,0,true);
         this.FBTN_AddChallengeCount.addEventListener(MouseEvent.MOUSE_MOVE,this.AddChallengeCountOnMove,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.Dragon_Tips_01) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_End_Time) as TConfigValue;
         this.FCloseTimeArr = _loc2_.Value as Vector.<uint>;
         this.FTodayDate.setHours(this.FCloseTimeArr[0],this.FCloseTimeArr[1],0);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_Fight_Interval_time) as TConfigValue;
         this.FCDtime = _loc2_.Value as uint;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_Buy_Fight_Count) as TConfigValue;
         this.FBuyFightCount = _loc2_.Value as uint;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_Buy_Fight_Cost) as TConfigValue;
         this.FAddCountCost = _loc2_.Value as uint;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_Fight_CDclear_Cost) as TConfigValue;
         this.FClearCDCost = _loc2_.Value as uint;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_Watch_Player_CD) as TConfigValue;
         this.FLookCDTime = _loc2_.Value as uint;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIPalaceHero = null;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         if(!this.FInitialized)
         {
            return;
         }
         this.UpdateTime();
         if(!this.FIsLightButton)
         {
            return;
         }
         _loc1_ = uint(STimingCore.GetServerTick());
         if(_loc1_ - this.FStarTime >= this.FLookCDTime)
         {
            _loc3_ = this.FUIPalaceHeros.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = this.FUIPalaceHeros[_loc2_];
               _loc4_.LightButtonStatus();
               _loc2_++;
            }
            this.FIsLightButton = false;
         }
      }
      
      protected function UpdateTime() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc1_ = this.FPalaceData.PalaceRoleBaseInfo.LastChallengeTime;
         _loc2_ = uint(STimingCore.GetServerTick());
         this.FTapCDTime = _loc1_ != 0 ? uint(Math.ceil((_loc1_ + this.FCDtime - _loc2_) / 60)) : 0;
         if(_loc1_ != 0)
         {
            if(_loc1_ + this.FCDtime - _loc2_ >= 0)
            {
               this.FTF_CDTime.text = TUtilityString.Format(STRING_PALACE.FORMAT_CDTime,TGameUtil.fomatTime(_loc1_ + this.FCDtime - _loc2_).toString());
               this.FMC_CDTime.visible = true;
               this.FBTN_ClearCD.visible = true;
               this.FMC_Challenge.visible = false;
            }
            else
            {
               this.FMC_CDTime.visible = false;
               this.FMC_Challenge.visible = true;
            }
         }
         else
         {
            this.FMC_CDTime.visible = false;
            this.FMC_Challenge.visible = true;
         }
         _loc4_ = this.FTodayDate.valueOf() / 1000;
         _loc5_ = uint(STimingCore.GetServerTick());
         if(_loc4_ < _loc5_)
         {
            this.FTodayDate = new Date(_loc5_ * 1000);
            this.FTodayDate.setHours(this.FCloseTimeArr[0],this.FCloseTimeArr[1],0);
            _loc4_ = this.FTodayDate.valueOf() / 1000;
         }
         this.FEndTime = _loc4_;
         _loc3_ = this.FEndTime - _loc5_;
         if(_loc3_ >= 0)
         {
            this.FTF_ChallengeEndTime.text = TGameUtil.fomatTime(_loc3_).toString();
         }
      }
      
      protected function UpdateReportUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TCrossServerReport = null;
         var _loc7_:TCrossServerReports = null;
         var _loc8_:TPalaceTop3Report = null;
         var _loc9_:TPalaceTop3Reports = null;
         _loc7_ = this.FPalaceData.FightReports.PalaceCommonReports;
         _loc9_ = this.FPalaceData.FightReports.PalaceTop3Reports;
         _loc2_ = CONST_PALACE.CAPACITY_Reports;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FTextReportVect[_loc1_];
            _loc5_ = this.FBtnReportVect[_loc1_];
            _loc4_.visible = false;
            _loc5_.visible = false;
            _loc1_++;
         }
         _loc2_ = uint(_loc9_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ >= CONST_PALACE.CAPACITY_Top3Reports)
            {
               break;
            }
            _loc4_ = this.FTextReportVect[_loc1_];
            _loc5_ = this.FBtnReportVect[_loc1_];
            _loc3_ = _loc2_ - _loc1_ - 1;
            _loc8_ = _loc9_.GetPalaceTop3ReportByIndex(_loc3_);
            if(_loc8_ != null)
            {
               _loc4_.htmlText = this.Top3MakeHtmlTextInfo(_loc8_);
               _loc4_.visible = true;
               _loc5_.visible = true;
            }
            _loc1_++;
         }
         _loc2_ = uint(_loc7_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ >= CONST_PALACE.CAPACITY_CommonReports)
            {
               break;
            }
            _loc4_ = this.FTextReportVect[_loc1_ + CONST_PALACE.CAPACITY_Top3Reports];
            _loc5_ = this.FBtnReportVect[_loc1_ + CONST_PALACE.CAPACITY_Top3Reports];
            _loc3_ = _loc2_ - _loc1_ - 1;
            _loc6_ = _loc7_.GetCrossServerReportByIndex(_loc3_);
            if(_loc6_ != null)
            {
               _loc4_.htmlText = this.MakeHtmlTextInfo(_loc6_);
               _loc4_.visible = true;
               _loc5_.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function Top3MakeHtmlTextInfo(param1:TPalaceTop3Report) : String
      {
         var _loc2_:String = null;
         return TUtilityString.Format(STRING_PALACE.FORMAT_Top3Report,param1.ChallengeName,param1.TargetName);
      }
      
      protected function MakeHtmlTextInfo(param1:TCrossServerReport) : String
      {
         var _loc2_:String = null;
         if(param1.IsFight)
         {
            _loc2_ = STRING_PALACE.STRING_Report_Fight;
         }
         else
         {
            _loc2_ = STRING_PALACE.STRING_Report_BFight;
         }
         if(param1.IsWin)
         {
            _loc2_ += STRING_CROSSSERVERWAR.STRING_Report_Win;
         }
         else
         {
            _loc2_ += STRING_CROSSSERVERWAR.STRING_Report_Lost;
         }
         return _loc2_.split("%who%").join(param1.Name);
      }
      
      protected function UpdateRoleBaseInfo() : void
      {
         var _loc1_:TGSPVP_BattleZone = null;
         this.FTF_SilverCoin.text = SLogicsCore.Character.CreditSilverCoin.ToString();
         this.FTF_Gold.text = SLogicsCore.Character.CreditGold.toString();
         this.FTF_GiftCertificate.text = SLogicsCore.Character.CreditGiftCertificate.toString();
         this.FTF_YestodayRank.text = this.FPalaceData.PalaceRoleBaseInfo.YestodayRank.toString();
         this.FTF_CurrentRank.text = this.FPalaceData.PalaceRoleBaseInfo.CurrentRank.toString();
         this.FTF_FightingPower.text = this.FPalaceData.PalaceRoleBaseInfo.FightPower.toString();
         this.FTF_ChallengeCount.text = this.FPalaceData.PalaceRoleBaseInfo.CurrentTimes.toString();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_GSPVP_BattleZone,this.FEliteRecord.BattleID) as TGSPVP_BattleZone;
         if(_loc1_ != null)
         {
            this.FTF_BattleZone.text = TUtilityString.Format(STRING_PALACE.FORMAT_BattleZone,_loc1_.BzName);
         }
      }
      
      protected function UpdateRoleRankingUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTargetFighter = null;
         var _loc4_:TTargetFighters = null;
         var _loc5_:int = 0;
         var _loc6_:TUIPalaceHero = null;
         var _loc7_:int = 0;
         _loc2_ = CONST_PALACE.CAPACITY_Heros;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = this.FUIPalaceHeros[_loc1_];
            _loc6_.Resource.visible = false;
            _loc6_.Context = null;
            _loc1_++;
         }
         _loc4_ = this.FPalaceData.TargetFighters;
         if(_loc4_.RoleCurrentRank > 6)
         {
            _loc5_ = _loc4_.RoleCurrentRank - 6;
         }
         else
         {
            _loc5_ = 0;
         }
         _loc2_ = _loc4_.Count;
         _loc1_ = _loc5_;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = _loc1_ - _loc5_;
            if(_loc7_ >= CONST_PALACE.CAPACITY_Heros)
            {
               break;
            }
            _loc3_ = _loc4_.GetTargetFighterByIndex(_loc1_);
            _loc6_ = this.FUIPalaceHeros[_loc7_];
            _loc6_.Resource.visible = true;
            _loc6_.Context = _loc3_;
            _loc6_.Update();
            _loc1_++;
         }
      }
      
      protected function ClearChallengeCDOnClick(param1:MouseEvent) : void
      {
         if(this.FUIWindowClearCD.IsSelected)
         {
            if(this.FOnClearChallengeCD != null)
            {
               this.FOnClearChallengeCD(this);
            }
         }
         else if(this.FTapCDTime != 0)
         {
            this.FUIWindowClearCD.Text = TUtilityString.Format(STRING_PALACE.FORMAT_ClearChallengeCD,this.FClearCDCost * this.FTapCDTime);
            this.FUIWindowClearCD.Visible = true;
         }
      }
      
      protected function WindowClearOnOK(param1:Object) : void
      {
         if(this.FOnClearChallengeCD != null)
         {
            this.FOnClearChallengeCD(this);
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FOnAddChallengeCount != null)
         {
            this.FOnAddChallengeCount(this);
         }
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
         this.FAddCountHint.Caption = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_RestAddChallengeCount,this.FBuyFightCount - this.FPalaceData.PalaceRoleBaseInfo.BuyTimes);
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FAddCountHint);
         }
      }
      
      protected function ProcessorLookHeroInfoOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TCoordinate = null;
         var _loc4_:TUIPalaceHero = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         _loc6_ = this.FUIPalaceHeros.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = this.FUIPalaceHeros[_loc5_];
            _loc4_.DarkButtonStatus();
            _loc5_++;
         }
         _loc3_ = new TCoordinate();
         _loc4_ = param1 as TUIPalaceHero;
         _loc3_.X = _loc4_.Resource.x;
         _loc3_.Y = _loc4_.Resource.y;
         if(this.FLookHeroInfoOnClick != null)
         {
            this.FLookHeroInfoOnClick(this,param2,_loc3_);
         }
      }
      
      protected function ProcessorRoleOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TUIPalaceHero = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         if(this.FPalaceData.PalaceRoleBaseInfo.CurrentTimes <= 0)
         {
            this.AddChallengeCountOnClick(null);
            return;
         }
         if(this.FRoleOnClick != null)
         {
            this.FRoleOnClick(this,param2);
         }
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_TipsVec[_loc3_]) as TSystemLanguage;
         this.FHint.Content = _loc4_.Desc;
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,this.FHint);
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      protected function BTNLookReportOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         _loc2_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc5_ = _loc2_ - CONST_PALACE.CAPACITY_Top3Reports;
         if(_loc5_ < 0)
         {
            _loc4_ = uint(this.FPalaceData.FightReports.PalaceTop3Reports.Count);
            _loc3_ = this.FPalaceData.FightReports.PalaceTop3Reports.GetPalaceTop3ReportByIndex(_loc4_ - _loc2_ - 1).ReportID;
         }
         else
         {
            _loc4_ = uint(this.FPalaceData.FightReports.PalaceCommonReports.Count);
            _loc3_ = this.FPalaceData.FightReports.PalaceCommonReports.GetCrossServerReportByIndex(_loc4_ - _loc5_ - 1).ReportID;
         }
         SExternalCore.NavigateToFightReport(_loc3_);
      }
      
      protected function MC_LookRankingOnClick(param1:MouseEvent) : void
      {
         if(this.FLookRankingOnClick != null)
         {
            this.FLookRankingOnClick(this);
         }
      }
      
      public function get OnAddChallengeCount() : Function
      {
         return this.FOnAddChallengeCount;
      }
      
      public function set OnAddChallengeCount(param1:Function) : void
      {
         this.FOnAddChallengeCount = param1;
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
      
      public function get LookHeroInfoOnClick() : Function
      {
         return this.FLookHeroInfoOnClick;
      }
      
      public function set LookHeroInfoOnClick(param1:Function) : void
      {
         this.FLookHeroInfoOnClick = param1;
      }
      
      public function get RoleOnClick() : Function
      {
         return this.FRoleOnClick;
      }
      
      public function set RoleOnClick(param1:Function) : void
      {
         this.FRoleOnClick = param1;
      }
      
      public function get LookRankingOnClick() : Function
      {
         return this.FLookRankingOnClick;
      }
      
      public function set LookRankingOnClick(param1:Function) : void
      {
         this.FLookRankingOnClick = param1;
      }
      
      public function get OnClearChallengeCD() : Function
      {
         return this.FOnClearChallengeCD;
      }
      
      public function set OnClearChallengeCD(param1:Function) : void
      {
         this.FOnClearChallengeCD = param1;
      }
      
      public function Update() : void
      {
         this.UpdateBaseInfo();
         this.UpdateRoleRanking();
         this.UpdatePalaceReport();
      }
      
      public function UpdateBaseInfo() : void
      {
         this.UpdateRoleBaseInfo();
      }
      
      public function UpdateRoleRanking() : void
      {
         this.UpdateRoleRankingUI();
      }
      
      public function UpdatePalaceReport() : void
      {
         this.UpdateReportUI();
      }
      
      public function SetCDStartTime() : void
      {
         this.FStarTime = STimingCore.GetServerTick();
         this.FIsLightButton = true;
      }
      
      public function UpdateCDTime() : void
      {
         this.UpdateTime();
      }
   }
}

