package Logics.GroupBattle
{
   import Logics.Campaign.TMonsters;
   
   public class TMonsterInfo
   {
      
      protected var FMonsterInfo:Vector.<TMonsters>;
      
      public function TMonsterInfo()
      {
         super();
         this.FMonsterInfo = new Vector.<TMonsters>();
      }
      
      public function get Count() : uint
      {
         return this.FMonsterInfo.length;
      }
      
      public function GetMonstersByIndex(param1:int) : TMonsters
      {
         if(param1 >= this.FMonsterInfo.length)
         {
            return null;
         }
         return this.FMonsterInfo[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FMonsterInfo.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FMonsterInfo.pop();
            _loc2_++;
         }
         this.FMonsterInfo.length = 0;
      }
      
      public function Add(param1:TMonsters) : void
      {
         this.FMonsterInfo.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TMonsters = null;
         _loc2_ = this.FMonsterInfo[param1];
         this.FMonsterInfo.splice(param1,1);
      }
   }
}

