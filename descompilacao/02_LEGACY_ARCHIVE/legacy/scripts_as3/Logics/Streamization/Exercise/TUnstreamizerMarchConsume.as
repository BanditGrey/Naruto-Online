package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MarchConsume.TMarchConsume;
   import Logics.Exercise.MarchConsume.TMarchConsumeBox;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerMarchConsume extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerMarchConsume()
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
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBins = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:TMarchConsume = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:Vector.<int> = null;
         var _loc22_:TMarchConsumeBox = null;
         var _loc23_:TLotteryNews = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc20_ = new Vector.<int>();
         _loc21_ = new Vector.<int>();
         _loc19_ = param2 as TMarchConsume;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc19_.BeginTime = param1.readUnsignedInt();
         _loc19_.EndTime = param1.readUnsignedInt();
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc19_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc19_.InitDescListNew();
         _loc19_.ConsumeGold = param1.readUnsignedInt();
         _loc19_.TotalConsumeGold = param1.readUnsignedInt();
         _loc19_.Price.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc19_.Price[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc19_.DailyItems.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Price = param1.readInt();
            _loc18_.Status = param1.readInt();
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc11_ = new TInventories();
            _loc8_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
               _loc10_.Quantity = _loc16_[_loc5_];
               _loc5_++;
            }
            _loc18_.Inventories = _loc11_;
            _loc19_.DailyItems[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc19_.TotalBox.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc22_ = new TMarchConsumeBox();
            _loc22_.Gold = param1.readUnsignedInt();
            _loc22_.Days = param1.readUnsignedInt();
            _loc8_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc18_ = new TBaseBox();
               _loc18_.Price = param1.readUnsignedInt();
               _loc18_.Status = param1.readInt();
               _loc15_.length = 0;
               _loc16_.length = 0;
               _loc11_ = new TInventories();
               _loc9_ = int(param1.readUnsignedShort());
               _loc6_ = 0;
               while(_loc6_ < _loc9_)
               {
                  _loc14_ = param1.readUnsignedInt();
                  _loc13_ = param1.readUnsignedInt();
                  _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
                  _loc15_.push(_loc12_);
                  _loc16_.push(param1.readUnsignedInt());
                  _loc6_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
               _loc6_ = 0;
               while(_loc6_ < _loc9_)
               {
                  _loc10_ = _loc11_.GetInventoryByIndex(_loc6_);
                  _loc10_.Quantity = _loc16_[_loc6_];
                  _loc6_++;
               }
               _loc18_.Inventories = _loc11_;
               _loc22_.Boxes[_loc5_] = _loc18_;
               _loc5_++;
            }
            _loc19_.TotalBox[_loc4_] = _loc22_;
            _loc4_++;
         }
         _loc19_.ConsumeLog.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc23_ = new TLotteryNews();
            _loc23_.GetTime = param1.readUnsignedInt();
            _loc23_.Count = param1.readUnsignedInt();
            _loc8_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc23_.StatusList[_loc5_] = param1.readInt();
               _loc5_++;
            }
            _loc8_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc23_.PriceList[_loc5_] = param1.readInt();
               _loc5_++;
            }
            _loc19_.ConsumeLog[_loc4_] = _loc23_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

