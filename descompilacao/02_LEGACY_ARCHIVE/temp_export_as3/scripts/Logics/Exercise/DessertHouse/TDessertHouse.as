package Logics.Exercise.DessertHouse
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   
   public class TDessertHouse extends TBaseActivity
   {
      
      protected var FLuckyList:Vector.<Object>;
      
      protected var FLastLuckyList:Vector.<Object>;
      
      protected var FLuckyBox:TInventories;
      
      protected var FFoodBox:TBaseBox;
      
      protected var FMyFood:TInventories;
      
      protected var FMakeFoods:Vector.<TBaseBox>;
      
      protected var FServerBox:TBaseBox;
      
      protected var FFoodPrice:Vector.<int>;
      
      protected var FTastyValue:int;
      
      protected var FTaskList:Vector.<TDessertHouseTask>;
      
      protected var FCakeLevel:int;
      
      protected var FCakeExp:int;
      
      protected var FCakeNextExp:int;
      
      protected var FExchangeItems:Vector.<TBaseBox>;
      
      public function TDessertHouse()
      {
         super();
         this.FLuckyList = new Vector.<Object>();
         this.FLastLuckyList = new Vector.<Object>();
         this.FMakeFoods = new Vector.<TBaseBox>();
         this.FFoodPrice = new Vector.<int>();
         this.FTaskList = new Vector.<TDessertHouseTask>();
         this.FExchangeItems = new Vector.<TBaseBox>();
      }
      
      public function get LuckyList() : Vector.<Object>
      {
         return this.FLuckyList;
      }
      
      public function set LuckyList(param1:Vector.<Object>) : void
      {
         this.FLuckyList = param1;
      }
      
      public function get LastLuckyList() : Vector.<Object>
      {
         return this.FLastLuckyList;
      }
      
      public function set LastLuckyList(param1:Vector.<Object>) : void
      {
         this.FLastLuckyList = param1;
      }
      
      public function get LuckyBox() : TInventories
      {
         return this.FLuckyBox;
      }
      
      public function set LuckyBox(param1:TInventories) : void
      {
         this.FLuckyBox = param1;
      }
      
      public function get FoodBox() : TBaseBox
      {
         return this.FFoodBox;
      }
      
      public function set FoodBox(param1:TBaseBox) : void
      {
         this.FFoodBox = param1;
      }
      
      public function get MyFood() : TInventories
      {
         return this.FMyFood;
      }
      
      public function set MyFood(param1:TInventories) : void
      {
         this.FMyFood = param1;
      }
      
      public function get MakeFoods() : Vector.<TBaseBox>
      {
         return this.FMakeFoods;
      }
      
      public function set MakeFoods(param1:Vector.<TBaseBox>) : void
      {
         this.FMakeFoods = param1;
      }
      
      public function get ServerBox() : TBaseBox
      {
         return this.FServerBox;
      }
      
      public function set ServerBox(param1:TBaseBox) : void
      {
         this.FServerBox = param1;
      }
      
      public function get FoodPrice() : Vector.<int>
      {
         return this.FFoodPrice;
      }
      
      public function set FoodPrice(param1:Vector.<int>) : void
      {
         this.FFoodPrice = param1;
      }
      
      public function get TastyValue() : int
      {
         return this.FTastyValue;
      }
      
      public function set TastyValue(param1:int) : void
      {
         this.FTastyValue = param1;
      }
      
      public function get TaskList() : Vector.<TDessertHouseTask>
      {
         return this.FTaskList;
      }
      
      public function set TaskList(param1:Vector.<TDessertHouseTask>) : void
      {
         this.FTaskList = param1;
      }
      
      public function get CakeLevel() : int
      {
         return this.FCakeLevel;
      }
      
      public function set CakeLevel(param1:int) : void
      {
         this.FCakeLevel = param1;
      }
      
      public function get CakeExp() : int
      {
         return this.FCakeExp;
      }
      
      public function set CakeExp(param1:int) : void
      {
         this.FCakeExp = param1;
      }
      
      public function get CakeNextExp() : int
      {
         return this.FCakeNextExp;
      }
      
      public function set CakeNextExp(param1:int) : void
      {
         this.FCakeNextExp = param1;
      }
      
      public function get ExchangeItems() : Vector.<TBaseBox>
      {
         return this.FExchangeItems;
      }
      
      public function set ExchangeItems(param1:Vector.<TBaseBox>) : void
      {
         this.FExchangeItems = param1;
      }
      
      public function ChangeStatus() : void
      {
         if(this.FServerBox.BuyCount >= this.FServerBox.Count && this.FServerBox.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FServerBox.Status = TBaseActivity.STATUS_CANGET;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.FServerBox.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         if(SLogicsCore.ActivityTaskData.NeedShine == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         return false;
      }
      
      public function GetItemByIdentify(param1:int) : TBaseBox
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FExchangeItems.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FExchangeItems[_loc2_].Identify == param1)
            {
               return this.FExchangeItems[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetMaxMakeCount(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc3_ = int(this.FMakeFoods[param1].ExchangeVect.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMakeFoods[param1].ExchangeVect[_loc2_];
            _loc5_ = int(this.FMyFood.GetInventoryByIndex(_loc2_).Quantity);
            _loc6_ = _loc5_ / _loc4_;
            if(_loc2_ == 0)
            {
               _loc7_ = _loc6_;
            }
            else
            {
               _loc7_ = Math.min(_loc7_,_loc6_);
            }
            _loc2_++;
         }
         return _loc7_;
      }
      
      public function CheckTabStatus(param1:int) : Boolean
      {
         switch(param1)
         {
            case 0:
               if(this.FServerBox.Status == TBaseActivity.STATUS_CANGET)
               {
                  return true;
               }
               return false;
               break;
            case 1:
               return false;
            default:
               return false;
         }
      }
   }
}

