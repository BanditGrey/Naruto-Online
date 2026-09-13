package Logics.Streamization.Ramen
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Ramn.TFriendRamenData;
   import Logics.Ramn.TPoolFriendRamen;
   import Logics.Ramn.TRamenData;
   import Logics.Spaces.LogicsSpace;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerRamen extends TUnstreamizer
   {
      
      protected static var FPoolFriendRamen:TPoolFriendRamen;
      
      public function TUnstreamizerRamen()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolFriendRamen) : void
      {
         FPoolFriendRamen = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TRamenData = null;
         _loc4_ = param2 as TRamenData;
         _loc4_.SelfRamenLevel = param1.readUnsignedInt();
         _loc4_.SelfRamenCurrentExp = param1.readUnsignedInt();
         _loc4_.SelfRamenSendGoodsCount = param1.readUnsignedInt();
         _loc4_.SelfRamenRewardCount = param1.readUnsignedInt();
         _loc4_.SelfRamenSendCD = param1.readUnsignedInt();
         this.UnstreamizationFriendRamen(param1,param2,param3);
      }
      
      protected function UnstreamizationFriendRamen(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TRamenData = null;
         var _loc7_:TFriendRamenData = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc6_ = param2 as TRamenData;
         _loc6_.ClearFriend();
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc7_ = FPoolFriendRamen.AcquireFriendRamen(_loc8_,_loc9_);
            _loc6_.AddFriend(_loc7_);
            _loc7_.FriendRamenSendGoodsCount = param1.readUnsignedInt();
            _loc7_.FriendRamenLevel = param1.readUnsignedInt();
            _loc7_.FriendRamenCurrentExp = param1.readUnsignedInt();
            _loc4_++;
         }
      }
      
      protected function Unstreamization_SendGoodsSelfRamen(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TRamenData = null;
         var _loc7_:TFriendRamenData = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc6_ = param2 as TRamenData;
         _loc5_ = param1.readUnsignedShort();
         _loc8_ = param1.readUnsignedInt();
         _loc9_ = param1.readUnsignedInt();
         _loc6_.SelfRamenSendGoodsCount = param1.readUnsignedInt();
         _loc6_.SelfRamenLevel = param1.readUnsignedInt();
         _loc6_.SelfRamenCurrentExp = param1.readUnsignedInt();
      }
      
      protected function Unstreamization_SendGoodsFriendRamen(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TRamenData = null;
         var _loc7_:TFriendRamenData = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc6_ = param2 as TRamenData;
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc7_ = _loc6_.GetFriendById(_loc8_,_loc9_);
            _loc7_.FriendRamenSendGoodsCount = param1.readUnsignedInt();
            _loc7_.FriendRamenLevel = param1.readUnsignedInt();
            _loc7_.FriendRamenCurrentExp = param1.readUnsignedInt();
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeSelfRamen(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamization_SendGoodsSelfRamen(param1,param2,param3);
      }
      
      public function UnstreamizeFriendRamen(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamization_SendGoodsFriendRamen(param1,param2,param3);
      }
   }
}

