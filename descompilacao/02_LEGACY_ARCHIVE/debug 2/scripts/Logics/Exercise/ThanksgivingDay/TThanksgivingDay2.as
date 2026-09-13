package Logics.Exercise.ThanksgivingDay
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   
   public class TThanksgivingDay2 extends TBaseActivity
   {
      
      public static const BUY_COUNT:int = 3;
      
      public static const SEEK_COUNT:int = 30;
      
      public static const GAME_STATUS_NORMAL:int = 0;
      
      public static const GAME_STATUS_END:int = 1;
      
      protected var FMsgTreasure:Vector.<TMsgTreasure>;
      
      protected var FBuyTreasureMapBoxList:Vector.<TBaseBox>;
      
      protected var FTreasureMapBoxList:Vector.<TBaseBox>;
      
      protected var FSeekTreasureMapBoxList:Vector.<TMsgGraph>;
      
      protected var FFreeTreasureMap:int;
      
      protected var FTreasureMapCount:Vector.<int>;
      
      protected var FSeekTreasureCount:int;
      
      protected var FSeekTreasureStatue:int;
      
      protected var FRefreshBuyTime:int;
      
      protected var FRefreshPrize:int;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public var FreeTimes:int;
      
      public function TThanksgivingDay2()
      {
         var _loc1_:int = 0;
         super();
         this.FBuyTreasureMapBoxList = new Vector.<TBaseBox>(BUY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < BUY_COUNT)
         {
            this.FBuyTreasureMapBoxList[_loc1_] = new TBaseBox();
            this.FBuyTreasureMapBoxList[_loc1_].Inventories = new TInventories();
            _loc1_++;
         }
         this.FMsgTreasure = new Vector.<TMsgTreasure>(BUY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < BUY_COUNT)
         {
            this.FMsgTreasure[_loc1_] = new TMsgTreasure();
            _loc1_++;
         }
         this.FSeekTreasureMapBoxList = new Vector.<TMsgGraph>(BUY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < BUY_COUNT)
         {
            this.FSeekTreasureMapBoxList[_loc1_] = new TMsgGraph();
            _loc1_++;
         }
         this.FTreasureMapBoxList = new Vector.<TBaseBox>(SEEK_COUNT);
         _loc1_ = 0;
         while(_loc1_ < SEEK_COUNT)
         {
            this.FTreasureMapBoxList[_loc1_] = new TBaseBox();
            _loc1_++;
         }
         this.FTreasureMapCount = new Vector.<int>(BUY_COUNT);
      }
      
      public function get SeekTreasureStatue() : int
      {
         return this.FSeekTreasureStatue;
      }
      
      public function set SeekTreasureStatue(param1:int) : void
      {
         this.FSeekTreasureStatue = param1;
      }
      
      public function get TreasureMapBoxList() : Vector.<TBaseBox>
      {
         return this.FTreasureMapBoxList;
      }
      
      public function set TreasureMapBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FTreasureMapBoxList = param1;
      }
      
      public function get MsgTreasure() : Vector.<TMsgTreasure>
      {
         return this.FMsgTreasure;
      }
      
      public function set MsgTreasure(param1:Vector.<TMsgTreasure>) : void
      {
         this.FMsgTreasure = param1;
      }
      
      public function get RefreshPrize() : int
      {
         return this.FRefreshPrize;
      }
      
      public function set RefreshPrize(param1:int) : void
      {
         this.FRefreshPrize = param1;
      }
      
      public function get RefreshBuyTime() : int
      {
         return this.FRefreshBuyTime;
      }
      
      public function set RefreshBuyTime(param1:int) : void
      {
         this.FRefreshBuyTime = param1;
      }
      
      public function get SeekTreasureCount() : int
      {
         return this.FSeekTreasureCount;
      }
      
      public function set SeekTreasureCount(param1:int) : void
      {
         this.FSeekTreasureCount = param1;
      }
      
      public function get TreasureMapCount() : Vector.<int>
      {
         return this.FTreasureMapCount;
      }
      
      public function set TreasureMapCount(param1:Vector.<int>) : void
      {
         this.FTreasureMapCount = param1;
      }
      
      public function get SeekTreasureMapBoxList() : Vector.<TMsgGraph>
      {
         return this.FSeekTreasureMapBoxList;
      }
      
      public function set SeekTreasureMapBoxList(param1:Vector.<TMsgGraph>) : void
      {
         this.FSeekTreasureMapBoxList = param1;
      }
      
      public function get FreeTreasureMap() : int
      {
         return this.FFreeTreasureMap;
      }
      
      public function set FreeTreasureMap(param1:int) : void
      {
         this.FFreeTreasureMap = param1;
      }
      
      public function get BuyTreasureMapBoxList() : Vector.<TBaseBox>
      {
         return this.FBuyTreasureMapBoxList;
      }
      
      public function set BuyTreasureMapBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBuyTreasureMapBoxList = param1;
      }
   }
}

