package Logics.Exercise.NationalDay_2015
{
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   
   public class TNationalDay2_2015 extends TBaseActivity
   {
      
      public static const TYPE_ITEM:int = 1;
      
      public static const TYPE_HURT:int = 2;
      
      public static const TYPE_DOUBLE:int = 3;
      
      public static const TYPE_HOME:int = 4;
      
      public var Count:int;
      
      public var StepIndex:int;
      
      public var DoubleStatus:int;
      
      public var Price:int;
      
      public var DicePrice:int;
      
      public var BossHp:int;
      
      public var BossMaxHp:int;
      
      public var UpgradePrice:Vector.<int>;
      
      public var Gift:TBaseBox;
      
      public var NewsList:Vector.<TLotteryNews>;
      
      public var ItemList:Vector.<TBaseBox>;
      
      public var TargetIndex:int;
      
      public var UpgradeStatus:int;
      
      public var NextDoubleStatus:int;
      
      public var Step:int;
      
      public function TNationalDay2_2015()
      {
         super();
         this.UpgradePrice = new Vector.<int>();
         this.NewsList = new Vector.<TLotteryNews>();
         this.ItemList = new Vector.<TBaseBox>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function GameFlowText() : String
      {
         var _loc1_:String = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:TInventory = null;
         var _loc4_:String = null;
         _loc2_ = this.ItemList[this.TargetIndex];
         if(this.DoubleStatus == 0)
         {
            if(_loc2_.Type == TYPE_ITEM)
            {
               _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
               _loc4_ = _loc3_.Name + "*" + _loc3_.Quantity;
               _loc1_ = TUtilityString.Format(DescList[5],_loc4_);
            }
            else if(_loc2_.Type == TYPE_HOME)
            {
               _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
               _loc4_ = _loc3_.Name + "*" + _loc3_.Quantity;
               _loc1_ = TUtilityString.Format(DescList[7],_loc4_);
            }
            else if(_loc2_.Type == TYPE_HURT)
            {
               _loc1_ = TUtilityString.Format(DescList[4],_loc2_.Count,_loc2_.Count);
            }
            else
            {
               _loc1_ = DescList[6];
            }
         }
         else if(_loc2_.Type == TYPE_ITEM)
         {
            _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
            _loc4_ = _loc3_.Name + "*" + _loc3_.Quantity * 2;
            _loc1_ = TUtilityString.Format(DescList[9],_loc4_);
         }
         else if(_loc2_.Type == TYPE_HOME)
         {
            _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
            _loc4_ = _loc3_.Name + "*" + _loc3_.Quantity * 2;
            _loc1_ = TUtilityString.Format(DescList[10],_loc4_);
         }
         else if(_loc2_.Type == TYPE_HURT)
         {
            _loc1_ = TUtilityString.Format(DescList[8],_loc2_.Count * 2,_loc2_.Count * 2);
         }
         return _loc1_.split("%n%").join("\n");
      }
   }
}

