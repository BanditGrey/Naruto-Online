package Logics.Exercise.CreationAncestor
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TCreationAncestor extends TBaseActivity
   {
      
      public var Score:int;
      
      public var MapIndex:int;
      
      public var ServerBox:TBaseBox;
      
      public var PriceList:Vector.<int>;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var MaxStep:int;
      
      public var NeedGold:int;
      
      public var Price1:int;
      
      public var Price5:int;
      
      public var FreeCount:int;
      
      public function TCreationAncestor()
      {
         super();
         this.ServerBox = new TBaseBox();
         this.BoxList = new Vector.<TBaseBox>();
         this.PriceList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.ServerBox.CurPrice == 0 && this.ServerBox.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            this.ServerBox.Status = TBaseActivity.STATUS_CANGET;
         }
         _loc1_ = 0;
         while(_loc1_ < this.BoxList.length)
         {
            if(this.BoxList[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               break;
            }
            _loc2_ += 10;
            _loc1_++;
         }
         this.MaxStep = Math.max(_loc2_,this.MaxStep);
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function OpenGold(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = this.MaxStep / 10;
         _loc3_ = 0;
         while(_loc3_ < param1 + 1)
         {
            if(_loc3_ >= _loc4_)
            {
               _loc2_ += this.PriceList[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

