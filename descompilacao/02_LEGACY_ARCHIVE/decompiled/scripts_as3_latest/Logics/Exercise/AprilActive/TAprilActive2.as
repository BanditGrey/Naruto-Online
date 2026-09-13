package Logics.Exercise.AprilActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   
   public class TAprilActive2 extends TBaseActivity
   {
      
      public var MyScore:int;
      
      public var FreshTime:int;
      
      public var FreshCost:int;
      
      public var AllItems:Vector.<TBaseBox>;
      
      public var SaleItems:Vector.<TBaseBox>;
      
      public var SeedList:Vector.<int>;
      
      public var ToolList:Vector.<TBaseBox>;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var Hero:TBaseBox;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public var AllLogs:Vector.<TLotteryNews>;
      
      public function TAprilActive2()
      {
         super();
         this.AllItems = new Vector.<TBaseBox>();
         this.SaleItems = new Vector.<TBaseBox>();
         this.SeedList = new Vector.<int>();
         this.ToolList = new Vector.<TBaseBox>();
         this.BoxList = new Vector.<TBaseBox>();
         this.ExchangeItems = new Vector.<TBaseBox>();
         this.AllLogs = new Vector.<TLotteryNews>();
      }
      
      public function ChangeStatus() : void
      {
         if(this.Hero.Status != TBaseActivity.STATUS_GETED && this.MyScore >= this.Hero.Price)
         {
            this.Hero.Status = TBaseActivity.STATUS_CANGET;
         }
      }
      
      public function HaveExpensive() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         var _loc5_:TBaseBox = null;
         _loc3_ = int(this.SaleItems.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_ = this.SaleItems[_loc1_];
            _loc2_ = _loc4_.Type - 1;
            _loc5_ = this.AllItems[_loc2_];
            if(_loc5_.Level == 1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

