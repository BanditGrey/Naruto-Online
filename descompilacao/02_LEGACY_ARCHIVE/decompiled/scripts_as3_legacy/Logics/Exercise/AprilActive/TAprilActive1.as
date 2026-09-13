package Logics.Exercise.AprilActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TAprilActive1 extends TBaseActivity
   {
      
      public var ScoreA:int;
      
      public var TreeLevel:int;
      
      public var CurTree:int;
      
      public var MaxTree:int;
      
      public var ConsumeScore:int;
      
      public var ConsumeCount:int;
      
      public var CurLevelMin:int;
      
      public var CurLevelMax:int;
      
      public var NextLevelMin:int;
      
      public var NextLevelMax:int;
      
      public var NextLevel:int;
      
      public var Price:int;
      
      public var AutoPrice:int;
      
      public var ScorePrice:int;
      
      public var Gift:TBaseBox;
      
      public var ShowItems:TInventories;
      
      public var EquipList:TInventories;
      
      public var TitleList:Vector.<uint>;
      
      public var WaterList:Vector.<int>;
      
      public var RateList:Vector.<int>;
      
      public var AmountList:Vector.<int>;
      
      public var IndexList:Vector.<int>;
      
      public var StatusList:Vector.<int>;
      
      public var BoxList:Vector.<TBaseBox>;
      
      public var DailyGift:Vector.<TBaseBox>;
      
      public var Param1List:Vector.<int>;
      
      public var Param2List:Vector.<int>;
      
      public var Param3List:Vector.<int>;
      
      public var IsLevelUp:int;
      
      public function TAprilActive1()
      {
         super();
         this.TitleList = new Vector.<uint>();
         this.WaterList = new Vector.<int>();
         this.BoxList = new Vector.<TBaseBox>();
         this.DailyGift = new Vector.<TBaseBox>();
         this.AmountList = new Vector.<int>();
         this.IndexList = new Vector.<int>();
         this.StatusList = new Vector.<int>();
         this.Param1List = new Vector.<int>();
         this.Param2List = new Vector.<int>();
         this.Param3List = new Vector.<int>();
         this.RateList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.BoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.TreeLevel > _loc1_ + 1 && this.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               this.BoxList[_loc1_].Status = TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
      }
      
      public function get IsBtnShine() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.Gift.Count > 0)
         {
            return true;
         }
         _loc2_ = int(this.BoxList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
   }
}

