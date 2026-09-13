package Logics.Exercise.DayRechargeGift
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TDayRechargeGift extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public function TDayRechargeGift()
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
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:TBaseBox = null;
         if(this.FBoxList != null)
         {
            for each(_loc1_ in this.FBoxList)
            {
               if(_loc1_.Status == 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}

