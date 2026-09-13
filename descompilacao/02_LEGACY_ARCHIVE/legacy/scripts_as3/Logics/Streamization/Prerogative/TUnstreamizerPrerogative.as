package Logics.Streamization.Prerogative
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TPlatformID;
   import Logics.DatebaseVO.VO.TPlatformReward;
   import Logics.Inventories.TInventory;
   import Logics.Prerogative.TPrerogativeOne;
   import Logics.Prerogative.TPrerogativeOnes;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerPrerogative extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerPrerogative()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      protected function UnstreamizationPerformVIPWelfare(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPrerogativeOnes = null;
         var _loc5_:TPrerogativeOne = null;
         var _loc6_:TPlatformReward = null;
         var _loc7_:TBins = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:TFixedAward = null;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TPlatformID = null;
         var _loc16_:TInventory = null;
         _loc7_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_PlatformReward) as TBins;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc4_ = param2 as TPrerogativeOnes;
         _loc9_ = _loc4_.Count;
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc4_.GetPrerogativeOneByIndex(_loc8_).Inventories.Clear();
            _loc8_++;
         }
         _loc4_.Clear();
         _loc9_ = uint(_loc7_.Count);
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc6_ = _loc7_.GetDatebaseByIndex(_loc8_) as TPlatformReward;
            _loc11_ = _loc13_.length;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc13_.pop();
               _loc14_.pop();
               _loc10_++;
            }
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc5_ = new TPrerogativeOne();
            _loc5_.RewardID = _loc6_.Identifier;
            _loc5_.WelfareName = _loc6_.ActivityName;
            _loc5_.PlatformID = _loc6_.PlatformID;
            _loc15_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PlatformID,_loc5_.PlatformID) as TPlatformID;
            _loc5_.IsOpen = Boolean(_loc15_.Open);
            _loc5_.Type = _loc6_.Type;
            _loc5_.Member = _loc6_.Member;
            _loc5_.PrivilegeLevel = _loc6_.PrivilegeLevel;
            _loc11_ = _loc6_.Rewards.length;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc12_ = _loc6_.Rewards[_loc10_];
               if(_loc12_.Code >= 1000000)
               {
                  _loc13_.push(_loc12_.Code);
                  _loc14_.push(_loc12_.Amount);
               }
               _loc10_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_.Inventories,_loc13_);
            _loc11_ = uint(_loc5_.Inventories.Count);
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc16_ = _loc5_.Inventories.GetInventoryByIndex(_loc10_);
               _loc16_.Quantity = _loc14_[_loc10_];
               _loc10_++;
            }
            _loc4_.Add(_loc5_);
            _loc8_++;
         }
      }
      
      public function UnstreamizeVIPWelfare(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformVIPWelfare(param1,param2,param3);
      }
   }
}

