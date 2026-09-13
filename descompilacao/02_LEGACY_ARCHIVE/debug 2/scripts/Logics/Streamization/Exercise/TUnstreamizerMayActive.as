package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MayActive.TMayActive1;
   import Logics.Exercise.MayActive.TMayActive2;
   import Logics.Exercise.MayActive.TMayActive3;
   import Logics.Exercise.MayActive.TMayActive4;
   import Logics.Exercise.MayActive.TMayActiveDatas;
   import Logics.Exercise.MayActive.TMsgGraph;
   import Logics.Exercise.MayActive.TMsgTreasure;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerMayActive extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerMayActive()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TMayActiveDatas = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TMayActiveDatas;
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
         var _loc16_:TMayActiveDatas = null;
         var _loc17_:TMayActive1 = null;
         var _loc18_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TMayActiveDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_1_ID) as TMayActive1;
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
         var _loc16_:TMayActiveDatas = null;
         var _loc17_:TMayActive2 = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:TMsgTreasure = null;
         var _loc21_:TMsgGraph = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TMayActiveDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2;
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
         _loc17_.ActivityDesc = _loc17_.DescListNew[13];
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
         var _loc16_:TMayActiveDatas = null;
         var _loc17_:TMayActive3 = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TMayActiveDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_3_ID) as TMayActive3;
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
         _loc17_.RefreshTime = param1.readUnsignedInt();
         _loc17_.RefreshCost = param1.readUnsignedInt();
         _loc17_.MyPower = param1.readUnsignedInt();
         _loc17_.APValue = param1.readUnsignedInt();
         _loc17_.MPValue = param1.readUnsignedInt();
         _loc17_.MaxAP = param1.readUnsignedInt();
         _loc17_.MaxMP = param1.readUnsignedInt();
         _loc17_.AddAPCost = param1.readUnsignedInt();
         _loc17_.AddMPCost = param1.readUnsignedInt();
         _loc17_.KillCount = param1.readUnsignedInt();
         _loc17_.RankPoint = param1.readUnsignedInt();
         _loc17_.CurMyRank = param1.readUnsignedInt();
         _loc17_.BossIsAppear = param1.readUnsignedInt();
         _loc17_.BossAppearTime = param1.readUnsignedInt();
         _loc17_.RewardRound = param1.readUnsignedInt();
         _loc15_ = new TBaseBox();
         _loc15_.Type = param1.readUnsignedInt();
         _loc15_.Level = param1.readUnsignedInt();
         _loc15_.Time = param1.readUnsignedInt();
         _loc17_.MySoldier = _loc15_;
         _loc15_ = new TBaseBox();
         _loc15_.Type = param1.readUnsignedInt();
         _loc15_.Min = param1.readUnsignedInt();
         _loc15_.Max = param1.readUnsignedInt();
         _loc15_.Price = param1.readUnsignedInt();
         _loc17_.CurMonster = _loc15_;
         _loc15_ = new TBaseBox();
         _loc15_.Type = param1.readUnsignedInt();
         _loc15_.Min = param1.readUnsignedInt();
         _loc15_.Max = param1.readUnsignedInt();
         _loc15_.Price = param1.readUnsignedInt();
         _loc17_.CurBoss = _loc15_;
         _loc17_.SoldierList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc15_.Type = param1.readUnsignedInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc15_.Level = param1.readUnsignedInt();
            _loc17_.SoldierList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.MonsterDesc.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.MonsterDescNew[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc17_.InitMonsterDescNew();
         _loc17_.GiftList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Count = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc17_.GiftList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.SpecialReward.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc15_.Type = param1.readUnsignedInt();
            _loc15_.Identify = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            if(_loc15_.Type == TBaseBox.TYPE_IS_ITEM)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
               _loc13_.push(_loc10_);
               _loc14_.push(param1.readUnsignedInt());
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
               _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
               _loc15_.Inventories = _loc9_;
            }
            else
            {
               param1.readUnsignedInt();
               param1.readUnsignedInt();
               param1.readUnsignedInt();
            }
            _loc17_.SpecialReward[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.KillReward.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Count = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc17_.KillReward[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.BoxList.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc9_.GetInventoryByIndex(0).Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc17_.BoxList[_loc4_] = _loc15_;
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
         var _loc15_:TBaseBox = null;
         var _loc16_:TMayActiveDatas = null;
         var _loc17_:TMayActive4 = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TMayActiveDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_4_ID) as TMayActive4;
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
         _loc17_.Count = param1.readUnsignedInt();
         _loc17_.Score = param1.readUnsignedInt();
         _loc17_.TenPrice = param1.readUnsignedInt();
         _loc17_.SweetList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc17_.SweetList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.HeroList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Type = param1.readUnsignedInt();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.Status = param1.readInt();
            _loc15_.Identify = param1.readUnsignedInt();
            _loc15_.LimitCount = param1.readInt();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc15_.Desc3 = TUtilityString.FetchUTF(param1);
            _loc17_.HeroList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Price = param1.readUnsignedInt();
            _loc15_.LimitCount = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(param1.readUnsignedInt());
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc14_[0];
            _loc15_.Inventories = _loc9_;
            _loc17_.BoxList[_loc4_] = _loc15_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

