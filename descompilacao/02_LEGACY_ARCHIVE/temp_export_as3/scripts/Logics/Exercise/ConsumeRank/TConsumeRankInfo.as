package Logics.Exercise.ConsumeRank
{
   import Foundation.Common.Integer.UInt64;
   
   public class TConsumeRankInfo
   {
      
      protected var FIdentify0:uint;
      
      protected var FIdentify1:uint;
      
      protected var FUserName:String;
      
      protected var FScore:int;
      
      protected var FRank:int;
      
      protected var FServerID:String;
      
      protected var FTime:int;
      
      protected var FServerName:String;
      
      protected var FDesc1:String;
      
      public var HeroID:int;
      
      public var Level:int;
      
      public var Power:int;
      
      public var Desc:String;
      
      public var FightPower:UInt64;
      
      public function TConsumeRankInfo()
      {
         super();
         this.FightPower = new UInt64();
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
      
      public function get Time() : int
      {
         return this.FTime;
      }
      
      public function set Time(param1:int) : void
      {
         this.FTime = param1;
      }
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function get Desc1() : String
      {
         return this.FDesc1;
      }
      
      public function set Desc1(param1:String) : void
      {
         this.FDesc1 = param1;
      }
   }
}

