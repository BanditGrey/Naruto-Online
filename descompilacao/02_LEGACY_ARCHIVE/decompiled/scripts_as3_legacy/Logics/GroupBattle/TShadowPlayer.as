package Logics.GroupBattle
{
   import Foundation.Common.TEntity64;
   
   public class TShadowPlayer extends TEntity64
   {
      
      protected var FType:uint;
      
      protected var FPlayerName:String;
      
      protected var FPlayerLevel:uint;
      
      protected var FFamily:uint;
      
      protected var FIsOnline:uint;
      
      protected var FAuthorizeStatus:uint;
      
      public function TShadowPlayer(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
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
      
      public function get Family() : uint
      {
         return this.FFamily;
      }
      
      public function set Family(param1:uint) : void
      {
         this.FFamily = param1;
      }
      
      public function get AuthorizeStatus() : uint
      {
         return this.FAuthorizeStatus;
      }
      
      public function set AuthorizeStatus(param1:uint) : void
      {
         this.FAuthorizeStatus = param1;
      }
      
      public function get IsOnline() : uint
      {
         return this.FIsOnline;
      }
      
      public function set IsOnline(param1:uint) : void
      {
         this.FIsOnline = param1;
      }
   }
}

