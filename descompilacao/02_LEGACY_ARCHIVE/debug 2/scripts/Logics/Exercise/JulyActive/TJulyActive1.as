package Logics.Exercise.JulyActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TJulyActive1 extends TBaseActivity
   {
      
      protected var FDailyStatus:int;
      
      protected var FCountA:int;
      
      protected var FCountB:int;
      
      protected var FConsumeCountA:int;
      
      protected var FConsumeCountB:int;
      
      protected var FPriceA:int;
      
      protected var FPriceB:int;
      
      protected var FScore:int;
      
      protected var FHoleStatus:int;
      
      protected var FTotalCount:int;
      
      protected var FSaleBox:TBaseBox;
      
      protected var FDailyItems:TInventories;
      
      protected var FEquipItems:TInventories;
      
      protected var FBuyCountAwards:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TJulyActive1()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FBuyCountAwards = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get DailyStatus() : int
      {
         return this.FDailyStatus;
      }
      
      public function set DailyStatus(param1:int) : void
      {
         this.FDailyStatus = param1;
      }
      
      public function get DailyItems() : TInventories
      {
         return this.FDailyItems;
      }
      
      public function set DailyItems(param1:TInventories) : void
      {
         this.FDailyItems = param1;
      }
      
      public function get SaleBox() : TBaseBox
      {
         return this.FSaleBox;
      }
      
      public function set SaleBox(param1:TBaseBox) : void
      {
         this.FSaleBox = param1;
      }
      
      public function get BuyCountAwards() : Vector.<TBaseBox>
      {
         return this.FBuyCountAwards;
      }
      
      public function set BuyCountAwards(param1:Vector.<TBaseBox>) : void
      {
         this.FBuyCountAwards = param1;
      }
      
      public function get CountA() : int
      {
         return this.FCountA;
      }
      
      public function set CountA(param1:int) : void
      {
         this.FCountA = param1;
      }
      
      public function get CountB() : int
      {
         return this.FCountB;
      }
      
      public function set CountB(param1:int) : void
      {
         this.FCountB = param1;
      }
      
      public function get ConsumeCountA() : int
      {
         return this.FConsumeCountA;
      }
      
      public function set ConsumeCountA(param1:int) : void
      {
         this.FConsumeCountA = param1;
      }
      
      public function get ConsumeCountB() : int
      {
         return this.FConsumeCountB;
      }
      
      public function set ConsumeCountB(param1:int) : void
      {
         this.FConsumeCountB = param1;
      }
      
      public function get PriceA() : int
      {
         return this.FPriceA;
      }
      
      public function set PriceA(param1:int) : void
      {
         this.FPriceA = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get EquipItems() : TInventories
      {
         return this.FEquipItems;
      }
      
      public function set EquipItems(param1:TInventories) : void
      {
         this.FEquipItems = param1;
      }
      
      public function get PriceB() : int
      {
         return this.FPriceB;
      }
      
      public function set PriceB(param1:int) : void
      {
         this.FPriceB = param1;
      }
      
      public function get HoleStatus() : int
      {
         return this.FHoleStatus;
      }
      
      public function set HoleStatus(param1:int) : void
      {
         this.FHoleStatus = param1;
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
   }
}

