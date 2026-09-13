package Logics.Streamization.SystemActivity
{
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.SystemActivity.TSystemActivities;
   import Logics.SystemActivity.TSystemActivity;
   import Logics.SystemActivity.TSystemActivityData;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSystemActivity extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerSystemActivity()
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
         var _loc6_:int = 0;
         var _loc7_:TSystemActivity = null;
         var _loc8_:TSystemActivities = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:TSystemActivityData = null;
         var _loc13_:Vector.<uint> = null;
         _loc8_ = param2 as TSystemActivities;
         _loc5_ = int(param1.readUnsignedShort());
         _loc8_.SystemActivity.length = 0;
         _loc11_ = new Vector.<uint>();
         _loc13_ = new Vector.<uint>();
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc7_ = new TSystemActivity();
            _loc7_.Identify = param1.readUnsignedInt();
            _loc7_.ActivityName = TUtilityString.FetchUTF(param1);
            _loc7_.ActivityTabName = TUtilityString.FetchUTF(param1);
            _loc7_.ActivityDesc = TUtilityString.FetchUTF(param1);
            _loc7_.BeginTime = param1.readUnsignedInt();
            _loc7_.EndTime = param1.readUnsignedInt();
            _loc6_ = int(param1.readUnsignedShort());
            _loc11_.length = 0;
            _loc13_.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc10_ = param1.readUnsignedInt();
               _loc11_.push(_loc10_);
               _loc13_.push(param1.readUnsignedInt());
               _loc4_++;
            }
            _loc9_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc11_);
            _loc7_.Inventories = _loc9_;
            _loc7_.Count.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc7_.Count.push(_loc13_[_loc4_]);
               _loc7_.Inventories.GetInventoryByIndex(_loc4_).Quantity = _loc13_[_loc4_];
               _loc4_++;
            }
            _loc6_ = int(param1.readUnsignedShort());
            _loc7_.ActivityData.length = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc12_ = new TSystemActivityData();
               _loc12_.Identify = _loc4_;
               param1.readUnsignedInt();
               _loc12_.ActivityDate = param1.readUnsignedInt();
               _loc12_.OrganzationName = TUtilityString.FetchUTF(param1);
               _loc12_.PlayerNick = TUtilityString.FetchUTF(param1);
               _loc12_.FamilyType = param1.readUnsignedInt();
               _loc12_.OrganzationLevel = param1.readUnsignedInt();
               _loc12_.OrganzationLeader = TUtilityString.FetchUTF(param1);
               _loc12_.HurtScore = param1.readUnsignedInt();
               _loc12_.FightResult = param1.readUnsignedInt();
               _loc12_.Point = param1.readUnsignedInt();
               param1.readUnsignedInt();
               _loc12_.Rank = param1.readUnsignedInt();
               _loc7_.ActivityData.push(_loc12_);
               _loc4_++;
            }
            _loc7_.ActivityData.sort(this.SortActivityData);
            _loc8_.SystemActivity.push(_loc7_);
            _loc3_++;
         }
      }
      
      protected function SortActivityData(param1:TSystemActivityData, param2:TSystemActivityData) : Number
      {
         if(param1.ActivityDate > param2.ActivityDate)
         {
            return 1;
         }
         if(param1.ActivityDate < param2.ActivityDate)
         {
            return -1;
         }
         return 0;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

