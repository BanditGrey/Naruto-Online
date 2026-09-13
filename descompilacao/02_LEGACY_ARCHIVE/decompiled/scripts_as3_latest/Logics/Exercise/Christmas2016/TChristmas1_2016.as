package Logics.Exercise.Christmas2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TChristmas1_2016 extends TBaseActivity
   {
      
      public var DayList:Vector.<TBaseBox>;
      
      public var CurDay:int;
      
      public var CurStatus:int;
      
      public var BuySignDay:int;
      
      public var TotalSign:int;
      
      public var SignCost:int;
      
      public var GiftList:Vector.<TBaseBox>;
      
      public var TotalSignGift:TBaseBox;
      
      public function TChristmas1_2016()
      {
         super();
         this.DayList = new Vector.<TBaseBox>();
         this.GiftList = new Vector.<TBaseBox>();
         this.TotalSignGift = new TBaseBox();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
      }
   }
}

