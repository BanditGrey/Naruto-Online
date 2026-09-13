package Logics.Exercise.SingleTopUp
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TSingleTopUp extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FStatus:int;
      
      protected var FIsHot:int;
      
      public function TSingleTopUp()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
      }
      
      public function get IsHot() : int
      {
         return this.FIsHot;
      }
      
      public function set IsHot(param1:int) : void
      {
         this.FIsHot = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FStatus == TBaseActivity.STATUS_CANGET)
         {
            return true;
         }
         _loc2_ = int(this.FBoxList.length);
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
      
      public function CheckIsBoxGet() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

