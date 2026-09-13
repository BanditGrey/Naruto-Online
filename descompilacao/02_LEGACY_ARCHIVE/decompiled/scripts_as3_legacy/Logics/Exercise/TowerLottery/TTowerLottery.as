package Logics.Exercise.TowerLottery
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   
   public class TTowerLottery extends TBaseActivity
   {
      
      public static const MAX_COUNT:int = 53;
      
      public static const GAME_STATUS_NORMAL:int = 0;
      
      public static const GAME_STATUS_END:int = 1;
      
      public static const START_MOVE_BOX_INDEX:Vector.<int> = Vector.<int>([0,10,19,27,34,40,45,49,52]);
      
      protected var FCurLayer:int;
      
      protected var FMaxLayer:int;
      
      protected var FMaxCol:int;
      
      protected var FGameStatus:int;
      
      protected var FLotteryPrice:Vector.<int>;
      
      protected var FLotteryInventories:TInventories;
      
      protected var FLotteryStatus:Vector.<int>;
      
      public var PetID:int;
      
      public function TTowerLottery()
      {
         super();
         this.FLotteryPrice = new Vector.<int>();
         this.FLotteryInventories = new TInventories();
         this.FLotteryStatus = new Vector.<int>();
      }
      
      public function get CurLayer() : int
      {
         return this.FCurLayer;
      }
      
      public function set CurLayer(param1:int) : void
      {
         this.FCurLayer = param1;
      }
      
      public function get LotteryInventories() : TInventories
      {
         return this.FLotteryInventories;
      }
      
      public function set LotteryInventories(param1:TInventories) : void
      {
         this.FLotteryInventories = param1;
      }
      
      public function get LotteryStatus() : Vector.<int>
      {
         return this.FLotteryStatus;
      }
      
      public function set LotteryStatus(param1:Vector.<int>) : void
      {
         this.FLotteryStatus = param1;
      }
      
      public function get MaxLayer() : int
      {
         return this.FMaxLayer;
      }
      
      public function set MaxLayer(param1:int) : void
      {
         this.FMaxLayer = param1;
      }
      
      public function get MaxCol() : int
      {
         return this.FMaxCol;
      }
      
      public function set MaxCol(param1:int) : void
      {
         this.FMaxCol = param1;
      }
      
      public function get GameStatus() : int
      {
         return this.FGameStatus;
      }
      
      public function set GameStatus(param1:int) : void
      {
         this.FGameStatus = param1;
      }
      
      public function get LotteryPrice() : Vector.<int>
      {
         return this.FLotteryPrice;
      }
      
      public function set LotteryPrice(param1:Vector.<int>) : void
      {
         this.FLotteryPrice = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(FRewardStatus.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(FRewardStatus[_loc1_] == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function SetLotteryStatusByCurIndex(param1:int, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         _loc3_ = this.GetTotalIndexByCurIndex(param1);
         this.FLotteryStatus[_loc3_] = param2;
      }
      
      public function GetTotalIndexByCurIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         return int(START_MOVE_BOX_INDEX[this.FCurLayer - 1] + param1 - 1);
      }
   }
}

