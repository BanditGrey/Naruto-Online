package Logics.Streamization.Campaign
{
   import Logics.Campaign.TMonster;
   import Logics.Campaign.TNodalAutoMonsterInfo;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerOpenAuto extends TUnstreamizerCampaignUnknown
   {
      
      public function TUnstreamizerOpenAuto()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Vector.<TMonster> = null;
         var _loc6_:TMonster = null;
         var _loc7_:TNodalAutoMonsterInfo = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc7_ = param2 as TNodalAutoMonsterInfo;
         _loc7_.CostTime = param1.readByte() * 60;
         _loc7_.CurAutoMissionId = param1.readInt();
         _loc7_.HootMonster.length = 0;
         _loc8_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc8_)
         {
            _loc9_ = uint(param1.readInt());
            _loc6_ = FPoolCampaign.AcquireMonster(_loc9_);
            _loc6_.MonsterLevel = param1.readShort();
            _loc6_.MonsterCount = param1.readByte();
            _loc5_.push(_loc6_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

