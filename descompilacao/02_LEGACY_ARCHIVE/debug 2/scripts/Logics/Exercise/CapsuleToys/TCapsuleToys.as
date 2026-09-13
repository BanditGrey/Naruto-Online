package Logics.Exercise.CapsuleToys
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TCapsuleToys extends TBaseActivity
   {
      
      public static const TYPE_NULL:int = 5;
      
      public static const TYPE_BADGE:int = 4;
      
      public static const TYPE_SOCK_NULL:int = 2;
      
      public static const TYPE_IS_CONTINUE:int = 0;
      
      public static const TYPE_IS_WIN:int = 1;
      
      public static const TYPE_IS_LOSE:int = 2;
      
      public var FreshTime:int;
      
      public var FreshCost:int;
      
      public var FreeCount:int;
      
      public var AutoPlayPrice:int;
      
      public var PlayPrice:int;
      
      public var EggList:Vector.<int>;
      
      public var AllItems:TInventories;
      
      public var SaleItems:Vector.<TBaseBox>;
      
      public var ShowItems:TInventories;
      
      public var BadgeCost:int;
      
      public var BadgeCount:int;
      
      public var ShearIndex:int;
      
      public var LastShear:int;
      
      public var BarList:Vector.<TBaseBox>;
      
      public var SockList:Vector.<int>;
      
      public var CurSock:int;
      
      public var IndexList:Vector.<int>;
      
      public var AmountList:Vector.<int>;
      
      public var IsEnd:int;
      
      public var Amount:int;
      
      public function TCapsuleToys()
      {
         super();
         this.EggList = new Vector.<int>();
         this.SaleItems = new Vector.<TBaseBox>();
         this.BarList = new Vector.<TBaseBox>();
         this.SockList = new Vector.<int>();
         this.IndexList = new Vector.<int>();
         this.AmountList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(ConsumeGift.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(ConsumeGift[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && TotalConsumeGold >= ConsumeGift[_loc1_].Price)
            {
               ConsumeGift[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FreeCount > 0)
         {
            return true;
         }
         _loc2_ = int(ConsumeGift.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(ConsumeGift[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get CurBoxIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(ConsumeGift.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(ConsumeGift[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(ConsumeGift[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_ - 1;
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

