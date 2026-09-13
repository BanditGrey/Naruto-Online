package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.BaseRank.TActiveRankDataNew;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerActiveRankNew extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TUnstreamizerActiveRankNew()
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
         var _loc16_:TBaseBox = null;
         var _loc17_:Vector.<int> = null;
         var _loc18_:Vector.<int> = null;
         var _loc19_:int = 0;
         var _loc20_:TActiveRankDataNew = null;
         var _loc21_:TBins = null;
         var _loc22_:TConsumeRankInfo = null;
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc17_ = new Vector.<int>();
         _loc18_ = new Vector.<int>();
         _loc20_ = param2 as TActiveRankDataNew;
         _loc21_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc19_ = int(param1.readUnsignedInt());
         _loc20_.CurMyRank = param1.readUnsignedInt();
         _loc20_.RankPoint = param1.readUnsignedInt();
         _loc20_.ScoreCommand.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc20_.ScoreCommand[_loc4_] = param1.readUnsignedInt();
            _loc4_++;
         }
         _loc20_.RankGiftList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Min = param1.readUnsignedInt();
            _loc16_.Max = param1.readUnsignedInt();
            _loc16_.TitleID = param1.readUnsignedInt();
            _loc7_ = param1.readShort();
            _loc9_ = new TInventories();
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc21_);
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
            _loc16_.Inventories = _loc9_;
            _loc20_.RankGiftList[_loc4_] = _loc16_;
            _loc4_++;
         }
         _loc20_.RankSpecialList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc7_ = param1.readShort();
            _loc9_ = new TInventories();
            _loc17_.length = 0;
            _loc18_.length = 0;
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc17_.push(param1.readUnsignedInt());
               _loc18_.push(param1.readUnsignedInt());
               _loc12_ = param1.readUnsignedInt();
               _loc11_ = param1.readUnsignedInt();
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc21_);
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
               _loc8_.NewType = _loc17_[_loc5_];
               _loc8_.NewIdentify = _loc18_[_loc5_];
               _loc5_++;
            }
            _loc20_.RankSpecialList[_loc4_] = _loc9_;
            _loc4_++;
         }
         _loc20_.RankPlayerList.length = 0;
         _loc6_ = param1.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc22_ = new TConsumeRankInfo();
            _loc22_.UserName = TUtilityString.FetchUTF(param1);
            _loc22_.ServerName = TUtilityString.FetchUTF(param1);
            _loc22_.Rank = param1.readUnsignedInt();
            _loc22_.Score = param1.readUnsignedInt();
            _loc20_.RankPlayerList.push(_loc22_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

