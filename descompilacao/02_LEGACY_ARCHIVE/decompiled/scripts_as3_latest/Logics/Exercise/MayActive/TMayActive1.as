package Logics.Exercise.MayActive
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TMayActive1 extends TBaseActivity
   {
      
      public static const MAX_COUNT:int = 50;
      
      public static const GAME_STATUS_NORMAL:int = 0;
      
      public static const GAME_STATUS_END:int = 1;
      
      protected var FGameStatus:int;
      
      protected var FSignStatus:int;
      
      protected var FCurIndex:int;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FRewardBoxList:Vector.<TBaseBox>;
      
      protected var FNeedMoney:int;
      
      protected var FGetEvyDay:String;
      
      protected var FContinueDays:int;
      
      protected var FSendMailHour:int;
      
      protected var FGetMoney:int;
      
      protected var FCanReturn:int;
      
      public function TMayActive1()
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super();
         this.FBoxList = new Vector.<TBaseBox>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FBoxList[_loc1_] = new TBaseBox();
            this.FBoxList[_loc1_].Inventories = new TInventories();
            _loc1_++;
         }
         this.FRewardBoxList = new Vector.<TBaseBox>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FRewardBoxList[_loc1_] = new TBaseBox();
            this.FRewardBoxList[_loc1_].Inventories = new TInventories();
            _loc1_++;
         }
      }
      
      public function get CanReturn() : int
      {
         return this.FCanReturn;
      }
      
      public function set CanReturn(param1:int) : void
      {
         this.FCanReturn = param1;
      }
      
      public function get RewardBoxList() : Vector.<TBaseBox>
      {
         return this.FRewardBoxList;
      }
      
      public function set RewardBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FRewardBoxList = param1;
      }
      
      public function get GetMoney() : int
      {
         return this.FGetMoney;
      }
      
      public function set GetMoney(param1:int) : void
      {
         this.FGetMoney = param1;
      }
      
      public function get SendMailHour() : int
      {
         return this.FSendMailHour;
      }
      
      public function set SendMailHour(param1:int) : void
      {
         this.FSendMailHour = param1;
      }
      
      public function get ContinueDays() : int
      {
         return this.FContinueDays;
      }
      
      public function set ContinueDays(param1:int) : void
      {
         this.FContinueDays = param1;
      }
      
      public function get GetEvyDay() : String
      {
         return this.FGetEvyDay;
      }
      
      public function set GetEvyDay(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FGetEvyDay = _loc3_;
            }
         }
         else
         {
            this.FGetEvyDay = param1;
         }
      }
      
      public function get NeedMoney() : int
      {
         return this.FNeedMoney;
      }
      
      public function set NeedMoney(param1:int) : void
      {
         this.FNeedMoney = param1;
      }
      
      public function get SignStatus() : int
      {
         return this.FSignStatus;
      }
      
      public function set SignStatus(param1:int) : void
      {
         this.FSignStatus = param1;
      }
      
      public function get CurIndex() : int
      {
         return this.FCurIndex;
      }
      
      public function set CurIndex(param1:int) : void
      {
         this.FCurIndex = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function GetNextBoxIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FCurIndex == this.FBoxList.length - 1)
         {
            return this.FCurIndex;
         }
         _loc3_ = int(this.FBoxList.length);
         _loc2_ = this.FCurIndex + 1;
         while(_loc2_ < _loc3_)
         {
            if(this.FBoxList[_loc2_] != null && this.FBoxList[_loc2_].Type == 2)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function GetResidue() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.FCurIndex;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_] != null && this.FBoxList[_loc1_].Status == 0)
            {
               _loc3_++;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function GetSignedNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_] != null && this.FBoxList[_loc1_].Status == 1)
            {
               _loc3_++;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function GetResidueBaseBox() : TBaseBox
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.FCurIndex;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_] != null && this.FBoxList[_loc1_].Status == 0)
            {
               return this.FBoxList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function ChangeSignStatus() : void
      {
         this.SignStatus = this.BoxList[this.CurIndex].Status;
      }
   }
}

