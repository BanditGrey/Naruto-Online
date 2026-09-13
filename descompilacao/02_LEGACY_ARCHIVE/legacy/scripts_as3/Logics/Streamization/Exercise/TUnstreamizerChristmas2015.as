package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2015.TChristmas1_2015;
   import Logics.Exercise.Christmas2015.TChristmas2_2015;
   import Logics.Exercise.Christmas2015.TChristmas3_2015;
   import Logics.Exercise.Christmas2015.TChristmas4_2015;
   import Logics.Exercise.Christmas2015.TChristmasDatas_2015;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerChristmas2015 extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerChristmas2015(param1:int)
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
         var _loc6_:TChristmasDatas_2015 = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TChristmasDatas_2015;
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
               break;
            case ACTIVITY_4_ID:
               this.UnstreamizationPerform_4(param1,_loc6_,_loc9_);
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
         var _loc17_:TChristmasDatas_2015 = null;
         var _loc18_:TChristmas1_2015 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TChristmasDatas_2015;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_1_ID) as TChristmas1_2015;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.InitDescListNew();
         _loc18_.SignCost = param1.readUnsignedInt();
         _loc18_.TotalSign = param1.readUnsignedInt();
         _loc18_.CurStatus = param1.readInt();
         _loc18_.CurDay = param1.readUnsignedInt();
         _loc18_.BuySignDay = param1.readUnsignedInt();
         _loc18_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Max = param1.readUnsignedInt();
            _loc16_.Min = param1.readUnsignedInt();
            _loc16_.LimitCount = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc19_.length = 0;
            _loc20_.length = 0;
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
               _loc8_.MinPrice = _loc16_.Min;
               _loc8_.MaxPrice = _loc16_.Max;
               _loc8_.LimitCount = _loc16_.LimitCount;
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc18_.ShopExchangeItems[_loc4_] = _loc16_;
            _loc4_++;
         }
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
         var _loc17_:TChristmasDatas_2015 = null;
         var _loc18_:TChristmas2_2015 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TChristmasDatas_2015;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmas2_2015;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.InitDescListNew();
         _loc18_.TreeLevel = param1.readUnsignedInt();
         _loc18_.IsEnd = param1.readUnsignedInt();
         _loc18_.TreeExp = param1.readUnsignedInt();
         _loc18_.TreeExpMax = param1.readUnsignedInt();
         _loc18_.Max = param1.readUnsignedInt();
         _loc18_.Min = param1.readUnsignedInt();
         _loc18_.TotalConsumeGold = param1.readUnsignedInt();
         _loc18_.GiftCount.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.GiftCount[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.GiftList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.GiftList[_loc4_] = param1.readUnsignedInt();
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
         _loc18_.TitleList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.TitleList[_loc4_] = new TBaseBox();
            _loc18_.TitleList[_loc4_].Status = param1.readInt();
            _loc18_.TitleList[_loc4_].Level = param1.readUnsignedInt();
            _loc18_.TitleList[_loc4_].Identify = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.WaterList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Time = param1.readUnsignedInt();
            _loc18_.WaterList[_loc4_] = _loc16_;
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
         var _loc16_:TBaseBox = null;
         var _loc17_:TChristmasDatas_2015 = null;
         var _loc18_:TChristmas3_2015 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TChristmasDatas_2015;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmas3_2015;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.InitDescListNew();
         _loc18_.RankPoint = param1.readUnsignedInt();
         _loc18_.ShopExchangePoint = param1.readUnsignedInt();
         _loc18_.CurMyRank = param1.readUnsignedInt();
         _loc18_.TotalRechargeGold = param1.readUnsignedInt();
         _loc18_.BadgeCount = param1.readUnsignedInt();
         _loc18_.BadgeCost = param1.readUnsignedInt();
         _loc18_.IceList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.IceList[_loc4_] = param1.readInt();
            _loc4_++;
         }
         _loc18_.BookList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.BookList[_loc4_] = param1.readInt();
            _loc4_++;
         }
         _loc18_.FreeCount = param1.readUnsignedInt();
         _loc18_.MaxCount = param1.readUnsignedInt();
         _loc18_.LimitCount = param1.readUnsignedInt();
         _loc18_.Gain = param1.readUnsignedInt();
         _loc18_.Price = param1.readUnsignedInt();
         _loc18_.AutoPrice = param1.readUnsignedInt();
         _loc18_.ShearIndex = param1.readInt();
         _loc18_.LastShear = param1.readUnsignedInt();
         _loc18_.CurSock = param1.readUnsignedInt();
         _loc18_.BarList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.BarList[_loc4_] = new TBaseBox();
            _loc18_.BarList[_loc4_].Price = param1.readUnsignedInt();
            _loc18_.BarList[_loc4_].Count = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.SockList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.SockList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.RechargeBox.length = 0;
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
            _loc16_.IsHot = param1.readUnsignedInt();
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
      }
      
      protected function UnstreamizationPerform_4(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc17_:TChristmasDatas_2015 = null;
         var _loc18_:TChristmas4_2015 = null;
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
         _loc17_ = param2 as TChristmasDatas_2015;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmas4_2015;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc18_.InitDescListNew();
         _loc18_.CurFund = param1.readUnsignedInt();
         _loc18_.Price = param1.readUnsignedInt();
         _loc18_.LimitCount = param1.readUnsignedInt();
         _loc18_.TotalRechargeGold = param1.readUnsignedInt();
         _loc18_.FundList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Count = param1.readUnsignedInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Discount = param1.readUnsignedInt();
            _loc16_.ReturnMoney = param1.readUnsignedInt();
            _loc18_.FundList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc18_.EggList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.EggList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.LuckyList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc24_ = new TLotteryNews();
            _loc24_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc24_.NewsType = param1.readUnsignedInt();
            _loc24_.Count = param1.readUnsignedInt();
            _loc24_.GetTime = param1.readUnsignedInt();
            _loc18_.LuckyList[_loc4_] = _loc24_;
            _loc4_++;
         }
         _loc18_.NewsList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc24_ = new TLotteryNews();
            _loc24_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc24_.NewsType = param1.readUnsignedInt();
            _loc24_.Count = param1.readUnsignedInt();
            _loc24_.GetTime = param1.readUnsignedInt();
            _loc18_.NewsList[_loc4_] = _loc24_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

