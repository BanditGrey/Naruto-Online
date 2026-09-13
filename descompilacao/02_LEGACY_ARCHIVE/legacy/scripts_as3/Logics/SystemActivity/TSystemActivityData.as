package Logics.SystemActivity
{
   public class TSystemActivityData
   {
      
      protected var FIdentify:int;
      
      protected var FOrganzationName:String;
      
      protected var FPlayerNick:String;
      
      protected var FOrganzationLevel:int;
      
      protected var FOrganzationLeader:String;
      
      protected var FFamilyType:int;
      
      protected var FActivityDate:int;
      
      protected var FHurtScore:int;
      
      protected var FFightResult:int;
      
      protected var FPoint:int;
      
      protected var FRank:int;
      
      public function TSystemActivityData()
      {
         super();
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get OrganzationName() : String
      {
         return this.FOrganzationName;
      }
      
      public function set OrganzationName(param1:String) : void
      {
         this.FOrganzationName = param1;
      }
      
      public function get OrganzationLevel() : int
      {
         return this.FOrganzationLevel;
      }
      
      public function set OrganzationLevel(param1:int) : void
      {
         this.FOrganzationLevel = param1;
      }
      
      public function get OrganzationLeader() : String
      {
         return this.FOrganzationLeader;
      }
      
      public function set OrganzationLeader(param1:String) : void
      {
         this.FOrganzationLeader = param1;
      }
      
      public function get FamilyType() : int
      {
         return this.FFamilyType;
      }
      
      public function set FamilyType(param1:int) : void
      {
         this.FFamilyType = param1;
      }
      
      public function get ActivityDate() : int
      {
         return this.FActivityDate;
      }
      
      public function set ActivityDate(param1:int) : void
      {
         this.FActivityDate = param1;
      }
      
      public function get HurtScore() : int
      {
         return this.FHurtScore;
      }
      
      public function set HurtScore(param1:int) : void
      {
         this.FHurtScore = param1;
      }
      
      public function get FightResult() : int
      {
         return this.FFightResult;
      }
      
      public function set FightResult(param1:int) : void
      {
         this.FFightResult = param1;
      }
      
      public function get PlayerNick() : String
      {
         return this.FPlayerNick;
      }
      
      public function set PlayerNick(param1:String) : void
      {
         this.FPlayerNick = param1;
      }
      
      public function get Point() : int
      {
         return this.FPoint;
      }
      
      public function set Point(param1:int) : void
      {
         this.FPoint = param1;
      }
      
      public function get Rank() : int
      {
         return this.FRank;
      }
      
      public function set Rank(param1:int) : void
      {
         this.FRank = param1;
      }
   }
}

