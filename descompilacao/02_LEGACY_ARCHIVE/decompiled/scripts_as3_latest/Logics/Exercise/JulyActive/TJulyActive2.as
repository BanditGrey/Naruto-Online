package Logics.Exercise.JulyActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TJulyActive2 extends TBaseActivity
   {
      
      protected var FBossID:int;
      
      protected var FCurHp:int;
      
      protected var FMaxHp:int;
      
      protected var FMaxPower:int;
      
      protected var FMyPower:int;
      
      protected var FNeedPower:int;
      
      protected var FPowerPrice:int;
      
      protected var FKillCount:int;
      
      protected var FScore:int;
      
      protected var FAllKillCount:int;
      
      protected var FAllKillNeedCount:int;
      
      protected var FAllKillStatus:int;
      
      protected var FAllKillItems:TInventories;
      
      protected var FLuckyItems:TInventories;
      
      protected var FExchangeHero:TBaseBox;
      
      protected var FExchangeBoxList:Vector.<TBaseBox>;
      
      protected var FKillBoxList:Vector.<TBaseBox>;
      
      protected var FLuckyName:Vector.<String>;
      
      public function TJulyActive2()
      {
         super();
         this.FExchangeBoxList = new Vector.<TBaseBox>();
         this.FKillBoxList = new Vector.<TBaseBox>();
         this.FLuckyName = new Vector.<String>();
      }
      
      public function get ExchangeBoxList() : Vector.<TBaseBox>
      {
         return this.FExchangeBoxList;
      }
      
      public function set ExchangeBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FExchangeBoxList = param1;
      }
      
      public function get ExchangeHero() : TBaseBox
      {
         return this.FExchangeHero;
      }
      
      public function set ExchangeHero(param1:TBaseBox) : void
      {
         this.FExchangeHero = param1;
      }
      
      public function get LuckyName() : Vector.<String>
      {
         return this.FLuckyName;
      }
      
      public function set LuckyName(param1:Vector.<String>) : void
      {
         this.FLuckyName = param1;
      }
      
      public function get BossID() : int
      {
         return this.FBossID;
      }
      
      public function set BossID(param1:int) : void
      {
         this.FBossID = param1;
      }
      
      public function get CurHp() : int
      {
         return this.FCurHp;
      }
      
      public function set CurHp(param1:int) : void
      {
         this.FCurHp = param1;
      }
      
      public function get MyPower() : int
      {
         return this.FMyPower;
      }
      
      public function set MyPower(param1:int) : void
      {
         this.FMyPower = param1;
      }
      
      public function get KillCount() : int
      {
         return this.FKillCount;
      }
      
      public function set KillCount(param1:int) : void
      {
         this.FKillCount = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get KillBoxList() : Vector.<TBaseBox>
      {
         return this.FKillBoxList;
      }
      
      public function set KillBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FKillBoxList = param1;
      }
      
      public function get MaxHp() : int
      {
         return this.FMaxHp;
      }
      
      public function set MaxHp(param1:int) : void
      {
         this.FMaxHp = param1;
      }
      
      public function get AllKillCount() : int
      {
         return this.FAllKillCount;
      }
      
      public function set AllKillCount(param1:int) : void
      {
         this.FAllKillCount = param1;
      }
      
      public function get AllKillStatus() : int
      {
         return this.FAllKillStatus;
      }
      
      public function set AllKillStatus(param1:int) : void
      {
         this.FAllKillStatus = param1;
      }
      
      public function get AllKillItems() : TInventories
      {
         return this.FAllKillItems;
      }
      
      public function set AllKillItems(param1:TInventories) : void
      {
         this.FAllKillItems = param1;
      }
      
      public function get LuckyItems() : TInventories
      {
         return this.FLuckyItems;
      }
      
      public function set LuckyItems(param1:TInventories) : void
      {
         this.FLuckyItems = param1;
      }
      
      public function get AllKillNeedCount() : int
      {
         return this.FAllKillNeedCount;
      }
      
      public function set AllKillNeedCount(param1:int) : void
      {
         this.FAllKillNeedCount = param1;
      }
      
      public function get NeedPower() : int
      {
         return this.FNeedPower;
      }
      
      public function set NeedPower(param1:int) : void
      {
         this.FNeedPower = param1;
      }
      
      public function get PowerPrice() : int
      {
         return this.FPowerPrice;
      }
      
      public function set PowerPrice(param1:int) : void
      {
         this.FPowerPrice = param1;
      }
      
      public function get MaxPower() : int
      {
         return this.FMaxPower;
      }
      
      public function set MaxPower(param1:int) : void
      {
         this.FMaxPower = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FKillBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FKillBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FKillCount >= this.FKillBoxList[_loc1_].Price)
            {
               this.FKillBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

