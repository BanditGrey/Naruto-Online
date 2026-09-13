package Logics.Exercise.TreasureBox
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Processors.Game.Lobby.Exercise.TreasureBox.TProcessorTreasureBox;
   
   public class TTreasureBox extends TBaseActivity
   {
      
      public static const BOX_COUNT:int = TProcessorTreasureBox.BOX_COUNT;
      
      protected var FTotalCount:int;
      
      protected var FMaxCount:int;
      
      protected var FBigBoxVect:Vector.<TBaseBox>;
      
      protected var FSmallBoxVect:Vector.<TBaseBox>;
      
      protected var FBarBoxVect:Vector.<TBaseBox>;
      
      public function TTreasureBox()
      {
         super();
         this.FBigBoxVect = new Vector.<TBaseBox>();
         this.FSmallBoxVect = new Vector.<TBaseBox>();
         this.FBarBoxVect = new Vector.<TBaseBox>();
      }
      
      public function get BigBoxVect() : Vector.<TBaseBox>
      {
         return this.FBigBoxVect;
      }
      
      public function set BigBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FBigBoxVect = param1;
      }
      
      public function get SmallBoxVect() : Vector.<TBaseBox>
      {
         return this.FSmallBoxVect;
      }
      
      public function set SmallBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FSmallBoxVect = param1;
      }
      
      public function get TotalCount() : int
      {
         return this.FTotalCount;
      }
      
      public function set TotalCount(param1:int) : void
      {
         this.FTotalCount = param1;
      }
      
      public function get BarBoxVect() : Vector.<TBaseBox>
      {
         return this.FBarBoxVect;
      }
      
      public function set BarBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FBarBoxVect = param1;
      }
      
      public function get MaxCount() : int
      {
         return this.FMaxCount;
      }
      
      public function set MaxCount(param1:int) : void
      {
         this.FMaxCount = param1;
      }
      
      public function ChangeBoxStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.FSmallBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_ / BOX_COUNT;
            if(this.FSmallBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FBigBoxVect[_loc3_].BuyCount >= this.FSmallBoxVect[_loc1_].Price)
            {
               this.FSmallBoxVect[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FBarBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBarBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.FTotalCount >= this.FBarBoxVect[_loc1_].Price)
            {
               this.FBarBoxVect[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function CheckBoxStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FBigBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBigBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FSmallBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FSmallBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FBarBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FBarBoxVect[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

