package Processors.Game.Lobby.SixFairy
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_SIXFAIRYMAIN;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSixFairyManPanel extends TProcessorLobbyWindow
   {
      
      public static const Six:int = 6;
      
      public static const Nine:int = 9;
      
      protected var FRootPanel:MovieClip = null;
      
      protected var FMC_Btn_GetAward:MovieClip = null;
      
      protected var FMC_Btn_GotoPractice:MovieClip = null;
      
      protected var FSixFairy_MC_CustomBackGroud:MovieClip = null;
      
      protected var FSixFairy_MC_Background_Effect:MovieClip = null;
      
      protected var FBtn_LevelupSixFair:MovieClip = null;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var Fmc_list:MovieClip = null;
      
      protected var FGetAwardFun:Function = null;
      
      protected var FGotoPracticeFun:Function = null;
      
      protected var FLevelupSixFairFun:Function = null;
      
      protected var FUIComponentsHintOnOver:Function = null;
      
      protected var FUIComponentsHintOnOut:Function = null;
      
      protected var FExcelOne:Function = null;
      
      protected var FBtn_enterFun:Function = null;
      
      protected var FFTCount:TextField = null;
      
      protected var FFT_Customsed:TextField = null;
      
      protected var FSixFaryAllDataBase:SixFaryAllDataBase = null;
      
      protected var FSixVecMvc:Vector.<CustomsUint>;
      
      protected var FNineVecMvc:Vector.<CustomsUint>;
      
      protected var tempVec:Vector.<CustomsUint>;
      
      public function TProcessorWindowSixFairyManPanel(param1:TUIComponent, param2:SixFaryAllDataBase)
      {
         super(param1);
         this.FSixFaryAllDataBase = param2;
         this.FSixVecMvc = new Vector.<CustomsUint>(Six);
         this.FNineVecMvc = new Vector.<CustomsUint>(Nine);
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         this.FRootPanel = param1;
         this.FBtn_LevelupSixFair = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Btn_LevelupSixFair];
         this.FMC_Btn_GetAward = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Btn_GetAward];
         this.FMC_Btn_GotoPractice = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Btn_GotoPractice];
         this.FFTCount = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_FT_Count];
         this.FFT_Customsed = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_FT_Customsed];
         this.Fmc_list = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_BattleReport][CONST_SIXFAIRYMAIN.SixFairy_mc_list];
         this.FSixFairy_MC_CustomBackGroud = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_CustomBackGroud];
         this.FSixFairy_MC_Background_Effect = this.FSixFairy_MC_CustomBackGroud[CONST_SIXFAIRYMAIN.SixFairy_MC_Background_Effect];
         this.FScrollBar = new TScrollBar(this.Fmc_list,70,true,0);
         this.FScrollBar.Clear();
         this.ForBeautiful(true);
         TGameUtil.setButtonMode(this.FMC_Btn_GotoPractice,true);
         this.addVecMov();
         this.addEvent();
         new Tools_Help(FParent,this.FRootPanel[CONST_SIXFAIRYMAIN.BooldPurgatory_HelpBtn],CONST_SYSTEMLANGUAGE.HELPTIPS_SixFairy_SixFairy,FUICore);
         if(this.FExcelOne != null)
         {
            this.FExcelOne();
         }
      }
      
      public function set ExcelOne(param1:Function) : void
      {
         this.FExcelOne = param1;
      }
      
      public function UpdateManual() : void
      {
         if(!this.FSixFaryAllDataBase)
         {
            return;
         }
         this.setGetRewardBtnState();
         TextField(this.FRootPanel["FT_Count"]).text = String(this.FSixFaryAllDataBase.BatchCount - this.FSixFaryAllDataBase.ThisDayCanChallengeCount);
         this.FFT_Customsed.text = String(this.FSixFaryAllDataBase.ThisThroudCount);
         this.UpdateCustomImage();
      }
      
      public function UpdateCustomImage() : void
      {
         var _loc2_:Vector.<int> = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc1_:int = 0;
         this.setVisibel();
         _loc2_ = this.FSixFaryAllDataBase.CurSceneVec;
         if(this.FSixFaryAllDataBase.SixOrNine)
         {
            this.tempVec = this.FNineVecMvc;
            _loc3_ = Nine;
         }
         else
         {
            this.tempVec = this.FSixVecMvc;
            _loc3_ = Six;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            this.tempVec[_loc1_].ThisPanel.visible = true;
            _loc1_++;
         }
         _loc6_ = uint(this.FSixFaryAllDataBase.NextCustomsLayer);
         if(this.FBtn_LevelupSixFair)
         {
            if(this.FSixFaryAllDataBase.NeedChangeStatue)
            {
               if(SLogicsCore.Character.GetMainLevel() >= this.FSixFaryAllDataBase.NeedLevel && this.FSixFaryAllDataBase.CanChangeStatue)
               {
                  TGameUtil.setButtonMode(this.FBtn_LevelupSixFair,true);
               }
               else
               {
                  TGameUtil.setButtonMode(this.FBtn_LevelupSixFair,false);
               }
               this.FBtn_LevelupSixFair.visible = true;
            }
            else
            {
               this.FBtn_LevelupSixFair.visible = false;
            }
         }
         this.FSixFairy_MC_Background_Effect.gotoAndStop(_loc6_);
         switch(_loc6_)
         {
            case 1:
               _loc5_ = 1;
               break;
            case 2:
               _loc5_ = 7;
               break;
            case 3:
               _loc5_ = 13;
               break;
            case 4:
               _loc5_ = 22;
               break;
            case 5:
               _loc5_ = 31;
               break;
            case 6:
               _loc5_ = 37;
               break;
            case 7:
               _loc5_ = 43;
               break;
            case 8:
               _loc5_ = 52;
               break;
            case 9:
               _loc5_ = 61;
               break;
            case 10:
               _loc5_ = 67;
               break;
            case 11:
               _loc5_ = 73;
               break;
            case 12:
               _loc5_ = 82;
               break;
            case 13:
               _loc5_ = 91;
               break;
            case 14:
               _loc5_ = 97;
               break;
            case 15:
               _loc5_ = 103;
               break;
            case 16:
               _loc5_ = 112;
         }
         _loc1_ = 0;
         while(_loc1_ < this.tempVec.length)
         {
            this.tempVec[_loc1_].ResourceId = _loc2_[_loc1_];
            _loc4_ = TUtilityString.Format(STRING_TONGLING.TONGLING_45,_loc5_ + _loc1_);
            this.tempVec[_loc1_].TF_EnterText = _loc4_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.tempVec.length)
         {
            if(_loc1_ < this.FSixFaryAllDataBase.NextLayerCustoms)
            {
               this.tempVec[_loc1_].mc_pass = true;
               this.tempVec[_loc1_].MC_Locked = false;
            }
            else
            {
               this.tempVec[_loc1_].mc_pass = false;
               this.tempVec[_loc1_].MC_Locked = true;
            }
            this.tempVec[_loc1_].Btn_enter = false;
            if(_loc1_ == this.FSixFaryAllDataBase.NextLayerCustoms)
            {
               this.tempVec[_loc1_].mc_pass = false;
               this.tempVec[_loc1_].MC_Locked = false;
               this.tempVec[_loc1_].Btn_enter = true;
            }
            _loc1_++;
         }
      }
      
      public function JudgeCanPlayerEffectByCondition() : void
      {
         var _loc1_:int = 0;
         if(this.FSixFaryAllDataBase.NextLayerCustoms == 0 && this.FSixFaryAllDataBase.CurLayerCustoms == 5 || this.FSixFaryAllDataBase.NextLayerCustoms == 0 && this.FSixFaryAllDataBase.CurLayerCustoms == 8)
         {
            this.FSixFairy_MC_CustomBackGroud.gotoAndPlay(1);
            _loc1_ = 0;
            while(_loc1_ < this.tempVec.length)
            {
               this.tempVec[_loc1_].ThisPanel.gotoAndPlay(1);
               _loc1_++;
            }
         }
      }
      
      public function setGetRewardBtnState() : void
      {
         if(this.FSixFaryAllDataBase.GetRewardBtnState)
         {
            this.ForBeautiful(false);
         }
         else
         {
            this.ForBeautiful(true);
         }
      }
      
      public function ForBeautiful(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMC_Btn_GetAward,param1);
      }
      
      public function setVisibel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Six)
         {
            this.FSixVecMvc[_loc1_].ThisPanel.visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Nine)
         {
            this.FNineVecMvc[_loc1_].ThisPanel.visible = false;
            _loc1_++;
         }
      }
      
      public function UpdateLogic() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Six)
         {
            this.FSixVecMvc[_loc1_].UpdateHeadImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Nine)
         {
            this.FNineVecMvc[_loc1_].UpdateHeadImage();
            _loc1_++;
         }
      }
      
      public function addVecMov() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CustomsUint = null;
         if(!this.FRootPanel)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < Six)
         {
            _loc2_ = new CustomsUint(this.FRootPanel["MC_Father_Customs"]["MC_Six_Customs_" + _loc1_]);
            _loc2_.Btn_enterFun = this.FBtn_enterFunF;
            _loc2_.UIComponentsHintOnOver = this.UIComponentsHintOnOverFun;
            _loc2_.UIComponentsHintOnOut = this.UIComponentsHintOnOutFun;
            this.FSixVecMvc[_loc1_] = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Nine)
         {
            _loc2_ = new CustomsUint(this.FRootPanel["MC_Father_Customs"]["MC_Nina_Customs_" + _loc1_]);
            _loc2_.Btn_enterFun = this.FBtn_enterFunF;
            _loc2_.UIComponentsHintOnOver = this.UIComponentsHintOnOverFun;
            _loc2_.UIComponentsHintOnOut = this.UIComponentsHintOnOutFun;
            this.FNineVecMvc[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function addEvent() : void
      {
         if(this.FBtn_LevelupSixFair)
         {
            this.FBtn_LevelupSixFair.addEventListener(MouseEvent.ROLL_OVER,this.OnLevelupSixFairOver);
            this.FBtn_LevelupSixFair.addEventListener(MouseEvent.ROLL_OUT,this.OnLevelupSixFairOut);
            this.FBtn_LevelupSixFair.addEventListener(MouseEvent.CLICK,this.GetAwardPracticeClick);
         }
         this.FMC_Btn_GetAward.addEventListener(MouseEvent.CLICK,this.GetAwardPracticeClick);
         this.FMC_Btn_GotoPractice.addEventListener(MouseEvent.CLICK,this.GetAwardPracticeClick);
      }
      
      public function AddItem(param1:DisplayObject) : void
      {
         if(!this.FScrollBar)
         {
            return;
         }
         this.FScrollBar.AddItem(param1);
      }
      
      public function AddItems(param1:Vector.<DisplayObject>) : void
      {
         this.FScrollBar.AddItems(param1);
      }
      
      public function ScrollBarClear() : void
      {
         if(!this.FScrollBar)
         {
            return;
         }
         this.FScrollBar.Clear();
      }
      
      public function set FTCount(param1:int) : void
      {
         if(!this.FFTCount)
         {
            return;
         }
         this.FFTCount.text = String(param1);
      }
      
      public function OnLevelupSixFairOver(param1:MouseEvent) : void
      {
      }
      
      public function OnLevelupSixFairOut(param1:MouseEvent) : void
      {
      }
      
      public function GetAwardPracticeClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBtn_LevelupSixFair:
               if(!this.FSixFaryAllDataBase.CanChangeStatue)
               {
                  EffectGenerateText(STRING_TONGLING.TONGLING_302);
                  return;
               }
               if(SLogicsCore.Character.GetMainLevel() < this.FSixFaryAllDataBase.NeedLevel)
               {
                  EffectGenerateText(STRING_TONGLING.TONGLING_301);
                  return;
               }
               if(this.FLevelupSixFairFun != null)
               {
                  this.FLevelupSixFairFun(this,1);
               }
               break;
            case this.FMC_Btn_GetAward:
               if(this.FGetAwardFun != null)
               {
                  if(this.FSixFaryAllDataBase.GetRewardBtnState)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_44);
                  }
                  else
                  {
                     this.FGetAwardFun();
                  }
               }
               break;
            case this.FMC_Btn_GotoPractice:
               if(this.FGotoPracticeFun != null)
               {
                  this.FGotoPracticeFun();
               }
         }
      }
      
      public function FBtn_enterFunF(param1:int, param2:int) : void
      {
         if(this.FBtn_enterFun != null)
         {
            this.FBtn_enterFun(param1,param2);
         }
      }
      
      public function set GetAwardFun(param1:Function) : void
      {
         this.FGetAwardFun = param1;
      }
      
      public function set GotoPracticeFun(param1:Function) : void
      {
         this.FGotoPracticeFun = param1;
      }
      
      public function set LevelupSixFairFun(param1:Function) : void
      {
         this.FLevelupSixFairFun = param1;
      }
      
      public function set Btn_enterFun(param1:Function) : void
      {
         this.FBtn_enterFun = param1;
      }
      
      public function UIComponentsHintOnOverFun(param1:int) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,null);
         }
      }
      
      public function UIComponentsHintOnOutFun(param1:int) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,null);
         }
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
   }
}

