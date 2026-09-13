package Logics.Exercise.ValentineDay
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TValentineDay2 extends TBaseActivity
   {
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      public function TValentineDay2()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FGiftList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function CheckBoxStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FGiftList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FGiftList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            else
            {
               this.FBoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

