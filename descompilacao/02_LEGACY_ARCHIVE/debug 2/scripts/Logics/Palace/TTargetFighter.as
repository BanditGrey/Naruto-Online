package Logics.Palace
{
   import Logics.Characters.THeros;
   
   public class TTargetFighter
   {
      
      protected var FRankIndex:uint;
      
      protected var FPlayerName:String;
      
      protected var FServerName:String;
      
      protected var FLevel:uint;
      
      protected var FWingID:uint;
      
      protected var FTitleID:uint;
      
      protected var FHeros:THeros;
      
      public function TTargetFighter()
      {
         super();
         this.FHeros = new THeros();
      }
      
      public function get RankIndex() : uint
      {
         return this.FRankIndex;
      }
      
      public function set RankIndex(param1:uint) : void
      {
         this.FRankIndex = param1;
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
      
      public function get Heros() : THeros
      {
         return this.FHeros;
      }
      
      public function set Heros(param1:THeros) : void
      {
         this.FHeros = param1;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get WingID() : uint
      {
         return this.FWingID;
      }
      
      public function set WingID(param1:uint) : void
      {
         this.FWingID = param1;
      }
      
      public function get TitleID() : uint
      {
         return this.FTitleID;
      }
      
      public function set TitleID(param1:uint) : void
      {
         this.FTitleID = param1;
      }
   }
}

