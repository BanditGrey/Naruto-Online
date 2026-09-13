package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FerrisWheel.TFerrisWheel;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerFerrisWheel extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerFerrisWheel()
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
         var _loc17_:TFerrisWheel = null;
         var _loc18_:Vector.<int> = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:TLotteryNews = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = new Vector.<int>();
         _loc19_ = new Vector.<int>();
         _loc17_ = param2 as TFerrisWheel;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.InitDescListNew();
         _loc17_.GoldCounts = param1.readUnsignedInt();
         _loc17_.TodayCounts = param1.readUnsignedInt();
         _loc17_.MaxCounts = param1.readUnsignedInt();
         _loc17_.FreeCounts = param1.readUnsignedInt();
         _loc17_.GoldAddCounts = param1.readUnsignedInt();
         _loc17_.RechargeGold = param1.readUnsignedInt();
         _loc17_.FreeOtherCounts = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc18_.length = 0;
         _loc19_.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.push(param1.readUnsignedInt());
            _loc19_.push(param1.readUnsignedInt());
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc4_);
            _loc8_.Quantity = _loc14_[_loc4_];
            _loc8_.ShowFire = _loc18_[_loc4_];
            _loc8_.NewType = _loc19_[_loc4_];
            _loc4_++;
         }
         _loc17_.GoldItems = _loc9_;
         _loc9_ = new TInventories();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc18_.length = 0;
         _loc19_.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.push(param1.readUnsignedInt());
            _loc19_.push(param1.readUnsignedInt());
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc4_);
            _loc8_.Quantity = _loc14_[_loc4_];
            _loc8_.ShowFire = _loc18_[_loc4_];
            _loc8_.NewType = _loc19_[_loc4_];
            _loc4_++;
         }
         _loc17_.FreeItems = _loc9_;
         _loc17_.NewsList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc20_ = new TLotteryNews();
            _loc20_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc9_ = new TInventories();
            _loc13_.length = 0;
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = param1.readUnsignedInt();
            _loc20_.Inventories = _loc9_;
            _loc20_.SoureID = param1.readUnsignedInt();
            _loc20_.GetTime = param1.readUnsignedInt();
            _loc17_.NewsList.push(_loc20_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

