package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NinjaMeet.TNinjaMeeting;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNinjaMeeting extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNinjaMeeting()
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
         var _loc15_:TBins = null;
         var _loc16_:TBaseBox = null;
         var _loc17_:TNinjaMeeting = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = param2 as TNinjaMeeting;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc17_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_NinjaMeeting;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc17_.ActivityName = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityTabName = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc2 = TUtilityString.FetchUTF(param1);
         _loc17_.ActivityDesc3 = TUtilityString.FetchUTF(param1);
         _loc17_.Score = param1.readUnsignedInt();
         _loc17_.Money = param1.readUnsignedInt();
         _loc17_.HeroList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.PicType = param1.readUnsignedInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Status = param1.readInt();
            _loc16_.Identify = param1.readUnsignedInt();
            _loc16_.LimitCount = param1.readUnsignedInt();
            _loc16_.Desc1 = TUtilityString.FetchUTF(param1);
            _loc16_.Desc2 = TUtilityString.FetchUTF(param1);
            _loc16_.Desc3 = TUtilityString.FetchUTF(param1);
            _loc16_.Count = param1.readUnsignedInt();
            _loc16_.CurPrice = param1.readUnsignedInt();
            _loc17_.HeroList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc17_.BoxList.length = 0;
         _loc6_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Count = param1.readUnsignedInt();
            _loc16_.BuyCount = param1.readUnsignedInt();
            _loc16_.Price = param1.readUnsignedInt();
            _loc16_.Discount = param1.readUnsignedInt();
            _loc9_ = new TInventories();
            _loc13_.length = 0;
            _loc12_ = param1.readUnsignedInt();
            _loc11_ = param1.readUnsignedInt();
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = param1.readUnsignedInt();
            _loc16_.Inventories = _loc9_;
            _loc16_.CurPrice = param1.readUnsignedInt();
            _loc17_.BoxList[_loc4_] = _loc16_;
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

