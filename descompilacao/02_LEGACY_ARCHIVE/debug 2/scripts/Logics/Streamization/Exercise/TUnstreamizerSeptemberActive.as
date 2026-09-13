package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.SeptemberActive.TSeptemberActive1;
   import Logics.Exercise.SeptemberActive.TSeptemberActive2;
   import Logics.Exercise.SeptemberActive.TSeptemberActive3;
   import Logics.Exercise.SeptemberActive.TSeptemberActive4;
   import Logics.Exercise.SeptemberActive.TSeptemberActiveDatas;
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
   
   public class TUnstreamizerSeptemberActive extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerSeptemberActive(param1:int)
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
         var _loc6_:TSeptemberActiveDatas = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TSeptemberActiveDatas;
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
         var _loc17_:TSeptemberActive1 = null;
         var _loc18_:TSeptemberActiveDatas = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = param2 as TSeptemberActiveDatas;
         _loc17_ = _loc18_.GetActivityByIdentify(ACTIVITY_1_ID) as TSeptemberActive1;
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
         _loc17_.TotalCount = param1.readUnsignedInt();
         _loc17_.MyCount = param1.readUnsignedInt();
         _loc17_.GiftList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = param1.readShort();
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
            _loc17_.GiftList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc16_ = new TBaseBox();
         _loc16_.Price = param1.readUnsignedInt();
         _loc16_.CurPrice = param1.readUnsignedInt();
         _loc16_.LimitCount = param1.readUnsignedInt();
         _loc16_.Discount = param1.readUnsignedInt();
         _loc16_.Type = param1.readInt();
         _loc16_.Identify = param1.readUnsignedInt();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc9_ = new TInventories();
         _loc12_ = param1.readUnsignedInt();
         _loc11_ = param1.readUnsignedInt();
         _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
         _loc13_.push(_loc10_);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
         _loc8_ = _loc9_.GetInventoryByIndex(0);
         _loc8_.Quantity = param1.readUnsignedInt();
         _loc16_.Inventories = _loc9_;
         _loc17_.SaleItem = _loc16_;
         _loc17_.ServerList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.BuyCount = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
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
            _loc17_.ServerList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc17_.BoxList.length = 0;
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
            _loc17_.BoxList[_loc4_] = _loc16_;
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
         var _loc17_:TSeptemberActive2 = null;
         var _loc18_:TSeptemberActiveDatas = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc18_ = param2 as TSeptemberActiveDatas;
         _loc17_ = _loc18_.GetActivityByIdentify(ACTIVITY_2_ID) as TSeptemberActive2;
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
         _loc17_.CurGold = param1.readUnsignedInt();
         _loc17_.WaterCount = param1.readUnsignedInt();
         _loc17_.WaterReduceTime = param1.readUnsignedInt();
         _loc17_.WaterPrice = param1.readUnsignedInt();
         _loc17_.MaxGold = param1.readUnsignedInt();
         _loc17_.TreeLevel = param1.readUnsignedInt();
         _loc17_.NextTime = param1.readUnsignedInt();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc17_.FruitStatus.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.FruitStatus[_loc4_] = param1.readInt();
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
         _loc17_.FruitList = _loc9_;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc19_.length = 0;
         _loc20_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_[_loc4_] = param1.readUnsignedInt();
            _loc20_[_loc4_] = param1.readUnsignedInt();
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
         _loc17_.ShowItems = _loc9_;
         _loc13_.length = 0;
         _loc14_.length = 0;
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
         _loc17_.WaterReward = _loc9_;
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
         var _loc17_:TSeptemberActive3 = null;
         var _loc18_:TSeptemberActiveDatas = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:Object = null;
         var _loc22_:TLotteryNews = null;
         var _loc23_:TSystemLanguage = null;
         var _loc24_:TConfigValue = null;
         var _loc25_:Vector.<Object> = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         _loc18_ = param2 as TSeptemberActiveDatas;
         _loc17_ = _loc18_.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
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
         _loc17_.MyScore = param1.readUnsignedInt();
         _loc17_.RankPoint = param1.readUnsignedInt();
         _loc17_.CurMyRank = param1.readUnsignedInt();
         _loc17_.PoolGold = param1.readUnsignedInt();
         _loc17_.TotalCount = param1.readUnsignedInt();
         _loc17_.ScorePrice = param1.readUnsignedInt();
         _loc17_.WishIndex = param1.readUnsignedInt() - 1;
         param1.readShort();
         _loc17_.ItemAID = param1.readUnsignedInt();
         _loc17_.ItemBID = param1.readUnsignedInt();
         _loc17_.BoxList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Price = param1.readUnsignedInt();
            _loc17_.BoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc17_.ServerBoxList.length = 0;
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
            _loc17_.ServerBoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc19_.length = 0;
         _loc20_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc19_[_loc4_] = param1.readUnsignedInt();
            _loc20_[_loc4_] = param1.readUnsignedInt();
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
         _loc17_.ShowItems = _loc9_;
         _loc17_.LuckyList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc21_ = new Object();
            _loc21_.name = TUtilityString.FetchUTF(param1);
            _loc21_.server = TUtilityString.FetchUTF(param1);
            _loc21_.gold = param1.readUnsignedInt();
            _loc21_.date = param1.readUnsignedInt();
            _loc17_.LuckyList[_loc4_] = _loc21_;
            _loc4_++;
         }
         _loc17_.ServerNews.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc22_ = new TLotteryNews();
            _loc22_.Identifier0 = param1.readUnsignedInt();
            _loc22_.Identifier1 = param1.readUnsignedInt();
            _loc22_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc22_.SoureID = param1.readUnsignedInt();
            if(_loc22_.SoureID != 0)
            {
               _loc23_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc22_.SoureID) as TSystemLanguage;
               _loc22_.GetSource = _loc23_.Desc;
            }
            else
            {
               _loc22_.GetSource = "";
            }
            _loc13_.length = 0;
            _loc9_ = new TInventories();
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = param1.readUnsignedInt();
            _loc22_.GetTime = param1.readUnsignedInt();
            _loc22_.Inventories = _loc9_;
            _loc17_.ServerNews[_loc4_] = _loc22_;
            _loc4_++;
         }
         _loc24_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380007) as TConfigValue;
         _loc25_ = _loc24_.Value as Vector.<Object>;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc9_ = new TInventories();
         _loc6_ = int(_loc25_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_ = 1;
            _loc11_ = parseInt(_loc25_[_loc4_] as String);
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(1);
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
         _loc17_.Equipments = _loc9_;
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
         var _loc15_:Vector.<int> = null;
         var _loc16_:TBaseBox = null;
         var _loc17_:TSeptemberActive4 = null;
         var _loc18_:TSeptemberActiveDatas = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:Object = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc18_ = param2 as TSeptemberActiveDatas;
         _loc17_ = _loc18_.GetActivityByIdentify(ACTIVITY_4_ID) as TSeptemberActive4;
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
         _loc17_.FreeCount = param1.readUnsignedInt();
         _loc17_.RechargeGold = param1.readUnsignedInt();
         _loc17_.CurScore = param1.readUnsignedInt();
         _loc17_.BoxPrice = param1.readUnsignedInt();
         _loc17_.TotalBoxPrice = param1.readUnsignedInt();
         _loc17_.ItemAID = param1.readUnsignedInt();
         _loc17_.HeroScore.length = 0;
         _loc17_.HeroGold.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.HeroGold[_loc4_] = param1.readUnsignedInt();
            _loc17_.HeroScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc17_.GiftScore.length = 0;
         _loc17_.GiftGold.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.GiftGold[_loc4_] = param1.readUnsignedInt();
            _loc17_.GiftScore[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc16_ = new TBaseBox();
         _loc16_.Status = param1.readInt();
         _loc16_.Identify = param1.readUnsignedInt();
         _loc16_.Price = param1.readUnsignedInt();
         _loc17_.Hero = _loc16_;
         _loc17_.GiftList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.LimitCount = param1.readUnsignedInt();
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
            _loc17_.GiftList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc17_.RewardsIndex.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc17_.RewardsIndex[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc17_.Rewards.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
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
            _loc17_.Rewards[_loc4_] = _loc9_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

