package Logics.NinjaRelation
{
   import Logics.Characters.THeros;
   
   public class TNinjaGroupBuff
   {
      
      protected var FTeamID:uint;
      
      protected var FIsActivited:Boolean;
      
      protected var FCurStartExpricence:uint;
      
      protected var FCurExpricence:uint;
      
      protected var FNextExpricence:uint;
      
      protected var FFriendLevel:uint;
      
      protected var FGroupName:String;
      
      protected var FCurrentBuffDesc:String;
      
      protected var FAdvancedBuffDesc:String;
      
      protected var FHeros:THeros;
      
      protected var FIsMistery:Boolean;
      
      protected var FConfigId:uint;
      
      protected var FShenMiIsActivited:Boolean;
      
      public function TNinjaGroupBuff()
      {
         super();
         this.FTeamID = 0;
         this.FIsActivited = false;
         this.FFriendLevel = 0;
         this.FCurStartExpricence = 0;
         this.FCurExpricence = 0;
         this.FNextExpricence = 0;
         this.FGroupName = "";
         this.FCurrentBuffDesc = "";
         this.FAdvancedBuffDesc = "";
         this.FIsMistery = false;
         this.FHeros = new THeros();
      }
      
      public function get IsActivited() : Boolean
      {
         return this.FIsActivited;
      }
      
      public function set IsActivited(param1:Boolean) : void
      {
         this.FIsActivited = param1;
      }
      
      public function get FriendLevel() : uint
      {
         return this.FFriendLevel;
      }
      
      public function set FriendLevel(param1:uint) : void
      {
         this.FFriendLevel = param1;
      }
      
      public function get GroupName() : String
      {
         return this.FGroupName;
      }
      
      public function set GroupName(param1:String) : void
      {
         this.FGroupName = param1;
      }
      
      public function get CurrentBuffDesc() : String
      {
         return this.FCurrentBuffDesc;
      }
      
      public function set CurrentBuffDesc(param1:String) : void
      {
         this.FCurrentBuffDesc = param1;
      }
      
      public function get AdvancedBuffDesc() : String
      {
         return this.FAdvancedBuffDesc;
      }
      
      public function set AdvancedBuffDesc(param1:String) : void
      {
         this.FAdvancedBuffDesc = param1;
      }
      
      public function get CurExpricence() : uint
      {
         return this.FCurExpricence;
      }
      
      public function set CurExpricence(param1:uint) : void
      {
         this.FCurExpricence = param1;
      }
      
      public function get TeamID() : uint
      {
         return this.FTeamID;
      }
      
      public function set TeamID(param1:uint) : void
      {
         this.FTeamID = param1;
      }
      
      public function get Heros() : THeros
      {
         return this.FHeros;
      }
      
      public function set Heros(param1:THeros) : void
      {
         this.FHeros = param1;
      }
      
      public function get NextExpricence() : uint
      {
         return this.FNextExpricence;
      }
      
      public function set NextExpricence(param1:uint) : void
      {
         this.FNextExpricence = param1;
      }
      
      public function get IsMistery() : Boolean
      {
         return this.FIsMistery;
      }
      
      public function set IsMistery(param1:Boolean) : void
      {
         this.FIsMistery = param1;
      }
      
      public function set ConfigId(param1:uint) : void
      {
         this.FConfigId = param1;
      }
      
      public function get ConfigId() : uint
      {
         return this.FConfigId;
      }
      
      public function get CurStartExpricence() : uint
      {
         return this.FCurStartExpricence;
      }
      
      public function set CurStartExpricence(param1:uint) : void
      {
         this.FCurStartExpricence = param1;
      }
      
      public function set ShenMiIsActivited(param1:Boolean) : void
      {
         this.FShenMiIsActivited = param1;
      }
      
      public function get ShenMiIsActivited() : Boolean
      {
         return this.FShenMiIsActivited;
      }
   }
}

