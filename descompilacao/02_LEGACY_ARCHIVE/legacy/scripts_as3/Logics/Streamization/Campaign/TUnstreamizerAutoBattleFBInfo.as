package Logics.Streamization.Campaign
{
   import Logics.Campaign.TNodalAutoBattleFBInfo;
   import Logics.Items.TItems;
   import Logics.Streamization.Items.TUnstreamizerRewards;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerAutoBattleFBInfo extends TUnstreamizerCampaignUnknown
   {
      
      private var UnstreamizerRewards:TUnstreamizerRewards;
      
      public function TUnstreamizerAutoBattleFBInfo()
      {
         super();
         this.UnstreamizerRewards = new TUnstreamizerRewards();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TItems = null;
         var _loc6_:TNodalAutoBattleFBInfo = null;
         var _loc7_:uint = 0;
         _loc6_ = param2 as TNodalAutoBattleFBInfo;
         _loc6_.CostTimer = param1.readInt();
         _loc6_.Star = param1.readByte();
         _loc6_.BattleID = param1.readInt();
         _loc6_.TotleCount = param1.readByte();
         _loc6_.CurCount = param1.readByte();
         _loc7_ = uint(param1.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc5_ = new TItems();
            this.UnstreamizerRewards.Unstreamize(param1,_loc5_,param3);
            _loc6_.BattleResult.push(_loc5_);
            _loc4_++;
         }
         this.UnstreamizerRewards.Unstreamize(param1,_loc6_.PassResult,param3);
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

