package Logics.Exercise.Dice
{
   import Logics.Characters.TCharacter;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   
   public class TDice extends TBaseActivity
   {
      
      public static const WIN_COUNT_VEC:Vector.<int> = Vector.<int>([0,100]);
      
      public static const BOX_COUNT:int = 10;
      
      public static const NOT_BEGIN:int = 0;
      
      public static const NEED_GET_REWARD:int = 1;
      
      public static const WAIT_FOR_SELECT:int = 2;
      
      public static const GET_RESULT:int = 3;
      
      public static const WAIT_FOR_WRONG:int = 4;
      
      public static const BEGIN_GAME_AGAIN:int = 5;
      
      public static const CHOICE_NONE:int = -1;
      
      public static const CHOICE_SMALL:int = 0;
      
      public static const CHOICE_BIG:int = 1;
      
      public static const RESULT_NONE:int = -1;
      
      public static const RESULT_WIN:int = 0;
      
      public static const RESULT_LOSE:int = 1;
      
      public static const TYPE_BUY:int = 1;
      
      public static const TYPE_NO_BUY:int = 0;
      
      protected var FWinCount:int;
      
      protected var FFirstNumber:Vector.<int>;
      
      protected var FSecondNumber:Vector.<int>;
      
      protected var FCurResult:int;
      
      protected var FLife:int;
      
      protected var FCanBeWrong:int;
      
      protected var FDiceGold:int;
      
      protected var FWrongGold:int;
      
      protected var FStatus:int;
      
      protected var FIsSelected:Boolean;
      
      protected var FChoiceType:int;
      
      protected var FIsBuy:int;
      
      protected var FLoadLog:Boolean;
      
      protected var FDialogList:Vector.<String>;
      
      protected var FRankList:Vector.<TDiceRank>;
      
      protected var FBoxList:Vector.<TDiceBox>;
      
      protected var FDiceLogList:Vector.<TDiceLog>;
      
      protected var FWinPrice:int;
      
      protected var FAutoDiceLog:Vector.<Object>;
      
      public function TDice()
      {
         super();
         this.FFirstNumber = new Vector.<int>();
         this.FSecondNumber = new Vector.<int>();
         this.FDialogList = new Vector.<String>();
         this.FBoxList = new Vector.<TDiceBox>();
         this.FRankList = new Vector.<TDiceRank>();
         this.FDiceLogList = new Vector.<TDiceLog>();
         this.FAutoDiceLog = new Vector.<Object>();
      }
      
      protected function ProcessorOnWin() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FBoxList.length);
         _loc2_ = this.FBoxList[_loc1_ - 1].NeedWinCount;
         if(this.FWinCount == _loc2_)
         {
            this.FWinCount = 1;
         }
         else
         {
            ++this.FWinCount;
         }
         this.ChangeBoxStatus();
         this.CheckStatus();
      }
      
      protected function ProcessorOnLose() : void
      {
         this.CheckStatus();
      }
      
      public function ChangeBoxStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TDiceBox = null;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(this.FWinCount >= _loc3_.NeedWinCount)
            {
               if(_loc3_.Status != 1)
               {
                  _loc3_.Status = 0;
               }
            }
            else if(_loc3_.Status == 1)
            {
               _loc3_.Status = -1;
            }
            _loc1_++;
         }
      }
      
      protected function IsBoxCanOpen() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get RankList() : Vector.<TDiceRank>
      {
         return this.FRankList;
      }
      
      public function set RankList(param1:Vector.<TDiceRank>) : void
      {
         this.FRankList = param1;
      }
      
      public function get WinCount() : int
      {
         return this.FWinCount;
      }
      
      public function set WinCount(param1:int) : void
      {
         this.FWinCount = param1;
      }
      
      public function get CurResult() : int
      {
         return this.FCurResult;
      }
      
      public function set CurResult(param1:int) : void
      {
         this.FCurResult = param1;
      }
      
      public function get Life() : int
      {
         return this.FLife;
      }
      
      public function set Life(param1:int) : void
      {
         this.FLife = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get IsSelected() : Boolean
      {
         return this.FIsSelected;
      }
      
      public function set IsSelected(param1:Boolean) : void
      {
         this.FIsSelected = param1;
      }
      
      public function get DialogList() : Vector.<String>
      {
         return this.FDialogList;
      }
      
      public function set DialogList(param1:Vector.<String>) : void
      {
         this.FDialogList = param1;
      }
      
      public function get BoxList() : Vector.<TDiceBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TDiceBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get CanBeWrong() : int
      {
         return this.FCanBeWrong;
      }
      
      public function set CanBeWrong(param1:int) : void
      {
         this.FCanBeWrong = param1;
      }
      
      public function get DiceGold() : int
      {
         return this.FDiceGold;
      }
      
      public function set DiceGold(param1:int) : void
      {
         this.FDiceGold = param1;
      }
      
      public function get WrongGold() : int
      {
         return this.FWrongGold;
      }
      
      public function set WrongGold(param1:int) : void
      {
         this.FWrongGold = param1;
      }
      
      public function get FirstNumber() : Vector.<int>
      {
         return this.FFirstNumber;
      }
      
      public function set FirstNumber(param1:Vector.<int>) : void
      {
         this.FFirstNumber = param1;
      }
      
      public function get SecondNumber() : Vector.<int>
      {
         return this.FSecondNumber;
      }
      
      public function set SecondNumber(param1:Vector.<int>) : void
      {
         this.FSecondNumber = param1;
      }
      
      public function get ChoiceType() : int
      {
         return this.FChoiceType;
      }
      
      public function set ChoiceType(param1:int) : void
      {
         this.FChoiceType = param1;
      }
      
      public function get IsBuy() : int
      {
         return this.FIsBuy;
      }
      
      public function set IsBuy(param1:int) : void
      {
         this.FIsBuy = param1;
      }
      
      public function get DiceLogList() : Vector.<TDiceLog>
      {
         return this.FDiceLogList;
      }
      
      public function set DiceLogList(param1:Vector.<TDiceLog>) : void
      {
         this.FDiceLogList = param1;
      }
      
      public function get LoadLog() : Boolean
      {
         return this.FLoadLog;
      }
      
      public function set LoadLog(param1:Boolean) : void
      {
         this.FLoadLog = param1;
      }
      
      public function get WinPrice() : int
      {
         return this.FWinPrice;
      }
      
      public function set WinPrice(param1:int) : void
      {
         this.FWinPrice = param1;
      }
      
      public function get AutoDiceLog() : Vector.<Object>
      {
         return this.FAutoDiceLog;
      }
      
      public function set AutoDiceLog(param1:Vector.<Object>) : void
      {
         this.FAutoDiceLog = param1;
      }
      
      public function GetBarIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = this.FWinCount / WIN_COUNT_VEC[1];
         if(WIN_COUNT_VEC.indexOf(this.FWinCount) != -1 && this.IsBoxCanOpen())
         {
            if(_loc3_ == 0)
            {
               return 0;
            }
            return _loc3_ - 1;
         }
         if(_loc3_ >= WIN_COUNT_VEC.length - 1)
         {
            return _loc3_ - 1;
         }
         return _loc3_;
      }
      
      public function CheckAwardStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function CheckStatus() : void
      {
         if(this.FFirstNumber.length == 0)
         {
            if(WIN_COUNT_VEC.indexOf(this.FWinCount) != -1 && this.IsBoxCanOpen())
            {
               this.FStatus = NEED_GET_REWARD;
            }
            else
            {
               this.FStatus = NOT_BEGIN;
            }
         }
         else if(this.FSecondNumber.length == 0)
         {
            this.FStatus = WAIT_FOR_SELECT;
         }
         else if(this.FCurResult != RESULT_NONE)
         {
            this.FStatus = GET_RESULT;
         }
         this.ChangeBoxStatus();
      }
      
      public function ProcessorOnResult() : void
      {
         if(this.FCurResult == RESULT_WIN)
         {
            this.ProcessorOnWin();
         }
         else
         {
            this.ProcessorOnLose();
         }
      }
      
      public function CheckMoney(param1:int = 0) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:TCharacter = null;
         _loc4_ = SLogicsCore.Character;
         if(param1 == 0)
         {
            if(this.FCanBeWrong > 0)
            {
               _loc3_ = 0;
            }
            else
            {
               _loc3_ = this.FWrongGold;
            }
         }
         else if(this.FLife > 0)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = this.FDiceGold;
         }
         if(_loc4_.CreditGiftCertificate + _loc4_.CreditGold >= _loc3_)
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function CheckCanStart() : Boolean
      {
         var _loc1_:Boolean = false;
         if(WIN_COUNT_VEC.indexOf(this.FWinCount) != -1 && this.IsBoxCanOpen())
         {
            this.FStatus = NEED_GET_REWARD;
            return false;
         }
         if(this.CurResult == RESULT_WIN)
         {
            _loc1_ = true;
         }
         else if(this.CurResult == RESULT_NONE)
         {
            _loc1_ = true;
         }
         else if(this.CurResult == RESULT_LOSE)
         {
            this.Status = WAIT_FOR_WRONG;
         }
         else
         {
            this.Status = NEED_GET_REWARD;
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function BeginAgain() : void
      {
         if(this.CurResult == RESULT_WIN)
         {
            this.Status = BEGIN_GAME_AGAIN;
         }
         else
         {
            this.Status = NOT_BEGIN;
         }
         this.ResetData();
      }
      
      public function ResetData() : void
      {
         this.FirstNumber.length = 0;
         this.FSecondNumber.length = 0;
         this.FCurResult = RESULT_NONE;
         this.FChoiceType = CHOICE_NONE;
      }
      
      public function GetBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TDiceBox = null;
         var _loc4_:String = null;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc3_.Status == 0)
            {
               if(this.FWinCount >= _loc3_.NeedWinCount)
               {
                  _loc3_.Status = 1;
               }
               else
               {
                  _loc3_.Status = -1;
               }
            }
            _loc1_++;
         }
      }
   }
}

