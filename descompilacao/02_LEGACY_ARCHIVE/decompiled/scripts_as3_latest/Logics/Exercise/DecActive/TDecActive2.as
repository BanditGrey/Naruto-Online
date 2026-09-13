package Logics.Exercise.DecActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TDecActive2 extends TBaseActivity
   {
      
      public static const STATUS_BUYING:int = 1;
      
      public static const STATUS_WAITING:int = 2;
      
      public static const STATUS_SENDING:int = 3;
      
      protected var FPrice:int;
      
      protected var FPoolGold:int;
      
      protected var FNextTime:int;
      
      protected var FGameStatus:int;
      
      protected var FSelectedCount:int;
      
      protected var FMaxCount:int;
      
      protected var FLuckyBox:TBaseBox;
      
      protected var FGoldList:Vector.<int>;
      
      protected var FResults:Vector.<TLotteryResult>;
      
      protected var FPlayers:Vector.<TLotteryResult>;
      
      protected var FMyTickets:Vector.<TTicketData>;
      
      protected var FAllTickets:Vector.<TTicketData>;
      
      protected var FLotteryLogs:Vector.<TLotteryLog>;
      
      protected var FCurResults:TLotteryLog;
      
      protected var FTreeLevel:int;
      
      protected var FRechargeGold:int;
      
      protected var FBarGold:int;
      
      protected var FTreeItems:Vector.<TBaseBox>;
      
      protected var FTreeShowItems:TInventories;
      
      protected var FNeedGolds:Vector.<int>;
      
      public function TDecActive2()
      {
         super();
         this.FGoldList = new Vector.<int>();
         this.FResults = new Vector.<TLotteryResult>();
         this.FPlayers = new Vector.<TLotteryResult>();
         this.FMyTickets = new Vector.<TTicketData>();
         this.FAllTickets = new Vector.<TTicketData>();
         this.FLotteryLogs = new Vector.<TLotteryLog>();
         this.FTreeItems = new Vector.<TBaseBox>();
         this.FNeedGolds = new Vector.<int>();
      }
      
      public function get PoolGold() : int
      {
         return this.FPoolGold;
      }
      
      public function set PoolGold(param1:int) : void
      {
         this.FPoolGold = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get SelectedCount() : int
      {
         return this.FSelectedCount;
      }
      
      public function set SelectedCount(param1:int) : void
      {
         this.FSelectedCount = param1;
      }
      
      public function get MaxCount() : int
      {
         return this.FMaxCount;
      }
      
      public function set MaxCount(param1:int) : void
      {
         this.FMaxCount = param1;
      }
      
      public function get LuckyBox() : TBaseBox
      {
         return this.FLuckyBox;
      }
      
      public function set LuckyBox(param1:TBaseBox) : void
      {
         this.FLuckyBox = param1;
      }
      
      public function get GoldList() : Vector.<int>
      {
         return this.FGoldList;
      }
      
      public function set GoldList(param1:Vector.<int>) : void
      {
         this.FGoldList = param1;
      }
      
      public function get TreeLevel() : int
      {
         return this.FTreeLevel;
      }
      
      public function set TreeLevel(param1:int) : void
      {
         this.FTreeLevel = param1;
      }
      
      public function get TreeItems() : Vector.<TBaseBox>
      {
         return this.FTreeItems;
      }
      
      public function set TreeItems(param1:Vector.<TBaseBox>) : void
      {
         this.FTreeItems = param1;
      }
      
      public function get TreeShowItems() : TInventories
      {
         return this.FTreeShowItems;
      }
      
      public function set TreeShowItems(param1:TInventories) : void
      {
         this.FTreeShowItems = param1;
      }
      
      public function get NextTime() : int
      {
         return this.FNextTime;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.FNextTime = param1;
      }
      
      public function get Results() : Vector.<TLotteryResult>
      {
         return this.FResults;
      }
      
      public function set Results(param1:Vector.<TLotteryResult>) : void
      {
         this.FResults = param1;
      }
      
      public function get Players() : Vector.<TLotteryResult>
      {
         return this.FPlayers;
      }
      
      public function set Players(param1:Vector.<TLotteryResult>) : void
      {
         this.FPlayers = param1;
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get MyTickets() : Vector.<TTicketData>
      {
         return this.FMyTickets;
      }
      
      public function set MyTickets(param1:Vector.<TTicketData>) : void
      {
         this.FMyTickets = param1;
      }
      
      public function get AllTickets() : Vector.<TTicketData>
      {
         return this.FAllTickets;
      }
      
      public function set AllTickets(param1:Vector.<TTicketData>) : void
      {
         this.FAllTickets = param1;
      }
      
      public function get LotteryLogs() : Vector.<TLotteryLog>
      {
         return this.FLotteryLogs;
      }
      
      public function set LotteryLogs(param1:Vector.<TLotteryLog>) : void
      {
         this.FLotteryLogs = param1;
      }
      
      public function get CurResults() : TLotteryLog
      {
         return this.FCurResults;
      }
      
      public function set CurResults(param1:TLotteryLog) : void
      {
         this.FCurResults = param1;
      }
      
      public function get NeedGolds() : Vector.<int>
      {
         return this.FNeedGolds;
      }
      
      public function set NeedGolds(param1:Vector.<int>) : void
      {
         this.FNeedGolds = param1;
      }
      
      public function get BarGold() : int
      {
         return this.FBarGold;
      }
      
      public function set BarGold(param1:int) : void
      {
         this.FBarGold = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function AddTicket(param1:int, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TTicketData = null;
         _loc4_ = int(this.FMyTickets.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FMyTickets[_loc3_].Num == param1)
            {
               ++this.FMyTickets[_loc3_].Count;
               return;
            }
            _loc3_++;
         }
         _loc5_ = new TTicketData();
         _loc5_.Num = param1;
         _loc5_.Count = param2;
         this.FMyTickets.push(_loc5_);
      }
   }
}

