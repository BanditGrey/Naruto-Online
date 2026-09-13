package Logics.Exercise.Christmas
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TChristmasCollect extends TBaseActivity
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FCollectNum:int;
      
      protected var FStatus:int;
      
      public function TChristmasCollect()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>(BOX_COUNT);
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get CollectNum() : int
      {
         return this.FCollectNum;
      }
      
      public function set CollectNum(param1:int) : void
      {
         this.FCollectNum = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FCollectNum >= this.FBoxList[_loc1_].Price)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

