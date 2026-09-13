package Logics.Exercise.DailyRecharge
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TDailyRecharge extends TBaseActivity
   {
      
      protected var FRechargeGold:int;
      
      protected var FServerNum:int;
      
      protected var FDailyBox:TBaseBox;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TDailyRecharge()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
      }
      
      public function get RechargeGold() : int
      {
         return this.FRechargeGold;
      }
      
      public function set RechargeGold(param1:int) : void
      {
         this.FRechargeGold = param1;
      }
      
      public function get DailyBox() : TBaseBox
      {
         return this.FDailyBox;
      }
      
      public function set DailyBox(param1:TBaseBox) : void
      {
         this.FDailyBox = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get ServerNum() : int
      {
         return this.FServerNum;
      }
      
      public function set ServerNum(param1:int) : void
      {
         this.FServerNum = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FDailyBox.Status == TBaseActivity.STATUS_CANNOTGET && this.FRechargeGold >= this.FDailyBox.Price)
         {
            this.FDailyBox.Status = TBaseActivity.STATUS_CANGET;
         }
         if(this.FDailyBox.Status != TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_ = int(this.FBoxList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FServerNum >= this.FBoxList[_loc1_].Count)
               {
                  this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
               }
               _loc1_++;
            }
         }
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FDailyBox.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

