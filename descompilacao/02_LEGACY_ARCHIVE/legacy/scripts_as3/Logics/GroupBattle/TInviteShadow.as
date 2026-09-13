package Logics.GroupBattle
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TEntity64;
   
   public class TInviteShadow extends TEntity64
   {
      
      protected var FPlayerName:String;
      
      protected var FPlayerLevel:uint;
      
      protected var FFightPower:UInt64 = new UInt64();
      
      protected var FCDTime:uint;
      
      protected var FLeftInviteTImes:uint;
      
      public function TInviteShadow(param1:uint, param2:uint)
      {
         super(param1,param2);
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
      
      public function get CDTime() : uint
      {
         return this.FCDTime;
      }
      
      public function set CDTime(param1:uint) : void
      {
         this.FCDTime = param1;
      }
      
      public function get LeftInviteTImes() : uint
      {
         return this.FLeftInviteTImes;
      }
      
      public function set LeftInviteTImes(param1:uint) : void
      {
         this.FLeftInviteTImes = param1;
      }
   }
}

