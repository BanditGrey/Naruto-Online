package Logics.Streamization.Lottery
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryItem;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerLotteryItem extends TUnstreamizer
   {
      
      public static const TYPE_Free:int = 1;
      
      public static const TYPE_Gold:int = 2;
      
      public static const TYPE_Outside:int = 1;
      
      public static const TYPE_Inside:int = 2;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerLotteryItem()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TLotteryItem = null;
         var _loc9_:Vector.<TLotteryItem> = null;
         var _loc10_:TInventories = null;
         var _loc11_:Vector.<TLotteryItem> = SLogicsCore.Lottery.FreeOutsideItems;
         var _loc12_:Vector.<TLotteryItem> = SLogicsCore.Lottery.FreeInsideItems;
         var _loc13_:Vector.<TLotteryItem> = SLogicsCore.Lottery.GoldOutsideItems;
         var _loc14_:Vector.<TLotteryItem> = SLogicsCore.Lottery.GoldInsideItems;
         _loc9_ = param2 as Vector.<TLotteryItem>;
         _loc7_ = new Vector.<uint>();
         _loc10_ = new TInventories();
         _loc5_ = int(param1.readUnsignedShort());
         _loc9_.length = 0;
         _loc11_.length = 0;
         _loc12_.length = 0;
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = new TLotteryItem();
            _loc8_.Identify = param1.readUnsignedInt();
            _loc8_.SlotId = param1.readUnsignedInt();
            _loc8_.IsInside = param1.readUnsignedInt();
            _loc8_.Type = param1.readUnsignedInt();
            _loc6_ = param1.readUnsignedInt();
            _loc7_.length = 0;
            _loc7_.push(_loc6_);
            _loc10_ = new TInventories();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc10_,_loc7_);
            _loc8_.Inventories = _loc10_;
            _loc8_.Count = param1.readUnsignedInt();
            _loc8_.Inventories.GetInventoryByIndex(0).Quantity = _loc8_.Count;
            _loc8_.IsShine = param1.readUnsignedInt();
            _loc8_.ShineColor = param1.readUnsignedInt();
            _loc9_.push(_loc8_);
            if(_loc8_.IsInside == TYPE_Inside)
            {
               if(_loc8_.Type == TYPE_Free)
               {
                  _loc12_.push(_loc8_);
               }
               else
               {
                  _loc14_.push(_loc8_);
               }
            }
            else if(_loc8_.Type == TYPE_Free)
            {
               _loc11_.push(_loc8_);
            }
            else
            {
               _loc13_.push(_loc8_);
            }
            _loc4_++;
         }
      }
      
      protected function SortItems(param1:TLotteryItem, param2:TLotteryItem) : Number
      {
         if(param1.SlotId > param2.SlotId)
         {
            return 1;
         }
         if(param1.SlotId < param2.SlotId)
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

