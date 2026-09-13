package Logics.Tower
{
   public class TTowerData
   {
      
      protected var FTowers:TTowers;
      
      protected var FPlayerHP:uint;
      
      protected var FFreeExploreTimes:uint;
      
      protected var FBuyHPTimes:uint;
      
      protected var FOpenTowers:TOpenTowers;
      
      public function TTowerData()
      {
         super();
         this.FTowers = new TTowers();
         this.FOpenTowers = new TOpenTowers();
      }
      
      public function get Towers() : TTowers
      {
         return this.FTowers;
      }
      
      public function get PlayerHP() : uint
      {
         return this.FPlayerHP;
      }
      
      public function set PlayerHP(param1:uint) : void
      {
         this.FPlayerHP = param1;
      }
      
      public function get FreeExploreTimes() : uint
      {
         return this.FFreeExploreTimes;
      }
      
      public function set FreeExploreTimes(param1:uint) : void
      {
         this.FFreeExploreTimes = param1;
      }
      
      public function get OpenTowers() : TOpenTowers
      {
         return this.FOpenTowers;
      }
      
      public function set OpenTowers(param1:TOpenTowers) : void
      {
         this.FOpenTowers = param1;
      }
      
      public function get BuyHPTimes() : uint
      {
         return this.FBuyHPTimes;
      }
      
      public function set BuyHPTimes(param1:uint) : void
      {
         this.FBuyHPTimes = param1;
      }
   }
}

