package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TWorldCupVo3;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.WorldCup.TWorldCup1;
   import Logics.Exercise.WorldCup.TWorldCup2;
   import Logics.Exercise.WorldCup.TWorldCupDatas;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerWorldCup extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerWorldCup(param1:int)
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
         var _loc6_:TWorldCupDatas = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TWorldCupDatas;
         _loc9_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc6_.DescList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < 11)
         {
            _loc6_.DescList[_loc4_] = String(10100 + _loc4_);
            _loc4_++;
         }
         _loc6_.InitDescListNew();
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
         var _loc17_:TWorldCupDatas = null;
         var _loc18_:TWorldCup1 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TWorldCupDatas;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_1_ID) as TWorldCup1;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.giftGold = param1.readUnsignedInt();
         _loc17_.gold = param1.readUnsignedInt();
         _loc18_.betCountry.length = 0;
         _loc18_.betValue.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_.betCountry[_loc4_] = param1.readUnsignedInt();
            _loc18_.betValue[_loc4_] = param1.readUnsignedInt();
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
         var _loc17_:TWorldCupDatas = null;
         var _loc18_:TWorldCup2 = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Object = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc17_ = param2 as TWorldCupDatas;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_2_ID) as TWorldCup2;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.giftGold = param1.readUnsignedInt();
         _loc17_.gold = param1.readUnsignedInt();
         _loc18_.BetInfo.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc23_ = new Object();
            _loc23_.id = param1.readUnsignedInt();
            _loc23_.result = param1.readInt();
            _loc23_.gold = param1.readUnsignedInt();
            _loc23_.type = param1.readUnsignedInt();
            _loc23_.end = param1.readUnsignedInt();
            _loc18_.BetInfo.push(_loc23_);
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
         var _loc17_:TWorldCupDatas = null;
         var _loc18_:Vector.<int> = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:TWorldCupVo3 = null;
         var _loc21_:TBins = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc18_ = new Vector.<int>();
         _loc19_ = new Vector.<int>();
         _loc17_ = param2 as TWorldCupDatas;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc21_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WorldCup3);
         _loc17_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc5_ = int(param1.readUnsignedInt());
            _loc20_ = _loc21_.GetDatebaseByIdentifier(_loc5_) as TWorldCupVo3;
            _loc16_.Identify = _loc5_;
            _loc16_.LimitCount = _loc20_.personallimit - param1.readUnsignedInt();
            _loc16_.Price = _loc20_.price;
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc12_ = 1;
            _loc11_ = uint(_loc20_.item);
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,param3);
            _loc13_.push(_loc10_);
            _loc14_.push(_loc20_.num);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc14_[0];
            _loc16_.Inventories = _loc9_;
            _loc17_.ShopExchangeItems[_loc4_] = _loc16_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

