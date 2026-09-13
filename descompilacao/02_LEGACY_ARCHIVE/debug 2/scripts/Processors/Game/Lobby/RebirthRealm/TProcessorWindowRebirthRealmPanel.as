package Processors.Game.Lobby.RebirthRealm
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowRebirthRealmPanel extends TProcessorLobbyWindow
   {
      
      public static const THREE:int = 3;
      
      public static const SIX:int = 6;
      
      protected var FRootPanel:MovieClip;
      
      protected var FMC_GotoDestinyCorona:MovieClip = null;
      
      protected var FMC_GotoSixRebirth:MovieClip = null;
      
      protected var FMC_ThreeCustomVec:Vector.<MovieClip> = null;
      
      protected var FMC_ThreeCustomBtnVec:Vector.<MovieClip> = null;
      
      protected var FCur_Temp_CustomBtn:MovieClip = null;
      
      protected var FMC_CartoonVec:Vector.<MovieClip> = null;
      
      protected var FAutoBtnVec:Vector.<MovieClip> = null;
      
      protected var Stateindex:int = 10;
      
      protected var FCurPage:int;
      
      protected var FMC_GotoDestinyCoronaFun:Function = null;
      
      protected var FMC_GotoSixRebirthFun:Function = null;
      
      protected var FChallenge_BtnFun:Function = null;
      
      protected var FMC_GotoEntryRebirthFun:Function;
      
      protected var FAutoBtnClickBack:Function;
      
      protected var FBtnOverFunc:Function;
      
      protected var FBtnOutFunc:Function;
      
      protected var FBtnMoveFunc:Function;
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData = null;
      
      public function TProcessorWindowRebirthRealmPanel(param1:TUIComponent, param2:TRebirthRealmBaseData)
      {
         super(param1);
         this.FRebirthRealmBaseData = param2;
         this.FMC_ThreeCustomVec = new Vector.<MovieClip>(THREE);
         this.FMC_ThreeCustomBtnVec = new Vector.<MovieClip>(THREE);
         this.FMC_CartoonVec = new Vector.<MovieClip>(THREE);
         this.FAutoBtnVec = new Vector.<MovieClip>(THREE);
         this.FCurPage = 0;
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         this.FRootPanel = param1;
         this.FMC_GotoDestinyCorona = this.FRootPanel["MC_GotoDestinyCorona"];
         this.FMC_GotoSixRebirth = this.FRootPanel["MC_GotoSixRebirth"];
         this.FMC_ThreeCustomVec[0] = this.FRootPanel["MC_Normal_Btn"];
         this.FMC_ThreeCustomVec[1] = this.FRootPanel["MC_Difficulty_Btn"];
         this.FMC_ThreeCustomVec[2] = this.FRootPanel["MC_Hell_Btn"];
         _loc2_ = 0;
         while(_loc2_ < THREE)
         {
            this.FMC_ThreeCustomVec[_loc2_].gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < THREE)
         {
            this.FMC_ThreeCustomBtnVec[_loc2_] = this.FMC_ThreeCustomVec[_loc2_]["BTN_Challenge"];
            this.FMC_CartoonVec[_loc2_] = this.FMC_ThreeCustomVec[_loc2_]["MC_Cartoon"];
            MovieClip(this.FMC_ThreeCustomVec[_loc2_]["MC_Pass"]).visible = false;
            this.FAutoBtnVec[_loc2_] = this.FMC_ThreeCustomVec[_loc2_]["AutoFireBtn"];
            this.FAutoBtnVec[_loc2_].addEventListener(MouseEvent.CLICK,this.AutoBtnClick);
            this.FAutoBtnVec[_loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.AutoBtnOver);
            this.FAutoBtnVec[_loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.AutoBtnOut);
            this.FAutoBtnVec[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.AutoBtnMove);
            _loc2_++;
         }
         TGameUtil.setButtonMode(this.FMC_GotoDestinyCorona,true);
         TGameUtil.setButtonMode(this.FMC_GotoSixRebirth,true);
         TGameUtil.setButtonMode(this.FRootPanel.BTN_GoNext,true);
         TGameUtil.setButtonMode(this.FRootPanel.BTN_Back,true);
         this.FRootPanel.BTN_GoNext.addEventListener(MouseEvent.CLICK,this.OnChangePageClick);
         this.FRootPanel.BTN_Back.addEventListener(MouseEvent.CLICK,this.OnChangePageClick);
         this.addEvent();
         new Tools_Help(FParent,this.FRootPanel["BTN_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_RebirthMain_mainPanel,FUICore);
      }
      
      protected function AutoBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FAutoBtnVec[0]:
               _loc2_ = 0 + this.FCurPage * THREE;
               break;
            case this.FAutoBtnVec[1]:
               _loc2_ = 1 + this.FCurPage * THREE;
               break;
            case this.FAutoBtnVec[2]:
               _loc2_ = 2 + this.FCurPage * THREE;
         }
         if(this.FBtnOverFunc != null)
         {
            this.FBtnOverFunc(_loc2_);
         }
      }
      
      protected function AutoBtnOut(param1:MouseEvent) : void
      {
         if(this.FBtnOutFunc != null)
         {
            this.FBtnOutFunc();
         }
      }
      
      protected function AutoBtnMove(param1:MouseEvent) : void
      {
         if(this.FBtnMoveFunc != null)
         {
            this.FBtnMoveFunc();
         }
      }
      
      protected function AutoBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         switch(param1.currentTarget)
         {
            case this.FAutoBtnVec[0]:
               _loc2_ = 1 + this.FCurPage * THREE;
               break;
            case this.FAutoBtnVec[1]:
               _loc2_ = 2 + this.FCurPage * THREE;
               break;
            case this.FAutoBtnVec[2]:
               _loc2_ = 3 + this.FCurPage * THREE;
         }
         if(this.FAutoBtnClickBack != null)
         {
            this.FAutoBtnClickBack(_loc2_);
         }
      }
      
      public function Challenge_BtnFunClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMC_ThreeCustomBtnVec[0]:
               _loc2_ = 1 + this.FCurPage * THREE;
               break;
            case this.FMC_ThreeCustomBtnVec[1]:
               _loc2_ = 2 + this.FCurPage * THREE;
               break;
            case this.FMC_ThreeCustomBtnVec[2]:
               _loc2_ = 3 + this.FCurPage * THREE;
         }
         if(this.FChallenge_BtnFun != null)
         {
            this.FChallenge_BtnFun(_loc2_);
         }
      }
      
      public function MC_GotoDestinyCoronaClick(param1:MouseEvent) : void
      {
         if(this.FMC_GotoDestinyCoronaFun != null)
         {
            this.FMC_GotoDestinyCoronaFun();
         }
      }
      
      public function MC_GotoSixRebirthClick(param1:MouseEvent) : void
      {
         if(this.FMC_GotoSixRebirthFun != null)
         {
            this.FMC_GotoSixRebirthFun();
         }
      }
      
      public function OnChangePageClick(param1:MouseEvent) : void
      {
         if(this.FMC_GotoEntryRebirthFun != null)
         {
            this.FMC_GotoEntryRebirthFun(null);
         }
      }
      
      public function set MC_GotoSixRebirthFun(param1:Function) : void
      {
         this.FMC_GotoSixRebirthFun = param1;
      }
      
      public function set MC_GotoDestinyCoronaFun(param1:Function) : void
      {
         this.FMC_GotoDestinyCoronaFun = param1;
      }
      
      public function set GotoEntryRebirthFun(param1:Function) : void
      {
         this.FMC_GotoEntryRebirthFun = param1;
      }
      
      public function set Challenge_BtnFun(param1:Function) : void
      {
         this.FChallenge_BtnFun = param1;
      }
      
      public function set AutoBtnClickBack(param1:Function) : void
      {
         this.FAutoBtnClickBack = param1;
      }
      
      public function set BtnOverFunc(param1:Function) : void
      {
         this.FBtnOverFunc = param1;
      }
      
      public function set BtnOutFunc(param1:Function) : void
      {
         this.FBtnOutFunc = param1;
      }
      
      public function set BtnMoveFunc(param1:Function) : void
      {
         this.FBtnMoveFunc = param1;
      }
      
      public function set CurPage(param1:int) : void
      {
         this.FCurPage = param1;
      }
      
      public function updateState(param1:int, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         if(this.FRebirthRealmBaseData.IsPassCustom)
         {
            _loc3_ = 0;
            while(_loc3_ < THREE)
            {
               TGameUtil.setButtonMode(this.FMC_ThreeCustomBtnVec[_loc3_],false);
               _loc3_++;
            }
            if(this.FRebirthRealmBaseData.CurCustomBig <= THREE && this.FCurPage == 0 || this.FRebirthRealmBaseData.CurCustomBig > THREE && this.FCurPage == 1)
            {
               this.FMC_ThreeCustomVec[this.FRebirthRealmBaseData.CurCustomBig - 1 - this.FCurPage * THREE]["MC_Pass"].visible = true;
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < THREE)
               {
                  this.FMC_ThreeCustomVec[_loc3_]["MC_Pass"].visible = false;
                  _loc3_++;
               }
            }
         }
         else if(param1 == 0)
         {
            _loc3_ = 0;
            while(_loc3_ < THREE)
            {
               TGameUtil.setButtonMode(this.FMC_ThreeCustomBtnVec[_loc3_],true);
               MovieClip(this.FMC_ThreeCustomVec[_loc3_]["MC_Pass"]).visible = false;
               _loc3_++;
            }
            this.Stateindex = 10;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < THREE)
            {
               TGameUtil.setButtonMode(this.FMC_ThreeCustomBtnVec[_loc3_],false);
               _loc3_++;
            }
            if(param2 == 10)
            {
               _loc3_ = 0;
               while(_loc3_ < THREE)
               {
                  MovieClip(this.FMC_ThreeCustomVec[_loc3_]["MC_Pass"]).visible = false;
                  _loc3_++;
               }
               if(param1 <= THREE && this.FCurPage == 0 || param1 > THREE && this.FCurPage == 1)
               {
                  this.FMC_ThreeCustomVec[param1 - 1 - this.FCurPage * THREE]["MC_Pass"].visible = true;
               }
            }
            else if(param1 <= THREE && this.FCurPage == 0 || param1 > THREE && this.FCurPage == 1 || param1 > SIX && this.FCurPage == 2)
            {
               TGameUtil.setButtonMode(this.FMC_ThreeCustomBtnVec[param1 - 1 - this.FCurPage * THREE],true);
            }
            this.Stateindex = param1 - 1;
         }
      }
      
      public function UpdateManual() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FMC_ThreeCustomVec[_loc1_].gotoAndStop(_loc1_ + this.FCurPage * THREE + 1);
            _loc1_++;
         }
         this.FRootPanel.MC_Background.gotoAndStop(this.FCurPage + 1);
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FMC_CartoonVec[_loc1_].gotoAndPlay(1);
            _loc1_++;
         }
         if(this.FCurPage == 0)
         {
            TextField(this.FMC_ThreeCustomVec[0]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.CommonCustomRecommendPower;
            TextField(this.FMC_ThreeCustomVec[1]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.DifficultyCustomRecommendPower;
            TextField(this.FMC_ThreeCustomVec[2]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.HellCustomRecommendPower;
         }
         else if(this.FCurPage == 1)
         {
            TextField(this.FMC_ThreeCustomVec[0]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.CommonCustomRecommendPower2;
            TextField(this.FMC_ThreeCustomVec[1]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.DifficultyCustomRecommendPower2;
            TextField(this.FMC_ThreeCustomVec[2]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.HellCustomRecommendPower2;
         }
         else
         {
            TextField(this.FMC_ThreeCustomVec[0]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.CommonCustomRecommendPower3;
            TextField(this.FMC_ThreeCustomVec[1]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.DifficultyCustomRecommendPower3;
            TextField(this.FMC_ThreeCustomVec[2]["MC_Schedule"]).text = STRING_COMMON.SixFary_Recommend_Power + this.FRebirthRealmBaseData.HellCustomRecommendPower3;
         }
         this.updateState(this.FRebirthRealmBaseData.todayChallengeType);
         this.SetCustomPercentCanSee(this.Stateindex);
         this.TodayChallengeTimes();
      }
      
      public function UpdateThreeAutoBtn() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < THREE)
         {
            if(this.FRebirthRealmBaseData.TodayChallengeTimes >= 1)
            {
               TGameUtil.setButtonMode(this.FAutoBtnVec[_loc1_],false);
            }
            else if(this.FRebirthRealmBaseData.AutoBtnIsCanClcik[_loc1_ + this.FCurPage * THREE] > 0)
            {
               TGameUtil.setButtonMode(this.FAutoBtnVec[_loc1_],true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FAutoBtnVec[_loc1_],false);
            }
            _loc1_++;
         }
      }
      
      public function SetCustomPercentCanSee(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < THREE)
         {
            if(_loc2_ + this.FCurPage * THREE == param1)
            {
               this.FMC_ThreeCustomVec[_loc2_]["TF_CustomPercent"].text = this.FRebirthRealmBaseData.CurCustomLittle + "/" + this.FRebirthRealmBaseData.CustomImageVec.length;
            }
            else
            {
               this.FMC_ThreeCustomVec[_loc2_]["TF_CustomPercent"].text = "";
            }
            _loc2_++;
         }
      }
      
      public function TodayChallengeTimes() : void
      {
         TextField(this.FRootPanel["TF_TodayChallengeTimes"]).text = TUtilityString.Format(STRING_COMMON.SixFary_TodayChallengeTimes,this.FRebirthRealmBaseData.TodayChallengeTimes);
      }
      
      public function ClosePanel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this.FMC_CartoonVec[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      public function addEvent() : void
      {
         var _loc1_:int = 0;
         this.FMC_GotoDestinyCorona.addEventListener(MouseEvent.CLICK,this.MC_GotoDestinyCoronaClick);
         this.FMC_GotoSixRebirth.addEventListener(MouseEvent.CLICK,this.MC_GotoSixRebirthClick);
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.FMC_ThreeCustomBtnVec[_loc1_].addEventListener(MouseEvent.CLICK,this.Challenge_BtnFunClick);
            _loc1_++;
         }
      }
   }
}

