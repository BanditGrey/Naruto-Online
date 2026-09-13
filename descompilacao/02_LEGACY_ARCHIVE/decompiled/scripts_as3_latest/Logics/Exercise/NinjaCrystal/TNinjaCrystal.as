package Logics.Exercise.NinjaCrystal
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TNinjaCrystal extends TBaseActivity
   {
      
      public var MyScore:int;
      
      public var GiftCount:int;
      
      public var GiftPrice:int;
      
      public var RechargeList:Vector.<TBaseBox>;
      
      public var LotteryItems:Vector.<TInventories>;
      
      public var LotteryPrice:Vector.<int>;
      
      public var Hero:TBaseBox;
      
      public function TNinjaCrystal()
      {
         super();
         this.RechargeList = new Vector.<TBaseBox>();
         this.LotteryItems = new Vector.<TInventories>();
         this.LotteryPrice = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.GiftCount > 0)
         {
            return true;
         }
         return false;
      }
      
      public function Reset() : void
      {
      }
   }
}

