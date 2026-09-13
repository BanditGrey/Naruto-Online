package Logics.Exercise.Christmas2015
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TChristmas2_2015 extends TBaseActivity
   {
      
      public static const TYPE_COIN:int = 1;
      
      public static const TYPE_GOLD:int = 2;
      
      public var WaterList:Vector.<TBaseBox>;
      
      public var Max:int;
      
      public var Min:int;
      
      public var GiftCount:Vector.<int>;
      
      public var TreeLevel:int;
      
      public var TreeExp:int;
      
      public var TreeExpMax:int;
      
      public var IsEnd:int;
      
      public var GiftList:Vector.<int>;
      
      public var ItemList:Vector.<TBaseBox>;
      
      public var TitleList:Vector.<TBaseBox>;
      
      public function TChristmas2_2015()
      {
         super();
         this.WaterList = new Vector.<TBaseBox>();
         this.GiftCount = new Vector.<int>();
         this.GiftList = new Vector.<int>();
         this.ItemList = new Vector.<TBaseBox>();
         this.TitleList = new Vector.<TBaseBox>();
      }
      
      public function get NextTime() : int
      {
         return this.WaterList[0].Time;
      }
      
      public function set NextTime(param1:int) : void
      {
         this.WaterList[0].Time = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.TitleList.length)
         {
            if(this.TitleList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.TreeLevel >= this.TitleList[_loc1_].Level)
            {
               this.TitleList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

