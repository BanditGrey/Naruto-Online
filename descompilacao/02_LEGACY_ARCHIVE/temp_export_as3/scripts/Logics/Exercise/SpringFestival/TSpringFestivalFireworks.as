package Logics.Exercise.SpringFestival
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TSpringFestivalFireworks extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FFishList:Vector.<TBaseBox>;
      
      protected var FTotalDays:int;
      
      protected var FContiueDays:int;
      
      protected var FFireworkCost:int;
      
      protected var FFireworkDays:int;
      
      protected var FFireworkStatus:int;
      
      public function TSpringFestivalFireworks()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FFishList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get FishList() : Vector.<TBaseBox>
      {
         return this.FFishList;
      }
      
      public function set FishList(param1:Vector.<TBaseBox>) : void
      {
         this.FFishList = param1;
      }
      
      public function get TotalDays() : int
      {
         return this.FTotalDays;
      }
      
      public function set TotalDays(param1:int) : void
      {
         this.FTotalDays = param1;
      }
      
      public function get ContiueDays() : int
      {
         return this.FContiueDays;
      }
      
      public function set ContiueDays(param1:int) : void
      {
         this.FContiueDays = param1;
      }
      
      public function get FireworkCost() : int
      {
         return this.FFireworkCost;
      }
      
      public function set FireworkCost(param1:int) : void
      {
         this.FFireworkCost = param1;
      }
      
      public function get FireworkDays() : int
      {
         return this.FFireworkDays;
      }
      
      public function set FireworkDays(param1:int) : void
      {
         this.FFireworkDays = param1;
      }
      
      public function get FireworkStatus() : int
      {
         return this.FFireworkStatus;
      }
      
      public function set FireworkStatus(param1:int) : void
      {
         this.FFireworkStatus = param1;
      }
   }
}

