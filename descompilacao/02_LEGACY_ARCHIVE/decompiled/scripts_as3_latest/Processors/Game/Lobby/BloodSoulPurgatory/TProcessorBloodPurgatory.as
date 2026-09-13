package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Tools.MvcPlayEffect;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorBloodPurgatory extends TProcessorLobbyWindow
   {
      
      public static const Mvc_Num:int = 3;
      
      public static const FrameNum:int = 55;
      
      protected var FMcPanel:Sprite;
      
      protected var FChallengeBtn:MovieClip;
      
      protected var FCBloodSoulBtn:MovieClip;
      
      protected var FTextCusTom:TextField;
      
      protected var FTextLevel:TextField;
      
      protected var FTF_Experience:TextField;
      
      protected var FExpBar:MovieClip;
      
      protected var FMC_PetPosition:MovieClip;
      
      protected var FMC_PetPositionPanel:MovieClip;
      
      protected var FMC_Background_Effect:MovieClip;
      
      protected var FChallengeBtnIsCanClick:Boolean = true;
      
      protected var FEffectInstance:MovieClip;
      
      protected var FMonster:TActive;
      
      protected var FChallengeBtnFun:Function;
      
      protected var FCBloodSoulBtnFun:Function;
      
      protected var FBloodSoulCloseBtnFun:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FUIComponentsLittleOnOver:Function;
      
      protected var FUIComponentsLittleOnOut:Function;
      
      protected var FInitilization:int;
      
      protected var FMvcPlayEffect:MvcPlayEffect;
      
      protected var FMC_Little_Csutom:MovieClip;
      
      protected var FMC_All_Csutom:MovieClip;
      
      protected var OneTimes:int = 1;
      
      protected var FCurpetid:int;
      
      protected var FNeedLevel:int;
      
      protected var FIsWin:Boolean = false;
      
      protected var FIsOver:Boolean;
      
      protected var FIsClearance:Boolean;
      
      public function TProcessorBloodPurgatory(param1:TUIComponent)
      {
         super(param1);
         this.FMvcPlayEffect = new MvcPlayEffect(this.FMvcPlayerOver,FrameNum);
      }
      
      public function SetIsWin(param1:Boolean) : void
      {
         this.FIsWin = param1;
      }
      
      public function setRootPanel(param1:Sprite) : void
      {
         var _loc2_:int = 0;
         this.FMcPanel = param1;
         SimpleButton(this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_CloseBtn]).addEventListener(MouseEvent.CLICK,this.BloodSoulCloseBtn);
         this.FChallengeBtn = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Challenge_Btn];
         this.FCBloodSoulBtn = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_See_BloodSoul];
         this.ChallengeBtn(true);
         TGameUtil.setButtonMode(this.FCBloodSoulBtn,true);
         this.FChallengeBtn.addEventListener(MouseEvent.CLICK,this.ChallengeBloodClick);
         this.FCBloodSoulBtn.addEventListener(MouseEvent.CLICK,this.ChallengeBloodClick);
         this.FTextCusTom = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Custom];
         this.FTextLevel = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Level];
         this.FTF_Experience = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Exp_Bar][CONST_BLOODPURGATORY.BooldPurgatory_TF_Experience];
         this.FExpBar = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Exp_Bar][CONST_BLOODPURGATORY.BooldPurgatory_MC_ProgressBarExp];
         this.FMC_PetPositionPanel = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_PetPanel];
         this.FMC_PetPosition = this.FMC_PetPositionPanel["MC_PetPanel_Second"]["MC_PetPanel_One"];
         this.FMC_Background_Effect = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Background_Effect];
         this.FMC_Little_Csutom = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Little_Csutom];
         this.FMC_All_Csutom = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_All_Csutom];
         this.FMC_All_Csutom.addEventListener(MouseEvent.MOUSE_MOVE,this.FUIComponentsHintOnOverF);
         this.FMC_All_Csutom.addEventListener(MouseEvent.MOUSE_OUT,this.FUIComponentsHintOnOutF);
         this.FMC_Little_Csutom.addEventListener(MouseEvent.MOUSE_MOVE,this.FUIComponentsLittleOnOverF);
         this.FMC_Little_Csutom.addEventListener(MouseEvent.MOUSE_OUT,this.FUIComponentsLittleOnOutF);
         new Tools_Help(FParent,this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_HelpBtn],CONST_SYSTEMLANGUAGE.HELPTIPS_BloodSoulPurgatory_Custom,FUICore);
         this.FMonster = new TActive(null,11110012,CONST_MODULES.MODULE_Common,true);
         this.FMC_PetPosition.addChild(this.FMonster);
         this.FInitilization = 1;
      }
      
      public function FUIComponentsHintOnOverF(param1:MouseEvent) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver();
         }
      }
      
      public function FUIComponentsHintOnOutF(param1:MouseEvent) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut();
         }
      }
      
      public function FUIComponentsLittleOnOverF(param1:MouseEvent) : void
      {
         if(this.FUIComponentsLittleOnOver != null)
         {
            this.FUIComponentsLittleOnOver();
         }
      }
      
      public function FUIComponentsLittleOnOutF(param1:MouseEvent) : void
      {
         if(this.FUIComponentsLittleOnOut != null)
         {
            this.FUIComponentsLittleOnOut();
         }
      }
      
      public function setInstance(param1:int) : void
      {
         this.FMC_Background_Effect.gotoAndStop(param1 + 1);
         this.FEffectInstance = this.FMC_Background_Effect[[CONST_BLOODPURGATORY.BooldPurgatory_MC_Customs0_ + param1]];
         if(!this.FEffectInstance)
         {
            return;
         }
         this.FMvcPlayEffect.SetEffectPanel(this.FEffectInstance);
      }
      
      public function BeginPlayerEffect() : void
      {
         this.FMC_PetPosition.visible = false;
         this.FChallengeBtn.visible = false;
         this.FCBloodSoulBtn.visible = false;
         if(this.FIsWin)
         {
            if(this.FIsClearance)
            {
               this.FMC_All_Csutom.gotoAndPlay(1);
            }
         }
         if(this.FIsOver)
         {
            this.FChallengeBtn.visible = true;
            this.ChallengeBtn(false);
            this.FCBloodSoulBtn.visible = true;
            return;
         }
         this.FMC_PetPositionPanel.gotoAndStop(1);
         this.FMvcPlayEffect.playEffect();
      }
      
      protected function FMvcPlayerOver() : void
      {
         this.FMC_PetPosition.visible = true;
         this.FChallengeBtn.visible = true;
         this.FCBloodSoulBtn.visible = true;
         this.FMC_All_Csutom.gotoAndStop(1);
         this.FMC_PetPositionPanel.gotoAndPlay(1);
      }
      
      public function SetFUIPetId(param1:int, param2:uint = 0) : void
      {
         this.FCurpetid = param1;
         this.FNeedLevel = param2;
      }
      
      public function UpdtaMonsterId() : void
      {
         this.FMonster.ResetActive(null,this.FCurpetid,CONST_MODULES.MODULE_Common,true);
      }
      
      public function LogicUpdate() : void
      {
         if(this.FInitilization == 1)
         {
            if(this.FMonster != null)
            {
               this.FMonster.UpdateActive();
            }
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(!this.FMcPanel)
         {
            return;
         }
         this.FMcPanel.visible = param1;
      }
      
      public function GetCustomLayer(param1:int, param2:int, param3:int) : void
      {
         if(!this.FMcPanel)
         {
            return;
         }
         param2 += 1;
         this.FIsOver = false;
         this.FIsClearance = false;
         if(param1 > 4)
         {
            param1 = 4;
            param2 = 6;
            param3 = 5;
         }
         if(param3 == 5)
         {
            if(param1 != 3 && param1 != 4 && param2 == 3 || (param1 == 3 || param1 == 4) && param2 == 6)
            {
               this.FIsOver = true;
               this.ChallengeBtn(false);
            }
            else
            {
               param2++;
               param3 = 0;
            }
            this.FIsClearance = true;
         }
         this.FTextCusTom.text = TUtilityString.Format(STRING_TONGLING.TONGLING_21,param2);
         if(this.FNeedLevel < CONST_COMMON.Ninja_One_Reincarnation_Footstone)
         {
            this.FTextLevel.text = TUtilityString.Format(STRING_TONGLING.TONGLING_76,this.FNeedLevel);
         }
         else
         {
            this.FTextLevel.text = TUtilityString.Format(STRING_TONGLING.TONGLING_77,STRING_COMMON.GetLevelStrByLevelLineFeed(this.FNeedLevel));
         }
         var _loc4_:Number = Number(param3) / 5;
         this.FTF_Experience.text = _loc4_ * 100 + "%";
         this.FExpBar.scaleX = _loc4_;
         this.setInstance(param1);
      }
      
      public function ChallengeBloodClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FChallengeBtn:
               if(this.FChallengeBtnFun != null)
               {
                  if(this.FChallengeBtnIsCanClick)
                  {
                     this.FChallengeBtnFun();
                  }
               }
               break;
            case this.FCBloodSoulBtn:
               if(this.FCBloodSoulBtnFun != null)
               {
                  this.FCBloodSoulBtnFun();
               }
         }
      }
      
      public function ChallengeBtn(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FChallengeBtn,param1);
         this.FChallengeBtnIsCanClick = param1;
      }
      
      public function BloodSoulCloseBtn(param1:MouseEvent) : void
      {
         if(this.FBloodSoulCloseBtnFun != null)
         {
            this.FBloodSoulCloseBtnFun(1);
         }
      }
      
      public function set BloodSoulCloseBtnFun(param1:Function) : void
      {
         this.FBloodSoulCloseBtnFun = param1;
      }
      
      public function set ChallengeBtnFun(param1:Function) : void
      {
         this.FChallengeBtnFun = param1;
      }
      
      public function set CBloodSoulBtnFun(param1:Function) : void
      {
         this.FCBloodSoulBtnFun = param1;
      }
      
      public function get IsOver() : Boolean
      {
         return this.FIsOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function set UIComponentsLittleOnOver(param1:Function) : void
      {
         this.FUIComponentsLittleOnOver = param1;
      }
      
      public function set UIComponentsLittleOnOut(param1:Function) : void
      {
         this.FUIComponentsLittleOnOut = param1;
      }
   }
}

