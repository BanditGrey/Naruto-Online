package Logics.Exercise.NationalDay_2015
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TNationalDay1_2015 extends TBaseActivity
   {
      
      public static const TYPE_CONSUME:int = 0;
      
      public static const TYPE_RECHARGE:int = 1;
      
      public var LoginDay:int;
      
      public var NeedDay:int;
      
      public var FreeCount:int;
      
      public var DailyGift:TBaseBox;
      
      public var ShowItem:TInventories;
      
      public var Funds:Vector.<TBaseBox>;
      
      public var FundStatus:int;
      
      public var ReturnType:int;
      
      public function TNationalDay1_2015()
      {
         super();
         this.Funds = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

