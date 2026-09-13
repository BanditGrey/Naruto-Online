package Logics.Exercise.NovActive
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   
   public class TNovActive1 extends TBaseActivity
   {
      
      protected var FMyScore:int;
      
      protected var FTotalCount:int;
      
      protected var FItemIDA:uint;
      
      protected var FItemIDB:uint;
      
      protected var FCostNum:int;
      
      protected var FItemPrice:int;
      
      protected var FTenNum:int;
      
      protected var FResult:Vector.<int>;
      
      protected var FResultScore:int;
      
      protected var FServerList:TBaseBox;
      
      protected var FShowItems:TInventories;
      
      public function TNovActive1()
      {
         super();
         this.FResult = new Vector.<int>();
      }
      
      public function get ItemIDA() : uint
      {
         return this.FItemIDA;
      }
      
      public function set ItemIDA(param1:uint) : void
      {
         this.FItemIDA = param1;
      }
      
      public function get ItemIDB() : uint
      {
         return this.FItemIDB;
      }
      
      public function set ItemIDB(param1:uint) : void
      {
         this.FItemIDB = param1;
      }
      
      public function get MyScore() : int
      {
         return this.FMyScore;
      }
      
      public function set MyScore(param1:int) : void
      {
         this.FMyScore = param1;
      }
      
      public function get ServerList() : TBaseBox
      {
         return this.FServerList;
      }
      
      public function set ServerList(param1:TBaseBox) : void
      {
         this.FServerList = param1;
      }
      
      public function get ShowItems() : TInventories
      {
         return this.FShowItems;
      }
      
      public function set ShowItems(param1:TInventories) : void
      {
         this.FShowItems = param1;
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
      
      public function get CostNum() : int
      {
         return this.FCostNum;
      }
      
      public function set CostNum(param1:int) : void
      {
         this.FCostNum = param1;
      }
      
      public function get ItemPrice() : int
      {
         return this.FItemPrice;
      }
      
      public function set ItemPrice(param1:int) : void
      {
         this.FItemPrice = param1;
      }
      
      public function get Result() : Vector.<int>
      {
         return this.FResult;
      }
      
      public function set Result(param1:Vector.<int>) : void
      {
         this.FResult = param1;
      }
      
      public function get ResultScore() : int
      {
         return this.FResultScore;
      }
      
      public function set ResultScore(param1:int) : void
      {
         this.FResultScore = param1;
      }
      
      public function get TenNum() : int
      {
         return this.FTenNum;
      }
      
      public function set TenNum(param1:int) : void
      {
         this.FTenNum = param1;
      }
      
      public function get TaskStatus() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityTaskData = null;
         _loc3_ = SLogicsCore.ActivityTaskData;
         _loc2_ = int(_loc3_.TaskList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.TaskList[_loc1_].Step != TBaseActivity.STATUS_CANNOTGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TActivityTaskData = null;
         _loc4_ = SLogicsCore.ActivityTaskData;
         _loc1_ = 0;
         while(_loc1_ < FShopRewardItems.length)
         {
            if(FShopRewardItems[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && FShopExchangePoint >= FShopRewardItems[_loc1_].Price)
            {
               FShopRewardItems[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

