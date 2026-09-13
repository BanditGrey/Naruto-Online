package Processors.Game.Lobby.Exercise.Dice.Compoents
{
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.Dice.TDice;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_DICE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TUITable extends TUIComponent
   {
      
      protected static const MAX_COUNT:int = 10;
      
      protected static const DICE_COUNT:int = 3;
      
      public static const GOLD_FOR_WRONG:int = 0;
      
      public static const GOLD_FOR_LIFE:int = 1;
      
      public static const NOT_BEGIN:int = TDice.NOT_BEGIN;
      
      public static const NEED_GET_REWARD:int = TDice.NEED_GET_REWARD;
      
      public static const WAIT_FOR_SELECT:int = TDice.WAIT_FOR_SELECT;
      
      public static const GET_RESULT:int = TDice.GET_RESULT;
      
      public static const CHOICE_NONE:int = TDice.CHOICE_NONE;
      
      public static const CHOICE_SMALL:int = TDice.CHOICE_SMALL;
      
      public static const CHOICE_BIG:int = TDice.CHOICE_BIG;
      
      public static const WAIT_FOR_WRONG:int = TDice.WAIT_FOR_WRONG;
      
      public static const BEGIN_GAME_AGAIN:int = TDice.BEGIN_GAME_AGAIN;
      
      public static const RESULT_NONE:int = TDice.RESULT_NONE;
      
      public static const RESULT_LOSE:int = TDice.RESULT_LOSE;
      
      public static const RESULT_WIN:int = TDice.RESULT_WIN;
      
      public static const TYPE_BUY:int = 0;
      
      public static const TYPE_NO_BUY:int = 1;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Start:MovieClip;
      
      protected var FBTN_Select:MovieClip;
      
      protected var FBTN_Big:SimpleButton;
      
      protected var FBTN_Small:SimpleButton;
      
      protected var FTF_WinCount:TextField;
      
      protected var FTF_Life:TextField;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_FirstDice:MovieClip;
      
      protected var FMC_SecondDice:MovieClip;
      
      protected var FMC_Cup0:MovieClip;
      
      protected var FMC_Cup1:MovieClip;
      
      protected var FDice:TDice;
      
      protected var FInitialized:Boolean;
      
      protected var FTimeID:int;
      
      protected var FHintBoxTip:THint;
      
      protected var FOnStart:Function;
      
      protected var FOnChoice:Function;
      
      protected var FOnLose:Function;
      
      protected var FOnContiue:Function;
      
      protected var FOnResultMovieEnd:Function;
      
      protected var FOnShowGotoRecharge:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      public function TUITable(param1:TUIComponent)
      {
         super(param1);
         this.FDice = SLogicsCore.Dice;
         this.FHintBoxTip = new THint();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.Resources_UIDispatchBtn();
         this.Resources_UIDispatchTxt();
         this.Resources_UIDispatchTable();
      }
      
      protected function Resources_UIDispatchBtn() : void
      {
         this.FBTN_Start = this.FMC_Scene.BTN_Start;
         this.FBTN_Select = this.FMC_Scene.BTN_Select;
         this.FBTN_Big = this.FMC_Scene.BTN_Big;
         this.FBTN_Small = this.FMC_Scene.BTN_Small;
         TGameUtil.setButtonMode(this.FBTN_Start,true);
         this.FBTN_Start.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnStart);
         this.FBTN_Start.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
         this.FBTN_Start.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
         this.FBTN_Select.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnSelect);
         this.FBTN_Big.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnChoice);
         this.FBTN_Small.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnChoice);
      }
      
      protected function Resources_UIDispatchTxt() : void
      {
         this.FTF_Life = this.FMC_Scene.TF_Life;
         this.FTF_WinCount = this.FMC_Scene.TF_WinCount;
      }
      
      protected function Resources_UIDispatchTable() : void
      {
         this.FMC_Effect = this.FMC_Scene.MC_Effect;
         this.FMC_FirstDice = this.FMC_Scene.MC_Dice0;
         this.FMC_SecondDice = this.FMC_Scene.MC_Dice1;
         this.FMC_Cup0 = this.FMC_Scene.MC_Cup0;
         this.FMC_Cup1 = this.FMC_Scene.MC_Cup1;
      }
      
      protected function UpdateTable() : void
      {
         switch(this.FDice.Status)
         {
            case NOT_BEGIN:
               this.FMC_Effect.gotoAndStop("normal");
               this.FMC_Cup0.visible = true;
               this.FMC_Cup0.gotoAndStop(1);
               this.FMC_Cup1.visible = true;
               this.FMC_Cup1.gotoAndStop(1);
               TGameUtil.setButtonMode(this.FBTN_Start,true);
               break;
            case NEED_GET_REWARD:
               this.FMC_Effect.gotoAndStop("getReward");
               this.FMC_Cup0.visible = true;
               this.FMC_Cup0.gotoAndStop(1);
               this.FMC_Cup1.visible = true;
               this.FMC_Cup1.gotoAndStop(1);
               TGameUtil.setButtonMode(this.FBTN_Start,false);
               break;
            case WAIT_FOR_SELECT:
               this.FMC_Effect.gotoAndStop("normal");
               this.FMC_Cup0.visible = true;
               this.FMC_Cup0.gotoAndStop(this.FMC_Cup0.totalFrames);
               this.FMC_Cup1.visible = true;
               this.FMC_Cup1.gotoAndStop(this.FMC_Cup1.totalFrames);
               TGameUtil.setButtonMode(this.FBTN_Start,false);
               break;
            case GET_RESULT:
               this.FMC_Cup0.visible = false;
               this.FMC_Cup1.visible = false;
               TGameUtil.setButtonMode(this.FBTN_Start,false);
               if(this.FTimeID != 0)
               {
                  clearTimeout(this.FTimeID);
                  this.FTimeID = 0;
               }
               if(this.FDice.CurResult == RESULT_WIN)
               {
                  this.FMC_Effect.gotoAndStop("win");
                  this.FTimeID = setTimeout(this.BeginGameAgain,2000);
               }
               else
               {
                  this.FMC_Effect.gotoAndStop("lose");
                  this.FTimeID = setTimeout(this.BeginGameAgain,2000);
               }
               break;
            case WAIT_FOR_WRONG:
               TGameUtil.setButtonMode(this.FBTN_Start,false);
               if(this.FOnLose != null)
               {
                  this.FOnLose();
               }
               break;
            case BEGIN_GAME_AGAIN:
               this.FMC_Effect.gotoAndStop("normal");
               this.FMC_Cup0.visible = true;
               this.FMC_Cup1.visible = true;
               TGameUtil.setButtonMode(this.FBTN_Start,false);
               if(this.FOnContiue != null)
               {
                  this.FOnContiue();
               }
         }
      }
      
      public function UpdateBtn() : void
      {
         if(this.FDice.Status == NOT_BEGIN)
         {
            TGameUtil.setButtonMode(this.FBTN_Start,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Start,false);
         }
         if(this.FDice.IsSelected)
         {
            if(this.FDice.CheckMoney(GOLD_FOR_WRONG))
            {
               this.FBTN_Select.gotoAndStop("ok");
            }
            else
            {
               this.FBTN_Select.gotoAndStop("cancle");
               this.FDice.IsSelected = false;
            }
         }
         else
         {
            this.FBTN_Select.gotoAndStop("cancle");
         }
         if(this.FDice.Status != WAIT_FOR_SELECT)
         {
            this.FBTN_Big.visible = false;
            this.FBTN_Small.visible = false;
         }
         else
         {
            this.FBTN_Big.visible = true;
            this.FBTN_Small.visible = true;
         }
      }
      
      public function UpdateTxt() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FDice.FirstNumber.length);
         _loc1_ = 0;
         while(_loc1_ < DICE_COUNT)
         {
            if(_loc1_ < _loc2_)
            {
               this.FMC_FirstDice["MC_SingleDice" + _loc1_].visible = true;
               this.FMC_FirstDice["MC_SingleDice" + _loc1_].gotoAndStop(this.FDice.FirstNumber[_loc1_]);
            }
            else
            {
               this.FMC_FirstDice["MC_SingleDice" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FDice.SecondNumber.length);
         _loc1_ = 0;
         while(_loc1_ < DICE_COUNT)
         {
            if(_loc1_ < _loc2_)
            {
               this.FMC_SecondDice["MC_SingleDice" + _loc1_].visible = true;
               this.FMC_SecondDice["MC_SingleDice" + _loc1_].gotoAndStop(this.FDice.SecondNumber[_loc1_]);
            }
            else
            {
               this.FMC_SecondDice["MC_SingleDice" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FTF_WinCount.text = TUtilityString.Format(STRING_DICE.FORMAT_WIN_COUNTS,this.FDice.WinCount);
         this.FTF_Life.text = TUtilityString.Format(STRING_DICE.FORMAT_DESC,this.FDice.Life,this.FDice.CanBeWrong);
         this.FMC_Scene.TF_WrongCost.text = TUtilityString.Format(STRING_DICE.FORMAT_WRONG_COST,this.FDice.WrongGold);
         this.FMC_Scene.MC_Result.visible = false;
         switch(this.FDice.Status)
         {
            case NOT_BEGIN:
               this.FMC_Scene.MC_Dialog.visible = true;
               this.FMC_Scene.MC_Dialog.gotoAndPlay(1);
               this.FMC_Scene.MC_Dialog.MC_Dialog.TF_Dialog.text = STRING_DICE.TEXT_NOT_BEGIN;
               break;
            case NEED_GET_REWARD:
               this.FMC_Scene.MC_Dialog.visible = true;
               this.FMC_Scene.MC_Dialog.gotoAndPlay(1);
               this.FMC_Scene.MC_Dialog.MC_Dialog.TF_Dialog.text = STRING_DICE.TEXT_NEED_GET;
               break;
            case WAIT_FOR_SELECT:
               this.FMC_Scene.MC_Dialog.visible = true;
               this.FMC_Scene.MC_Dialog.gotoAndPlay(1);
               this.FMC_Scene.MC_Dialog.MC_Dialog.TF_Dialog.text = STRING_DICE.TEXT_NOT_BEGIN;
               break;
            case GET_RESULT:
               this.FMC_Scene.MC_Dialog.visible = true;
               this.FMC_Scene.MC_Dialog.gotoAndPlay(1);
               if(this.FDice.CurResult == RESULT_WIN)
               {
                  this.FMC_Scene.MC_Dialog.MC_Dialog.TF_Dialog.text = STRING_DICE.TEXT_WIN;
                  this.FMC_Scene.MC_Result.visible = true;
                  this.FMC_Scene.MC_Result.gotoAndStop(1);
                  this.FMC_Scene.MC_Result.win.gotoAndPlay(1);
               }
               else
               {
                  this.FMC_Scene.MC_Dialog.MC_Dialog.TF_Dialog.text = STRING_DICE.TEXT_LOSE;
                  this.FMC_Scene.MC_Result.visible = true;
                  this.FMC_Scene.MC_Result.gotoAndStop(2);
                  this.FMC_Scene.MC_Result.lose.gotoAndPlay(1);
               }
               break;
            case WAIT_FOR_WRONG:
               this.FMC_Scene.MC_Dialog.visible = false;
               break;
            case BEGIN_GAME_AGAIN:
               this.FMC_Scene.MC_Dialog.visible = false;
         }
      }
      
      protected function ProcessorOnStart(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FBTN_Start,false);
         this.FMC_Effect.gotoAndStop("shy");
         if(this.FOnStart != null)
         {
            this.FOnStart();
         }
      }
      
      protected function ProcessorOnChoice(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.currentTarget.name;
         if(_loc2_ == "BTN_Big")
         {
            this.FDice.ChoiceType = CHOICE_BIG;
         }
         else
         {
            this.FDice.ChoiceType = CHOICE_SMALL;
         }
         this.FBTN_Big.visible = false;
         this.FBTN_Small.visible = false;
         if(this.FOnChoice != null)
         {
            this.FOnChoice();
         }
      }
      
      protected function ProcessorOnSelect(param1:MouseEvent = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(this.FDice.IsSelected)
         {
            this.FBTN_Select.gotoAndStop("cancle");
            this.FDice.IsSelected = false;
         }
         else
         {
            if(_loc2_.CreditGold + _loc2_.CreditGiftCertificate < this.FDice.WrongGold)
            {
               if(this.FOnShowGotoRecharge != null)
               {
                  this.FOnShowGotoRecharge();
                  return;
               }
            }
            this.FBTN_Select.gotoAndStop("ok");
            this.FDice.IsSelected = true;
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         if(Boolean(param1.currentTarget.buttonMode) || this.FDice.Status != NEED_GET_REWARD)
         {
            return;
         }
         _loc2_ = STRING_DICE.FORMAT_NEED_GET_REWARD;
         this.FHintBoxTip.Caption = _loc2_;
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,this.FHintBoxTip);
         }
      }
      
      protected function ProcessorOnTipOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
         }
      }
      
      public function get OnStart() : Function
      {
         return this.FOnStart;
      }
      
      public function set OnStart(param1:Function) : void
      {
         this.FOnStart = param1;
      }
      
      public function get OnChoice() : Function
      {
         return this.FOnChoice;
      }
      
      public function set OnChoice(param1:Function) : void
      {
         this.FOnChoice = param1;
      }
      
      public function get OnLose() : Function
      {
         return this.FOnLose;
      }
      
      public function set OnLose(param1:Function) : void
      {
         this.FOnLose = param1;
      }
      
      public function get OnContiue() : Function
      {
         return this.FOnContiue;
      }
      
      public function set OnContiue(param1:Function) : void
      {
         this.FOnContiue = param1;
      }
      
      public function get OnResultMovieEnd() : Function
      {
         return this.FOnResultMovieEnd;
      }
      
      public function set OnResultMovieEnd(param1:Function) : void
      {
         this.FOnResultMovieEnd = param1;
      }
      
      public function get OnShowGotoRecharge() : Function
      {
         return this.FOnShowGotoRecharge;
      }
      
      public function set OnShowGotoRecharge(param1:Function) : void
      {
         this.FOnShowGotoRecharge = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.visible)
         {
         }
      }
      
      public function UpdateUI() : void
      {
         this.UpdateTable();
         this.UpdateBtn();
         this.UpdateTxt();
      }
      
      public function PlayCupMovie() : void
      {
         this.FMC_Cup0.visible = true;
         this.FMC_Cup1.visible = true;
         this.FMC_Cup0.gotoAndPlay(1);
         this.FMC_Cup1.gotoAndPlay(1);
         this.FTimeID = setTimeout(this.StopCupMovie,1000);
      }
      
      public function StopCupMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         _loc2_ = int(this.FDice.FirstNumber.length);
         _loc1_ = 0;
         while(_loc1_ < DICE_COUNT)
         {
            if(_loc1_ < _loc2_)
            {
               this.FMC_FirstDice["MC_SingleDice" + _loc1_].visible = true;
               this.FMC_FirstDice["MC_SingleDice" + _loc1_].gotoAndStop(this.FDice.FirstNumber[_loc1_]);
            }
            else
            {
               this.FMC_FirstDice["MC_SingleDice" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FDice.CheckStatus();
         this.UpdateUI();
      }
      
      public function PlayResultMovie() : void
      {
         this.FTimeID = setTimeout(this.StopResultMovie,1000);
      }
      
      public function StopResultMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         _loc2_ = int(this.FDice.SecondNumber.length);
         _loc1_ = 0;
         while(_loc1_ < DICE_COUNT)
         {
            if(_loc1_ < _loc2_)
            {
               this.FMC_SecondDice["MC_SingleDice" + _loc1_].visible = true;
               this.FMC_SecondDice["MC_SingleDice" + _loc1_].gotoAndStop(this.FDice.SecondNumber[_loc1_]);
            }
            else
            {
               this.FMC_SecondDice["MC_SingleDice" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FMC_Cup0.visible = false;
         this.FMC_Cup1.visible = false;
         this.FDice.ProcessorOnResult();
         this.UpdateUI();
         if(this.FDice.CurResult == RESULT_WIN && this.FOnResultMovieEnd != null)
         {
            this.FOnResultMovieEnd();
         }
      }
      
      public function BeginGameAgain() : void
      {
         if(this.FTimeID != 0)
         {
            clearTimeout(this.FTimeID);
            this.FTimeID = 0;
         }
         if(this.FDice.CheckCanStart())
         {
            this.FDice.BeginAgain();
            this.UpdateUI();
         }
         else if(this.FDice.Status == WAIT_FOR_WRONG)
         {
            this.UpdateUI();
         }
         else if(this.FDice.Status == NEED_GET_REWARD)
         {
            this.UpdateUI();
         }
      }
   }
}

