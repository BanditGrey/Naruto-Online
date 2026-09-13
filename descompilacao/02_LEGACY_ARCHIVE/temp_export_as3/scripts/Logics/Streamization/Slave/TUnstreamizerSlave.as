package Logics.Streamization.Slave
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Slave.TSlave;
   import Logics.Slave.TSlaveDisciple;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSlave extends TUnstreamizer
   {
      
      protected var FUnstreamizerDisciple:TUnstreamizerSlaveDisciple;
      
      public function TUnstreamizerSlave()
      {
         super();
         this.FUnstreamizerDisciple = new TUnstreamizerSlaveDisciple();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TSlave = null;
         var _loc7_:TSlaveDisciple = null;
         _loc6_ = param2 as TSlave;
         _loc5_ = _loc6_.DiscipleList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_.DiscipleList.pop();
            _loc4_++;
         }
         _loc6_.Identity = param1.readUnsignedByte();
         _loc6_.TodayArrestCount = param1.readUnsignedInt();
         _loc6_.TodayRescueCount = param1.readUnsignedInt();
         _loc6_.TodayGetExp = param1.readUnsignedInt();
         _loc6_.TodayInteractionCount = param1.readUnsignedInt();
         _loc6_.TodaySOSCount = param1.readUnsignedInt();
         _loc6_.TodayResistCount = param1.readUnsignedInt();
         _loc6_.MasterID0 = param1.readUnsignedInt();
         _loc6_.MasterID1 = param1.readUnsignedInt();
         _loc6_.MasterName = TUtilityString.FetchUTF(param1);
         _loc6_.MasterLevel = param1.readUnsignedInt();
         _loc6_.MasterHeroID = param1.readUnsignedInt();
         _loc6_.MasterGuildName = TUtilityString.FetchUTF(param1);
         _loc6_.InteractionCDTime = param1.readUnsignedInt();
         _loc5_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TSlaveDisciple();
            this.FUnstreamizerDisciple.Unstreamize(param1,_loc7_,null);
            _loc6_.DiscipleList[_loc4_] = _loc7_;
            _loc4_++;
         }
         _loc6_.StartWorkTime = param1.readUnsignedInt();
         _loc6_.TodayBuyCount = param1.readUnsignedInt();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

