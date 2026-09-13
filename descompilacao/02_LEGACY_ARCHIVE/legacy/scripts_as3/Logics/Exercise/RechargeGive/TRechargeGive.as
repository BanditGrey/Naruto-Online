package Logics.Exercise.RechargeGive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TRechargeGive extends TBaseActivity
   {
      
      public static const BOX_COUNT:uint = 4;
      
      protected var FCurRecharge:int;
      
      protected var FCurConsume:int;
      
      protected var FConsumeBoxVect:Vector.<TBaseBox>;
      
      protected var FRechargeBoxVect:Vector.<TBaseBox>;
      
      public function TRechargeGive()
      {
         super();
         this.FConsumeBoxVect = new Vector.<TBaseBox>();
         this.FRechargeBoxVect = new Vector.<TBaseBox>();
      }
      
      public function get ConsumeBoxVect() : Vector.<TBaseBox>
      {
         return this.FConsumeBoxVect;
      }
      
      public function set ConsumeBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FConsumeBoxVect = param1;
      }
      
      public function get RechargeBoxVect() : Vector.<TBaseBox>
      {
         return this.FRechargeBoxVect;
      }
      
      public function set RechargeBoxVect(param1:Vector.<TBaseBox>) : void
      {
         this.FRechargeBoxVect = param1;
      }
      
      public function get CurRecharge() : int
      {
         return this.FCurRecharge;
      }
      
      public function set CurRecharge(param1:int) : void
      {
         this.FCurRecharge = param1;
      }
      
      public function get CurConsume() : int
      {
         return this.FCurConsume;
      }
      
      public function set CurConsume(param1:int) : void
      {
         this.FCurConsume = param1;
      }
      
      public function CheckBoxStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FConsumeBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FConsumeBoxVect[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FRechargeBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRechargeBoxVect[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function ChangeBoxStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FConsumeBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FConsumeBoxVect[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET && this.FCurConsume >= _loc3_.Price)
            {
               _loc3_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FRechargeBoxVect.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRechargeBoxVect[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET && this.FCurRecharge >= _loc3_.Price)
            {
               _loc3_.Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

