package Logics.Exercise.HallowmasActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class THallowmasActive2 extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FFishList:Vector.<TBaseBox>;
      
      protected var FTotalMoney:int;
      
      protected var FCount:int;
      
      public function THallowmasActive2()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FFishList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get FishList() : Vector.<TBaseBox>
      {
         return this.FFishList;
      }
      
      public function set FishList(param1:Vector.<TBaseBox>) : void
      {
         this.FFishList = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get TotalMoney() : int
      {
         return this.FTotalMoney;
      }
      
      public function set TotalMoney(param1:int) : void
      {
         this.FTotalMoney = param1;
      }
      
      public function GetCurLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FTotalMoney >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

