package Logics.WorldMatch
{
   import Logics.Characters.THeros;
   
   public class TWorldMatchPlayerInfo
   {
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var FHeroId:int;
      
      protected var FTargetRank:uint;
      
      protected var FPlayerName:String;
      
      protected var FServerName:String;
      
      protected var FPlayerLevel:uint;
      
      protected var FFightPower:uint;
      
      protected var FTargetPetLevel:String;
      
      protected var FTargetHeros:THeros;
      
      public function TWorldMatchPlayerInfo()
      {
         super();
         this.FTargetHeros = new THeros();
         this.FTargetRank = 0;
         this.FPlayerName = "";
         this.FServerName = "";
         this.FPlayerLevel = 0;
         this.FFightPower = 0;
         this.FTargetPetLevel = "";
      }
      
      public function get Identifier0() : uint
      {
         return this.FIdentifier0;
      }
      
      public function set Identifier0(param1:uint) : void
      {
         this.FIdentifier0 = param1;
      }
      
      public function get Identifier1() : uint
      {
         return this.FIdentifier1;
      }
      
      public function set Identifier1(param1:uint) : void
      {
         this.FIdentifier1 = param1;
      }
      
      public function get HeroId() : int
      {
         return this.FHeroId;
      }
      
      public function set HeroId(param1:int) : void
      {
         this.FHeroId = param1;
      }
      
      public function get TargetRank() : uint
      {
         return this.FTargetRank;
      }
      
      public function set TargetRank(param1:uint) : void
      {
         this.FTargetRank = param1;
      }
      
      public function get PlayerName() : String
      {
         return this.FPlayerName;
      }
      
      public function set PlayerName(param1:String) : void
      {
         this.FPlayerName = param1;
      }
      
      public function get ServerName() : String
      {
         return this.FServerName;
      }
      
      public function set ServerName(param1:String) : void
      {
         this.FServerName = param1;
      }
      
      public function get PlayerLevel() : uint
      {
         return this.FPlayerLevel;
      }
      
      public function set PlayerLevel(param1:uint) : void
      {
         this.FPlayerLevel = param1;
      }
      
      public function get FightPower() : uint
      {
         return this.FFightPower;
      }
      
      public function set FightPower(param1:uint) : void
      {
         this.FFightPower = param1;
      }
      
      public function get TargetPetLevel() : String
      {
         return this.FTargetPetLevel;
      }
      
      public function set TargetPetLevel(param1:String) : void
      {
         this.FTargetPetLevel = param1;
      }
      
      public function get TargetHeros() : THeros
      {
         return this.FTargetHeros;
      }
      
      public function set TargetHeros(param1:THeros) : void
      {
         this.FTargetHeros = param1;
      }
   }
}

