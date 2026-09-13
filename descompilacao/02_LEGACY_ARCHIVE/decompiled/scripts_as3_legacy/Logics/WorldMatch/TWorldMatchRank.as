package Logics.WorldMatch
{
   public class TWorldMatchRank
   {
      
      protected var FServerName:String;
      
      protected var FAgent:String;
      
      protected var FRank:int;
      
      protected var FUsername:String;
      
      protected var FUserlevel:int;
      
      public function TWorldMatchRank()
      {
         super();
      }
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function get Agent() : String
      {
         return this.FAgent;
      }
      
      public function set Agent(param1:String) : void
      {
         this.FAgent = param1;
      }
      
      public function get Rank() : int
      {
         return this.FRank;
      }
      
      public function set Rank(param1:int) : void
      {
         this.FRank = param1;
      }
      
      public function get Username() : String
      {
         return this.FUsername;
      }
      
      public function set Username(param1:String) : void
      {
         this.FUsername = param1;
      }
      
      public function get Userlevel() : int
      {
         return this.FUserlevel;
      }
      
      public function set Userlevel(param1:int) : void
      {
         this.FUserlevel = param1;
      }
   }
}

