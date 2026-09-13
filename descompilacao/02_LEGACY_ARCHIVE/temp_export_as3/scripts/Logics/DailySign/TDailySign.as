package Logics.DailySign
{
   import Logics.DatebaseVO.TSignReward_Circle;
   import Logics.DatebaseVO.VO.TSignReward;
   import Logics.Inventories.TInventorySamples;
   
   public class TDailySign
   {
      
      protected var FCurrentMonth:uint;
      
      protected var FDayList:Vector.<String>;
      
      protected var FRewardID:uint;
      
      protected var FSignTotalDays:uint;
      
      protected var FServerStartDate:uint;
      
      protected var FSignReward:TSignReward;
      
      protected var FSignReward_Circle:TSignReward_Circle;
      
      protected var FExchangeReward:TInventorySamples;
      
      protected var FCircleRewardID:uint;
      
      protected var FCircleSignTotalDays:uint;
      
      protected var FIsCanGetReward:uint;
      
      protected var FSignTotalDaysCopy:uint;
      
      protected var FTempValue:Boolean;
      
      public function TDailySign()
      {
         super();
         this.FDayList = new Vector.<String>();
      }
      
      public function get CurrentMonth() : uint
      {
         return this.FCurrentMonth;
      }
      
      public function set CurrentMonth(param1:uint) : void
      {
         this.FCurrentMonth = param1;
      }
      
      public function get DayList() : Vector.<String>
      {
         return this.FDayList;
      }
      
      public function set DayList(param1:Vector.<String>) : void
      {
         this.FDayList = param1;
      }
      
      public function get SignTotalDays() : int
      {
         return this.FSignTotalDays;
      }
      
      public function set SignTotalDays(param1:int) : void
      {
         this.FSignTotalDays = param1;
      }
      
      public function get SignTotalDaysCopy() : int
      {
         return this.FSignTotalDaysCopy;
      }
      
      public function set SignTotalDaysCopy(param1:int) : void
      {
         this.FSignTotalDaysCopy = param1;
      }
      
      public function get ServerStartDate() : uint
      {
         return this.FServerStartDate;
      }
      
      public function set ServerStartDate(param1:uint) : void
      {
         this.FServerStartDate = param1;
      }
      
      public function get ExchangeReward() : TInventorySamples
      {
         return this.FExchangeReward;
      }
      
      public function set ExchangeReward(param1:TInventorySamples) : void
      {
         this.FExchangeReward = param1;
      }
      
      public function get SignReward() : TSignReward
      {
         return this.FSignReward;
      }
      
      public function set SignReward(param1:TSignReward) : void
      {
         this.FSignReward = param1;
      }
      
      public function get SignReward_Circle() : TSignReward_Circle
      {
         return this.FSignReward_Circle;
      }
      
      public function set SignReward_Circle(param1:TSignReward_Circle) : void
      {
         this.FSignReward_Circle = param1;
      }
      
      public function get RewardID() : uint
      {
         return this.FRewardID;
      }
      
      public function set RewardID(param1:uint) : void
      {
         this.FRewardID = param1;
      }
      
      public function get CircleRewardID() : uint
      {
         return this.FCircleRewardID;
      }
      
      public function set CircleRewardID(param1:uint) : void
      {
         this.FCircleRewardID = param1;
      }
      
      public function get CircleSignTotalDays() : uint
      {
         return this.FCircleSignTotalDays;
      }
      
      public function set CircleSignTotalDays(param1:uint) : void
      {
         this.FCircleSignTotalDays = param1;
      }
      
      public function get IsCanGetReward() : uint
      {
         return this.FIsCanGetReward;
      }
      
      public function set IsCanGetReward(param1:uint) : void
      {
         this.FIsCanGetReward = param1;
      }
      
      public function get TempValue() : Boolean
      {
         return this.FTempValue;
      }
      
      public function set TempValue(param1:Boolean) : void
      {
         this.FTempValue = param1;
      }
   }
}

