package Logics.Streamization.WorldMatch
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.DatebaseVO.VO.TGlobalArenaMall;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Logics.WorldMatch.TWorldMatch;
   import Logics.WorldMatch.TWorldMatchPlayerInfo;
   import Logics.WorldMatch.TWorldMatchRank;
   import Logics.WorldMatch.TWorldMatchReport;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerWorldMatch extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      public function TUnstreamizerWorldMatch()
      {
         super();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TWorldMatch = null;
         var _loc5_:Vector.<TWorldMatchRank> = null;
         var _loc6_:Vector.<TWorldMatchRank> = null;
         var _loc7_:TWorldMatchRank = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc4_ = param2 as TWorldMatch;
         _loc5_ = _loc4_.WorldMatchRanks;
         _loc5_.length = 0;
         _loc8_ = param1.readShort();
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = new TWorldMatchRank();
            _loc7_.Rank = param1.readInt();
            _loc7_.Username = TUtilityString.FetchUTF(param1);
            _loc7_.Userlevel = param1.readInt();
            _loc7_.Agent = TUtilityString.FetchUTF(param1);
            _loc7_.ServerName = TUtilityString.FetchUTF(param1);
            _loc5_.push(_loc7_);
            _loc9_++;
         }
         _loc5_.sort(this.sortFunctionOnRank);
         _loc6_ = _loc4_.WorldMatchRanksCopy;
         _loc6_.length = 0;
         _loc8_ = param1.readShort();
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = new TWorldMatchRank();
            _loc7_.Rank = param1.readInt();
            _loc7_.Username = TUtilityString.FetchUTF(param1);
            _loc7_.Userlevel = param1.readInt();
            _loc7_.Agent = TUtilityString.FetchUTF(param1);
            _loc7_.ServerName = TUtilityString.FetchUTF(param1);
            _loc6_.push(_loc7_);
            _loc9_++;
         }
         _loc6_.sort(this.sortFunctionOnRank);
      }
      
      protected function sortFunctionOnRank(param1:TWorldMatchRank, param2:TWorldMatchRank) : int
      {
         if(param1.Rank > param2.Rank)
         {
            return 1;
         }
         return -1;
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:TGlobalArenaMall = null;
         var _loc7_:TInventorySamples = null;
         var _loc8_:TInventorySample = null;
         _loc7_ = param2 as TInventorySamples;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GlobalArenaMall);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetDatebaseByIndex(_loc4_) as TGlobalArenaMall;
            _loc8_ = new TInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizerGlobalArenaMallByDatabase(null,_loc8_,_loc6_);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerWorldMatchReport(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<TWorldMatchReport> = null;
         var _loc7_:TWorldMatchReport = null;
         _loc6_ = param2 as Vector.<TWorldMatchReport>;
         _loc6_.length = 0;
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new TWorldMatchReport();
            _loc7_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc7_.IsFight = !Boolean(param1.readUnsignedByte());
            _loc7_.ChgRanking = param1.readShort();
            _loc7_.When = param1.readUnsignedInt();
            _loc7_.ReportId = TUtilityString.FetchUTF(param1);
            _loc7_.IsWin = Boolean(_loc7_.ChgRanking > 0);
            if(_loc7_.ChgRanking >= 10000 || _loc7_.ChgRanking <= -10000)
            {
               _loc7_.ChgRanking = 0;
            }
            _loc6_.push(_loc7_);
            _loc5_++;
         }
      }
      
      public function UnstreamizeInquirePlayerInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var Count:int = 0;
         var Index:int = 0;
         var WorldMatch:TWorldMatch = null;
         var WorldMatchPlayerInfos:Vector.<TWorldMatchPlayerInfo> = null;
         var WorldMatchPlayerInfo:TWorldMatchPlayerInfo = null;
         var Stream:ByteArray = param1;
         var Destination:Object = param2;
         var Correlator:Object = param3;
         WorldMatch = Destination as TWorldMatch;
         WorldMatchPlayerInfos = WorldMatch.WorldMatchPlayerInfos;
         WorldMatchPlayerInfos.length = 0;
         Count = Stream.readShort();
         Index = 0;
         while(Index < Count)
         {
            WorldMatchPlayerInfo = new TWorldMatchPlayerInfo();
            this.UnstreamizationPerformInquirePlayerInfo(Stream,WorldMatchPlayerInfo,null);
            WorldMatchPlayerInfos.push(WorldMatchPlayerInfo);
            Index++;
         }
         WorldMatchPlayerInfos.sort(function(param1:TWorldMatchPlayerInfo, param2:TWorldMatchPlayerInfo):int
         {
            if(param1.TargetRank < param2.TargetRank)
            {
               return 1;
            }
            return -1;
         });
         WorldMatch.SelfRank = Stream.readInt();
         WorldMatch.RewardConditon = Stream.readInt();
      }
      
      protected function UnstreamizationPerformInquirePlayerInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TWorldMatchPlayerInfo = null;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:uint = 0;
         var _loc11_:TBasePet = null;
         _loc4_ = param1 as ByteArray;
         _loc7_ = param2 as TWorldMatchPlayerInfo;
         _loc7_.TargetHeros.Clear();
         _loc9_ = new Vector.<uint>();
         _loc7_.Identifier0 = _loc4_.readUnsignedInt();
         _loc7_.Identifier1 = _loc4_.readUnsignedInt();
         _loc7_.ServerName = TUtilityString.FetchUTF(_loc4_);
         _loc7_.PlayerName = TUtilityString.FetchUTF(_loc4_);
         _loc7_.PlayerLevel = _loc4_.readUnsignedInt();
         _loc7_.FightPower = _loc4_.readUnsignedInt();
         _loc8_ = _loc4_.readUnsignedInt();
         if(_loc8_ == 0)
         {
            _loc7_.TargetPetLevel = STRING_COMMON.COMMON_NONE;
         }
         else
         {
            _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BasePet,_loc8_) as TBasePet;
            if(_loc11_)
            {
               if(_loc11_.NeedTransLv == 3)
               {
                  _loc7_.TargetPetLevel = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_ReincarnationPetLevel2,_loc11_.ReviceCount + 1,_loc11_.Star);
               }
               else if(_loc11_.NeedTransLv == 2 || _loc11_.NeedTransLv == 1)
               {
                  _loc7_.TargetPetLevel = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_ReincarnationPetLevel,_loc11_.ReviceCount + 1,_loc11_.Star);
               }
               else
               {
                  _loc7_.TargetPetLevel = TUtilityString.Format(STRING_CROSSSERVERWAR.FORMAT_PetLevel,_loc11_.ReviceCount + 1,_loc11_.Star);
               }
            }
         }
         _loc6_ = uint(_loc4_.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc8_ = _loc4_.readUnsignedInt();
            _loc9_.push(_loc8_);
            _loc5_++;
         }
         _loc7_.HeroId = _loc4_.readUnsignedInt();
         _loc7_.TargetRank = _loc4_.readUnsignedInt();
         this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,_loc7_.TargetHeros,_loc9_);
      }
   }
}

