package Logics.GroupBattle
{
   public class TGroupBattleLevels
   {
      
      protected var FGroupBattleLevels:Vector.<TGroupBattleLevel>;
      
      public function TGroupBattleLevels()
      {
         super();
         this.FGroupBattleLevels = new Vector.<TGroupBattleLevel>();
      }
      
      protected function SortByIndex(param1:TGroupBattleLevel, param2:TGroupBattleLevel) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         _loc3_ = param1.SortIndex;
         _loc4_ = param2.SortIndex;
         _loc5_ = param1.IsOpenLevel;
         _loc6_ = param2.IsOpenLevel;
         if(_loc5_ && _loc6_)
         {
            if(_loc3_ > _loc4_)
            {
               return -1;
            }
            if(_loc3_ < _loc4_)
            {
               return 1;
            }
         }
         else if(!_loc5_ && !_loc6_)
         {
            if(_loc3_ < _loc4_)
            {
               return -1;
            }
            if(_loc3_ > _loc4_)
            {
               return 1;
            }
         }
         else
         {
            if(_loc5_ && !_loc6_)
            {
               return -1;
            }
            if(!_loc5_ && _loc6_)
            {
               return 1;
            }
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FGroupBattleLevels.length;
      }
      
      public function GetGroupBattleLevelByIndex(param1:int) : TGroupBattleLevel
      {
         if(param1 >= this.FGroupBattleLevels.length)
         {
            return null;
         }
         return this.FGroupBattleLevels[param1];
      }
      
      public function FilterCommon() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:TGroupBattleLevel = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FGroupBattleLevels.length)
         {
            _loc3_ = this.FGroupBattleLevels[_loc1_];
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < this.FGroupBattleLevels.length)
            {
               _loc4_ = this.FGroupBattleLevels[_loc2_];
               if(uint(_loc3_.LevelID / 10) == uint(_loc4_.LevelID / 10))
               {
                  _loc5_ = _loc3_.LevelID;
                  _loc6_ = _loc4_.LevelID;
                  _loc7_ = Math.min(_loc5_,_loc6_);
                  if(_loc3_.LevelID == _loc7_)
                  {
                     this.FGroupBattleLevels.splice(_loc1_,1);
                  }
                  else if(_loc4_.LevelID == _loc7_)
                  {
                     this.FGroupBattleLevels.splice(_loc2_,1);
                  }
                  _loc1_ = -1;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TGroupBattleLevel = null;
         _loc1_ = int(this.FGroupBattleLevels.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGroupBattleLevels.pop();
            _loc2_++;
         }
         this.FGroupBattleLevels.length = 0;
      }
      
      public function Add(param1:TGroupBattleLevel) : void
      {
         this.FGroupBattleLevels.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TGroupBattleLevel = null;
         _loc2_ = this.FGroupBattleLevels[param1];
         this.FGroupBattleLevels.splice(param1,1);
      }
      
      public function Sort() : void
      {
         this.FGroupBattleLevels.sort(this.SortByIndex);
      }
   }
}

