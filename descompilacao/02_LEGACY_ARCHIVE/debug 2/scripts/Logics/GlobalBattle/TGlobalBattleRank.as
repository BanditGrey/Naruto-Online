package Logics.GlobalBattle
{
   public class TGlobalBattleRank
   {
      
      protected var FUid:Number;
      
      protected var FServerId:int;
      
      protected var FAgentId:int;
      
      protected var FAgent:String;
      
      protected var FRank:int;
      
      protected var FScore:int;
      
      protected var FUsername:String;
      
      protected var FUserlevel:int;
      
      public function TGlobalBattleRank()
      {
         super();
      }
      
      public function get Uid() : Number
      {
         return this.FUid;
      }
      
      public function set Uid(param1:Number) : void
      {
         this.FUid = param1;
      }
      
      public function get ServerId() : int
      {
         return this.FServerId;
      }
      
      public function set ServerId(param1:int) : void
      {
         this.FServerId = param1;
      }
      
      public function get AgentId() : int
      {
         return this.FAgentId;
      }
      
      public function set AgentId(param1:int) : void
      {
         this.FAgentId = param1;
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
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
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

