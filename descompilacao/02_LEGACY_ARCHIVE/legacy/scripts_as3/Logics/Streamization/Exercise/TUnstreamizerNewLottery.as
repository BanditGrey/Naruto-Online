package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NewLottery.TNewLottery;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNewLottery extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNewLottery()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ActivityData(param1,param2);
      }
      
      protected function UnstreamizationPerform_ActivityData(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TInventory = null;
         var _loc8_:TInventories = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:TBaseBox = null;
         var _loc15_:Object = null;
         var _loc16_:TLotteryNews = null;
         var _loc17_:TNewLottery = null;
         var _loc18_:TBins = null;
         _loc12_ = new Vector.<uint>();
         _loc13_ = new Vector.<uint>();
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_ = param2 as TNewLottery;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.DescList.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc17_.DescList[_loc3_] = TUtilityString.FetchUTF(param1);
            _loc3_++;
         }
         _loc17_.InitDescListNew();
         _loc17_.CDTime = param1.readUnsignedInt();
         _loc17_.NextTime = param1.readUnsignedInt();
         _loc17_.PoolGold = param1.readUnsignedInt();
         _loc17_.Score = param1.readUnsignedInt();
         _loc17_.HeroList.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc17_.HeroList[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         _loc17_.FreeExp = param1.readUnsignedInt();
         _loc17_.FreeBar.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc17_.FreeBar[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         _loc17_.GoldExp = param1.readUnsignedInt();
         _loc17_.GoldBar.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc17_.GoldBar[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         _loc14_ = new TBaseBox();
         _loc14_.Count = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.FreeBox = _loc14_;
         _loc14_ = new TBaseBox();
         _loc14_.Count = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.GoldBox = _loc14_;
         param1.readShort();
         _loc14_ = new TBaseBox();
         _loc14_.Price = param1.readUnsignedInt();
         _loc14_.Level = param1.readUnsignedInt();
         _loc14_.BuyCount = param1.readUnsignedInt();
         _loc14_.CurPrice = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc14_.ExchangeVect[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.FreeOut = _loc14_;
         _loc14_ = new TBaseBox();
         _loc14_.Price = param1.readUnsignedInt();
         _loc14_.Level = param1.readUnsignedInt();
         _loc14_.BuyCount = param1.readUnsignedInt();
         _loc14_.CurPrice = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc14_.ExchangeVect[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.FreeMiddle = _loc14_;
         _loc14_ = new TBaseBox();
         _loc14_.Price = param1.readUnsignedInt();
         _loc14_.Level = param1.readUnsignedInt();
         _loc14_.BuyCount = param1.readUnsignedInt();
         _loc14_.CurPrice = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc14_.ExchangeVect[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.FreeInside = _loc14_;
         param1.readShort();
         _loc14_ = new TBaseBox();
         _loc14_.Price = param1.readUnsignedInt();
         _loc14_.Level = param1.readUnsignedInt();
         _loc14_.BuyCount = param1.readUnsignedInt();
         _loc14_.CurPrice = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc14_.ExchangeVect[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.GoldOut = _loc14_;
         _loc14_ = new TBaseBox();
         _loc14_.Price = param1.readUnsignedInt();
         _loc14_.Level = param1.readUnsignedInt();
         _loc14_.BuyCount = param1.readUnsignedInt();
         _loc14_.CurPrice = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc14_.ExchangeVect[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.GoldMiddle = _loc14_;
         _loc14_ = new TBaseBox();
         _loc14_.Price = param1.readUnsignedInt();
         _loc14_.Level = param1.readUnsignedInt();
         _loc14_.BuyCount = param1.readUnsignedInt();
         _loc14_.CurPrice = param1.readUnsignedInt();
         _loc8_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            _loc13_.push(param1.readUnsignedInt());
            _loc14_.ExchangeVect[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = _loc8_.GetInventoryByIndex(_loc3_);
            _loc7_.Quantity = _loc13_[_loc3_];
            _loc3_++;
         }
         _loc14_.Inventories = _loc8_;
         _loc17_.GoldInside = _loc14_;
         _loc17_.LuckyList.length = 0;
         _loc5_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc15_ = new Object();
            _loc15_.name = TUtilityString.FetchUTF(param1);
            _loc15_.server = TUtilityString.FetchUTF(param1);
            _loc15_.gold = param1.readUnsignedInt();
            _loc17_.LuckyList[_loc3_] = _loc15_;
            _loc3_++;
         }
         _loc17_.NewsList.length = 0;
         _loc5_ = int(param1.readUnsignedShort());
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc16_ = new TLotteryNews();
            _loc16_.Identifier0 = param1.readUnsignedInt();
            _loc16_.Identifier1 = param1.readUnsignedInt();
            _loc16_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc16_.SoureID = param1.readUnsignedInt();
            _loc8_ = new TInventories();
            _loc12_.length = 0;
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = param1.readUnsignedInt();
            _loc9_ = CONST_COMMON.GetItemIDByType(_loc11_,_loc10_,_loc18_);
            _loc12_.push(_loc9_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc12_);
            _loc8_.GetInventoryByIndex(0).Quantity = param1.readUnsignedInt();
            _loc16_.Inventories = _loc8_;
            _loc17_.NewsList.push(_loc16_);
            _loc3_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

