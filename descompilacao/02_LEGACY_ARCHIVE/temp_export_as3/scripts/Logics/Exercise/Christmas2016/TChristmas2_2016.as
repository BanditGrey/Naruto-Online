package Logics.Exercise.Christmas2016
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TChristmas2_2016 extends TBaseActivity
   {
      
      public var Score:int;
      
      public var TotalScore:int;
      
      public var FreeCount:int;
      
      public var BoxPrice:uint;
      
      public var TotalBoxPrice:uint;
      
      public var ResetPrice:uint;
      
      public var RechargeGift:TBaseBox;
      
      public var RewardsIndex:Vector.<uint>;
      
      public var TitleList:Vector.<TBaseBox>;
      
      public var PetID:uint;
      
      public function TChristmas2_2016()
      {
         super();
         this.RewardsIndex = new Vector.<uint>();
         this.TitleList = new Vector.<TBaseBox>();
      }
      
      public function CanOpenAll() : Boolean
      {
         var _loc1_:int = 0;
         if(this.RewardsIndex.indexOf(0) == -1)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < this.RewardsIndex.length)
         {
            if(this.RewardsIndex[_loc1_] != 0)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.TitleList.length)
         {
            if(this.TitleList[_loc1_].Status != TBaseActivity.STATUS_GETED && this.TotalScore >= this.TitleList[_loc1_].Price)
            {
               this.TitleList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function ResetPoint() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.RewardsIndex.length)
         {
            this.RewardsIndex[_loc1_] = 0;
            _loc1_++;
         }
      }
   }
}

