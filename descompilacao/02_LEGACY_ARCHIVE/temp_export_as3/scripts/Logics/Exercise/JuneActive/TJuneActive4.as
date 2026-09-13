package Logics.Exercise.JuneActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TJuneActive4 extends TBaseActivity
   {
      
      protected static const SWEET_COUNT:int = 6;
      
      protected static const SOCK_COUNT:int = 8;
      
      protected static const BOX_COUNT:int = 6;
      
      protected var FScore:int;
      
      protected var FExchangeHero:TBaseBox;
      
      protected var FTotalCount:int;
      
      protected var FSweetList:Vector.<TBaseBox>;
      
      protected var FSockList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TJuneActive4()
      {
         super();
         this.FSweetList = new Vector.<TBaseBox>();
         this.FSockList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get SweetList() : Vector.<TBaseBox>
      {
         return this.FSweetList;
      }
      
      public function set SweetList(param1:Vector.<TBaseBox>) : void
      {
         this.FSweetList = param1;
      }
      
      public function get SockList() : Vector.<TBaseBox>
      {
         return this.FSockList;
      }
      
      public function set SockList(param1:Vector.<TBaseBox>) : void
      {
         this.FSockList = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get ExchangeHero() : TBaseBox
      {
         return this.FExchangeHero;
      }
      
      public function set ExchangeHero(param1:TBaseBox) : void
      {
         this.FExchangeHero = param1;
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FTotalCount >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

