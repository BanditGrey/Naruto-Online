package Logics.Streamization.SummonBattle
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSummonBattleMall;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Logics.SummonBattle.TSummonBattleData;
   import Logics.SummonBattle.TSummonBattleReport;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSummonBattle extends TUnstreamizer
   {
      
      public var SummonBattleDatas:Vector.<TSummonBattleData>;
      
      public var SummonBattleReports:Vector.<TSummonBattleReport>;
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerSummonBattle()
      {
         super();
         this.SummonBattleDatas = new Vector.<TSummonBattleData>();
         this.SummonBattleReports = new Vector.<TSummonBattleReport>();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TSummonBattleData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TSummonBattleReport = null;
         this.SummonBattleDatas.length = 0;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = param1.readInt();
            _loc4_ = new TSummonBattleData(_loc8_);
            this.SummonBattleDatas.push(_loc4_);
            _loc4_.Index = param1.readInt();
            _loc4_.AgentId = param1.readInt();
            _loc4_.OccupyTime = param1.readInt();
            _loc4_.IDHigh = param1.readUnsignedInt();
            _loc4_.IDLow = param1.readUnsignedInt();
            TUtilityString.FetchUTF(param1);
            _loc4_.UserName = TUtilityString.FetchUTF(param1);
            _loc4_.UserLevel = param1.readUnsignedInt();
            _loc4_.PvpFightValue.High = param1.readUnsignedInt();
            _loc4_.PvpFightValue.Low = param1.readUnsignedInt();
            param1.readUnsignedInt();
            _loc9_ = param1.readShort();
            _loc7_ = 0;
            while(_loc7_ < _loc9_)
            {
               param1.readUnsignedInt();
               _loc7_++;
            }
            param1.readUnsignedInt();
            _loc6_++;
         }
         this.SummonBattleReports.length = 0;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc10_ = new TSummonBattleReport();
            this.SummonBattleReports.push(_loc10_);
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedByte();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            _loc10_.PlayerNick = TUtilityString.FetchUTF(param1);
            param1.readUnsignedInt();
            _loc10_.When = param1.readUnsignedInt();
            _loc10_.IsWin = Boolean(param1.readUnsignedShort() > 0);
            _loc6_++;
         }
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:TSummonBattleMall = null;
         var _loc7_:TInventorySamples = null;
         var _loc8_:TInventorySample = null;
         _loc7_ = param2 as TInventorySamples;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SummonBattleMall);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetDatebaseByIndex(_loc4_) as TSummonBattleMall;
            _loc8_ = new TInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizerSummonBattleMallByDatabase(null,_loc8_,_loc6_);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
   }
}

