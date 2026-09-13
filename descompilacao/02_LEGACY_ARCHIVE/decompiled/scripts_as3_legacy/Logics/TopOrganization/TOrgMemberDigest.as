package Logics.TopOrganization
{
   import Logics.Characters.TDigest;
   
   public class TOrgMemberDigest extends TDigest
   {
      
      protected var FTemplateID:uint;
      
      protected var FIsThreeWins:uint;
      
      protected var FIsDead:uint;
      
      protected var FSortIndex:int;
      
      protected var FLeftHP:uint;
      
      public function TOrgMemberDigest(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get TemplateID() : uint
      {
         return this.FTemplateID;
      }
      
      public function set TemplateID(param1:uint) : void
      {
         this.FTemplateID = param1;
      }
      
      public function get IsThreeWins() : uint
      {
         return this.FIsThreeWins;
      }
      
      public function set IsThreeWins(param1:uint) : void
      {
         this.FIsThreeWins = param1;
      }
      
      public function get SortIndex() : int
      {
         return this.FSortIndex;
      }
      
      public function set SortIndex(param1:int) : void
      {
         this.FSortIndex = param1;
      }
      
      public function get IsDead() : uint
      {
         return this.FIsDead;
      }
      
      public function set IsDead(param1:uint) : void
      {
         this.FIsDead = param1;
      }
      
      public function get LeftHP() : uint
      {
         return this.FLeftHP;
      }
      
      public function set LeftHP(param1:uint) : void
      {
         this.FLeftHP = param1;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FIsThreeWins = 0;
      }
   }
}

