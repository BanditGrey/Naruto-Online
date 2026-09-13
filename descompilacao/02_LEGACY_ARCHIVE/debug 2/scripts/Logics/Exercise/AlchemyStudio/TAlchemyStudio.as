package Logics.Exercise.AlchemyStudio
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TAlchemyStudio extends TBaseActivity
   {
      
      public static const TYPE_NONE:int = 0;
      
      public static const TYPE_DOUBLE:int = -1;
      
      public static const TYPE_MINUS:int = -2;
      
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
      
      public var ShowItems:TInventories;
      
      public var GameBuff:int;
      
      public var GameValue:int;
      
      public var IsFirstPlay:int;
      
      public var TitleID:int;
      
      public var ActivityTaskData:TActivityTaskData;
      
      public function TAlchemyStudio()
      {
         super();
         this.Gift = new Vector.<TBaseBox>();
         this.RechargeList = new Vector.<TBaseBox>();
         this.PointList = new Vector.<int>();
      }
      
      public function get IsClick() : Boolean
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
         _loc2_ = int(this.Gift.length);
         _loc1_ = 0;
         while(_loc1_ < this.Gift.length)
         {
            if(this.Gift[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET && this.ScoreB >= this.Gift[_loc1_].Price)
            {
               this.Gift[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
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
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.PointList.length)
         {
            this.PointList[_loc1_] = TYPE_NONE;
            _loc1_++;
         }
         this.GameValue = 0;
         this.GameBuff = 0;
         this.GameStatus = TBaseActivity.STATUS_CANNOTGET;
      }
   }
}

