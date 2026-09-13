package Logics.Exercise.Christmas2015
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TChristmas3_2015 extends TBaseActivity
   {
      
      public static const TYPE_NULL:int = 5;
      
      public static const TYPE_BADGE:int = 4;
      
      public static const TYPE_SOCK_NULL:int = 2;
      
      public static const TYPE_IS_CONTINUE:int = 0;
      
      public static const TYPE_IS_WIN:int = 1;
      
      public static const TYPE_IS_LOSE:int = 2;
      
      public var BookList:Vector.<int>;
      
      public var BadgeCount:int;
      
      public var BadgeCost:int;
      
      public var FreeCount:int;
      
      public var Price:int;
      
      public var AutoPrice:int;
      
      public var MaxCount:int;
      
      public var LimitCount:int;
      
      public var Gain:int;
      
      public var IceList:Vector.<int>;
      
      public var ShearIndex:int;
      
      public var LastShear:int;
      
      public var BarList:Vector.<TBaseBox>;
      
      public var SockList:Vector.<int>;
      
      public var CurSock:int;
      
      public var ShowItem:TInventories;
      
      public var RechargeBox:Vector.<TBaseBox>;
      
      public var IndexList:Vector.<int>;
      
      public var AmountList:Vector.<int>;
      
      public var IsEnd:int;
      
      public var Amount:int;
      
      public function TChristmas3_2015()
      {
         super();
         this.BookList = new Vector.<int>();
         this.IceList = new Vector.<int>();
         this.BarList = new Vector.<TBaseBox>();
         this.SockList = new Vector.<int>();
         this.RechargeBox = new Vector.<TBaseBox>();
         this.IndexList = new Vector.<int>();
         this.AmountList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.RechargeBox.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeBox[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && TotalRechargeGold >= this.RechargeBox[_loc1_].Price)
            {
               this.RechargeBox[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function get CurBoxIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.RechargeBox.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeBox[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeBox[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
      }
      
      public function get IsBegin() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.IceList.length)
         {
            if(this.IceList[_loc1_] != 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.IceList.length)
         {
            this.IceList[_loc1_] = 0;
            _loc1_++;
         }
         this.LimitCount = this.MaxCount;
         this.Gain = 0;
      }
      
      public function ResetGame() : void
      {
         var _loc1_:int = 0;
         this.IsEnd = TYPE_IS_CONTINUE;
         this.Amount = 0;
         this.CurSock = 0;
         this.LastShear = 0;
         this.ShearIndex = 0;
         _loc1_ = 0;
         while(_loc1_ < this.SockList.length)
         {
            this.SockList[_loc1_] = 0;
            _loc1_++;
         }
      }
   }
}

