package Logics.TopOrganization
{
   public class TStatusJoinMembers
   {
      
      protected var FStatusJoinMembers:Vector.<TStatusJoinMember>;
      
      public function TStatusJoinMembers()
      {
         super();
         this.FStatusJoinMembers = new Vector.<TStatusJoinMember>();
      }
      
      public function get Count() : uint
      {
         return this.FStatusJoinMembers.length;
      }
      
      public function Add(param1:TStatusJoinMember) : void
      {
         this.FStatusJoinMembers.push(param1);
      }
      
      public function GetStatusJoinMemberByIndex(param1:int) : TStatusJoinMember
      {
         if(param1 >= this.FStatusJoinMembers.length)
         {
            return null;
         }
         return this.FStatusJoinMembers[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FStatusJoinMembers.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FStatusJoinMembers.pop();
            _loc2_++;
         }
         this.FStatusJoinMembers.length = 0;
      }
   }
}

