package Logics.TopTeam
{
   public class TTopTeamRank
   {
      
      protected var FRank:uint;
      
      protected var FName:String;
      
      protected var FJob:uint;
      
      protected var FLevel:uint;
      
      protected var FScore:uint;
      
      protected var FPlatformName:String;
      
      protected var FServerName:String;
      
      public function TTopTeamRank()
      {
         super();
         this.FRank = 0;
         this.FName = "";
         this.FJob = 0;
         this.FLevel = 0;
         this.FScore = 0;
         this.FPlatformName = "";
         this.FServerName = "";
      }
      
      public function get Rank() : uint
      {
         return this.FRank;
      }
      
      public function set Rank(param1:uint) : void
      {
         this.FRank = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Job() : uint
      {
         return this.FJob;
      }
      
      public function set Job(param1:uint) : void
      {
         this.FJob = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get Score() : uint
      {
         return this.FScore;
      }
      
      public function set Score(param1:uint) : void
      {
         this.FScore = param1;
      }
      
      public function get PlatformName() : String
      {
         return this.FPlatformName;
      }
      
      public function set PlatformName(param1:String) : void
      {
         this.FPlatformName = param1;
      }
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function Reset() : void
      {
         this.FRank = 0;
         this.FName = "";
         this.FJob = 0;
         this.FLevel = 0;
         this.FScore = 0;
         this.FPlatformName = "";
         this.FServerName = "";
      }
   }
}

