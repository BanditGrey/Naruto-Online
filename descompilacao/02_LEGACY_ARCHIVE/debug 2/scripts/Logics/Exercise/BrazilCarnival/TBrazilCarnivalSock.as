package Logics.Exercise.BrazilCarnival
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TBrazilCarnivalSock extends TBaseActivity
   {
      
      protected static const SWEET_COUNT:int = 6;
      
      protected static const SOCK_COUNT:int = 2;
      
      protected static const BOX_COUNT:int = 3;
      
      protected var FScore:int;
      
      protected var FExchangeHero:TBaseBox;
      
      protected var FSweetList:Vector.<TBaseBox>;
      
      protected var FSockList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TBrazilCarnivalSock()
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
      
      public function ChangeStatus() : void
      {
      }
   }
}

