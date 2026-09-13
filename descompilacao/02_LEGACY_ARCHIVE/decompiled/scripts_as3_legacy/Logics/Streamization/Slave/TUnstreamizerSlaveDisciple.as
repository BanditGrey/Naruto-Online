package Logics.Streamization.Slave
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Slave.TSlaveDisciple;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSlaveDisciple extends TUnstreamizer
   {
      
      public function TUnstreamizerSlaveDisciple()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TSlaveDisciple = null;
         _loc4_ = param2 as TSlaveDisciple;
         _loc4_.DiscipleID0 = param1.readUnsignedInt();
         _loc4_.DiscipleID1 = param1.readUnsignedInt();
         _loc4_.DiscipleName = TUtilityString.FetchUTF(param1);
         _loc4_.DiscipleLevel = param1.readUnsignedInt();
         _loc4_.DiscipleHeroID = param1.readUnsignedInt();
         _loc4_.DiscipleGuildName = TUtilityString.FetchUTF(param1);
         _loc4_.InteractionCDTime = param1.readUnsignedInt();
         _loc4_.StartWorkTime = param1.readUnsignedInt();
         _loc4_.DrawTime = param1.readUnsignedInt();
         _loc4_.AddUpExp = param1.readUnsignedInt();
         _loc4_.Rank = param1.readUnsignedInt();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

