package Logics.Exercise.SeventhEvening
{
   import Logics.Inventories.TInventories;
   
   public class TSeventhEveningBallon
   {
      
      protected var FIdentify:int;
      
      protected var FPrice:int;
      
      protected var FInventories:TInventories;
      
      protected var FMagpieMaxCount:int;
      
      protected var FMagpieMinCount:int;
      
      protected var FHeartMaxCount:int;
      
      protected var FHearteMinCount:int;
      
      public function TSeventhEveningBallon()
      {
         super();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get MagpieMaxCount() : int
      {
         return this.FMagpieMaxCount;
      }
      
      public function set MagpieMaxCount(param1:int) : void
      {
         this.FMagpieMaxCount = param1;
      }
      
      public function get MagpieMinCount() : int
      {
         return this.FMagpieMinCount;
      }
      
      public function set MagpieMinCount(param1:int) : void
      {
         this.FMagpieMinCount = param1;
      }
      
      public function get HeartMaxCount() : int
      {
         return this.FHeartMaxCount;
      }
      
      public function set HeartMaxCount(param1:int) : void
      {
         this.FHeartMaxCount = param1;
      }
      
      public function get HearteMinCount() : int
      {
         return this.FHearteMinCount;
      }
      
      public function set HearteMinCount(param1:int) : void
      {
         this.FHearteMinCount = param1;
      }
   }
}

