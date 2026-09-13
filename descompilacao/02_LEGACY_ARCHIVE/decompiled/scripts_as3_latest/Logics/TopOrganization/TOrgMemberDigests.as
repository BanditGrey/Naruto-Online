package Logics.TopOrganization
{
   public class TOrgMemberDigests
   {
      
      protected var FOrgMemberDigests:Vector.<TOrgMemberDigest>;
      
      public function TOrgMemberDigests()
      {
         super();
         this.FOrgMemberDigests = new Vector.<TOrgMemberDigest>();
      }
      
      protected function SortByIsDead(param1:TOrgMemberDigest, param2:TOrgMemberDigest) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc5_ = param1.IsThreeWins;
         _loc6_ = param2.IsThreeWins;
         if(_loc5_ > _loc6_)
         {
            return 1;
         }
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         _loc3_ = param1.IsDead;
         _loc4_ = param2.IsDead;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         _loc7_ = uint(param1.SortIndex);
         _loc8_ = uint(param2.SortIndex);
         if(_loc7_ > _loc8_)
         {
            return 1;
         }
         if(_loc7_ < _loc8_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FOrgMemberDigests.length;
      }
      
      public function GetOrgMemberDigestByIndex(param1:int) : TOrgMemberDigest
      {
         if(param1 < 0 || param1 >= this.FOrgMemberDigests.length)
         {
            return null;
         }
         return this.FOrgMemberDigests[param1];
      }
      
      public function GetOrgMemberDigestByIdentifier(param1:uint, param2:uint) : TOrgMemberDigest
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.Count)
         {
            if(this.FOrgMemberDigests[_loc3_].Identifier0 == param1 && this.FOrgMemberDigests[_loc3_].Identifier1 == param2)
            {
               return this.FOrgMemberDigests[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TOrgMemberDigest = null;
         _loc1_ = int(this.FOrgMemberDigests.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FOrgMemberDigests[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FOrgMemberDigests.length = 0;
      }
      
      public function Add(param1:TOrgMemberDigest) : void
      {
         param1.StubReferences.Reference(this);
         this.FOrgMemberDigests.push(param1);
      }
      
      public function Delete(param1:TOrgMemberDigest) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FOrgMemberDigests.length)
         {
            if(param1.Identifier0 == this.FOrgMemberDigests[_loc2_].Identifier0 && param1.Identifier1 == this.FOrgMemberDigests[_loc2_].Identifier1)
            {
               param1.StubReferences.Dereference(this);
               this.FOrgMemberDigests.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function ShiftOrgMemberDigest() : TOrgMemberDigest
      {
         var _loc1_:TOrgMemberDigest = null;
         return this.FOrgMemberDigests.shift();
      }
      
      public function Sort() : void
      {
         this.FOrgMemberDigests.sort(this.SortByIsDead);
      }
   }
}

