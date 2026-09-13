package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JanActive_2016.TJanActive1_2016;
   import Logics.Exercise.JanActive_2016.TJanActive2_2016;
   import Logics.Exercise.JanActive_2016.TJanActive3_2016;
   import Logics.Exercise.JanActive_2016.TJanActiveDatas_2016;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerJanActive2016 extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerJanActive2016(param1:int)
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerBaseActivityTask = new TUnstreamizerBaseActivityTask();
         this.FUnstreamizerBaseActivityTask.activityId = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TJanActiveDatas_2016 = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TJanActiveDatas_2016;
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
         var _loc16_:TBaseBox = null;
         var _loc17_:TJanActiveDatas_2016 = null;
         var _loc18_:TJanActive1_2016 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TJanActiveDatas_2016;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_1_ID) as TJanActive1_2016;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescListNew[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.SignCost = param1.readUnsignedInt();
         _loc18_.TotalSign = param1.readUnsignedInt();
         _loc18_.CurStatus = param1.readInt();
         _loc18_.CurDay = param1.readUnsignedInt();
         _loc18_.BuySignDay = param1.readUnsignedInt();
         _loc18_.TotalRechargeGold = param1.readUnsignedInt();
         _loc18_.TotalConsumeGold = param1.readUnsignedInt();
         _loc18_.BoxList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
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
            _loc16_.Inventories = _loc9_;
            _loc18_.BoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc18_.ItemList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
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
            _loc16_.Inventories = _loc9_;
            _loc18_.ItemList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc16_ = new TBaseBox();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Status = param1.readInt();
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
         _loc16_.Inventories = _loc9_;
         _loc18_.RechargeBox = _loc16_;
         _loc16_ = new TBaseBox();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Status = param1.readInt();
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
         _loc16_.Inventories = _loc9_;
         _loc18_.ConsumeBox = _loc16_;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
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
            _loc16_.Inventories = _loc9_;
            _loc18_.DayList[_loc4_] = _loc16_;
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
         var _loc16_:TBaseBox = null;
         var _loc17_:TJanActiveDatas_2016 = null;
         var _loc18_:TJanActive2_2016 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         _loc17_ = param2 as TJanActiveDatas_2016;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_2_ID) as TJanActive2_2016;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescListNew[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.ShopExchangePoint = param1.readUnsignedInt();
         _loc18_.RankPoint = param1.readUnsignedInt();
         _loc18_.CurMyRank = param1.readUnsignedInt();
         _loc18_.Score = param1.readUnsignedInt();
         _loc18_.ScorePrice = param1.readUnsignedInt();
         _loc18_.UpgradeCost = param1.readUnsignedInt();
         _loc18_.ResetCost = param1.readUnsignedInt();
         _loc18_.TotalRechargeGold = param1.readUnsignedInt();
         _loc18_.TotalConsumeGold = param1.readUnsignedInt();
         _loc16_ = new TBaseBox();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Count = param1.readUnsignedInt();
         _loc16_.BuyCount = param1.readUnsignedInt();
         _loc18_.ConsumeBox = _loc16_;
         _loc18_.TreeLevel = param1.readUnsignedInt();
         _loc18_.TreeExpMax = param1.readUnsignedInt();
         _loc18_.TreeExp = param1.readUnsignedInt();
         _loc18_.NeedReset = param1.readUnsignedInt();
         _loc18_.CostList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.CostList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.FruitList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc18_.FruitList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc18_.RechargeBox.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
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
               _loc8_.LimitCount = _loc16_.LimitCount;
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc18_.RechargeBox[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc18_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Level = param1.readUnsignedInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.LimitCount = param1.readUnsignedInt();
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
               _loc8_.LimitCount = _loc16_.LimitCount;
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc18_.ShopExchangeItems[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc19_.length = 0;
         _loc20_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.push(param1.readUnsignedInt());
            _loc20_.push(param1.readUnsignedInt());
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
            _loc8_.NewType = _loc19_[_loc4_];
            _loc8_.NewIdentify = _loc20_[_loc4_];
            _loc4_++;
         }
         _loc18_.ShowItem = _loc9_;
         this.FUnstreamizerBaseActivityTask.Unstreamize(param1,this.FActivityTaskData,null);
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
         var _loc16_:TBaseBox = null;
         var _loc17_:TJanActiveDatas_2016 = null;
         var _loc18_:TJanActive3_2016 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:TLotteryNews = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TJanActiveDatas_2016;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_3_ID) as TJanActive3_2016;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescListNew[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.Score = param1.readUnsignedInt();
         _loc18_.Price = param1.readUnsignedInt();
         _loc18_.AutoPrice = param1.readUnsignedInt();
         _loc18_.ResetPrice = param1.readUnsignedInt();
         _loc18_.TipIndex = param1.readUnsignedInt();
         _loc16_ = new TBaseBox();
         _loc16_.Type = param1.readInt();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Status = param1.readInt();
         _loc16_.Identify = param1.readUnsignedInt();
         _loc18_.Hero = _loc16_;
         _loc16_ = new TBaseBox();
         _loc16_.Status = param1.readInt();
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
            _loc8_.LimitCount = _loc16_.LimitCount;
            _loc5_++;
         }
         _loc16_.Inventories = _loc9_;
         _loc18_.HeroBox = _loc16_;
         _loc18_.GiftStatus.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.GiftStatus[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.ExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Level = param1.readUnsignedInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.LimitCount = param1.readUnsignedInt();
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
               _loc8_.LimitCount = _loc16_.LimitCount;
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc18_.ExchangeItems[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc18_.LuckyList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc24_ = new TLotteryNews();
            _loc9_ = new TInventories();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc24_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc14_[0];
            _loc24_.Inventory = _loc8_;
            _loc24_.Inventories = _loc9_;
            _loc24_.GetTime = param1.readUnsignedInt();
            _loc18_.LuckyList[_loc4_] = _loc24_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

