package Logics.Undertown
{
   public class TDailyTaskRewardCopy
   {
      
      protected var FType:uint;
      
      protected var FCode:uint;
      
      protected var FAmount:uint;
      
      public function TDailyTaskRewardCopy()
      {
         super();
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get Code() : uint
      {
         return this.FCode;
      }
      
      public function set Code(param1:uint) : void
      {
         this.FCode = param1;
      }
      
      public function get Amount() : uint
      {
         return this.FAmount;
      }
      
      public function set Amount(param1:uint) : void
      {
         this.FAmount = param1;
      }
   }
}

