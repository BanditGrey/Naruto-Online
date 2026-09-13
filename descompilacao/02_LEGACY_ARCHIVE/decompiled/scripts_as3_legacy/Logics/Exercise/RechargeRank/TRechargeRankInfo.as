package Logics.Exercise.RechargeRank
{
   public class TRechargeRankInfo
   {
      
      protected var FIdentify0:uint;
      
      protected var FIdentify1:uint;
      
      protected var FUserName:String;
      
      protected var FScore:int;
      
      protected var FRank:int;
      
      protected var FServerID:String;
      
      public function TRechargeRankInfo()
      {
         super();
      }
      
      public function get Identify0() : uint
      {
         return this.FIdentify0;
      }
      
      public function set Identify0(param1:uint) : void
      {
         this.FIdentify0 = param1;
      }
      
      public function get Identify1() : uint
      {
         return this.FIdentify1;
      }
      
      public function set Identify1(param1:uint) : void
      {
         this.FIdentify1 = param1;
      }
      
      public function get UserName() : String
      {
         return this.FUserName;
      }
      
      public function set UserName(param1:String) : void
      {
         this.FUserName = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Rank() : int
      {
         return this.FRank;
      }
      
      public function set Rank(param1:int) : void
      {
         this.FRank = param1;
      }
      
      public function get ServerID() : String
      {
         return this.FServerID;
      }
      
      public function set ServerID(param1:String) : void
      {
         this.FServerID = param1;
      }
   }
}

