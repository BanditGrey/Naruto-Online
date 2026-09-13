package Logics.Streamization.Exercise
{
   import Foundation.Streamization.TUnstreamizer;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerFirstRechargeResInfo extends TUnstreamizer
   {
      
      public var totalRcharge:int;
      
      public var startTime:int;
      
      public var endTime:int;
      
      public var lastTime:int;
      
      public var rechargePlayer:int;
      
      public var firstRechareShowStatus:int;
      
      public var firstRechareStatus:int;
      
      public var assupRechargeStatus:Vector.<int> = new Vector.<int>();
      
      public var groupRechareShowStatus:int;
      
      public var groupRechargeStauts:Vector.<int> = new Vector.<int>();
      
      public var maxGroupRechargeStatus:int;
      
      public function TUnstreamizerFirstRechargeResInfo()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.startTime = param1.readUnsignedInt();
         this.endTime = param1.readUnsignedInt();
         this.lastTime = param1.readUnsignedInt();
         this.totalRcharge = param1.readUnsignedInt();
         this.rechargePlayer = param1.readUnsignedInt();
         this.firstRechareShowStatus = param1.readUnsignedInt();
         this.groupRechareShowStatus = param1.readUnsignedInt();
         this.firstRechareStatus = param1.readUnsignedInt();
         this.maxGroupRechargeStatus = param1.readInt();
         this.assupRechargeStatus = new Vector.<int>();
         var _loc4_:int = param1.readShort();
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1.readInt();
            this.assupRechargeStatus.push(_loc5_);
            _loc6_++;
         }
         this.groupRechargeStauts = new Vector.<int>();
         _loc4_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1.readInt();
            this.groupRechargeStauts.push(_loc5_);
            _loc6_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

