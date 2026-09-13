package Processors.Game.Lobby.Exercise.NewSpringFestival.stream
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TNewSpring2018Config1;
   import Logics.DatebaseVO.VO.TNewSpring2018Config2;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Exercise.NewSpringFestival.data.NewSpring2018Data;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   public class TUnstreamizerNewSpring2018 extends TUnstreamizer
   {
      
      private var _bInitComplete:Boolean = false;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerNewSpring2018()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:NewSpring2018Data = param2 as NewSpring2018Data;
         _loc6_.init();
         _loc6_.beginTime = param1.readUnsignedInt();
         _loc6_.endTime = param1.readUnsignedInt();
         _loc6_.taskPoint = param1.readUnsignedInt();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc13_ = {};
            _loc13_.taskId = param1.readUnsignedInt();
            _loc13_.smallTaksId = param1.readUnsignedInt();
            _loc13_.resetTimes = param1.readUnsignedInt();
            _loc13_.progress = param1.readUnsignedInt();
            _loc13_.status = param1.readUnsignedInt();
            _loc6_.taskInfo.push(_loc13_);
            _loc4_++;
         }
         _loc6_.boxFlag1 = param1.readUnsignedInt();
         _loc6_.boxFlag2 = param1.readUnsignedInt();
         _loc6_.totalRecharge = param1.readUnsignedInt();
         _loc6_.openNomalBagTimes = param1.readUnsignedInt();
         _loc6_.openSuperBagTimes = param1.readUnsignedInt();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_.shopBuyTimes[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc6_.shopPoint = param1.readUnsignedInt();
         _loc6_.consumePoint = param1.readUnsignedInt();
         _loc6_.sale = param1.readUnsignedInt();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = int(param1.readUnsignedInt());
            _loc9_ = int(param1.readUnsignedInt());
            _loc10_ = int(param1.readUnsignedInt());
            _loc11_ = int(param1.readUnsignedInt());
            _loc12_ = new Object();
            _loc12_["price"] = _loc8_;
            _loc12_["type"] = _loc9_;
            _loc12_["itemID"] = _loc10_;
            _loc12_["amount"] = _loc11_;
            _loc6_.Lantern1.push(_loc12_);
            _loc4_++;
         }
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = int(param1.readUnsignedInt());
            _loc9_ = int(param1.readUnsignedInt());
            _loc10_ = int(param1.readUnsignedInt());
            _loc11_ = int(param1.readUnsignedInt());
            _loc12_ = new Object();
            _loc12_["price"] = _loc8_;
            _loc12_["type"] = _loc9_;
            _loc12_["itemID"] = _loc10_;
            _loc12_["amount"] = _loc11_;
            _loc6_.Lantern2.push(_loc12_);
            _loc4_++;
         }
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = int(param1.readUnsignedInt());
            _loc9_ = int(param1.readUnsignedInt());
            _loc10_ = int(param1.readUnsignedInt());
            _loc11_ = int(param1.readUnsignedInt());
            _loc12_ = new Object();
            _loc12_["price"] = _loc8_;
            _loc12_["type"] = _loc9_;
            _loc12_["itemID"] = _loc10_;
            _loc12_["amount"] = _loc11_;
            _loc6_.Lantern3.push(_loc12_);
            _loc4_++;
         }
         this.initGiftBoxConfig(_loc6_);
         this.initShopConfig(_loc6_);
         this.initBagRewardsPreviewConfig(_loc6_);
         this.initLanternRewardsPreviewConfig(_loc6_);
      }
      
      public function getCompleteRewards(param1:ByteArray) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc2_:String = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc4_ = int(param1.readUnsignedInt());
         var _loc14_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc6_ = new TInventories();
         _loc7_ = new Vector.<uint>();
         _loc8_ = new Vector.<uint>();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc10_ = int(param1.readUnsignedInt());
            _loc11_ = int(param1.readUnsignedInt());
            _loc12_ = int(param1.readUnsignedInt());
            _loc13_ = int(CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc14_));
            _loc7_.push(_loc13_);
            _loc8_.push(_loc12_);
            _loc3_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc7_);
         var _loc15_:int = 0;
         while(_loc15_ < _loc8_.length)
         {
            _loc5_ = _loc6_.GetInventoryByIndex(_loc15_);
            _loc5_.Quantity = _loc8_[_loc15_];
            _loc2_ += _loc5_.Name + "*" + _loc5_.Quantity + "\n";
            _loc15_++;
         }
         return _loc2_;
      }
      
      public function ProcessorRefreshLanternRet(param1:ByteArray, param2:int, param3:NewSpring2018Data) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:int = 3;
         param3.Lanterns[param2] = [];
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = int(param1.readUnsignedInt());
            _loc6_ = int(param1.readUnsignedInt());
            _loc7_ = int(param1.readUnsignedInt());
            _loc8_ = new Object();
            _loc8_["price"] = _loc4_;
            _loc8_["type"] = _loc5_;
            _loc8_["itemID"] = _loc6_;
            _loc8_["amount"] = _loc7_;
            param3.Lanterns[param2].push(_loc8_);
            _loc10_++;
         }
      }
      
      public function ProcessorRefreshAllLanternRet(param1:ByteArray, param2:NewSpring2018Data) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc9_:Array = null;
         var _loc11_:int = 0;
         var _loc8_:int = 3;
         param2.Lanterns = [];
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_)
         {
            _loc9_ = [];
            _loc11_ = 0;
            while(_loc11_ < _loc8_)
            {
               _loc3_ = int(param1.readUnsignedInt());
               _loc4_ = int(param1.readUnsignedInt());
               _loc5_ = int(param1.readUnsignedInt());
               _loc6_ = int(param1.readUnsignedInt());
               _loc7_ = new Object();
               _loc7_["price"] = _loc3_;
               _loc7_["type"] = _loc4_;
               _loc7_["itemID"] = _loc5_;
               _loc7_["amount"] = _loc6_;
               _loc9_.push(_loc7_);
               _loc11_++;
            }
            param2.Lanterns.push(_loc9_);
            _loc10_++;
         }
      }
      
      private function initLanternRewardsPreviewConfig(param1:NewSpring2018Data) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TInventories = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:Vector.<uint> = null;
         var _loc13_:TBins = null;
         var _loc14_:TBaseBox = null;
         var _loc16_:TNewSpring2018Config2 = null;
         var _loc17_:Array = null;
         var _loc18_:Object = null;
         var _loc19_:Object = null;
         var _loc20_:int = 0;
         var _loc2_:int = 60007;
         var _loc3_:int = 3;
         _loc13_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc15_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config2);
         var _loc21_:int = 0;
         while(_loc21_ < _loc3_)
         {
            _loc16_ = _loc15_.GetDatebaseByIdentifier(_loc2_ + _loc21_) as TNewSpring2018Config2;
            _loc17_ = Json.decode(_loc16_.houduan) as Array;
            _loc7_ = new TInventories();
            _loc14_ = new TBaseBox();
            _loc11_ = new Vector.<uint>();
            _loc12_ = new Vector.<uint>();
            _loc4_ = 0;
            while(_loc4_ < _loc17_.length)
            {
               _loc18_ = _loc17_[_loc4_];
               _loc19_ = _loc18_["items"][0];
               _loc10_ = uint(int(_loc19_["type"]));
               _loc9_ = uint(int(_loc19_["itemid"]));
               _loc8_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc9_,_loc13_);
               _loc11_.push(_loc8_);
               _loc12_.push(int(_loc19_["count"]));
               _loc4_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_,_loc11_);
            _loc20_ = 0;
            while(_loc20_ < _loc12_.length)
            {
               _loc6_ = _loc7_.GetInventoryByIndex(_loc20_);
               _loc6_.Quantity = _loc12_[_loc20_];
               _loc20_++;
            }
            _loc14_.Inventories = _loc7_;
            param1.LanternRewardsPreviewConfig[_loc21_] = _loc14_;
            _loc21_++;
         }
      }
      
      private function initBagRewardsPreviewConfig(param1:NewSpring2018Data) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TInventories = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:TBins = null;
         var _loc12_:TBaseBox = null;
         var _loc16_:Object = null;
         var _loc17_:Object = null;
         var _loc18_:int = 0;
         _loc11_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc13_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config2);
         var _loc14_:TNewSpring2018Config2 = _loc13_.GetDatebaseByIdentifier(60003) as TNewSpring2018Config2;
         var _loc15_:Array = Json.decode(_loc14_.houduan) as Array;
         _loc5_ = new TInventories();
         _loc12_ = new TBaseBox();
         _loc9_ = new Vector.<uint>();
         _loc10_ = new Vector.<uint>();
         _loc2_ = 0;
         while(_loc2_ < _loc15_.length)
         {
            _loc16_ = _loc15_[_loc2_];
            _loc17_ = _loc16_["items"][0];
            _loc8_ = uint(int(_loc17_["type"]));
            _loc7_ = uint(int(_loc17_["itemid"]));
            _loc6_ = CONST_COMMON.GetItemIDByType(_loc8_,_loc7_,_loc11_);
            _loc9_.push(_loc6_);
            _loc10_.push(int(_loc17_["count"]));
            _loc2_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_,_loc9_);
         _loc18_ = 0;
         while(_loc18_ < _loc10_.length)
         {
            _loc4_ = _loc5_.GetInventoryByIndex(_loc18_);
            _loc4_.Quantity = _loc10_[_loc18_];
            _loc18_++;
         }
         _loc12_.Inventories = _loc5_;
         param1.bagRewardsPreviewConfig[0] = _loc12_;
         _loc14_ = _loc13_.GetDatebaseByIdentifier(60004) as TNewSpring2018Config2;
         _loc15_ = Json.decode(_loc14_.houduan) as Array;
         _loc5_ = new TInventories();
         _loc12_ = new TBaseBox();
         _loc9_ = new Vector.<uint>();
         _loc10_ = new Vector.<uint>();
         _loc2_ = 0;
         while(_loc2_ < _loc15_.length)
         {
            _loc16_ = _loc15_[_loc2_];
            _loc17_ = _loc16_["items"][0];
            _loc8_ = uint(int(_loc17_["type"]));
            _loc7_ = uint(int(_loc17_["itemid"]));
            _loc6_ = CONST_COMMON.GetItemIDByType(_loc8_,_loc7_,_loc11_);
            _loc9_.push(_loc6_);
            _loc10_.push(int(_loc17_["count"]));
            _loc2_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc5_,_loc9_);
         _loc18_ = 0;
         while(_loc18_ < _loc10_.length)
         {
            _loc4_ = _loc5_.GetInventoryByIndex(_loc18_);
            _loc4_.Quantity = _loc10_[_loc18_];
            _loc18_++;
         }
         _loc12_.Inventories = _loc5_;
         param1.bagRewardsPreviewConfig[1] = _loc12_;
      }
      
      private function initShopConfig(param1:NewSpring2018Data) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
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
         var _loc17_:Vector.<int> = null;
         var _loc18_:Vector.<int> = null;
         var _loc20_:TNewSpring2018Config1 = null;
         var _loc21_:Object = null;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         var _loc19_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config1);
         _loc5_ = _loc19_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc20_ = _loc19_.GetDatebaseByIndex(_loc2_) as TNewSpring2018Config1;
            _loc13_ = new Vector.<uint>();
            _loc14_ = new Vector.<uint>();
            _loc16_ = new TBaseBox();
            _loc16_.IsHot = 0;
            _loc16_.Price = _loc20_.needScore;
            _loc16_.LimitCount = _loc20_.limit;
            _loc9_ = new TInventories();
            _loc21_ = Json.decode(_loc20_.items) as Object;
            _loc12_ = uint(int(_loc21_["type"]));
            _loc11_ = uint(int(_loc21_["itemid"]));
            _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
            _loc13_.push(_loc10_);
            _loc14_.push(int(_loc21_["count"]));
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc8_ = _loc9_.GetInventoryByIndex(0);
            _loc8_.Quantity = _loc14_[0];
            _loc16_.Inventories = _loc9_;
            param1.ShopExchangeItems[_loc2_] = _loc16_;
            _loc2_++;
         }
      }
      
      private function initGiftBoxConfig(param1:NewSpring2018Data) : void
      {
         var _loc4_:TBaseBox = null;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:int = 0;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 2;
         var _loc10_:TBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewSpring2018Config2);
         var _loc11_:String = _loc10_.GetDatebaseByIdentifier(60001)["houduan"];
         var _loc12_:Array = Json.decode(_loc11_) as Array;
         param1.giftBoxRewardsConfig.push(_loc12_);
         _loc11_ = _loc10_.GetDatebaseByIdentifier(60002)["houduan"];
         _loc12_ = Json.decode(_loc11_) as Array;
         param1.giftBoxRewardsConfig.push(_loc12_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TBaseBox();
            _loc8_ = new Vector.<uint>();
            _loc9_ = [];
            _loc4_.Price = 0;
            _loc4_.Status = 0;
            _loc6_ = new TInventories();
            _loc7_ = int(param1.giftBoxRewardsConfig[_loc2_].length);
            _loc13_ = 0;
            while(_loc13_ < _loc7_)
            {
               _loc15_ = int(param1.giftBoxRewardsConfig[_loc2_][_loc13_]["type"]);
               _loc16_ = int(param1.giftBoxRewardsConfig[_loc2_][_loc13_]["itemid"]);
               _loc17_ = int(param1.giftBoxRewardsConfig[_loc2_][_loc13_]["count"]);
               if(_loc16_ != 0)
               {
                  _loc8_.push(_loc16_);
               }
               _loc9_.push(_loc17_);
               _loc13_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc6_,_loc8_);
            _loc7_ = _loc6_.Count;
            _loc14_ = 0;
            while(_loc14_ < _loc7_)
            {
               _loc5_ = _loc6_.GetInventoryByIndex(_loc14_);
               _loc5_.Quantity = _loc9_[_loc14_];
               _loc14_++;
            }
            _loc4_.Inventories = _loc6_;
            param1.giftBoxRewards[_loc2_] = _loc4_;
            _loc2_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

