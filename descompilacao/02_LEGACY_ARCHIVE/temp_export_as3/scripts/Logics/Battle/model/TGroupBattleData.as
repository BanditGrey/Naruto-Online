package Logics.Battle.model
{
   public class TGroupBattleData
   {
      
      protected var FFightResult:int;
      
      protected var FDefNpcId:int;
      
      protected var FAtkHp:int;
      
      protected var FDefHp:int;
      
      protected var FFightReportId:String;
      
      protected var FWinPlayerIdLow:uint;
      
      protected var FWinPlayerIdHight:uint;
      
      public function TGroupBattleData()
      {
         super();
      }
      
      public function get FightResult() : int
      {
         return this.FFightResult;
      }
      
      public function set FightResult(param1:int) : void
      {
         this.FFightResult = param1;
      }
      
      public function get DefNpcId() : int
      {
         return this.FDefNpcId;
      }
      
      public function set DefNpcId(param1:int) : void
      {
         this.FDefNpcId = param1;
      }
      
      public function get AtkHp() : int
      {
         return this.FAtkHp;
      }
      
      public function set AtkHp(param1:int) : void
      {
         this.FAtkHp = param1;
      }
      
      public function get DefHp() : int
      {
         return this.FDefHp;
      }
      
      public function set DefHp(param1:int) : void
      {
         this.FDefHp = param1;
      }
      
      public function get FightReportId() : String
      {
         return this.FFightReportId;
      }
      
      public function set FightReportId(param1:String) : void
      {
         this.FFightReportId = param1;
      }
   }
}

