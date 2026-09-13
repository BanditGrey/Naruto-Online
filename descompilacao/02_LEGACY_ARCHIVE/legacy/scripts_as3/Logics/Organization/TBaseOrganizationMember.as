package Logics.Organization
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.TEntity64;
   
   public class TBaseOrganizationMember extends TEntity64
   {
      
      protected var FRank:uint;
      
      protected var FPlayerName:String;
      
      protected var FPlayerFamily:uint;
      
      protected var FPlayerLevel:uint;
      
      protected var FPlayerOrgPower:UInt64 = new UInt64();
      
      protected var FTodayContribution:int;
      
      protected var FTotalContribution:int;
      
      protected var FLastLogginTime:int;
      
      protected var FOrgDuties:uint;
      
      protected var FScore:int;
      
      protected var FOrgName:String;
      
      public function TBaseOrganizationMember(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get Rank() : uint
      {
         return this.FRank;
      }
      
      public function set Rank(param1:uint) : void
      {
         this.FRank = param1;
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
      
      public function get PlayerOrgPower() : UInt64
      {
         return this.FPlayerOrgPower;
      }
      
      public function set PlayerOrgPower(param1:UInt64) : void
      {
         this.FPlayerOrgPower = param1;
      }
      
      public function get TodayContribution() : int
      {
         return this.FTodayContribution;
      }
      
      public function set TodayContribution(param1:int) : void
      {
         this.FTodayContribution = param1;
      }
      
      public function get TotalContribution() : int
      {
         return this.FTotalContribution;
      }
      
      public function set TotalContribution(param1:int) : void
      {
         this.FTotalContribution = param1;
      }
      
      public function get LastLogginTime() : int
      {
         return this.FLastLogginTime;
      }
      
      public function set LastLogginTime(param1:int) : void
      {
         this.FLastLogginTime = param1;
      }
      
      public function get OrgDuties() : uint
      {
         return this.FOrgDuties;
      }
      
      public function set OrgDuties(param1:uint) : void
      {
         this.FOrgDuties = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get PlayerFamily() : uint
      {
         return this.FPlayerFamily;
      }
      
      public function set PlayerFamily(param1:uint) : void
      {
         this.FPlayerFamily = param1;
      }
      
      public function get OrgName() : String
      {
         return this.FOrgName;
      }
      
      public function set OrgName(param1:String) : void
      {
         this.FOrgName = param1;
      }
   }
}

