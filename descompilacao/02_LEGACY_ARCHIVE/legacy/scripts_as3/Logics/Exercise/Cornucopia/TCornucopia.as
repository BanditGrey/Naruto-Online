package Logics.Exercise.Cornucopia
{
   import Logics.Exercise.DecActive.TLotteryLog;
   import Logics.Exercise.DecActive.TLotteryResult;
   import Logics.Exercise.DecActive.TTicketData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TCornucopia extends TBaseActivity
   {
      
      public static const STATUS_BUYING:int = 1;
      
      public static const STATUS_WAITING:int = 2;
      
      public static const STATUS_SENDING:int = 3;
      
      public var PoolGold:int;
      
      public var NextTime:int;
      
      public var GameStatus:int;
      
      public var SelectedCount:int;
      
      public var MaxCount:int;
      
      public var LuckyBox:TBaseBox;
      
      public var GoldList:Vector.<int>;
      
      public var Results:Vector.<TLotteryResult>;
      
      public var Players:Vector.<TLotteryResult>;
      
      public var MyTickets:Vector.<TTicketData>;
      
      public var AllTickets:Vector.<TTicketData>;
      
      public var LotteryLogs:Vector.<TLotteryLog>;
      
      public var CurResults:TLotteryLog;
      
      public var CurCount:int;
      
      public var RechargeGold:int;
      
      public var BoxType:int;
      
      public var BoxPrice:int;
      
      public var BoxCount:int;
      
      public var ShowItems:TInventories;
      
      public function TCornucopia()
      {
         super();
         this.GoldList = new Vector.<int>();
         this.Results = new Vector.<TLotteryResult>();
         this.Players = new Vector.<TLotteryResult>();
         this.MyTickets = new Vector.<TTicketData>();
         this.AllTickets = new Vector.<TTicketData>();
         this.LotteryLogs = new Vector.<TLotteryLog>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function AddTicket(param1:int, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TTicketData = null;
         _loc4_ = int(this.MyTickets.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.MyTickets[_loc3_].Num == param1)
            {
               ++this.MyTickets[_loc3_].Count;
               return;
            }
            _loc3_++;
         }
         _loc5_ = new TTicketData();
         _loc5_.Num = param1;
         _loc5_.Count = param2;
         this.MyTickets.push(_loc5_);
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.CurCount > 0 && this.SelectedCount < this.MaxCount)
         {
            return true;
         }
         return false;
      }
   }
}

