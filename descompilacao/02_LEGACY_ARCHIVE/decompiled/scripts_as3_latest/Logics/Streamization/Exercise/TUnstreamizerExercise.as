package Logics.Streamization.Exercise
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TActivitiesData;
   import Logics.Exercise.FrogWallet.TCornucopia;
   import Logics.Exercise.FrogWallet.TCornucopiaBox;
   import Logics.Exercise.FrogWallet.TRechargeAccum;
   import Logics.Exercise.FrogWallet.TShadow;
   import Logics.Exercise.FrogWallet.TShadowConfig;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_FROGWALLET;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerExercise extends TUnstreamizer
   {
      
      public static const ACTIVITY_1_ID:int = CONST_FROGWALLET.ACTIVITY_1_ID;
      
      public static const ACTIVITY_2_ID:int = CONST_FROGWALLET.ACTIVITY_2_ID;
      
      public static const ACTIVITY_3_ID:int = CONST_FROGWALLET.ACTIVITY_3_ID;
      
      public static const ACTIVITY_4_ID:int = CONST_FROGWALLET.ACTIVITY_4_ID;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerExercise()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ActivityData(param1,param2);
      }
      
      protected function UnstreamizationPerform_ActivityData(param1:ByteArray, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = int(param1.readUnsignedInt());
         switch(_loc5_)
         {
            case ACTIVITY_1_ID:
               this.UnstreamizationPerform_Cornucopia(_loc5_,param1,param2);
               break;
            case ACTIVITY_2_ID:
               this.UnstreamizationPerform_RechargeAccum(_loc5_,param1,param2);
               break;
            case ACTIVITY_3_ID:
               this.UnstreamizationPerform_TenTail(_loc5_,param1,param2);
               break;
            case ACTIVITY_4_ID:
               this.UnstreamizationPerform_Shadow(_loc5_,param1,param2);
         }
      }
      
      protected function UnstreamizationPerform_Cornucopia(param1:int, param2:ByteArray, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TCornucopia = null;
         var _loc13_:TCornucopiaBox = null;
         var _loc14_:TActivitiesData = null;
         _loc14_ = param3 as TActivitiesData;
         _loc12_ = _loc14_.GetActivityByIdentify(param1) as TCornucopia;
         if(_loc12_ == null)
         {
            _loc12_ = new TCornucopia();
            _loc12_.Identify = param1;
            _loc12_.BeginTime = param2.readUnsignedInt();
            _loc12_.EndTime = param2.readUnsignedInt();
            _loc12_.PayEndTime = param2.readUnsignedInt();
            _loc12_.ActivityName = TUtilityString.FetchUTF(param2);
            _loc12_.ActivityTabName = TUtilityString.FetchUTF(param2);
            _loc12_.ActivityDesc = TUtilityString.FetchUTF(param2);
            _loc6_ = int(param2.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc13_ = new TCornucopiaBox();
               _loc13_.Identify = param2.readUnsignedInt();
               _loc13_.BoxName = TUtilityString.FetchUTF(param2);
               _loc13_.PayLimit = param2.readUnsignedInt();
               _loc13_.BoxPrice = param2.readUnsignedInt();
               _loc13_.Rebate = param2.readUnsignedInt();
               _loc13_.State = param2.readByte();
               _loc13_.GotTimes = param2.readUnsignedInt();
               _loc13_.GetGold = param2.readUnsignedInt();
               _loc13_.CanGetTime = param2.readUnsignedInt();
               _loc7_ = int(param2.readUnsignedShort());
               _loc10_ = new Vector.<uint>();
               _loc11_ = new Vector.<uint>();
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc10_.push(param2.readUnsignedInt());
                  _loc11_.push(param2.readUnsignedInt());
                  _loc5_++;
               }
               _loc9_ = new TInventories();
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
               _loc13_.Inventories = _loc9_;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = _loc13_.Inventories.GetInventoryByIndex(_loc5_);
                  _loc8_.Quantity = _loc11_[_loc5_];
                  _loc5_++;
               }
               _loc12_.CornucopiaList.push(_loc13_);
               _loc12_.RewardStatus.push(_loc13_.State);
               _loc4_++;
            }
            _loc14_.Activities.push(_loc12_);
         }
      }
      
      protected function UnstreamizationPerform_RechargeAccum(param1:int, param2:ByteArray, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TRechargeAccum = null;
         var _loc9_:TActivitiesData = null;
         _loc9_ = param3 as TActivitiesData;
         _loc8_ = _loc9_.GetActivityByIdentify(param1) as TRechargeAccum;
         if(_loc8_ == null)
         {
            _loc8_ = new TRechargeAccum();
            _loc9_.Activities.push(_loc8_);
         }
         _loc8_.Identify = param1;
         _loc8_.BeginTime = param2.readUnsignedInt();
         _loc8_.EndTime = param2.readUnsignedInt();
         _loc8_.PayEndTime = param2.readUnsignedInt();
         _loc8_.ActivityName = TUtilityString.FetchUTF(param2);
         _loc8_.ActivityTabName = TUtilityString.FetchUTF(param2);
         _loc8_.ActivityDesc = TUtilityString.FetchUTF(param2);
         _loc8_.Buff = param2.readUnsignedInt();
         _loc8_.RewardStatus[0] = param2.readByte();
         _loc8_.MinRechargeLimit = param2.readUnsignedInt();
         _loc5_ = int(param2.readUnsignedShort());
         _loc8_.Rebate.length = 0;
         _loc8_.RebateNeedGold.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_.RebateNeedGold.push(param2.readUnsignedInt());
            _loc8_.Rebate.push(param2.readUnsignedInt());
            _loc4_++;
         }
         _loc5_ = int(param2.readUnsignedShort());
         _loc8_.AmountGold.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_.AmountGold.push(param2.readUnsignedInt());
            _loc4_++;
         }
         _loc8_.CheckIsContinue();
      }
      
      protected function UnstreamizationPerform_TenTail(param1:int, param2:ByteArray, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TTenTail = null;
         var _loc13_:TActivitiesData = null;
         _loc13_ = param3 as TActivitiesData;
         _loc12_ = _loc13_.GetActivityByIdentify(param1) as TTenTail;
         if(_loc12_ == null)
         {
            _loc12_ = new TTenTail();
            _loc13_.Activities.push(_loc12_);
         }
         _loc12_.Identify = param1;
         _loc12_.BeginTime = param2.readUnsignedInt();
         _loc12_.EndTime = param2.readUnsignedInt();
         _loc12_.PayEndTime = param2.readUnsignedInt();
         _loc12_.ActivityName = TUtilityString.FetchUTF(param2);
         _loc12_.ActivityTabName = TUtilityString.FetchUTF(param2);
         _loc12_.ActivityDesc = TUtilityString.FetchUTF(param2);
         _loc12_.CurSoul = param2.readUnsignedInt();
         _loc12_.CurTenTail = param2.readUnsignedInt();
         _loc12_.ExchangeScale = param2.readUnsignedInt();
         _loc12_.FireColor = param2.readUnsignedInt();
         _loc6_ = int(param2.readUnsignedShort());
         _loc12_.RewardStatus.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RewardID[_loc4_] = param2.readUnsignedInt();
            _loc12_.RewardStatus.push(param2.readByte());
            _loc12_.RewardColor[_loc4_] = param2.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param2.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.DisplaySoulConfig[_loc4_] = param2.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param2.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RealSoulConfig[_loc4_] = param2.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param2.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.CertificateConfig[_loc4_] = param2.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param2.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.DisplayTenTailConfig[_loc4_] = param2.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param2.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RealTenTailConfig[_loc4_] = param2.readUnsignedInt();
            _loc4_++;
         }
         if(_loc12_.Rewards[0] == null)
         {
            _loc6_ = int(param2.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc11_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc10_.length = 0;
               _loc11_.length = 0;
               _loc9_ = new TInventories();
               _loc7_ = int(param2.readUnsignedShort());
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc10_.push(param2.readUnsignedInt());
                  _loc11_.push(param2.readUnsignedInt());
                  _loc5_++;
               }
               this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
                  _loc8_.Quantity = _loc11_[_loc5_];
                  _loc5_++;
               }
               _loc12_.Rewards[_loc4_] = _loc9_;
               _loc4_++;
            }
         }
      }
      
      protected function UnstreamizationPerform_Shadow(param1:int, param2:ByteArray, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TShadow = null;
         var _loc13_:TShadowConfig = null;
         var _loc14_:TActivitiesData = null;
         var _loc15_:int = 0;
         _loc14_ = param3 as TActivitiesData;
         _loc12_ = _loc14_.GetActivityByIdentify(param1) as TShadow;
         if(_loc12_ == null)
         {
            _loc12_ = new TShadow();
            _loc14_.Activities.push(_loc12_);
         }
         _loc12_.Identify = param1;
         _loc12_.BeginTime = param2.readUnsignedInt();
         _loc12_.EndTime = param2.readUnsignedInt();
         _loc12_.ActivityName = TUtilityString.FetchUTF(param2);
         _loc12_.ActivityTabName = TUtilityString.FetchUTF(param2);
         _loc12_.ActivityDesc = TUtilityString.FetchUTF(param2);
         _loc12_.Result = param2.readUnsignedInt();
         _loc12_.MinGold = param2.readUnsignedInt();
         _loc12_.PutGold = _loc12_.MinGold;
         _loc10_ = new Vector.<uint>();
         _loc11_ = new Vector.<uint>();
         _loc10_.length = 0;
         _loc11_.length = 0;
         _loc12_.Inventories.Clear();
         _loc9_ = new TInventories();
         _loc10_.push(param2.readUnsignedInt());
         _loc12_.PutCount = param2.readUnsignedInt();
         _loc11_.push(_loc12_.PutCount);
         if(_loc10_[0] != 0)
         {
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc10_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc11_[0];
            _loc12_.Inventories = _loc9_;
         }
         if(_loc12_.ShadowConfigs.length == 0)
         {
            _loc6_ = int(param2.readUnsignedShort());
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc13_ = new TShadowConfig();
               _loc13_.ItemID = param2.readUnsignedInt();
               _loc13_.MaxCnt = param2.readUnsignedInt();
               _loc7_ = int(param2.readUnsignedShort());
               _loc13_.ItemCnt.length = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc13_.ItemCnt.push(param2.readUnsignedInt());
                  _loc5_++;
               }
               _loc7_ = int(param2.readUnsignedShort());
               _loc13_.ItemMinGold.length = 0;
               _loc13_.ItemMaxGold.length = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc13_.ItemMinGold.push(param2.readUnsignedInt());
                  _loc13_.ItemMaxGold.push(param2.readUnsignedInt());
                  _loc5_++;
               }
               _loc7_ = int(param2.readUnsignedShort());
               _loc13_.Range.length = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc13_.Range.push(param2.readUnsignedInt());
                  _loc5_++;
               }
               _loc12_.ShadowConfigs.push(_loc13_);
               _loc4_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

