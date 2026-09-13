package Logics.Exercise.GodWelfare
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TBaseBoxes;
   
   public class TGodWelfare extends TBaseActivity
   {
      
      public static const REFRESH_DAILY:int = 1;
      
      public var ConsumeGold:int;
      
      public var ActType:int;
      
      public var NextTime:int;
      
      public var ReturnList:Vector.<TBaseBoxes>;
      
      public function TGodWelfare()
      {
         super();
         this.ReturnList = new Vector.<TBaseBoxes>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBoxes = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < this.ReturnList.length)
         {
            _loc3_ = this.ReturnList[_loc1_];
            if(TotalConsumeGold >= _loc3_.Price)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc3_.Items.length)
               {
                  _loc4_ = _loc3_.Items[_loc2_];
                  if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET && this.ConsumeGold >= _loc4_.Price)
                  {
                     _loc4_.Status = TBaseActivity.STATUS_CANGET;
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

