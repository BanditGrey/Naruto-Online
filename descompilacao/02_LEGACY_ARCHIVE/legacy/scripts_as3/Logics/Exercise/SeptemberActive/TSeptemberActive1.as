package Logics.Exercise.SeptemberActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TSeptemberActive1 extends TBaseActivity
   {
      
      protected var FMyCount:int;
      
      protected var FTotalCount:int;
      
      protected var FSaleItem:TBaseBox;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      protected var FServerList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TSeptemberActive1()
      {
         super();
         this.FGiftList = new Vector.<TBaseBox>();
         this.FServerList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function get SaleItem() : TBaseBox
      {
         return this.FSaleItem;
      }
      
      public function set SaleItem(param1:TBaseBox) : void
      {
         this.FSaleItem = param1;
      }
      
      public function get MyCount() : int
      {
         return this.FMyCount;
      }
      
      public function set MyCount(param1:int) : void
      {
         this.FMyCount = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
      
      public function get ServerList() : Vector.<TBaseBox>
      {
         return this.FServerList;
      }
      
      public function set ServerList(param1:Vector.<TBaseBox>) : void
      {
         this.FServerList = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FMyCount >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FServerList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FServerList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FTotalCount >= this.FServerList[_loc1_].BuyCount)
            {
               this.FServerList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function GetCurIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FServerList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FServerList[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_;
      }
   }
}

