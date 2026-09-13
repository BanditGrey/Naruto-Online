package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ThanksgivingDay.TMsgGraph;
   import Logics.Exercise.ThanksgivingDay.TMsgTreasure;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay1;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay2;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay3;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDay4;
   import Logics.Exercise.ThanksgivingDay.TThanksgivingDayDatas;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerThanksgivingDay extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerThanksgivingDay(param1:int)
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
         var _loc6_:TThanksgivingDayDatas = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TThanksgivingDayDatas;
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
         var _loc15_:TBaseBox = null;
         var _loc16_:TThanksgivingDayDatas = null;
         var _loc17_:TThanksgivingDay1 = null;
         var _loc18_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TThanksgivingDayDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_1_ID) as TThanksgivingDay1;
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
         _loc17_.ActivityDesc = _loc17_.DescListNew[10];
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc18_ = param1.readUnsignedInt() - 1;
            _loc15_ = _loc17_.BoxList[_loc18_];
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            _loc15_.Level = param1.readUnsignedInt();
            _loc15_.ReturnMoney = param1.readUnsignedInt();
            _loc15_.Status = param1.readUnsignedInt();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc4_++;
         }
         _loc17_.CurIndex = param1.readUnsignedInt();
         _loc17_.NeedMoney = param1.readUnsignedInt();
         _loc17_.GetEvyDay = TUtilityString.FetchUTF(param1);
         _loc17_.ContinueDays = param1.readUnsignedInt();
         _loc17_.SendMailHour = param1.readUnsignedInt();
         _loc17_.GetMoney = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc15_ = _loc17_.RewardBoxList[_loc4_];
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc4_++;
         }
         _loc17_.CanReturn = param1.readUnsignedInt();
         _loc17_.ChangeSignStatus();
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
         var _loc15_:TBaseBox = null;
         var _loc16_:TThanksgivingDayDatas = null;
         var _loc17_:TThanksgivingDay2 = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:TMsgTreasure = null;
         var _loc21_:TMsgGraph = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TThanksgivingDayDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_2_ID) as TThanksgivingDay2;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.ActivityDesc = _loc17_.DescList[13];
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.TreasureMapCount[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc17_.FreeTreasureMap = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = param1.readUnsignedInt() - 1;
            _loc20_ = _loc17_.MsgTreasure[_loc18_];
            _loc20_.TreasureMapIndex = _loc18_;
            _loc20_.RewardDescNew.length = 0;
            _loc7_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc20_.RewardDescNew[_loc5_] = TUtilityString.FetchUTF(param1);
               _loc5_++;
            }
            _loc20_.InitRewardDescNew();
            _loc20_.Prize = param1.readUnsignedInt();
            _loc20_.NeedScore = param1.readUnsignedInt();
            _loc20_.TreasureStatus = param1.readUnsignedInt();
            _loc7_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc9_ = new TInventories();
               _loc13_.length = 0;
               _loc14_.length = 0;
               _loc19_ = param1.readUnsignedInt() - 1;
               _loc15_ = _loc20_.TreasureMapBoxList[_loc19_];
               _loc15_.Identify = _loc19_;
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
               _loc15_.Inventories = _loc9_;
               _loc5_++;
            }
            _loc4_++;
         }
         _loc17_.RefreshBuyTime = param1.readUnsignedInt();
         _loc17_.RefreshPrize = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc9_ = new TInventories();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc15_ = _loc17_.BuyTreasureMapBoxList[_loc4_];
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc4_++;
         }
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc21_ = _loc17_.SeekTreasureMapBoxList[_loc4_];
            _loc21_.TreasureIndex = param1.readUnsignedInt() - 1;
            _loc21_.GraphStatus = param1.readUnsignedInt();
            _loc21_.CurStep = param1.readUnsignedInt();
            _loc15_ = _loc21_.TreasureBoxList[_loc4_];
            _loc17_.SeekTreasureStatue = _loc21_.GraphStatus;
            _loc7_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc9_ = new TInventories();
               _loc13_.length = 0;
               _loc14_.length = 0;
               _loc19_ = param1.readUnsignedInt() - 1;
               _loc12_ = param1.readUnsignedInt() - 1;
               _loc15_ = _loc21_.TreasureBoxList[_loc19_];
               _loc15_.Type = _loc12_;
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
               _loc15_.Inventories = _loc9_;
               _loc5_++;
            }
            _loc4_++;
         }
         _loc17_.SeekTreasureCount = param1.readUnsignedInt();
         _loc6_ = param1.readShort();
         if(_loc6_ == 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc17_.TreasureMapBoxList.length)
            {
               _loc17_.TreasureMapBoxList[_loc4_] = null;
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc9_ = new TInventories();
               _loc13_.length = 0;
               _loc14_.length = 0;
               _loc19_ = param1.readUnsignedInt() - 1;
               _loc15_ = _loc17_.TreasureMapBoxList[_loc19_];
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
               _loc15_.Inventories = _loc9_;
               _loc4_++;
            }
         }
         _loc17_.FreeTimes = param1.readUnsignedInt();
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
         var _loc15_:TBaseBox = null;
         var _loc16_:TThanksgivingDayDatas = null;
         var _loc17_:TThanksgivingDay3 = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         _loc16_ = param2 as TThanksgivingDayDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_3_ID) as TThanksgivingDay3;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.InitDescListNew();
         _loc17_.RankPoint = param1.readUnsignedInt();
         _loc17_.Round = param1.readUnsignedInt();
         _loc17_.CurMyRank = param1.readUnsignedInt();
         _loc17_.DartID = param1.readUnsignedInt();
         _loc17_.ItemID = param1.readUnsignedInt();
         _loc17_.FreeCount = param1.readUnsignedInt();
         _loc17_.PowerPrice = param1.readUnsignedInt();
         _loc17_.MyPower = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc14_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         _loc15_ = new TBaseBox();
         _loc15_.Type = param1.readUnsignedInt();
         _loc15_.Identify = param1.readUnsignedInt();
         _loc17_.Pet = _loc15_;
         _loc15_ = new TBaseBox();
         _loc15_.Status = param1.readInt();
         _loc15_.Price = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc13_.length = 0;
         _loc14_.length = 0;
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
         _loc15_.Inventories = _loc9_;
         _loc17_.BigBox = _loc15_;
         _loc17_.BoxList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
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
            _loc15_.Inventories = _loc9_;
            _loc17_.BoxList[_loc4_] = _loc15_;
            _loc4_++;
         }
         this.FUnstreamizerBaseActivityTask.Unstreamize(param1,this.FActivityTaskData,null);
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
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBaseBox = null;
         var _loc18_:TThanksgivingDayDatas = null;
         var _loc19_:TThanksgivingDay4 = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc18_ = param2 as TThanksgivingDayDatas;
         _loc19_ = _loc18_.GetActivityByIdentify(ACTIVITY_4_ID) as TThanksgivingDay4;
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
         _loc19_.BoxScore = param1.readUnsignedInt();
         _loc19_.ShopExchangePoint = param1.readUnsignedInt();
         _loc19_.CardPrice = param1.readUnsignedInt();
         _loc19_.AllOpenPrice = param1.readUnsignedInt();
         _loc19_.AgainPrice = param1.readUnsignedInt();
         _loc19_.FreeCount = param1.readUnsignedInt();
         _loc17_ = new TBaseBox();
         _loc17_.Status = param1.readInt();
         _loc17_.Identify = param1.readUnsignedInt();
         _loc17_.Price = param1.readUnsignedInt();
         _loc19_.Hero = _loc17_;
         _loc19_.BoxList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TBaseBox();
            _loc17_.Status = param1.readInt();
            _loc17_.Price = param1.readUnsignedInt();
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
            _loc17_.Inventories = _loc9_;
            _loc19_.BoxList[_loc4_] = _loc17_;
            _loc4_++;
         }
         _loc19_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TBaseBox();
            _loc17_.LimitCount = param1.readUnsignedInt();
            _loc17_.Price = param1.readUnsignedInt();
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
            _loc17_.Inventories = _loc9_;
            _loc19_.ShopExchangeItems[_loc4_] = _loc17_;
            _loc4_++;
         }
         _loc19_.CardList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_.CardList[_loc4_] = param1.readInt();
            _loc4_++;
         }
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc15_.length = 0;
         _loc16_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_.push(param1.readUnsignedInt());
            _loc16_.push(param1.readUnsignedInt());
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
            _loc8_.NewType = _loc15_[_loc4_];
            _loc8_.NewIdentify = _loc16_[_loc4_];
            _loc4_++;
         }
         _loc19_.EquipList = _loc9_;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

