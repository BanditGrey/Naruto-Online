package Logics.Streamization.Exercise
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTenTail extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerTenTail()
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
         var _loc12_:TTenTail = null;
         _loc12_ = param2 as TTenTail;
         _loc12_.Identify = param1.readUnsignedInt();
         _loc12_.BeginTime = param1.readUnsignedInt();
         _loc12_.EndTime = param1.readUnsignedInt();
         _loc12_.PayEndTime = param1.readUnsignedInt();
         _loc12_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityTabName = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc12_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc12_.CurSoul = param1.readUnsignedInt();
         _loc12_.CurTenTail = param1.readUnsignedInt();
         _loc12_.ExchangeScale = param1.readUnsignedInt();
         _loc12_.FireColor = param1.readUnsignedInt();
         _loc6_ = int(param1.readUnsignedShort());
         _loc12_.RewardStatus.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RewardID[_loc4_] = param1.readUnsignedInt();
            _loc12_.RewardStatus.push(param1.readByte());
            _loc12_.RewardColor[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.DisplaySoulConfig[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RealSoulConfig[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.CertificateConfig[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.DisplayTenTailConfig[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc12_.RealTenTailConfig[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         if(_loc12_.Rewards[0] == null)
         {
            _loc6_ = int(param1.readUnsignedShort());
            _loc10_ = new Vector.<uint>();
            _loc11_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc10_.length = 0;
               _loc11_.length = 0;
               _loc9_ = new TInventories();
               _loc7_ = int(param1.readUnsignedShort());
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc10_.push(param1.readUnsignedInt());
                  _loc11_.push(param1.readUnsignedInt());
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
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

