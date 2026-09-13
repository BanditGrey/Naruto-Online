package Logics.TopOrganization
{
   public class TGVG3Top32Org
   {
      
      protected var FOrgID:uint;
      
      protected var FOrgName:String;
      
      protected var FLoseCircle:uint;
      
      protected var FCircle_0:uint;
      
      protected var FCircle_1:uint;
      
      protected var FCircle_2:uint;
      
      protected var FCircle_3:uint;
      
      protected var FAgentID:uint;
      
      protected var FServerID:uint;
      
      protected var FInitPos:uint;
      
      public function TGVG3Top32Org()
      {
         super();
         this.FOrgName = "";
      }
      
      public function get OrgID() : uint
      {
         return this.FOrgID;
      }
      
      public function set OrgID(param1:uint) : void
      {
         this.FOrgID = param1;
      }
      
      public function get OrgName() : String
      {
         return this.FOrgName;
      }
      
      public function set OrgName(param1:String) : void
      {
         this.FOrgName = param1;
      }
      
      public function get LoseCircle() : uint
      {
         return this.FLoseCircle;
      }
      
      public function set LoseCircle(param1:uint) : void
      {
         this.FLoseCircle = param1;
      }
      
      public function get Circle_0() : uint
      {
         return this.FCircle_0;
      }
      
      public function set Circle_0(param1:uint) : void
      {
         this.FCircle_0 = param1;
      }
      
      public function get Circle_1() : uint
      {
         return this.FCircle_1;
      }
      
      public function set Circle_1(param1:uint) : void
      {
         this.FCircle_1 = param1;
      }
      
      public function get Circle_2() : uint
      {
         return this.FCircle_2;
      }
      
      public function set Circle_2(param1:uint) : void
      {
         this.FCircle_2 = param1;
      }
      
      public function get Circle_3() : uint
      {
         return this.FCircle_3;
      }
      
      public function set Circle_3(param1:uint) : void
      {
         this.FCircle_3 = param1;
      }
      
      public function get AgentID() : uint
      {
         return this.FAgentID;
      }
      
      public function set AgentID(param1:uint) : void
      {
         this.FAgentID = param1;
      }
      
      public function get ServerID() : uint
      {
         return this.FServerID;
      }
      
      public function set ServerID(param1:uint) : void
      {
         this.FServerID = param1;
      }
      
      public function get InitPos() : uint
      {
         return this.FInitPos;
      }
      
      public function set InitPos(param1:uint) : void
      {
         this.FInitPos = param1;
      }
   }
}

