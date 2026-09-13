package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SpringFestival.TSpringFestivalCollect;
   import Logics.Exercise.SpringFestival.TSpringFestivalDatas;
   import Logics.Exercise.SpringFestival.TSpringFestivalFireworks;
   import Logics.Exercise.SpringFestival.TSpringFestivalFish;
   import Logics.Exercise.SpringFestival.TSpringFestivalTaiko;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSpringFestival extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerSpringFestival()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TSpringFestivalDatas = null;
         var _loc7_:TBaseActivity = null;
         var _loc8_:int = 0;
         var _loc9_:TBins = null;
         _loc6_ = param2 as TSpringFestivalDatas;
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
               this.UnstreamizationPerform_Fireworks(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_2_ID:
               this.UnstreamizationPerform_Fish(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_3_ID:
               this.UnstreamizationPerform_Taiko(param1,_loc6_,_loc9_);
               break;
            case ACTIVITY_4_ID:
               this.UnstreamizationPerform_Collect(param1,_loc6_,_loc9_);
         }
      }
      
      protected function UnstreamizationPerform_Fireworks(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc16_:TSpringFestivalDatas = null;
         var _loc17_:TSpringFestivalFireworks = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TSpringFestivalDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_1_ID) as TSpringFestivalFireworks;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc17_.TotalDays = param1.readUnsignedInt();
         _loc17_.FishList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc15_.Status = param1.readInt();
            _loc15_.Price = param1.readUnsignedInt();
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
            _loc17_.FishList[_loc4_] = _loc15_;
            _loc4_++;
         }
         _loc17_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
            _loc15_.Desc1 = TUtilityString.FetchUTF(param1);
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
         _loc17_.FireworkStatus = param1.readInt();
         _loc17_.ContiueDays = param1.readUnsignedInt();
         _loc17_.FireworkDays = param1.readUnsignedInt();
         _loc17_.FireworkCost = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
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
         _loc17_.Inventories = _loc9_;
      }
      
      protected function UnstreamizationPerform_Fish(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc17_:TSpringFestivalDatas = null;
         var _loc18_:TSpringFestivalFish = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TSpringFestivalDatas;
         _loc18_ = _loc17_.GetActivityByIdentify(ACTIVITY_2_ID) as TSpringFestivalFish;
         _loc18_.BeginTime = param1.readUnsignedInt();
         _loc18_.EndTime = param1.readUnsignedInt();
         _loc18_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc18_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc18_.TotalMoney = param1.readUnsignedInt();
         _loc18_.Count = param1.readUnsignedInt();
         _loc18_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Status = param1.readInt();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Desc2 = TUtilityString.FetchUTF(param1);
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
         _loc18_.FishList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc15_ = new Vector.<int>();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Desc2 = TUtilityString.FetchUTF(param1);
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
               _loc15_.push(param1.readUnsignedInt());
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
            _loc16_.MaxVect = _loc15_;
            _loc18_.FishList[_loc4_] = _loc16_;
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerform_Taiko(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc16_:TSpringFestivalDatas = null;
         var _loc17_:TSpringFestivalTaiko = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TSpringFestivalDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_3_ID) as TSpringFestivalTaiko;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc17_.Score = param1.readUnsignedInt();
         _loc17_.Round = param1.readUnsignedInt();
         _loc17_.MyRank = param1.readUnsignedInt();
         _loc17_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc17_.Count = param1.readUnsignedInt();
         _loc17_.Cost = param1.readUnsignedInt();
         _loc17_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc15_ = new TBaseBox();
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
      }
      
      protected function UnstreamizationPerform_Collect(param1:ByteArray, param2:Object, param3:TBins) : void
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
         var _loc16_:TSpringFestivalDatas = null;
         var _loc17_:TSpringFestivalCollect = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = param2 as TSpringFestivalDatas;
         _loc17_ = _loc16_.GetActivityByIdentify(ACTIVITY_4_ID) as TSpringFestivalCollect;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc17_.Count = param1.readUnsignedInt();
         _loc17_.Score = param1.readUnsignedInt();
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

