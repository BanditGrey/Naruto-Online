package Logics.Campaign
{
   public class TMonsters
   {
      
      protected var FMonsters:Vector.<TMonster>;
      
      public function TMonsters()
      {
         super();
         this.FMonsters = new Vector.<TMonster>();
      }
      
      public function get Count() : int
      {
         return this.FMonsters.length;
      }
      
      public function GetMonsterByIndex(param1:int) : TMonster
      {
         return this.FMonsters[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TMonster = null;
         _loc1_ = int(this.FMonsters.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FMonsters[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FMonsters.length = 0;
      }
      
      public function Add(param1:TMonster) : void
      {
         param1.StubReferences.Reference(this);
         this.FMonsters.push(param1);
      }
      
      public function sort(param1:Function) : void
      {
         this.FMonsters.sort(param1);
      }
   }
}

