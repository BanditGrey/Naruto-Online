package Logics.Exercise.ActivityB
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TActivityB extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FTotalMoney:int;
      
      protected var FBigBox:TBaseBox;
      
      public function TActivityB()
      {
         super();
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
      
      public function get TotalMoney() : int
      {
         return this.FTotalMoney;
      }
      
      public function set TotalMoney(param1:int) : void
      {
         this.FTotalMoney = param1;
      }
      
      public function get BigBox() : TBaseBox
      {
         return this.FBigBox;
      }
      
      public function set BigBox(param1:TBaseBox) : void
      {
         this.FBigBox = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FBigBox.Status == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET && this.FBoxList[_loc1_].BuyCount > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

