package Logics.Prerogative
{
   import Logics.Inventories.TInventories;
   
   public class TPrerogativeOne
   {
      
      protected var FWelfareName:String;
      
      protected var FRewardID:uint;
      
      protected var FPlatformID:uint;
      
      protected var FType:uint;
      
      protected var FMember:uint;
      
      protected var FPrivilegeLevel:uint;
      
      protected var FIsOpen:Boolean;
      
      protected var FInventories:TInventories;
      
      protected var FBecomeMemberURL:String;
      
      protected var FYearMemberURL:String;
      
      protected var FMemberDescURL:String;
      
      public function TPrerogativeOne()
      {
         super();
         this.FWelfareName = "";
         this.FInventories = new TInventories();
         this.FIsOpen = false;
      }
      
      public function get RewardID() : uint
      {
         return this.FRewardID;
      }
      
      public function set RewardID(param1:uint) : void
      {
         this.FRewardID = param1;
      }
      
      public function get PlatformID() : uint
      {
         return this.FPlatformID;
      }
      
      public function set PlatformID(param1:uint) : void
      {
         this.FPlatformID = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Member() : uint
      {
         return this.FMember;
      }
      
      public function set Member(param1:uint) : void
      {
         this.FMember = param1;
      }
      
      public function get PrivilegeLevel() : uint
      {
         return this.FPrivilegeLevel;
      }
      
      public function set PrivilegeLevel(param1:uint) : void
      {
         this.FPrivilegeLevel = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get IsOpen() : Boolean
      {
         return this.FIsOpen;
      }
      
      public function set IsOpen(param1:Boolean) : void
      {
         this.FIsOpen = param1;
      }
      
      public function get WelfareName() : String
      {
         return this.FWelfareName;
      }
      
      public function set WelfareName(param1:String) : void
      {
         this.FWelfareName = param1;
      }
      
      public function get BecomeMemberURL() : String
      {
         return this.FBecomeMemberURL;
      }
      
      public function set BecomeMemberURL(param1:String) : void
      {
         this.FBecomeMemberURL = param1;
      }
      
      public function get YearMemberURL() : String
      {
         return this.FYearMemberURL;
      }
      
      public function set YearMemberURL(param1:String) : void
      {
         this.FYearMemberURL = param1;
      }
      
      public function get MemberDescURL() : String
      {
         return this.FMemberDescURL;
      }
      
      public function set MemberDescURL(param1:String) : void
      {
         this.FMemberDescURL = param1;
      }
   }
}

