package Logics.CrossServerWar
{
   import Foundation.Common.Integer.UInt64;
   import Logics.Characters.THeros;
   
   public class TChallengePlayer
   {
      
      protected var FTargetIndex:uint;
      
      protected var FTargetName:String;
      
      protected var FTargetServerName:String;
      
      protected var FTargetHeros:THeros;
      
      protected var FTargetLevel:uint;
      
      protected var FTargetQuality:uint;
      
      protected var FTargetFightingPower:UInt64;
      
      protected var FTargetPetLevel:String;
      
      protected var FTargetScore:uint;
      
      protected var FIsDefeated:Boolean;
      
      protected var FType:uint;
      
      public function TChallengePlayer()
      {
         super();
         this.FTargetHeros = new THeros();
         this.FTargetFightingPower = new UInt64();
      }
      
      public function get TargetIndex() : uint
      {
         return this.FTargetIndex;
      }
      
      public function set TargetIndex(param1:uint) : void
      {
         this.FTargetIndex = param1;
      }
      
      public function get TargetName() : String
      {
         return this.FTargetName;
      }
      
      public function set TargetName(param1:String) : void
      {
         this.FTargetName = param1;
      }
      
      public function get TargetServerName() : String
      {
         return this.FTargetServerName;
      }
      
      public function set TargetServerName(param1:String) : void
      {
         this.FTargetServerName = param1;
      }
      
      public function get TargetHeros() : THeros
      {
         return this.FTargetHeros;
      }
      
      public function set TargetHeros(param1:THeros) : void
      {
         this.FTargetHeros = param1;
      }
      
      public function get TargetLevel() : uint
      {
         return this.FTargetLevel;
      }
      
      public function set TargetLevel(param1:uint) : void
      {
         this.FTargetLevel = param1;
      }
      
      public function get TargetFightingPower() : UInt64
      {
         return this.FTargetFightingPower;
      }
      
      public function set TargetFightingPower(param1:UInt64) : void
      {
         this.FTargetFightingPower = param1;
      }
      
      public function get TargetPetLevel() : String
      {
         return this.FTargetPetLevel;
      }
      
      public function set TargetPetLevel(param1:String) : void
      {
         this.FTargetPetLevel = param1;
      }
      
      public function get TargetScore() : uint
      {
         return this.FTargetScore;
      }
      
      public function set TargetScore(param1:uint) : void
      {
         this.FTargetScore = param1;
      }
      
      public function get IsDefeated() : Boolean
      {
         return this.FIsDefeated;
      }
      
      public function set IsDefeated(param1:Boolean) : void
      {
         this.FIsDefeated = param1;
      }
      
      public function get TargetQuality() : uint
      {
         return this.FTargetQuality;
      }
      
      public function set TargetQuality(param1:uint) : void
      {
         this.FTargetQuality = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
   }
}

