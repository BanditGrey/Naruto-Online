package Logics.Palace
{
   import Resources.Constants.CONST_PALACE;
   
   public class TTargetFighters
   {
      
      protected var FRoleCurrentRank:uint;
      
      protected var FTargetFighters:Vector.<TTargetFighter>;
      
      public function TTargetFighters()
      {
         super();
         this.FTargetFighters = new Vector.<TTargetFighter>(CONST_PALACE.CAPACITY_AllPlayers);
      }
      
      public function get Count() : uint
      {
         return this.FTargetFighters.length;
      }
      
      public function GetTargetFighterByIndex(param1:int) : TTargetFighter
      {
         return this.FTargetFighters[param1];
      }
      
      public function get RoleCurrentRank() : uint
      {
         return this.FRoleCurrentRank;
      }
      
      public function set RoleCurrentRank(param1:uint) : void
      {
         this.FRoleCurrentRank = param1;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TTargetFighter = null;
         _loc1_ = int(this.FTargetFighters.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FTargetFighters.pop();
            _loc2_++;
         }
         this.FTargetFighters.length = 0;
      }
      
      public function AddByIndex(param1:int, param2:TTargetFighter) : void
      {
         this.FTargetFighters[param1] = param2;
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TTargetFighter = null;
         _loc2_ = this.FTargetFighters[param1];
         this.FTargetFighters.splice(param1,1);
      }
   }
}

