package Logics.GroupBattle
{
   public class TShadowList
   {
      
      protected var FShadowList:Vector.<TShadowPlayer>;
      
      public function TShadowList()
      {
         super();
         this.FShadowList = new Vector.<TShadowPlayer>();
      }
      
      public function get Count() : uint
      {
         return this.FShadowList.length;
      }
      
      public function GetShadowPlayerByIndex(param1:int) : TShadowPlayer
      {
         if(param1 >= this.FShadowList.length)
         {
            return null;
         }
         return this.FShadowList[param1];
      }
      
      public function GetShadowPlayerByIdentifier(param1:uint, param2:uint) : TShadowPlayer
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TShadowPlayer = null;
         _loc4_ = this.FShadowList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FShadowList[_loc3_];
            if(_loc5_.Identifier0 == param1 && _loc5_.Identifier1 == param2)
            {
               return _loc5_;
            }
            _loc3_++;
         }
         return null;
      }
      
      protected function SortByIsOnline(param1:TShadowPlayer, param2:TShadowPlayer) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc3_ = param1.IsOnline;
         _loc4_ = param2.IsOnline;
         _loc5_ = param1.AuthorizeStatus;
         _loc6_ = param2.AuthorizeStatus;
         _loc7_ = param1.PlayerLevel;
         _loc8_ = param2.PlayerLevel;
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         if(_loc5_ > _loc6_)
         {
            return 1;
         }
         if(_loc7_ > _loc8_)
         {
            return -1;
         }
         if(_loc7_ < _loc8_)
         {
            return 1;
         }
         return 0;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TShadowPlayer = null;
         _loc1_ = int(this.FShadowList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FShadowList.pop();
            _loc2_++;
         }
         this.FShadowList.length = 0;
      }
      
      public function Add(param1:TShadowPlayer) : void
      {
         this.FShadowList.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TShadowPlayer = null;
         _loc2_ = this.FShadowList[param1];
         this.FShadowList.splice(param1,1);
      }
      
      public function Sort() : void
      {
         this.FShadowList.sort(this.SortByIsOnline);
      }
   }
}

