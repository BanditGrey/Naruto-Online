package Processors.Game.Lobby.NarutoHelper.SecondaryWindow
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.NarutoHelper.TQuestion;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_NARUTOHELPER;
   import Resources.Strings.STRING_NARUTOHELPER;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUISecretQAndA extends TUIComponent
   {
      
      protected var FMainUI:Sprite;
      
      protected var FTF_Question:TextField;
      
      protected var FMC_Confirm:MovieClip;
      
      protected var FMC_Answers:Vector.<MovieClip>;
      
      protected var FBTN_Options:Vector.<MovieClip>;
      
      protected var FTF_Answers:Vector.<TextField>;
      
      protected var FLevel:uint;
      
      protected var FAnswerIndex:uint;
      
      protected var FAnswerOnClick:Function;
      
      protected var FOnClose:Function;
      
      public function TUISecretQAndA(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Answers = new Vector.<MovieClip>();
         this.FBTN_Options = new Vector.<MovieClip>();
         this.FTF_Answers = new Vector.<TextField>();
      }
      
      protected function Perform_ResourceUIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         addChild(this.FMainUI);
         _loc2_ = CONST_NARUTOHELPER.CAPACITY_Answers;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMC_Answers[_loc1_] = this.FMainUI["MC_Answer_" + _loc1_];
            this.FBTN_Options[_loc1_] = this.FMC_Answers[_loc1_]["BTN_Option"];
            this.FTF_Answers[_loc1_] = this.FMC_Answers[_loc1_]["TF_Answer"];
            _loc1_++;
         }
         this.FTF_Question = this.FMainUI["TF_Question"];
         this.FMC_Confirm = this.FMainUI["MC_Confirm"];
         TGameUtil.setButtonMode(this.FMC_Confirm,true);
      }
      
      protected function Perform_ResourceUILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FBTN_Options.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FBTN_Options[_loc1_].addEventListener(MouseEvent.CLICK,this.BTNOptionOnClick,false,0,true);
            _loc1_++;
         }
         this.FMC_Confirm.addEventListener(MouseEvent.CLICK,this.MCConfirmOnClick,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TQuestion = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:Boolean = false;
         _loc2_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc3_ = uint(SLogicsCore.NarutoHelperData.AnswerLevel);
         _loc6_ = "";
         _loc8_ = this.FMC_Answers.length;
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc9_ = this.FBTN_Options[_loc7_];
            _loc9_.gotoAndStop(1);
            _loc7_++;
         }
         if(_loc3_ == SLogicsCore.NarutoHelperData.Questions.Count)
         {
            this.FMC_Confirm["TF_Confirm"].text = STRING_NARUTOHELPER.STRING_GotoLevelUp;
            _loc6_ = STRING_NARUTOHELPER.STRING_QuestionOver;
            this.FTF_Question.text = _loc6_;
            this.HideAnswer(false);
            return;
         }
         if(_loc2_ > _loc3_)
         {
            _loc1_ = SLogicsCore.NarutoHelperData.Questions.GetQuestionByLevel(_loc3_ + 1);
            _loc5_ = this.CheckOptionIsSelect();
            if(_loc1_ != null)
            {
               _loc6_ = _loc1_.Question;
               this.FMC_Confirm["TF_Confirm"].text = STRING_NARUTOHELPER.STRING_ConfirmAnswer;
               this.FLevel = _loc1_.Level;
            }
            TGameUtil.setButtonMode(this.FMC_Confirm,_loc5_);
            this.FMC_Confirm.mouseEnabled = _loc5_;
            _loc10_ = true;
         }
         else if(_loc2_ == _loc3_)
         {
            _loc1_ = SLogicsCore.NarutoHelperData.Questions.GetQuestionByLevel(_loc3_);
            this.FMC_Confirm["TF_Confirm"].text = STRING_NARUTOHELPER.STRING_GotoLevelUp;
            _loc6_ = STRING_NARUTOHELPER.STRING_NeedLevelUp;
            _loc10_ = false;
         }
         this.HideAnswer(_loc10_);
         this.FTF_Question.text = _loc6_;
         this.UpdateAnswers(_loc1_);
      }
      
      protected function HideAnswer(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         _loc3_ = this.FMC_Answers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_Answers[_loc2_];
            _loc4_.visible = param1;
            _loc2_++;
         }
      }
      
      protected function UpdateConfirm() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = this.CheckOptionIsSelect();
         TGameUtil.setButtonMode(this.FMC_Confirm,_loc1_);
         this.FMC_Confirm.mouseEnabled = _loc1_;
      }
      
      protected function UpdateAnswers(param1:TQuestion) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TextField = null;
         _loc3_ = CONST_NARUTOHELPER.CAPACITY_Answers;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FTF_Answers[_loc2_];
            _loc4_.text = param1.Answers[_loc2_];
            _loc2_++;
         }
      }
      
      protected function CheckOptionIsSelect() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.FMC_Answers.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBTN_Options[_loc1_];
            if(_loc3_.currentFrame == 2)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function BTNOptionOnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         _loc4_ = int(param1.currentTarget.parent.name.split("_")[2]);
         this.FAnswerIndex = _loc4_ + 1;
         _loc3_ = CONST_NARUTOHELPER.CAPACITY_Answers;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc4_ == _loc2_)
            {
               this.FBTN_Options[_loc2_].gotoAndStop(2);
            }
            else
            {
               this.FBTN_Options[_loc2_].gotoAndStop(1);
            }
            _loc2_++;
         }
         this.UpdateConfirm();
      }
      
      protected function MCConfirmOnClick(param1:MouseEvent) : void
      {
         if(this.FMC_Confirm["TF_Confirm"].text == STRING_NARUTOHELPER.STRING_GotoLevelUp)
         {
            if(this.FOnClose != null)
            {
               this.FOnClose(this);
            }
            return;
         }
         if(this.FAnswerOnClick != null)
         {
            this.FAnswerOnClick(this,this.FLevel,this.FAnswerIndex);
         }
      }
      
      public function set AnswerOnClick(param1:Function) : void
      {
         this.FAnswerOnClick = param1;
      }
      
      public function set OnClose(param1:Function) : void
      {
         this.FOnClose = param1;
      }
      
      public function ResourceUIDispatch(param1:Sprite) : void
      {
         this.FMainUI = param1;
         this.Perform_ResourceUIDispatch();
         this.Perform_ResourceUILocation();
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

