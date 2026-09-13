package Logics.Organization.TreasureTree
{
   public class TUserWaterInfo
   {
      
      protected var FOrgMemberName:String;
      
      protected var FOrgMemberID0:uint;
      
      protected var FOrgMemberID1:uint;
      
      protected var FNextWaterTime:uint;
      
      protected var FIsOnline:Boolean;
      
      protected var FOrgDuty:uint;
      
      protected var FOrgMemberLevel:uint;
      
      public function TUserWaterInfo()
      {
         super();
         this.FOrgMemberName = "";
         this.FOrgMemberID0 = 0;
         this.FOrgMemberID1 = 0;
         this.FNextWaterTime = 0;
         this.FIsOnline = false;
      }
      
      public function get OrgMemberName() : String
      {
         return this.FOrgMemberName;
      }
      
      public function set OrgMemberName(param1:String) : void
      {
         this.FOrgMemberName = param1;
      }
      
      public function get OrgMemberID0() : uint
      {
         return this.FOrgMemberID0;
      }
      
      public function set OrgMemberID0(param1:uint) : void
      {
         this.FOrgMemberID0 = param1;
      }
      
      public function get OrgMemberID1() : uint
      {
         return this.FOrgMemberID1;
      }
      
      public function set OrgMemberID1(param1:uint) : void
      {
         this.FOrgMemberID1 = param1;
      }
      
      public function get NextWaterTime() : uint
      {
         return this.FNextWaterTime;
      }
      
      public function set NextWaterTime(param1:uint) : void
      {
         this.FNextWaterTime = param1;
      }
      
      public function get IsOnline() : Boolean
      {
         return this.FIsOnline;
      }
      
      public function set IsOnline(param1:Boolean) : void
      {
         this.FIsOnline = param1;
      }
      
      public function get OrgDuty() : uint
      {
         return this.FOrgDuty;
      }
      
      public function set OrgDuty(param1:uint) : void
      {
         this.FOrgDuty = param1;
      }
      
      public function get OrgMemberLevel() : uint
      {
         return this.FOrgMemberLevel;
      }
      
      public function set OrgMemberLevel(param1:uint) : void
      {
         this.FOrgMemberLevel = param1;
      }
   }
}

