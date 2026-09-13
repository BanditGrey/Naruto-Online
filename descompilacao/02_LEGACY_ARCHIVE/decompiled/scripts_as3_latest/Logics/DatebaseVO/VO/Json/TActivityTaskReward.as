package Logics.DatebaseVO.VO.Json
{
   public class TActivityTaskReward
   {
      
      protected var FRewards:Vector.<TTaskReward>;
      
      public function TActivityTaskReward(param1:Array)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TTaskReward = null;
         super();
         _loc3_ = int(param1.length);
         this.FRewards = new Vector.<TTaskReward>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TTaskReward(param1[_loc2_]);
            this.FRewards[_loc2_] = _loc4_;
            _loc2_++;
         }
      }
      
      public function get Rewards() : Vector.<TTaskReward>
      {
         return this.FRewards;
      }
      
      public function set Rewards(param1:Vector.<TTaskReward>) : void
      {
         this.FRewards = param1;
      }
   }
}

