package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2016.TChristmas1_2016;
   import Logics.Exercise.Christmas2016.TChristmas2_2016;
   import Logics.Exercise.Christmas2016.TChristmas3_2016;
   import Logics.Exercise.Christmas2016.TChristmas4_2016;
   import Logics.Exercise.Christmas2016.TChristmasDatas_2016;
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
   
   public class TUnstreamizerChristmas2016 extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerChristmas2016(param1:int)
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
         var _loc6_:TChristmasDatas_2016 = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TChristmasDatas_2016;
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
         var _loc10_:TInventories = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<int> = null;
         var _loc17_:TBaseBox = null;
         var _loc18_:TChristmasDatas_2016 = null;
         var _loc19_:TChristmas1_2016 = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:Vector.<int> = null;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         _loc14_ = new Vector.<uint>();
         _loc15_ = new Vector.<uint>();
         _loc20_ = new Vector.<int>();
         _loc21_ = new Vector.<int>();
         _loc16_ = new Vector.<int>();
         _loc18_ = param2 as TChristmasDatas_2016;
         _loc19_ = _loc18_.GetActivityByIdentify(ACTIVITY_1_ID) as TChristmas1_2016;
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
         _loc19_.SignCost = param1.readUnsignedInt();
         _loc19_.TotalSign = param1.readUnsignedInt();
         _loc19_.CurStatus = param1.readInt();
         _loc19_.CurDay = param1.readUnsignedInt();
         _loc19_.BuySignDay = param1.readUnsignedInt();
         _loc19_.TotalRechargeGold = param1.readUnsignedInt();
         _loc19_.TotalSignGift.Status = param1.readInt();
         _loc19_.TotalSignGift.Price = param1.readUnsignedInt();
         _loc14_.length = 0;
         _loc15_.length = 0;
         _loc9_ = new TInventories();
         _loc7_ = int(param1.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = CONST_COMMON.GetItemIDByType(_loc13_,_loc12_,param3);
            _loc14_.push(_loc11_);
            _loc15_.push(param1.readUnsignedInt());
            _loc5_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
            _loc8_.Quantity = _loc15_[_loc5_];
            _loc5_++;
         }
         _loc19_.TotalSignGift.Inventories = _loc9_;
         _loc19_.GiftList.length = 0;
         _loc19_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TBaseBox();
            _loc17_.Price = param1.readUnsignedInt();
            _loc17_.Status = param1.readInt();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = CONST_COMMON.GetItemIDByType(_loc13_,_loc12_,param3);
               _loc14_.push(_loc11_);
               _loc15_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc15_[_loc5_];
               _loc5_++;
            }
            _loc17_.Inventories = _loc9_;
            _loc19_.GiftList[_loc4_] = _loc17_;
            _loc17_ = new TBaseBox();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc20_.length = 0;
            _loc21_.length = 0;
            _loc16_.length = 0;
            _loc10_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc16_.push(param1.readUnsignedInt());
               _loc20_.push(param1.readUnsignedInt());
               _loc21_.push(param1.readUnsignedInt());
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = CONST_COMMON.GetItemIDByType(_loc13_,_loc12_,param3);
               _loc14_.push(_loc11_);
               _loc15_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc14_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc10_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc15_[_loc5_];
               _loc8_.LimitCount = _loc21_[_loc5_];
               _loc8_.MaxPrice = _loc16_[_loc5_];
               _loc8_.MinPrice = _loc20_[_loc5_];
               _loc5_++;
            }
            _loc17_.Inventories = _loc10_;
            _loc19_.ShopExchangeItems[_loc4_] = _loc17_;
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_ = new TBaseBox();
            _loc17_.Status = param1.readInt();
            _loc14_.length = 0;
            _loc15_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = CONST_COMMON.GetItemIDByType(_loc13_,_loc12_,param3);
               _loc14_.push(_loc11_);
               _loc15_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc14_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc15_[_loc5_];
               _loc5_++;
            }
            _loc17_.Inventories = _loc9_;
            _loc19_.DayList[_loc4_] = _loc17_;
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
         var _loc17_:TChristmasDatas_2016 = null;
         var _loc18_:TChristmas2_2016 = null;
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
         _loc17_ = param2 as TChristmasDatas_2016;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmas2_2016;
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
         _loc18_.TotalScore = param1.readUnsignedInt();
         _loc18_.ShopExchangePoint = param1.readUnsignedInt();
         _loc18_.BoxPrice = param1.readUnsignedInt();
         _loc18_.TotalBoxPrice = param1.readUnsignedInt();
         _loc18_.ResetPrice = param1.readUnsignedInt();
         _loc18_.FreeCount = param1.readUnsignedInt();
         _loc18_.TotalRechargeGold = param1.readUnsignedInt();
         _loc16_ = new TBaseBox();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Count = param1.readUnsignedInt();
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
         _loc18_.RechargeGift = _loc16_;
         _loc18_.RewardsIndex.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.RewardsIndex[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.TitleList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
            _loc16_.Identify = param1.readUnsignedInt();
            _loc18_.TitleList[_loc4_] = _loc16_;
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
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
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
            _loc4_++;
         }
         _loc18_.Equipments = _loc9_;
         this.FUnstreamizerBaseActivityTask.Unstreamize(param1,this.FActivityTaskData,null);
         _loc18_.PetID = param1.readUnsignedInt();
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
         var _loc17_:TChristmasDatas_2016 = null;
         var _loc18_:TChristmas3_2016 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TChristmasDatas_2016;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmas3_2016;
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
         _loc18_.TenPrice = param1.readUnsignedInt();
         _loc18_.Count = param1.readUnsignedInt();
         _loc18_.Score = param1.readUnsignedInt();
         _loc18_.TotalRechargeGold = param1.readUnsignedInt();
         _loc18_.PoolValue = param1.readUnsignedInt();
         _loc18_.PoolMax = param1.readUnsignedInt();
         _loc16_ = new TBaseBox();
         _loc16_.Count = param1.readUnsignedInt();
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
         _loc16_.Inventories = _loc9_;
         _loc18_.Gift = _loc16_;
         _loc18_.SweetList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
            _loc18_.SweetList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc18_.HeroGold.length = 0;
         _loc18_.HeroScore.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.HeroGold[_loc4_] = param1.readUnsignedInt();
            _loc18_.HeroScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.PetGold.length = 0;
         _loc18_.PetScore.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.PetGold[_loc4_] = param1.readUnsignedInt();
            _loc18_.PetScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc18_.ItemGold.length = 0;
         _loc18_.ItemScore.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.ItemGold[_loc4_] = param1.readUnsignedInt();
            _loc18_.ItemScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc16_ = new TBaseBox();
         _loc16_.Type = param1.readInt();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Status = param1.readInt();
         _loc16_.Identify = param1.readUnsignedInt();
         _loc18_.Hero = _loc16_;
         _loc16_ = new TBaseBox();
         _loc16_.Type = param1.readInt();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.Status = param1.readInt();
         _loc16_.Identify = param1.readUnsignedInt();
         _loc18_.Pet = _loc16_;
         _loc18_.ItemList.length = 0;
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
            _loc18_.ItemList[_loc4_] = _loc16_;
            _loc4_++;
         }
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
         var _loc17_:TChristmasDatas_2016 = null;
         var _loc18_:TChristmas4_2016 = null;
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
         _loc17_ = param2 as TChristmasDatas_2016;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmas4_2016;
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

