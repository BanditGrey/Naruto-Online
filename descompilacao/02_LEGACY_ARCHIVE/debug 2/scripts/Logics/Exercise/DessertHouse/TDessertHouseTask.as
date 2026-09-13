package Logics.Exercise.DessertHouse
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   
   public class TDessertHouseTask
   {
      
      protected var FIdentify:int;
      
      protected var FTaskName:String;
      
      protected var FTaskDesc:String;
      
      protected var FTaskReq:Vector.<int>;
      
      protected var FTaskPoint:Vector.<int>;
      
      protected var FTaskAward:Vector.<TInventories>;
      
      protected var FMaxReset:int;
      
      protected var FReset:int;
      
      protected var FConsume:int;
      
      protected var FGo:int;
      
      protected var FStep:int;
      
      protected var FStatus:int;
      
      protected var FProcess:int;
      
      protected var FClientTaskReq:Vector.<int>;
      
      public function TDessertHouseTask(param1:int)
      {
         super();
         this.FIdentify = param1;
         this.FTaskAward = new Vector.<TInventories>();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get TaskName() : String
      {
         return this.FTaskName;
      }
      
      public function set TaskName(param1:String) : void
      {
         this.FTaskName = param1;
      }
      
      public function get TaskDesc() : String
      {
         return this.FTaskDesc;
      }
      
      public function set TaskDesc(param1:String) : void
      {
         this.FTaskDesc = param1;
      }
      
      public function get TaskReq() : Vector.<int>
      {
         return this.FTaskReq;
      }
      
      public function set TaskReq(param1:Vector.<int>) : void
      {
         this.FTaskReq = param1;
      }
      
      public function get TaskPoint() : Vector.<int>
      {
         return this.FTaskPoint;
      }
      
      public function set TaskPoint(param1:Vector.<int>) : void
      {
         this.FTaskPoint = param1;
      }
      
      public function get TaskAward() : Vector.<TInventories>
      {
         return this.FTaskAward;
      }
      
      public function set TaskAward(param1:Vector.<TInventories>) : void
      {
         this.FTaskAward = param1;
      }
      
      public function get Reset() : int
      {
         return this.FReset;
      }
      
      public function set Reset(param1:int) : void
      {
         this.FReset = param1;
      }
      
      public function get Consume() : int
      {
         return this.FConsume;
      }
      
      public function set Consume(param1:int) : void
      {
         this.FConsume = param1;
      }
      
      public function get Go() : int
      {
         return this.FGo;
      }
      
      public function set Go(param1:int) : void
      {
         this.FGo = param1;
      }
      
      public function get Step() : int
      {
         return this.FStep;
      }
      
      public function set Step(param1:int) : void
      {
         this.FStep = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get Process() : int
      {
         return this.FProcess;
      }
      
      public function set Process(param1:int) : void
      {
         this.FProcess = param1;
      }
      
      public function get MaxReset() : int
      {
         return this.FMaxReset;
      }
      
      public function set MaxReset(param1:int) : void
      {
         this.FMaxReset = param1;
      }
      
      public function get ClientTaskReq() : Vector.<int>
      {
         return this.FClientTaskReq;
      }
      
      public function set ClientTaskReq(param1:Vector.<int>) : void
      {
         this.FClientTaskReq = param1;
      }
      
      public function ChangeStatus() : void
      {
         if(this.FStatus == TBaseActivity.STATUS_CANNOTGET && this.FProcess >= this.FTaskReq[this.FStep])
         {
            this.FStatus = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

