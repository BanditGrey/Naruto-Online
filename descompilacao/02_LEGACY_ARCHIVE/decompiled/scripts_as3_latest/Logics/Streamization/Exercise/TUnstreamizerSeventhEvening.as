package Logics.Streamization.Exercise
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SeventhEvening.TSeventhEvening;
   import Logics.Exercise.SeventhEvening.TSeventhEveningBallon;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TExchangeItem;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSeventhEvening extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerSeventhEvening()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TSeventhEvening = null;
         var _loc13_:TSeventhEveningBallon = null;
         var _loc14_:TExchangeItem = null;
         _loc12_ = param2 as TSeventhEvening;
         _loc12_.Identify = param1.readUnsignedInt();
         _loc12_.BeginTime = param1.readUnsignedInt();
         _loc12_.EndTime = param1.readUnsignedInt();
         _loc12_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityTabName = TUtilityString.FetchUTF(param1);
         _loc12_.RankPoint = param1.readUnsignedInt();
         _loc12_.MaxTotalHeartScore = param1.readUnsignedInt();
         _loc12_.TotalHeartScore = param1.readUnsignedInt();
         _loc12_.SeventhEveningRewardStatus = param1.readUnsignedInt();
         _loc12_.FreeCount = param1.readUnsignedInt();
         _loc12_.FreeMaxCount = param1.readUnsignedInt();
         _loc12_.Hero = new TBaseBox();
         _loc12_.Hero.Type = param1.readUnsignedInt();
         _loc12_.Hero.Identify = param1.readUnsignedInt();
         _loc12_.CurMyRank = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.HeartRewardName[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.FreeHeartRewardName[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc12_.InitNameNew();
         if(_loc12_.NeedConfig)
         {
            _loc10_ = new Vector.<uint>();
            _loc11_ = new Vector.<uint>();
            _loc6_ = int(param1.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc10_.push(param1.readUnsignedInt());
               _loc11_.push(param1.readUnsignedInt());
               _loc4_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc4_);
               _loc8_.Quantity = _loc11_[_loc4_];
               _loc4_++;
            }
            _loc12_.HeartReward = _loc9_;
            _loc10_.length = 0;
            _loc11_.length = 0;
            _loc6_ = int(param1.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc10_.push(param1.readUnsignedInt());
               _loc11_.push(param1.readUnsignedInt());
               _loc4_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc4_);
               _loc8_.Quantity = _loc11_[_loc4_];
               _loc4_++;
            }
            _loc12_.FreeHeartReward = _loc9_;
            _loc6_ = int(param1.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc13_ = new TSeventhEveningBallon();
               _loc13_.Identify = param1.readUnsignedInt();
               _loc13_.Price = param1.readUnsignedInt();
               _loc13_.HearteMinCount = param1.readUnsignedInt();
               _loc13_.MagpieMaxCount = param1.readUnsignedInt();
               _loc13_.MagpieMinCount = param1.readUnsignedInt();
               _loc7_ = int(param1.readUnsignedShort());
               _loc10_.length = 0;
               _loc11_.length = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc10_.push(param1.readUnsignedInt());
                  _loc11_.push(param1.readUnsignedInt());
                  _loc5_++;
               }
               _loc9_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
                  _loc8_.Quantity = _loc11_[_loc5_];
                  _loc5_++;
               }
               _loc13_.Inventories = _loc9_;
               _loc12_.BallonList[_loc4_] = _loc13_;
               _loc4_++;
            }
            _loc10_.length = 0;
            _loc10_.push(param1.readUnsignedInt());
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc8_ = new TInventory(0,0);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc12_.SeventhEveningBox = _loc8_;
            _loc12_.NeedConfig = false;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

