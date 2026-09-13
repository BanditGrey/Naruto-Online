package Logics.Characters.MoveRole
{
   public class TRoleNpc extends TRole
   {
      
      protected var FUserType:int;
      
      protected var FNormalTalkText:String;
      
      protected var FNpcTitle:String;
      
      protected var FNpcCityid:int;
      
      protected var FNpcUserType:int;
      
      protected var FNpcStartTime:int;
      
      protected var FNpcEndTime:int;
      
      public function TRoleNpc(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get UserType() : int
      {
         return this.FUserType;
      }
      
      public function set UserType(param1:int) : void
      {
         this.FUserType = param1;
      }
      
      public function get NormalTalkText() : String
      {
         return this.FNormalTalkText;
      }
      
      public function set NormalTalkText(param1:String) : void
      {
         this.FNormalTalkText = param1;
      }
      
      public function get NpcTitle() : String
      {
         return this.FNpcTitle;
      }
      
      public function set NpcTitle(param1:String) : void
      {
         this.FNpcTitle = param1;
      }
      
      public function get NpcCityid() : int
      {
         return this.FNpcCityid;
      }
      
      public function set NpcCityid(param1:int) : void
      {
         this.FNpcCityid = param1;
      }
      
      public function get NpcUserType() : int
      {
         return this.FNpcUserType;
      }
      
      public function set NpcUserType(param1:int) : void
      {
         this.FNpcUserType = param1;
      }
      
      public function get NpcStartTime() : int
      {
         return this.FNpcStartTime;
      }
      
      public function set NpcStartTime(param1:int) : void
      {
         this.FNpcStartTime = param1;
      }
      
      public function get NpcEndTime() : int
      {
         return this.FNpcEndTime;
      }
      
      public function set NpcEndTime(param1:int) : void
      {
         this.FNpcEndTime = param1;
      }
   }
}

