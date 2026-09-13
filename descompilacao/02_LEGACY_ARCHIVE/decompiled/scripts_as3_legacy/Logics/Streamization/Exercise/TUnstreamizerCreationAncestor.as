package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.CreationAncestor.TCreationAncestor;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerCreationAncestor extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerCreationAncestor()
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
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:Vector.<int> = null;
         var _loc16_:Vector.<int> = null;
         var _loc17_:Vector.<int> = null;
         var _loc18_:TBaseBox = null;
         var _loc19_:TBins = null;
         var _loc20_:TCreationAncestor = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc16_ = new Vector.<int>();
         _loc17_ = new Vector.<int>();
         _loc20_ = param2 as TCreationAncestor;
         _loc19_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc20_.BeginTime = param1.readUnsignedInt();
         _loc20_.EndTime = param1.readUnsignedInt();
         _loc20_.DescList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc20_.DescList[_loc4_] = TUtilityString.FetchUTF(param1);
            _loc4_++;
         }
         _loc20_.InitDescListNew();
         _loc20_.TotalRechargeGold = param1.readUnsignedInt();
         _loc20_.Score = param1.readUnsignedInt();
         _loc18_ = new TBaseBox();
         _loc18_.Price = param1.readUnsignedInt();
         _loc18_.CurPrice = param1.readUnsignedInt();
         _loc18_.Status = param1.readInt();
         _loc13_.length = 0;
         _loc14_.length = 0;
         _loc9_ = new TInventories();
         _loc7_ = int(param1.readUnsignedShort());
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc19_);
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
         _loc18_.Inventories = _loc9_;
         _loc20_.ServerBox = _loc18_;
         _loc20_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Price = param1.readUnsignedInt();
            _loc18_.Status = param1.readInt();
            _loc18_.Count = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc19_);
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
            _loc18_.Inventories = _loc9_;
            _loc20_.BoxList[_loc4_] = _loc18_;
            _loc4_++;
         }
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc20_.PriceList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc20_.NeedGold = param1.readUnsignedInt();
         _loc20_.Price1 = param1.readUnsignedInt();
         _loc20_.Price5 = param1.readUnsignedInt();
         _loc20_.FreeCount = param1.readUnsignedInt();
         _loc20_.MapIndex = param1.readUnsignedInt() - 1;
         _loc20_.MaxStep = param1.readUnsignedInt();
         _loc20_.ShopExchangePoint = param1.readUnsignedInt();
         _loc20_.ShopExchangeItems.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TBaseBox();
            _loc18_.Type = param1.readUnsignedInt();
            _loc18_.Level = param1.readUnsignedInt();
            _loc18_.LimitCount = param1.readUnsignedInt();
            _loc18_.Price = param1.readUnsignedInt();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc7_ = int(param1.readUnsignedShort());
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc19_);
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
            _loc18_.TitleID = param1.readUnsignedInt();
            _loc18_.Inventories = _loc9_;
            _loc20_.ShopExchangeItems[_loc4_] = _loc18_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

