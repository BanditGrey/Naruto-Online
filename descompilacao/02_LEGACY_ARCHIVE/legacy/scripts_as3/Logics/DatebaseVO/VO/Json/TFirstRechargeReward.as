package Logics.DatebaseVO.VO.Json
{
   public class TFirstRechargeReward
   {
      
      public var type:int;
      
      public var id:int;
      
      public var count:int;
      
      public function TFirstRechargeReward(param1:Object)
      {
         super();
         this.type = param1.type;
         this.id = param1.code;
         this.count = param1.amount;
      }
   }
}

