package Logics.TopOrganization
{
   import Foundation.Common.TEntity64;
   
   public class TStatusJoinMember extends TEntity64
   {
      
      protected var FUserName:String;
      
      protected var FUserLevel:uint;
      
      protected var FCommitStatus:uint;
      
      public function TStatusJoinMember(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get UserName() : String
      {
         return this.FUserName;
      }
      
      public function set UserName(param1:String) : void
      {
         this.FUserName = param1;
      }
      
      public function get CommitStatus() : uint
      {
         return this.FCommitStatus;
      }
      
      public function set CommitStatus(param1:uint) : void
      {
         this.FCommitStatus = param1;
      }
      
      public function get UserLevel() : uint
      {
         return this.FUserLevel;
      }
      
      public function set UserLevel(param1:uint) : void
      {
         this.FUserLevel = param1;
      }
   }
}

