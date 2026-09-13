package Logics.Ramn
{
   public class TRamenData
   {
      
      protected var FSelfRamenLevel:uint;
      
      protected var FSelfRamenCurrentExp:uint;
      
      protected var FSelfRamenSendGoodsCount:uint;
      
      protected var FSelfRamenRewardCount:uint;
      
      protected var FSelfRamenSendCount:uint;
      
      protected var FSelfRamenSendCD:uint;
      
      protected var FFriendsRamen:Vector.<TFriendRamenData>;
      
      public function TRamenData()
      {
         super();
         this.FSelfRamenLevel = 1;
         this.FFriendsRamen = new Vector.<TFriendRamenData>();
      }
      
      public function get FriendsRamen() : Vector.<TFriendRamenData>
      {
         return this.FFriendsRamen;
      }
      
      public function get FriendCount() : int
      {
         return this.FFriendsRamen.length;
      }
      
      public function get SelfRamenLevel() : uint
      {
         return this.FSelfRamenLevel;
      }
      
      public function set SelfRamenLevel(param1:uint) : void
      {
         this.FSelfRamenLevel = param1;
      }
      
      public function get SelfRamenCurrentExp() : uint
      {
         return this.FSelfRamenCurrentExp;
      }
      
      public function set SelfRamenCurrentExp(param1:uint) : void
      {
         this.FSelfRamenCurrentExp = param1;
      }
      
      public function get SelfRamenSendGoodsCount() : uint
      {
         return this.FSelfRamenSendGoodsCount;
      }
      
      public function set SelfRamenSendGoodsCount(param1:uint) : void
      {
         this.FSelfRamenSendGoodsCount = param1;
      }
      
      public function get SelfRamenRewardCount() : uint
      {
         return this.FSelfRamenRewardCount;
      }
      
      public function set SelfRamenRewardCount(param1:uint) : void
      {
         this.FSelfRamenRewardCount = param1;
      }
      
      public function get SelfRamenSendCount() : uint
      {
         return this.FSelfRamenSendCount;
      }
      
      public function set SelfRamenSendCount(param1:uint) : void
      {
         this.FSelfRamenSendCount = param1;
      }
      
      public function get SelfRamenSendCD() : uint
      {
         return this.FSelfRamenSendCD;
      }
      
      public function set SelfRamenSendCD(param1:uint) : void
      {
         this.FSelfRamenSendCD = param1;
      }
      
      public function get CanSendGoodsCount() : uint
      {
         return Math.max(this.FSelfRamenSendCount - this.FSelfRamenSendGoodsCount,0);
      }
      
      public function GetFriendByIndex(param1:int) : TFriendRamenData
      {
         return this.FFriendsRamen[param1];
      }
      
      public function GetFriendById(param1:uint, param2:uint) : TFriendRamenData
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TFriendRamenData = null;
         _loc3_ = int(this.FFriendsRamen.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FFriendsRamen[_loc4_];
            if(_loc5_.Identifier0 == param1 && _loc5_.Identifier1 == param2)
            {
               break;
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function ClearFriend() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFriendRamenData = null;
         _loc1_ = int(this.FFriendsRamen.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FFriendsRamen[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FFriendsRamen.length = 0;
      }
      
      public function AddFriend(param1:TFriendRamenData) : void
      {
         param1.StubReferences.Reference(this);
         this.FFriendsRamen.push(param1);
      }
   }
}

