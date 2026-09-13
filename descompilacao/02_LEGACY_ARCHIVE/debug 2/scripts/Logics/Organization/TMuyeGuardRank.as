package Logics.Organization
{
   import Logics.Organization.Elements.*;
   import Resources.Strings.STRING_COMMON;
   
   public class TMuyeGuardRank
   {
      
      protected var FWinStatus:Boolean;
      
      protected var FCurTurnOrgName:String;
      
      protected var FCurTurnOrgFamily:uint;
      
      protected var FBeferTurnOrgName:String;
      
      protected var FBeferTurnOrgFamily:uint;
      
      protected var FDefendDay:uint;
      
      protected var FOrgRankList:Vector.<TBaseRankList>;
      
      public function TMuyeGuardRank()
      {
         super();
         this.FOrgRankList = new Vector.<TBaseRankList>();
         this.FWinStatus = false;
         this.FCurTurnOrgName = STRING_COMMON.COMMON_NONE;
         this.FCurTurnOrgFamily = 0;
         this.FBeferTurnOrgName = STRING_COMMON.COMMON_NONE;
         this.FBeferTurnOrgFamily = 0;
         this.FDefendDay = 0;
      }
      
      public function get WinStatus() : Boolean
      {
         return this.FWinStatus;
      }
      
      public function set WinStatus(param1:Boolean) : void
      {
         this.FWinStatus = param1;
      }
      
      public function get CurTurnOrgName() : String
      {
         return this.FCurTurnOrgName;
      }
      
      public function set CurTurnOrgName(param1:String) : void
      {
         this.FCurTurnOrgName = param1;
      }
      
      public function get CurTurnOrgFamily() : uint
      {
         return this.FCurTurnOrgFamily;
      }
      
      public function set CurTurnOrgFamily(param1:uint) : void
      {
         this.FCurTurnOrgFamily = param1;
      }
      
      public function get BeferTurnOrgName() : String
      {
         return this.FBeferTurnOrgName;
      }
      
      public function set BeferTurnOrgName(param1:String) : void
      {
         this.FBeferTurnOrgName = param1;
      }
      
      public function get BeferTurnOrgFamily() : uint
      {
         return this.FBeferTurnOrgFamily;
      }
      
      public function set BeferTurnOrgFamily(param1:uint) : void
      {
         this.FBeferTurnOrgFamily = param1;
      }
      
      public function get DefendDay() : uint
      {
         return this.FDefendDay;
      }
      
      public function set DefendDay(param1:uint) : void
      {
         this.FDefendDay = param1;
      }
      
      public function get OrgRankList() : Vector.<TBaseRankList>
      {
         return this.FOrgRankList;
      }
      
      public function set OrgRankList(param1:Vector.<TBaseRankList>) : void
      {
         this.FOrgRankList = param1;
      }
   }
}

