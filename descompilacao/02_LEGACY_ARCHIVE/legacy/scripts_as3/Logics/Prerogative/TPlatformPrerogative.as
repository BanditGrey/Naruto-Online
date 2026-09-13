package Logics.Prerogative
{
   public class TPlatformPrerogative
   {
      
      protected var FIsOpen:uint;
      
      protected var FAgentName:String;
      
      protected var FCommonPayIsGet:Boolean;
      
      protected var FYearStatus:uint;
      
      protected var FMemberLevel:uint;
      
      protected var FLastLoginMemberLevel:uint;
      
      protected var FYearPayIsGet:Boolean;
      
      protected var FBecomeMemberURL:String;
      
      protected var FYearMemberURL:String;
      
      protected var FMemberDescURL:String;
      
      protected var FPrerogativeOnes:TPrerogativeOnes;
      
      protected var FShowActivities:TPrerogativeOnes;
      
      protected var FMajorType:uint;
      
      protected var FMinorType:uint;
      
      public function TPlatformPrerogative()
      {
         super();
         this.FCommonPayIsGet = false;
         this.FYearStatus = 0;
         this.FMemberLevel = 0;
         this.FLastLoginMemberLevel = 0;
         this.FYearPayIsGet = false;
         this.FPrerogativeOnes = new TPrerogativeOnes();
      }
      
      public function get CommonPayIsGet() : Boolean
      {
         return this.FCommonPayIsGet;
      }
      
      public function set CommonPayIsGet(param1:Boolean) : void
      {
         this.FCommonPayIsGet = param1;
      }
      
      public function get YearStatus() : uint
      {
         return this.FYearStatus;
      }
      
      public function set YearStatus(param1:uint) : void
      {
         this.FYearStatus = param1;
      }
      
      public function get MemberLevel() : uint
      {
         return this.FMemberLevel;
      }
      
      public function set MemberLevel(param1:uint) : void
      {
         this.FMemberLevel = param1;
      }
      
      public function get LastLoginMemberLevel() : uint
      {
         return this.FLastLoginMemberLevel;
      }
      
      public function set LastLoginMemberLevel(param1:uint) : void
      {
         this.FLastLoginMemberLevel = param1;
      }
      
      public function get YearPayIsGet() : Boolean
      {
         return this.FYearPayIsGet;
      }
      
      public function set YearPayIsGet(param1:Boolean) : void
      {
         this.FYearPayIsGet = param1;
      }
      
      public function get MajorType() : uint
      {
         return this.FMajorType;
      }
      
      public function set MajorType(param1:uint) : void
      {
         this.FMajorType = param1;
      }
      
      public function get MinorType() : uint
      {
         return this.FMinorType;
      }
      
      public function set MinorType(param1:uint) : void
      {
         this.FMinorType = param1;
      }
      
      public function get PrerogativeOnes() : TPrerogativeOnes
      {
         return this.FPrerogativeOnes;
      }
      
      public function set PrerogativeOnes(param1:TPrerogativeOnes) : void
      {
         this.FPrerogativeOnes = param1;
      }
      
      public function get IsOpen() : uint
      {
         return this.FIsOpen;
      }
      
      public function set IsOpen(param1:uint) : void
      {
         this.FIsOpen = param1;
      }
      
      public function get AgentName() : String
      {
         return this.FAgentName;
      }
      
      public function set AgentName(param1:String) : void
      {
         this.FAgentName = param1;
      }
      
      public function get ShowActivities() : TPrerogativeOnes
      {
         return this.FShowActivities;
      }
      
      public function set ShowActivities(param1:TPrerogativeOnes) : void
      {
         this.FShowActivities = param1;
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

