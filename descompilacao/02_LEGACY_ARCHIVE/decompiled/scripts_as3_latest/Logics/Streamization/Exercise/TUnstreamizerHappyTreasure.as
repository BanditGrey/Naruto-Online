package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.HappyTreasure.THappyTreasure;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerHappyTreasure extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerHappyTreasure()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:THappyTreasure = null;
         var _loc12_:TLotteryNews = null;
         var _loc13_:TBaseBox = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:TBins = null;
         var _loc19_:uint = 0;
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc11_ = param2 as THappyTreasure;
         _loc11_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_HappyTreasure;
         _loc11_.BeginTime = param1.readUnsignedInt();
         _loc11_.EndTime = param1.readUnsignedInt();
         _loc11_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc11_.ActivityTabName = TUtilityString.FetchUTF(param1);
         _loc11_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc11_.TotalScore = param1.readUnsignedInt();
         _loc11_.CurScore = param1.readUnsignedInt();
         _loc11_.BoxPrice = param1.readUnsignedInt();
         _loc11_.Max = param1.readUnsignedInt();
         _loc11_.TotalBoxPrice = param1.readUnsignedInt();
         _loc11_.RechargeMax = param1.readUnsignedInt();
         _loc11_.RechargeMin = param1.readUnsignedInt();
         _loc11_.ConsumeMax = param1.readUnsignedInt();
         _loc11_.ConsumeMin = param1.readUnsignedInt();
         _loc11_.CurBarValue = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc10_ = new Vector.<uint>();
         _loc11_.RewardsIndex.length = 0;
         _loc11_.RewardsLevel.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc11_.RewardsIndex.push(param1.readUnsignedInt());
            _loc10_.push(param1.readUnsignedInt());
            _loc11_.RewardsLevel.push(param1.readUnsignedInt());
            _loc4_++;
         }
         _loc9_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
         _loc11_.Rewards = _loc9_;
         _loc6_ = int(param1.readUnsignedShort());
         _loc11_.NewsList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = new TLotteryNews();
            _loc12_.Identifier0 = param1.readUnsignedInt();
            _loc12_.Identifier1 = param1.readUnsignedInt();
            _loc12_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc12_.Identify = param1.readUnsignedInt();
            _loc10_ = new Vector.<uint>();
            _loc10_.push(_loc12_.Identify);
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = 1;
            _loc12_.Inventories = _loc9_;
            _loc11_.NewsList.push(_loc12_);
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc10_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc10_.push(param1.readUnsignedInt());
            _loc19_ = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc9_ = new TInventories();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
         _loc11_.Inventories = _loc9_;
         _loc11_.BarItems.length = 0;
         _loc6_ = param1.readShort();
         _loc14_ = new Vector.<uint>();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc13_ = new TBaseBox();
            _loc13_.Status = param1.readInt();
            _loc13_.Price = param1.readInt();
            _loc10_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc16_ = param1.readUnsignedInt();
               _loc15_ = param1.readUnsignedInt();
               _loc17_ = CONST_COMMON.GetItemIDByType(_loc16_,_loc15_,_loc18_);
               _loc10_.push(_loc17_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc13_.Inventories = _loc9_;
            _loc11_.BarItems[_loc4_] = _loc13_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

