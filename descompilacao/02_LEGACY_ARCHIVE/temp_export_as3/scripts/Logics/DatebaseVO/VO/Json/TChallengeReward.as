package Logics.DatebaseVO.VO.Json
{
   public class TChallengeReward
   {
      
      protected var FType:uint;
      
      protected var FCode:uint;
      
      protected var FMin:uint;
      
      protected var FMax:uint;
      
      public function TChallengeReward(param1:Object)
      {
         super();
         this.FType = param1.type;
         this.FCode = param1.code;
         this.FMin = param1.min;
         this.FMax = param1.max;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get Code() : uint
      {
         return this.FCode;
      }
      
      public function get Min() : uint
      {
         return this.FMin;
      }
      
      public function get Max() : uint
      {
         return this.FMax;
      }
   }
}

