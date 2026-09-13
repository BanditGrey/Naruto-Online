package Logics.GroupBattle
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TEntity64;
   import Logics.Characters.THeros;
   
   public class TRoomPlayer extends TEntity64
   {
      
      protected var FPositionIndex:int;
      
      protected var FPlayerModelID:uint;
      
      protected var FPlayerHeadID:uint;
      
      protected var FPlayerName:String;
      
      protected var FPlayerLevel:uint;
      
      protected var FFightPower:UInt64;
      
      protected var FIsReady:uint;
      
      protected var FFriendBuff:Boolean;
      
      protected var FOrganizationBuff:Boolean;
      
      protected var FPetID:uint;
      
      protected var FHeros:THeros;
      
      protected var FFamilyId:uint;
      
      protected var FIsShadow:uint;
      
      protected var FIsCaptaian:uint;
      
      public function TRoomPlayer(param1:uint, param2:uint)
      {
         super(param1,param2);
         this.FHeros = new THeros();
         this.FFightPower = new UInt64();
      }
      
      public function get PositionIndex() : int
      {
         return this.FPositionIndex;
      }
      
      public function set PositionIndex(param1:int) : void
      {
         this.FPositionIndex = param1;
      }
      
      public function get PlayerModelID() : uint
      {
         return this.FPlayerModelID;
      }
      
      public function set PlayerModelID(param1:uint) : void
      {
         this.FPlayerModelID = param1;
      }
      
      public function get PlayerHeadID() : uint
      {
         return this.FPlayerHeadID;
      }
      
      public function set PlayerHeadID(param1:uint) : void
      {
         this.FPlayerHeadID = param1;
      }
      
      public function get PlayerName() : String
      {
         return this.FPlayerName;
      }
      
      public function set PlayerName(param1:String) : void
      {
         this.FPlayerName = param1;
      }
      
      public function get PlayerLevel() : uint
      {
         return this.FPlayerLevel;
      }
      
      public function set PlayerLevel(param1:uint) : void
      {
         this.FPlayerLevel = param1;
      }
      
      public function get FightPower() : UInt64
      {
         return this.FFightPower;
      }
      
      public function set FightPower(param1:UInt64) : void
      {
         this.FFightPower = param1;
      }
      
      public function get IsReady() : uint
      {
         return this.FIsReady;
      }
      
      public function set IsReady(param1:uint) : void
      {
         this.FIsReady = param1;
      }
      
      public function get FriendBuff() : Boolean
      {
         return this.FFriendBuff;
      }
      
      public function set FriendBuff(param1:Boolean) : void
      {
         this.FFriendBuff = param1;
      }
      
      public function get OrganizationBuff() : Boolean
      {
         return this.FOrganizationBuff;
      }
      
      public function set OrganizationBuff(param1:Boolean) : void
      {
         this.FOrganizationBuff = param1;
      }
      
      public function get PetID() : uint
      {
         return this.FPetID;
      }
      
      public function set PetID(param1:uint) : void
      {
         this.FPetID = param1;
      }
      
      public function get Heros() : THeros
      {
         return this.FHeros;
      }
      
      public function set Heros(param1:THeros) : void
      {
         this.FHeros = param1;
      }
      
      public function get FamilyId() : uint
      {
         return this.FFamilyId;
      }
      
      public function set FamilyId(param1:uint) : void
      {
         this.FFamilyId = param1;
      }
      
      public function get IsShadow() : uint
      {
         return this.FIsShadow;
      }
      
      public function set IsShadow(param1:uint) : void
      {
         this.FIsShadow = param1;
      }
      
      public function get IsCaptaian() : uint
      {
         return this.FIsCaptaian;
      }
      
      public function set IsCaptaian(param1:uint) : void
      {
         this.FIsCaptaian = param1;
      }
   }
}

