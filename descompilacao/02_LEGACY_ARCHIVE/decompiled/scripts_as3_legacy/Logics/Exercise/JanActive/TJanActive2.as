package Logics.Exercise.JanActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TJanActive2 extends TBaseActivity
   {
      
      public static const TYPE_NONE:int = 0;
      
      public static const TYPE_BOMB:int = -1;
      
      public var ScoreA:int;
      
      public var ScoreB:int;
      
      public var AutoPrice:int;
      
      public var GameStatus:int;
      
      public var RechargeGold:int;
      
      public var ScorePrice:int;
      
      public var Price:int;
      
      public var Gift:Vector.<TBaseBox>;
      
      public var RechargeList:Vector.<TBaseBox>;
      
      public var PointList:Vector.<int>;
      
      public var Hero:TBaseBox;
      
      public var ExchangeItems:Vector.<TBaseBox>;
      
      public function TJanActive2()
      {
         super();
         this.Gift = new Vector.<TBaseBox>();
         this.RechargeList = new Vector.<TBaseBox>();
         this.PointList = new Vector.<int>();
         this.ExchangeItems = new Vector.<TBaseBox>();
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.PointList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.PointList[_loc1_] != TYPE_NONE)
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
         var _loc2_:int = 0;
         _loc2_ = int(this.RechargeList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.RechargeList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.RechargeGold >= this.RechargeList[_loc1_].Price)
            {
               this.RechargeList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
   }
}

