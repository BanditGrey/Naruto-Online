package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NationalDay_2015.TNationalDay1_2015;
   import Logics.Exercise.NationalDay_2015.TNationalDay2_2015;
   import Logics.Exercise.NationalDay_2015.TNationalDay3_2015;
   import Logics.Exercise.NationalDay_2015.TNationalDayDatas_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNationDay2015 extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNationDay2015()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TNationalDayDatas_2015 = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TNationalDayDatas_2015;
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetActivityByIndex(_loc4_);
            _loc7_.Identify = param1.readUnsignedInt();
            _loc7_.ActivityTabName = TUtilityString.FetchUTF(param1);
            _loc7_.IsOpen = param1.readInt();
            _loc7_.BeginTime = param1.readUnsignedInt();
            _loc7_.NeedShine = param1.readInt();
            _loc4_++;
         }
         _loc8_ = param1.readInt();
         switch(_loc8_)
         {
            case ACTIVITY_1_ID:
               this.UnstreamizationPerform_1(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_2_ID:
               this.UnstreamizationPerform_2(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_3_ID:
               this.UnstreamizationPerform_3(param1,_loc6_,_loc9_);
         }
      }
      
      protected function UnstreamizationPerform_1(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc15_:Vector.<int> = null;
         var _loc16_:Vector.<int> = null;
         var _loc17_:Vector.<int> = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:TNationalDay1_2015 = null;
         var _loc20_:TNationalDayDatas_2015 = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = new Vector.<int>();
         _loc17_ = new Vector.<int>();
         _loc20_ = param2 as TNationalDayDatas_2015;
         _loc19_ = _loc20_.GetActivityByIdentify(ACTIVITY_1_ID) as TNationalDay1_2015;
         _loc19_.BeginTime = param1.readUnsignedInt();
         _loc19_.EndTime = param1.readUnsignedInt();
         _loc19_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc19_.InitDescListNew();
         _loc19_.LoginDay = param1.readUnsignedInt();
         _loc19_.NeedDay = param1.readUnsignedInt();
         _loc19_.FreeCount = param1.readUnsignedInt();
         _loc19_.FundStatus = param1.readInt();
         _loc19_.ReturnType = param1.readInt();
         _loc18_ = new TBaseBox();
         _loc18_.Status = param1.readInt();
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc4_++;
         }
         _loc18_.Inventories = _loc9_;
         _loc19_.DailyGift = _loc18_;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc16_.length = 0;
         _loc17_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_[_loc4_] = param1.readUnsignedInt();
            _loc17_[_loc4_] = param1.readUnsignedInt();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc8_.NewType = _loc16_[_loc4_];
            _loc8_.NewIdentify = _loc17_[_loc4_];
            _loc4_++;
         }
         _loc19_.ShowItem = _loc9_;
         _loc19_.Funds.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.Count = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc18_.Inventories = _loc9_;
            _loc19_.Funds[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_2(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc15_:Vector.<int> = null;
         var _loc16_:Vector.<int> = null;
         var _loc17_:Vector.<int> = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:TNationalDay2_2015 = null;
         var _loc20_:TNationalDayDatas_2015 = null;
         var _loc21_:TLotteryNews = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = new Vector.<int>();
         _loc17_ = new Vector.<int>();
         _loc20_ = param2 as TNationalDayDatas_2015;
         _loc19_ = _loc20_.GetActivityByIdentify(ACTIVITY_2_ID) as TNationalDay2_2015;
         _loc19_.BeginTime = param1.readUnsignedInt();
         _loc19_.EndTime = param1.readUnsignedInt();
         _loc19_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc19_.InitDescListNew();
         _loc19_.RankPoint = param1.readUnsignedInt();
         _loc19_.ShopExchangePoint = param1.readUnsignedInt();
         _loc19_.CurMyRank = param1.readUnsignedInt();
         _loc19_.Count = param1.readUnsignedInt();
         _loc19_.Price = param1.readUnsignedInt();
         _loc19_.DicePrice = param1.readUnsignedInt();
         _loc19_.BossMaxHp = param1.readUnsignedInt();
         _loc19_.BossHp = param1.readUnsignedInt();
         _loc19_.StepIndex = param1.readUnsignedInt() - 1;
         _loc19_.DoubleStatus = param1.readUnsignedInt();
         _loc19_.UpgradeStatus = param1.readUnsignedInt();
         _loc19_.UpgradePrice.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.UpgradePrice[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_ = new TBaseBox();
         _loc18_.Count = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc4_++;
         }
         _loc18_.Inventories = _loc9_;
         _loc19_.Gift = _loc18_;
         _loc19_.ItemList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Type = param1.readUnsignedInt();
            _loc18_.Level = param1.readUnsignedInt();
            _loc18_.Count = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc18_.Inventories = _loc9_;
            _loc19_.ItemList[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc19_.NewsList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc21_ = new TLotteryNews();
            _loc21_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc21_.SoureID = param1.readUnsignedInt();
            _loc21_.GetTime = param1.readUnsignedInt();
            _loc19_.NewsList.push(_loc21_);
            _loc4_++;
         }
         _loc19_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.IsHot = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.LimitCount = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc18_.Inventories = _loc9_;
            _loc19_.ShopExchangeItems[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_3(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc15_:Vector.<int> = null;
         var _loc16_:Vector.<int> = null;
         var _loc17_:Vector.<int> = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:TNationalDay3_2015 = null;
         var _loc20_:TNationalDayDatas_2015 = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = new Vector.<int>();
         _loc17_ = new Vector.<int>();
         _loc20_ = param2 as TNationalDayDatas_2015;
         _loc19_ = _loc20_.GetActivityByIdentify(ACTIVITY_3_ID) as TNationalDay3_2015;
         _loc19_.BeginTime = param1.readUnsignedInt();
         _loc19_.EndTime = param1.readUnsignedInt();
         _loc19_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc19_.InitDescListNew();
         _loc19_.TenPrice = param1.readUnsignedInt();
         _loc19_.Count = param1.readUnsignedInt();
         _loc19_.Score = param1.readUnsignedInt();
         _loc19_.TotalRechargeGold = param1.readUnsignedInt();
         _loc19_.PoolValue = param1.readUnsignedInt();
         _loc19_.PoolMax = param1.readUnsignedInt();
         _loc18_ = new TBaseBox();
         _loc18_.Count = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc4_++;
         }
         _loc18_.Inventories = _loc9_;
         _loc19_.Gift = _loc18_;
         _loc19_.SweetList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.Status = param1.readInt();
            _loc19_.SweetList[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc19_.HeroGold.length = 0;
         _loc19_.HeroScore.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.HeroGold[_loc4_] = param1.readUnsignedInt();
            _loc19_.HeroScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc19_.ItemGold.length = 0;
         _loc19_.ItemScore.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.ItemGold[_loc4_] = param1.readUnsignedInt();
            _loc19_.ItemScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_ = new TBaseBox();
         _loc18_.Type = param1.readInt();
         _loc18_.Price = param1.readUnsignedInt();
         _loc18_.Status = param1.readInt();
         _loc18_.Identify = param1.readUnsignedInt();
         _loc19_.Hero = _loc18_;
         _loc19_.ItemList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.IsHot = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.LimitCount = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
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
            _loc18_.Inventories = _loc9_;
            _loc19_.ItemList[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

