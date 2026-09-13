package Logics.Streamization.GlobalBattle
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TGlobalBattleMall;
   import Logics.GlobalBattle.TGlobalBattle;
   import Logics.GlobalBattle.TGlobalBattleRank;
   import Logics.GlobalBattle.TGlobalBattleReport;
   import Logics.GlobalBattle.TGlobalBattleUser;
   import Logics.GlobalBattle.TGlobalBattleUsers;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerGlobalBattle extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerGlobalBattle()
      {
         super();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TGlobalBattle = null;
         var _loc5_:Vector.<TGlobalBattleRank> = null;
         var _loc6_:Vector.<TGlobalBattleRank> = null;
         var _loc7_:TGlobalBattleRank = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc4_ = param2 as TGlobalBattle;
         _loc5_ = _loc4_.GlobalBattleRanks;
         _loc5_.length = 0;
         _loc8_ = param1.readShort();
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = new TGlobalBattleRank();
            _loc7_.Uid = param1.readDouble();
            _loc7_.ServerId = param1.readInt();
            _loc7_.AgentId = param1.readInt();
            _loc7_.Rank = param1.readInt();
            _loc7_.Score = param1.readInt();
            _loc7_.Username = TUtilityString.FetchUTF(param1);
            _loc7_.Userlevel = param1.readInt();
            _loc7_.Agent = TUtilityString.FetchUTF(param1);
            _loc5_.push(_loc7_);
            _loc9_++;
         }
         _loc6_ = _loc4_.GlobalBattleRanksCopy;
         _loc6_.length = 0;
         _loc8_ = param1.readShort();
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = new TGlobalBattleRank();
            _loc7_.Uid = param1.readDouble();
            _loc7_.ServerId = param1.readInt();
            _loc7_.AgentId = param1.readInt();
            _loc7_.Rank = param1.readInt();
            _loc7_.Score = param1.readInt();
            _loc7_.Username = TUtilityString.FetchUTF(param1);
            _loc7_.Userlevel = param1.readInt();
            _loc7_.Agent = TUtilityString.FetchUTF(param1);
            _loc6_.push(_loc7_);
            _loc9_++;
         }
         _loc4_.SelfRank = param1.readInt();
         _loc4_.SelfScore = param1.readInt();
         _loc4_.IsReward = param1.readInt();
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:TGlobalBattleMall = null;
         var _loc7_:TInventorySamples = null;
         var _loc8_:TInventorySample = null;
         _loc7_ = param2 as TInventorySamples;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GlobalBattleMall);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetDatebaseByIndex(_loc4_) as TGlobalBattleMall;
            _loc8_ = new TInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizerGlobalBattleMallByDatabase(null,_loc8_,_loc6_);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerGlobalBattleReport(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<TGlobalBattleReport> = null;
         var _loc7_:TGlobalBattleReport = null;
         _loc6_ = param2 as Vector.<TGlobalBattleReport>;
         _loc6_.length = 0;
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new TGlobalBattleReport();
            _loc7_.ReportID = TUtilityString.FetchUTF(param1);
            _loc7_.Time = param1.readInt();
            _loc7_.FightResult = param1.readShort();
            _loc6_.push(_loc7_);
            _loc5_++;
         }
      }
      
      public function UnstreamizerGlobalBattleUsers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TGlobalBattleUser = null;
         var _loc5_:TGlobalBattleUsers = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc5_ = param2 as TGlobalBattleUsers;
         _loc7_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc4_ = new TGlobalBattleUser();
            _loc4_.UserName = TUtilityString.FetchUTF(param1);
            _loc4_.HeroId = param1.readInt();
            _loc4_.YearMonth = param1.readInt();
            _loc4_.Group = param1.readInt();
            _loc4_.Rank = param1.readInt();
            _loc5_.AddUser(_loc4_);
            _loc6_++;
         }
      }
   }
}

