package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Cornucopia.TCornucopia;
   import Logics.Exercise.DecActive.TLotteryLog;
   import Logics.Exercise.DecActive.TLotteryResult;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerCornucopia extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerCornucopia()
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
         var _loc21_:TCornucopia = null;
         var _loc22_:TLotteryResult = null;
         var _loc23_:TLotteryLog = null;
         _loc15_ = new Vector.<uint>();
         _loc16_ = new Vector.<uint>();
         _loc19_ = new Vector.<int>();
         _loc20_ = new Vector.<int>();
         _loc21_ = param2 as TCornucopia;
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
         _loc21_.GameStatus = param1.readInt();
         _loc21_.NextTime = param1.readUnsignedInt();
         _loc21_.SelectedCount = param1.readUnsignedInt();
         _loc21_.MaxCount = param1.readUnsignedInt();
         _loc21_.PoolGold = param1.readUnsignedInt();
         _loc21_.CurCount = param1.readUnsignedInt();
         _loc7_ = param1.readShort();
         if(_loc7_ > 0)
         {
            _loc23_ = new TLotteryLog();
            _loc7_ = param1.readShort();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc23_.FirstNumbers.push(param1.readUnsignedInt());
               _loc4_++;
            }
            _loc7_ = param1.readShort();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc23_.SecondNumbers.push(param1.readUnsignedInt());
               _loc4_++;
            }
            _loc7_ = param1.readShort();
            _loc4_ = 0;
            while(_loc4_ < _loc7_)
            {
               _loc23_.ThirdNumbers.push(param1.readUnsignedInt());
               _loc4_++;
            }
            _loc21_.CurResults = _loc23_;
         }
         _loc7_ = param1.readShort();
         _loc21_.GoldList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc21_.GoldList[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc7_ = param1.readShort();
         _loc21_.Results.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc22_ = new TLotteryResult();
            _loc8_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc22_.Numbers.push(param1.readUnsignedInt());
               _loc5_++;
            }
            _loc22_.Gold = param1.readUnsignedInt();
            _loc21_.Results[_loc4_] = _loc22_;
            _loc4_++;
         }
         _loc7_ = param1.readShort();
         _loc21_.Players.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc22_ = new TLotteryResult();
            _loc8_ = param1.readShort();
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc22_.Players.push(TUtilityString.FetchUTF(param1));
               _loc5_++;
            }
            _loc21_.Players[_loc4_] = _loc22_;
            _loc4_++;
         }
         _loc21_.RechargeGold = param1.readUnsignedInt();
         _loc21_.BoxType = param1.readUnsignedInt();
         _loc21_.BoxPrice = param1.readUnsignedInt();
         _loc21_.BoxCount = param1.readUnsignedInt();
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
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

