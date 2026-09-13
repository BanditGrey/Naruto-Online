package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TBaseBoxes;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerPersiaTrader extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerPersiaTrader()
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
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:Vector.<int> = null;
         var _loc22_:Vector.<int> = null;
         var _loc23_:TPersiaTrader = null;
         var _loc24_:TLotteryNews = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = new Vector.<int>();
         _loc22_ = new Vector.<int>();
         _loc23_ = param2 as TPersiaTrader;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc23_.BeginTime = param1.readUnsignedInt();
         _loc23_.EndTime = param1.readUnsignedInt();
         _loc23_.DescList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc23_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc23_.InitDescListNew();
         _loc23_.Score = param1.readUnsignedInt();
         _loc23_.NextTime = param1.readUnsignedInt();
         _loc23_.FreshPrice = param1.readUnsignedInt();
         _loc23_.TotalConsumeGold = param1.readUnsignedInt();
         _loc23_.PetID = param1.readUnsignedInt();
         _loc23_.HeroID = param1.readUnsignedInt();
         _loc23_.FreshSingleItem.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc23_.FreshSingleItem[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc23_.FreshSinglePrice.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc23_.FreshSinglePrice[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc23_.SaleItems.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc11_ = new TInventories();
            _loc19_.length = 0;
            _loc20_.length = 0;
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc19_.push(param1.readUnsignedInt());
            _loc20_.push(param1.readUnsignedInt());
            _loc18_.Status = param1.readInt();
            _loc18_.CurPrice = param1.readUnsignedInt();
            _loc18_.Min = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.Level = param1.readUnsignedInt();
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc10_ = _loc11_.GetInventoryByIndex(0);
            _loc10_.Quantity = _loc16_[0];
            _loc10_.NewType = _loc19_[0];
            _loc10_.NewIdentify = _loc20_[0];
            _loc18_.Inventories = _loc11_;
            _loc23_.SaleItems[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc23_.ExchangeItems.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.LimitCount = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc11_ = new TInventories();
            _loc19_.length = 0;
            _loc20_.length = 0;
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc19_.push(param1.readUnsignedInt());
            _loc20_.push(param1.readUnsignedInt());
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc10_ = _loc11_.GetInventoryByIndex(0);
            _loc10_.Quantity = _loc16_[0];
            _loc10_.NewType = _loc19_[0];
            _loc10_.NewIdentify = _loc20_[0];
            _loc18_.Inventories = _loc11_;
            _loc23_.ExchangeItems[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc23_.SaleLogs.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc11_ = new TInventories();
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc10_ = _loc11_.GetInventoryByIndex(0);
            _loc10_.Quantity = _loc16_[0];
            _loc18_.Inventory = _loc10_;
            _loc18_.Inventories = _loc11_;
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.IsHot = param1.readUnsignedInt();
            _loc23_.SaleLogs[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc23_.LuckyList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc24_ = new TLotteryNews();
            _loc24_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc11_ = new TInventories();
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc10_ = _loc11_.GetInventoryByIndex(0);
            _loc10_.Quantity = _loc16_[0];
            _loc24_.Inventory = _loc10_;
            _loc24_.Inventories = _loc11_;
            _loc24_.Count = param1.readUnsignedInt();
            _loc24_.GetTime = param1.readUnsignedInt();
            _loc23_.LuckyList[_loc4_] = _loc24_;
            _loc4_++;
         }
         _loc11_ = new TInventories();
         _loc19_.length = 0;
         _loc20_.length = 0;
         _loc15_.length = 0;
         _loc16_.length = 0;
         _loc21_.length = 0;
         _loc22_.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc19_.push(param1.readUnsignedInt());
            _loc20_.push(param1.readUnsignedInt());
            _loc21_.push(param1.readUnsignedInt());
            _loc22_.push(param1.readUnsignedInt());
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc4_);
            _loc10_.Quantity = _loc16_[_loc4_];
            _loc10_.NewType = _loc19_[_loc4_];
            _loc10_.NewIdentify = _loc20_[_loc4_];
            _loc10_.MinPrice = _loc21_[_loc4_];
            _loc10_.MaxPrice = _loc22_[_loc4_];
            _loc4_++;
         }
         _loc23_.HotList = _loc11_;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeShowList(param1:ByteArray, param2:Object, param3:Object) : void
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
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:TPersiaTrader = null;
         var _loc22_:TLotteryNews = null;
         var _loc23_:TBaseBoxes = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = param2 as TPersiaTrader;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc21_.ShowList.length = 0;
         _loc7_ = 5;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc23_ = new TBaseBoxes();
            _loc8_ = int(param1.readUnsignedInt());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc18_ = new TBaseBox();
               _loc18_.Price = param1.readUnsignedInt();
               _loc18_.Min = param1.readUnsignedInt();
               _loc18_.LimitCount = param1.readUnsignedInt();
               _loc11_ = new TInventories();
               _loc19_.length = 0;
               _loc20_.length = 0;
               _loc15_.length = 0;
               _loc16_.length = 0;
               _loc19_.push(param1.readUnsignedInt());
               _loc20_.push(param1.readUnsignedInt());
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
               _loc10_ = _loc11_.GetInventoryByIndex(0);
               _loc10_.Quantity = _loc16_[0];
               _loc10_.NewType = _loc19_[0];
               _loc10_.NewIdentify = _loc20_[0];
               _loc10_.NewIdentify = _loc20_[0];
               _loc10_.LimitCount = _loc18_.LimitCount;
               _loc18_.Inventories = _loc11_;
               _loc23_.Items[_loc5_] = _loc18_;
               _loc5_++;
            }
            _loc21_.ShowList[_loc4_] = _loc23_;
            _loc4_++;
         }
      }
   }
}

