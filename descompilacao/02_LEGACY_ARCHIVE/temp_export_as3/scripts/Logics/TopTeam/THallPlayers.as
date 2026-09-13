package Logics.TopTeam
{
   public class THallPlayers
   {
      
      protected var FHallPlayers:Vector.<THallPlayer>;
      
      public function THallPlayers()
      {
         super();
         this.FHallPlayers = new Vector.<THallPlayer>();
      }
      
      protected function SortByEnterTime(param1:THallPlayer, param2:THallPlayer) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.EnterTime;
         _loc4_ = param2.EnterTime;
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : uint
      {
         return this.FHallPlayers.length;
      }
      
      public function Add(param1:THallPlayer) : void
      {
         param1.StubReferences.Reference(this);
         this.FHallPlayers.push(param1);
      }
      
      public function GetHallPlayerByIndex(param1:int) : THallPlayer
      {
         if(param1 < 0 || param1 >= this.FHallPlayers.length)
         {
            return null;
         }
         return this.FHallPlayers[param1];
      }
      
      public function GetHallPlayerByIdentifier(param1:uint, param2:uint) : THallPlayer
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:THallPlayer = null;
         _loc3_ = int(this.FHallPlayers.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FHallPlayers[_loc4_];
            if(_loc5_.Identifier0 == param1 && _loc5_.Identifier1 == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function Delete(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:THallPlayer = null;
         _loc3_ = 0;
         while(_loc3_ < this.FHallPlayers.length)
         {
            _loc4_ = this.FHallPlayers[_loc3_];
            if(param1 == _loc4_.Identifier0 && param2 == _loc4_.Identifier1)
            {
               _loc4_.StubReferences.Dereference(this);
               this.FHallPlayers.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THallPlayer = null;
         _loc1_ = int(this.FHallPlayers.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FHallPlayers[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FHallPlayers.length = 0;
      }
      
      public function Sort() : void
      {
         this.FHallPlayers.sort(this.SortByEnterTime);
      }
   }
}

