package Logics.Exercise.ChristmasDay
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   
   public class TChristmasDay extends TBaseActivity
   {
      
      public var ScoreCommand:Vector.<int>;
      
      public var RankSpecialList:Vector.<TInventories>;
      
      protected var FScore:int;
      
      protected var FBoxNum:int;
      
      protected var FSocksNum:int;
      
      protected var FConsume:int;
      
      protected var FRecharge:int;
      
      protected var FUseSocks:int;
      
      public function TChristmasDay()
      {
         super();
         this.ScoreCommand = new Vector.<int>();
         this.RankSpecialList = new Vector.<TInventories>();
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get BoxNum() : int
      {
         return this.FBoxNum;
      }
      
      public function set BoxNum(param1:int) : void
      {
         this.FBoxNum = param1;
      }
      
      public function get SocksNum() : int
      {
         return this.FSocksNum;
      }
      
      public function set SocksNum(param1:int) : void
      {
         this.FSocksNum = param1;
      }
      
      public function get Consume() : int
      {
         return this.FConsume;
      }
      
      public function set Consume(param1:int) : void
      {
         this.FConsume = param1;
      }
      
      public function get Recharge() : int
      {
         return this.FRecharge;
      }
      
      public function set Recharge(param1:int) : void
      {
         this.FRecharge = param1;
      }
      
      public function get UseSocks() : int
      {
         return this.FUseSocks;
      }
      
      public function set UseSocks(param1:int) : void
      {
         this.FUseSocks = param1;
      }
   }
}

