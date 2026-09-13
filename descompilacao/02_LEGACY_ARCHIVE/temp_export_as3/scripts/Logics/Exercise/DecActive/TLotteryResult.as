package Logics.Exercise.DecActive
{
   public class TLotteryResult
   {
      
      protected var FLevel:int;
      
      protected var FGold:int;
      
      protected var FNumbers:Vector.<int>;
      
      protected var FPlayers:Vector.<String>;
      
      public function TLotteryResult()
      {
         super();
         this.FNumbers = new Vector.<int>();
         this.FPlayers = new Vector.<String>();
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function set Level(param1:int) : void
      {
         this.FLevel = param1;
      }
      
      public function get Gold() : int
      {
         return this.FGold;
      }
      
      public function set Gold(param1:int) : void
      {
         this.FGold = param1;
      }
      
      public function get Players() : Vector.<String>
      {
         return this.FPlayers;
      }
      
      public function set Players(param1:Vector.<String>) : void
      {
         this.FPlayers = param1;
      }
      
      public function get Numbers() : Vector.<int>
      {
         return this.FNumbers;
      }
      
      public function set Numbers(param1:Vector.<int>) : void
      {
         this.FNumbers = param1;
      }
   }
}

