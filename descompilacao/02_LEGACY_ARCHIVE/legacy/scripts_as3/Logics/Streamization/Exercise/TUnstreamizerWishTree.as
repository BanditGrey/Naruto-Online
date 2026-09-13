package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.WishTree.TWishTree;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerWishTree extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerWishTree()
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
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBins = null;
         var _loc16_:TBaseBox = null;
         var _loc17_:TWishTree = null;
         var _loc18_:TConsumeRankInfo = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TWishTree;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_WishTree;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.WishEndTime = param1.readUnsignedInt();
         _loc17_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc17_.FreeTimes = param1.readUnsignedInt();
         _loc17_.CurLevel = param1.readUnsignedInt();
         _loc17_.Point = param1.readUnsignedInt();
         _loc17_.CurRank = param1.readUnsignedInt();
         _loc17_.IsFailed = param1.readUnsignedInt();
         _loc17_.WishPrice = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc17_.RankList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TConsumeRankInfo();
            _loc18_.UserName = TUtilityString.FetchUTF(param1);
            _loc18_.ServerName = TUtilityString.FetchUTF(param1);
            _loc18_.Rank = param1.readUnsignedInt();
            _loc18_.Score = param1.readUnsignedInt();
            _loc17_.RankList.push(_loc18_);
            _loc4_++;
         }
         _loc17_.KillRank.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Min = param1.readUnsignedInt();
            _loc16_.Max = param1.readUnsignedInt();
            _loc16_.TitleID = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc9_ = new TInventories();
            _loc13_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = 1;
            _loc16_.Inventories = _loc9_;
            _loc17_.KillRank.push(_loc16_);
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
            _loc13_.length = 0;
            _loc9_ = new TInventories();
            _loc13_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = 1;
            _loc16_.Inventories = _loc9_;
            _loc17_.KillBox[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Min = param1.readUnsignedInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc17_.RewardList[_loc4_] = _loc16_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

