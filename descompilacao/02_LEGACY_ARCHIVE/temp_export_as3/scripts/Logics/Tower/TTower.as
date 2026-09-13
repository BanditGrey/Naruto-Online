package Logics.Tower
{
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   
   public class TTower
   {
      
      protected var FTowerID:uint;
      
      protected var FName:String;
      
      protected var FTower:uint;
      
      protected var FStageid:uint;
      
      protected var FStageClear:uint;
      
      protected var FLevel:uint;
      
      protected var FAwards:Vector.<TFixedAward>;
      
      protected var FAwardexs:Vector.<TFixedAward>;
      
      public function TTower()
      {
         super();
         this.FTowerID = 0;
         this.FName = "";
         this.FTower = 0;
         this.FStageid = 0;
         this.FStageClear = 0;
         this.FLevel = 0;
         this.FAwards = new Vector.<TFixedAward>();
         this.FAwardexs = new Vector.<TFixedAward>();
      }
      
      public function get TowerID() : uint
      {
         return this.FTowerID;
      }
      
      public function set TowerID(param1:uint) : void
      {
         this.FTowerID = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Tower() : uint
      {
         return this.FTower;
      }
      
      public function set Tower(param1:uint) : void
      {
         this.FTower = param1;
      }
      
      public function get Stageid() : uint
      {
         return this.FStageid;
      }
      
      public function set Stageid(param1:uint) : void
      {
         this.FStageid = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get Awards() : Vector.<TFixedAward>
      {
         return this.FAwards;
      }
      
      public function set Awards(param1:Vector.<TFixedAward>) : void
      {
         this.FAwards = param1;
      }
      
      public function get Awardexs() : Vector.<TFixedAward>
      {
         return this.FAwardexs;
      }
      
      public function set Awardexs(param1:Vector.<TFixedAward>) : void
      {
         this.FAwardexs = param1;
      }
      
      public function get StageClear() : uint
      {
         return this.FStageClear;
      }
      
      public function set StageClear(param1:uint) : void
      {
         this.FStageClear = param1;
      }
   }
}

