package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Bejeweled.TBejeweled;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerBejeweled extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUnstreamizerBaseActivityTask:TUnstreamizerBaseActivityTask;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      public function TUnstreamizerBejeweled(param1:int)
      {
         super();
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUnstreamizerBaseActivityTask = new TUnstreamizerBaseActivityTask();
         this.FUnstreamizerBaseActivityTask.activityId = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TInventory = null;
         var _loc11_:TInventories = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:TBins = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:Vector.<int> = null;
         var _loc20_:Vector.<int> = null;
         var _loc21_:TBejeweled = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = param2 as TBejeweled;
         _loc17_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc21_.BeginTime = param1.readUnsignedInt();
         _loc21_.EndTime = param1.readUnsignedInt();
         _loc21_.DescList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc21_.InitDescListNew();
         _loc21_.ShopExchangePoint = param1.readUnsignedInt();
         _loc21_.RankPoint = param1.readUnsignedInt();
         _loc21_.CurMyRank = param1.readUnsignedInt();
         _loc21_.RankType = param1.readUnsignedInt();
         _loc21_.ScoreA = param1.readUnsignedInt();
         _loc21_.ScorePrice = param1.readUnsignedInt();
         _loc21_.Double = param1.readUnsignedInt();
         _loc21_.ScoreB = param1.readUnsignedInt();
         _loc21_.AutoPrice = param1.readUnsignedInt();
         _loc18_ = new TBaseBox();
         _loc18_.Price = param1.readUnsignedInt();
         _loc21_.ConsumeScore = param1.readUnsignedInt();
         _loc18_.Count = param1.readUnsignedInt();
         _loc15_.length = 0;
         _loc16_.length = 0;
         _loc11_ = new TInventories();
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc4_);
            _loc10_.Quantity = _loc16_[_loc4_];
            _loc4_++;
         }
         _loc18_.Inventories = _loc11_;
         _loc21_.Gift = _loc18_;
         _loc21_.ScoreList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.ScoreList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc21_.IceList.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.IceList[_loc4_] = param1.readInt();
            _loc4_++;
         }
         _loc15_.length = 0;
         _loc16_.length = 0;
         _loc19_.length = 0;
         _loc20_.length = 0;
         _loc11_ = new TInventories();
         _loc7_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc19_.push(param1.readUnsignedInt());
            _loc20_.push(param1.readUnsignedInt());
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc4_);
            _loc10_.Quantity = _loc16_[_loc4_];
            _loc10_.NewType = _loc19_[_loc4_];
            _loc10_.NewIdentify = _loc20_[_loc4_];
            _loc4_++;
         }
         _loc21_.ShowItems = _loc11_;
         _loc15_.length = 0;
         _loc16_.length = 0;
         _loc19_.length = 0;
         _loc20_.length = 0;
         _loc11_ = new TInventories();
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc19_.push(param1.readUnsignedInt());
            _loc20_.push(param1.readUnsignedInt());
            _loc14_ = param1.readUnsignedInt();
            _loc13_ = param1.readUnsignedInt();
            _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
            _loc15_.push(_loc12_);
            _loc16_.push(param1.readUnsignedInt());
            _loc4_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc10_ = _loc11_.GetInventoryByIndex(_loc4_);
            _loc10_.Quantity = _loc16_[_loc4_];
            _loc10_.NewType = _loc19_[_loc4_];
            _loc10_.NewIdentify = _loc20_[_loc4_];
            _loc4_++;
         }
         _loc21_.Equipments = _loc11_;
         _loc21_.Titles.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.Titles[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc21_.ShopExchangeItems.length = 0;
         _loc7_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.LimitCount = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.IsHot = param1.readUnsignedInt();
            _loc15_.length = 0;
            _loc16_.length = 0;
            _loc11_ = new TInventories();
            _loc8_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc14_ = param1.readUnsignedInt();
               _loc13_ = param1.readUnsignedInt();
               _loc12_ = CONST_COMMON.GetItemIDByType(_loc14_,_loc13_,_loc17_);
               _loc15_.push(_loc12_);
               _loc16_.push(param1.readUnsignedInt());
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc11_,_loc15_);
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc10_ = _loc11_.GetInventoryByIndex(_loc5_);
               _loc10_.Quantity = _loc16_[_loc5_];
               _loc5_++;
            }
            _loc18_.Inventories = _loc11_;
            _loc21_.ShopExchangeItems[_loc4_] = _loc18_;
            _loc4_++;
         }
         this.FUnstreamizerBaseActivityTask.Unstreamize(param1,this.FActivityTaskData,param3);
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

