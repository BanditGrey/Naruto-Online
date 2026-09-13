package Logics.Exercise.ValentineDay
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TValentineDay1 extends TBaseActivity
   {
      
      protected var FContiueDays:int;
      
      protected var FCost:int;
      
      protected var FNeedDays:int;
      
      protected var FStatus:int;
      
      protected var FCurDay:int;
      
      protected var FCurStatus:int;
      
      protected var FFreeCount:int;
      
      protected var FDayList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FLabaInventories:TInventories;
      
      protected var FLabaFlowStr:String;
      
      public function TValentineDay1()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FDayList = new Vector.<TBaseBox>();
      }
      
      public function get DayList() : Vector.<TBaseBox>
      {
         return this.FDayList;
      }
      
      public function set DayList(param1:Vector.<TBaseBox>) : void
      {
         this.FDayList = param1;
      }
      
      public function get CurDay() : int
      {
         return this.FCurDay;
      }
      
      public function set CurDay(param1:int) : void
      {
         this.FCurDay = param1;
      }
      
      public function get CurStatus() : int
      {
         return this.FCurStatus;
      }
      
      public function set CurStatus(param1:int) : void
      {
         this.FCurStatus = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get ContiueDays() : int
      {
         return this.FContiueDays;
      }
      
      public function set ContiueDays(param1:int) : void
      {
         this.FContiueDays = param1;
      }
      
      public function get Cost() : int
      {
         return this.FCost;
      }
      
      public function set Cost(param1:int) : void
      {
         this.FCost = param1;
      }
      
      public function get NeedDays() : int
      {
         return this.FNeedDays;
      }
      
      public function set NeedDays(param1:int) : void
      {
         this.FNeedDays = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get LabaInventories() : TInventories
      {
         return this.FLabaInventories;
      }
      
      public function set LabaInventories(param1:TInventories) : void
      {
         this.FLabaInventories = param1;
      }
      
      public function get LabaFlowStr() : String
      {
         return this.FLabaFlowStr;
      }
      
      public function set LabaFlowStr(param1:String) : void
      {
         this.FLabaFlowStr = param1;
      }
   }
}

