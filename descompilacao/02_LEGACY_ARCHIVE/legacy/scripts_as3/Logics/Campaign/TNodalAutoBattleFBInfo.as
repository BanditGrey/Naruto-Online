package Logics.Campaign
{
   import Logics.Items.TItems;
   
   public class TNodalAutoBattleFBInfo
   {
      
      protected var FCostTimer:uint;
      
      protected var FStar:uint;
      
      protected var FBattleID:int;
      
      protected var FTotleCount:int;
      
      protected var FCurCount:int;
      
      protected var FBattleResult:Vector.<TItems>;
      
      protected var FPassResult:TItems;
      
      public function TNodalAutoBattleFBInfo()
      {
         super();
         this.FBattleResult = new Vector.<TItems>();
         this.FPassResult = new TItems();
      }
      
      public function get CostTimer() : uint
      {
         return this.FCostTimer;
      }
      
      public function set CostTimer(param1:uint) : void
      {
         this.FCostTimer = param1;
      }
      
      public function get Star() : uint
      {
         return this.FStar;
      }
      
      public function set Star(param1:uint) : void
      {
         this.FStar = param1;
      }
      
      public function get BattleID() : int
      {
         return this.FBattleID;
      }
      
      public function set BattleID(param1:int) : void
      {
         this.FBattleID = param1;
      }
      
      public function get TotleCount() : int
      {
         return this.FTotleCount;
      }
      
      public function set TotleCount(param1:int) : void
      {
         this.FTotleCount = param1;
      }
      
      public function get CurCount() : int
      {
         return this.FCurCount;
      }
      
      public function set CurCount(param1:int) : void
      {
         this.FCurCount = param1;
      }
      
      public function get BattleResult() : Vector.<TItems>
      {
         return this.FBattleResult;
      }
      
      public function set BattleResult(param1:Vector.<TItems>) : void
      {
         this.FBattleResult = param1;
      }
      
      public function get PassResult() : TItems
      {
         return this.FPassResult;
      }
      
      public function set PassResult(param1:TItems) : void
      {
         this.FPassResult = param1;
      }
   }
}

