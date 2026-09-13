package Processors.Game.Lobby.CrossServerWar.Window
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TGSPVP_BattleZone;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import Resources.Strings.STRING_PALACE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowExplanation extends TProcessorLobbyWindow
   {
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBTN_Join:MovieClip;
      
      protected var FBTN_ChallengeRankings:MovieClip;
      
      protected var FBTN_Cheers:MovieClip;
      
      protected var FBTN_SoulExchange:MovieClip;
      
      protected var FTF_IsJoin:TextField;
      
      protected var FBTN_TokenExchange:MovieClip;
      
      protected var FTF_Explanation:TextField;
      
      protected var FTF_JoinExplanation:TextField;
      
      protected var FTF_IsJoinTomorow:TextField;
      
      protected var FMC_BattleStartTime:MovieClip;
      
      protected var FTF_BattleStartTime:TextField;
      
      protected var FTF_BattleZone:TextField;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FHint:THint;
      
      protected var FStartTime:Vector.<uint>;
      
      protected var FEndTime:uint;
      
      protected var FOnOpenSoulExchange:Function;
      
      protected var FOnOpenToast:Function;
      
      protected var FOnOpenRankings:Function;
      
      protected var FOnEliteApply:Function;
      
      protected var FOnOpenTokenExchange:Function;
      
      protected var FHelpOnOver:Function;
      
      protected var FHelpOnOut:Function;
      
      public function TProcessorWindowExplanation(param1:TUIComponent)
      {
         super(param1);
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FHint = new THint();
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
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CROSSSERVERWAR.RESOURCE_ClassName_MC_Explanation) as Sprite;
         addChild(_loc1_);
         _loc1_.x = CONST_COMMON.STAGE_Width - _loc1_.width >> 1;
         _loc1_.y = CONST_COMMON.STAGE_Height - _loc1_.height >> 1;
         this.FBTN_Close = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Close];
         this.FBTN_Help = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Help];
         this.FBTN_Join = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Join];
         TGameUtil.setButtonMode(this.FBTN_Join,true);
         this.FTF_IsJoin = this.FBTN_Join["TF_IsJoin"];
         this.FBTN_ChallengeRankings = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_ChallengeRankings];
         TGameUtil.setButtonMode(this.FBTN_ChallengeRankings,true);
         this.FBTN_Cheers = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Cheers];
         TGameUtil.setButtonMode(this.FBTN_Cheers,true);
         this.FBTN_SoulExchange = _loc1_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_SoulExchange];
         TGameUtil.setButtonMode(this.FBTN_SoulExchange,true);
         this.FBTN_TokenExchange = _loc1_["BTN_TokenExchange"];
         TGameUtil.setButtonMode(this.FBTN_TokenExchange,true);
         this.FTF_Explanation = _loc1_["TF_Explanation"];
         this.FTF_JoinExplanation = _loc1_["TF_JoinExplanation"];
         this.FTF_JoinExplanation.visible = false;
         this.FTF_IsJoinTomorow = _loc1_["TF_IsJoinTomorow"];
         this.FMC_BattleStartTime = _loc1_["MC_BattleStartTime"];
         this.FTF_BattleStartTime = this.FMC_BattleStartTime["TF_BattleStartTime"];
         this.FTF_BattleZone = _loc1_["TF_BattleZone"];
         this.FTF_BattleZone.text = "";
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.BTNHelpOnOver,false,0,true);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.BTNHelpOnOut,false,0,true);
         this.FBTN_Join.addEventListener(MouseEvent.CLICK,this.BTNJoinOnClick,false,0,true);
         this.FBTN_ChallengeRankings.addEventListener(MouseEvent.CLICK,this.BTNChallengeRankingsOnClick,false,0,true);
         this.FBTN_Cheers.addEventListener(MouseEvent.CLICK,this.BTNCheersOnClick,false,0,true);
         this.FBTN_SoulExchange.addEventListener(MouseEvent.CLICK,this.BTNSoulExchangeOnClick,false,0,true);
         this.FBTN_TokenExchange.addEventListener(MouseEvent.CLICK,this.BTNTokenExchangeOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_CrossServer) as TSystemLanguage;
         this.FHint.Content = _loc1_.Desc;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GSPVP_DailySingUp) as TConfigValue;
         this.FStartTime = _loc2_.Value as Vector.<uint>;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_01) as TSystemLanguage;
         this.FTF_Explanation.htmlText = _loc1_.Desc;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.GSPVP_DailyCloseBattleTime) as TConfigValue;
         this.FEndTime = _loc2_.Value[0];
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:Date = null;
         var _loc2_:uint = 0;
         var _loc3_:Date = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         if(!this.Visible)
         {
            return;
         }
         if(this.FTF_JoinExplanation != null)
         {
            _loc1_ = new Date(STimingCore.GetClientShowTime(this.FEliteRecord.SeasonEndTime) * 1000);
            _loc3_ = new Date(STimingCore.GetServerTime() * 1000);
            if(_loc1_.getDate() == _loc3_.getDate())
            {
               this.UpdateTextFeildInfo();
            }
            else if(_loc3_.getDate() == _loc1_.getDate() - 1)
            {
               TGameUtil.setButtonMode(this.FBTN_Join,false);
               this.FBTN_Join.mouseEnabled = false;
            }
            _loc1_ = new Date(STimingCore.GetServerTime() * 1000);
            _loc2_ = _loc1_.getHours();
            _loc4_ = _loc1_.getMinutes();
            if(_loc2_ >= 22)
            {
               this.FTF_JoinExplanation.visible = true;
               _loc5_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_07) as TSystemLanguage).Desc;
               if(_loc5_ != this.FTF_JoinExplanation.text)
               {
                  this.FTF_JoinExplanation.text = _loc5_;
               }
            }
            else if(_loc2_ == 0 && _loc4_ < 20)
            {
               this.FTF_JoinExplanation.visible = false;
            }
            else
            {
               this.FTF_JoinExplanation.visible = true;
               this.UpdateTextFeildInfo();
               this.UpdateBtnInfo();
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateBtnInfo() : void
      {
         var _loc1_:Date = null;
         _loc1_ = new Date(STimingCore.GetServerTime() * 1000);
         if(this.FEliteRecord != null)
         {
            if(this.FEliteRecord.ApplyStatus)
            {
               this.FTF_IsJoin.text = STRING_CROSSSERVERWAR.STRING_HasJoin;
               TGameUtil.setButtonMode(this.FBTN_Join,false);
               this.FBTN_Join.mouseEnabled = false;
            }
            else
            {
               this.FTF_IsJoin.text = STRING_CROSSSERVERWAR.STRING_Join;
               if(_loc1_.getHours() > this.FStartTime[0] || _loc1_.getHours() == this.FStartTime[0] && _loc1_.getMinutes() >= 30)
               {
                  TGameUtil.setButtonMode(this.FBTN_Join,true);
                  this.FBTN_Join.mouseEnabled = true;
               }
               else
               {
                  TGameUtil.setButtonMode(this.FBTN_Join,false);
                  this.FBTN_Join.mouseEnabled = false;
               }
            }
         }
      }
      
      protected function UpdateTextFeildInfo() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:uint = 0;
         var _loc3_:Date = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TGSPVP_BattleZone = null;
         _loc3_ = new Date(STimingCore.GetServerTime() * 1000);
         _loc2_ = _loc3_.getDate();
         _loc3_ = new Date(STimingCore.GetClientShowTime(this.FEliteRecord.SeasonEndTime) * 1000);
         _loc5_ = _loc3_.getDate();
         _loc6_ = _loc3_.getMonth();
         _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_GSPVP_BattleZone,this.FEliteRecord.BattleID) as TGSPVP_BattleZone;
         if(_loc7_ != null)
         {
            this.FTF_BattleZone.text = TUtilityString.Format(STRING_PALACE.FORMAT_BattleZone,_loc7_.BzName);
         }
         if(_loc2_ == _loc5_ || _loc2_ == _loc5_ + 1)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_04) as TSystemLanguage;
            this.FTF_JoinExplanation.visible = false;
            this.FMC_BattleStartTime.visible = true;
            _loc3_ = new Date(this.FEliteRecord.SeasonStartTime * 1000);
            this.FTF_BattleStartTime.text = TUtilityString.Format(_loc1_.Desc,TUtilityDate.FormatDate(_loc3_));
            this.FTF_IsJoinTomorow.visible = false;
            this.FBTN_Join.visible = false;
         }
         else if(_loc2_ == _loc5_ - 1)
         {
            this.FTF_BattleStartTime.text = STRING_CROSSSERVERWAR.STRING_SeasonLastDay;
            this.FTF_JoinExplanation.visible = false;
            this.FMC_BattleStartTime.visible = true;
            this.FTF_IsJoinTomorow.visible = false;
            this.FBTN_Join.visible = false;
         }
         else
         {
            this.FMC_BattleStartTime.visible = false;
            this.FTF_IsJoinTomorow.visible = true;
            this.FBTN_Join.visible = true;
         }
         if(this.FEliteRecord.SeasonStatus == 0)
         {
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_05) as TSystemLanguage;
            this.FTF_IsJoinTomorow.visible = false;
            this.FBTN_Join.visible = false;
            this.FMC_BattleStartTime.visible = true;
            this.FTF_BattleStartTime.text = _loc1_.Desc;
            return;
         }
         _loc3_ = new Date(this.FEliteRecord.SeasonStartTime * 1000);
         _loc4_ = _loc3_.getDate();
         if(_loc4_ == _loc2_)
         {
            this.FTF_JoinExplanation.visible = false;
         }
         else
         {
            this.FTF_JoinExplanation.visible = true;
            if(this.FEliteRecord.YestodayIsApply > 0)
            {
               _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_02) as TSystemLanguage;
            }
            else
            {
               _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GSPVP_STRING_03) as TSystemLanguage;
            }
            this.FTF_JoinExplanation.text = _loc1_.Desc;
         }
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function BTNHelpOnOver(param1:MouseEvent) : void
      {
         if(this.FHelpOnOver != null)
         {
            this.FHelpOnOver(this,this.FHint);
         }
      }
      
      protected function BTNHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpOnOut != null)
         {
            this.FHelpOnOut(this);
         }
      }
      
      protected function BTNJoinOnClick(param1:MouseEvent) : void
      {
         if(this.FOnEliteApply != null)
         {
            this.FOnEliteApply(this);
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
      
      protected function BTNChallengeRankingsOnClick(param1:MouseEvent) : void
      {
         if(this.FOnOpenRankings != null)
         {
            this.FOnOpenRankings(this);
         }
      }
      
      public function get OnOpenSoulExchange() : Function
      {
         return this.FOnOpenSoulExchange;
      }
      
      public function set OnOpenSoulExchange(param1:Function) : void
      {
         this.FOnOpenSoulExchange = param1;
      }
      
      public function get OnOpenToast() : Function
      {
         return this.FOnOpenToast;
      }
      
      public function set OnOpenToast(param1:Function) : void
      {
         this.FOnOpenToast = param1;
      }
      
      public function get OnOpenRankings() : Function
      {
         return this.FOnOpenRankings;
      }
      
      public function set OnOpenRankings(param1:Function) : void
      {
         this.FOnOpenRankings = param1;
      }
      
      public function get OnEliteApply() : Function
      {
         return this.FOnEliteApply;
      }
      
      public function set OnEliteApply(param1:Function) : void
      {
         this.FOnEliteApply = param1;
      }
      
      public function get OnOpenTokenExchange() : Function
      {
         return this.FOnOpenTokenExchange;
      }
      
      public function set OnOpenTokenExchange(param1:Function) : void
      {
         this.FOnOpenTokenExchange = param1;
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
      
      public function Update() : void
      {
         this.UpdateBtnInfo();
         this.UpdateTextFeildInfo();
      }
   }
}

