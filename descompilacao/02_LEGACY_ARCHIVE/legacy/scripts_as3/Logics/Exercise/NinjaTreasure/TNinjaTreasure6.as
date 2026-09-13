package Logics.Exercise.NinjaTreasure
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TNinjaTreasure6 extends TBaseActivity
   {
      
      protected var FScore:int;
      
      protected var FCount:int;
      
      protected var FTenPrice:int;
      
      protected var FSweetList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FHeroList:Vector.<TBaseBox>;
      
      protected var FStatusList:Vector.<int>;
      
      protected var FIndexList:Vector.<int>;
      
      protected var FAmount1List:Vector.<int>;
      
      protected var FAmount2List:Vector.<int>;
      
      public function TNinjaTreasure6()
      {
         super();
         this.FSweetList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FHeroList = new Vector.<TBaseBox>();
         this.FStatusList = new Vector.<int>();
         this.FIndexList = new Vector.<int>();
         this.FAmount1List = new Vector.<int>();
         this.FAmount2List = new Vector.<int>();
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
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get HeroList() : Vector.<TBaseBox>
      {
         return this.FHeroList;
      }
      
      public function set HeroList(param1:Vector.<TBaseBox>) : void
      {
         this.FHeroList = param1;
      }
      
      public function get TenPrice() : int
      {
         return this.FTenPrice;
      }
      
      public function set TenPrice(param1:int) : void
      {
         this.FTenPrice = param1;
      }
      
      public function get StatusList() : Vector.<int>
      {
         return this.FStatusList;
      }
      
      public function set StatusList(param1:Vector.<int>) : void
      {
         this.FStatusList = param1;
      }
      
      public function get IndexList() : Vector.<int>
      {
         return this.FIndexList;
      }
      
      public function set IndexList(param1:Vector.<int>) : void
      {
         this.FIndexList = param1;
      }
      
      public function get Amount1List() : Vector.<int>
      {
         return this.FAmount1List;
      }
      
      public function set Amount1List(param1:Vector.<int>) : void
      {
         this.FAmount1List = param1;
      }
      
      public function get Amount2List() : Vector.<int>
      {
         return this.FAmount2List;
      }
      
      public function set Amount2List(param1:Vector.<int>) : void
      {
         this.FAmount2List = param1;
      }
      
      public function ChangeStatus() : void
      {
         if(this.FHeroList[0].Status == TBaseActivity.STATUS_CANNOTGET && this.FScore >= this.FHeroList[0].Price)
         {
            this.FHeroList[0].Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

