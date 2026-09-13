package Logics.Characters
{
   public class TGameNpc
   {
      
      protected var FID:int;
      
      protected var FName:String;
      
      protected var FNpcTitle:String;
      
      protected var FTalk:String;
      
      protected var FStartTime:int;
      
      protected var FEndTime:int;
      
      protected var FCityid:int;
      
      protected var FUserType:int;
      
      protected var FX:int;
      
      protected var FY:int;
      
      protected var FModel:uint;
      
      protected var FRoleStyle:uint;
      
      protected var FRoleHead:uint;
      
      public function TGameNpc()
      {
         super();
      }
      
      public function get ID() : int
      {
         return this.FID;
      }
      
      public function set ID(param1:int) : void
      {
         this.FID = param1;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set NpcTitle(param1:String) : void
      {
         this.FNpcTitle = param1;
      }
      
      public function get NpcTitle() : String
      {
         return this.FNpcTitle;
      }
      
      public function set Talk(param1:String) : void
      {
         this.FTalk = param1;
      }
      
      public function get Talk() : String
      {
         return this.FTalk;
      }
      
      public function set StartTime(param1:int) : void
      {
         this.FStartTime = param1;
      }
      
      public function get StartTime() : int
      {
         return this.FStartTime;
      }
      
      public function set EndTime(param1:int) : void
      {
         this.FEndTime = param1;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function set Cityid(param1:int) : void
      {
         this.FCityid = param1;
      }
      
      public function get Cityid() : int
      {
         return this.FCityid;
      }
      
      public function set UserType(param1:int) : void
      {
         this.FUserType = param1;
      }
      
      public function get UserType() : int
      {
         return this.FUserType;
      }
      
      public function set X(param1:int) : void
      {
         this.FX = param1;
      }
      
      public function get X() : int
      {
         return this.FX;
      }
      
      public function set Y(param1:int) : void
      {
         this.FY = param1;
      }
      
      public function get Y() : int
      {
         return this.FY;
      }
      
      public function set Model(param1:uint) : void
      {
         this.FModel = param1;
      }
      
      public function get Model() : uint
      {
         return this.FModel;
      }
      
      public function set RoleStyle(param1:uint) : void
      {
         this.FRoleStyle = param1;
      }
      
      public function get RoleStyle() : uint
      {
         return this.FRoleStyle;
      }
      
      public function set RoleHead(param1:uint) : void
      {
         this.FRoleHead = param1;
      }
      
      public function get RoleHead() : uint
      {
         return this.FRoleHead;
      }
   }
}

