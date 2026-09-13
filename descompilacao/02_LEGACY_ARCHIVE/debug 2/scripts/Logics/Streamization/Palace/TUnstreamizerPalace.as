package Logics.Streamization.Palace
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.CrossServerWar.TCrossServerReport;
   import Logics.CrossServerWar.TCrossServerReports;
   import Logics.CrossServerWar.TPoolCrossServerReport;
   import Logics.DatebaseVO.VO.TBasePet;
   import Logics.Palace.TFightReports;
   import Logics.Palace.TInquirePlayerInfo;
   import Logics.Palace.TPalaceRoleBaseInfo;
   import Logics.Palace.TPalaceTop3Report;
   import Logics.Palace.TPalaceTop3Reports;
   import Logics.Palace.TPoolPalaceReport;
   import Logics.Palace.TRankingPlayer;
   import Logics.Palace.TRankingPlayers;
   import Logics.Palace.TTargetFighter;
   import Logics.Palace.TTargetFighters;
   import Logics.Spaces.LogicsSpace;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_PALACE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_CROSSSERVERWAR;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerPalace extends TUnstreamizer
   {
      
      protected static var FPoolPalaceTop3Report:TPoolPalaceReport;
      
      protected static var FPoolPalaceCommonReport:TPoolCrossServerReport;
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      public function TUnstreamizerPalace()
      {
         super();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolPalaceReport, param2:TPoolCrossServerReport) : void
      {
         FPoolPalaceTop3Report = param1;
         FPoolPalaceCommonReport = param2;
      }
      
      protected function UnstreamizationPerformUserRecord(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TPalaceRoleBaseInfo = null;
         var _loc5_:ByteArray = null;
         _loc5_ = param1 as ByteArray;
         _loc4_ = param2 as TPalaceRoleBaseInfo;
         _loc4_.YestodayRank = _loc5_.readUnsignedInt();
         _loc4_.CurrentRank = _loc5_.readUnsignedInt();
         _loc4_.FightPower = _loc5_.readUnsignedInt();
         _loc4_.CurrentTimes = _loc5_.readUnsignedInt();
         _loc4_.BuyTimes = _loc5_.readUnsignedInt();
         _loc4_.LastChallengeTime = _loc5_.readUnsignedInt();
      }
      
      protected function UnstreamizationPerformTargetList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TTargetFighters = null;
         var _loc5_:ByteArray = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:TTargetFighter = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:uint = 0;
         _loc5_ = param1 as ByteArray;
         _loc4_ = param2 as TTargetFighters;
         _loc11_ = new Vector.<uint>();
         _loc7_ = uint(_loc5_.readShort());
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc10_ = new TTargetFighter();
            _loc10_.RankIndex = _loc5_.readUnsignedInt();
            _loc10_.PlayerName = TUtilityString.FetchUTF(_loc5_);
            _loc10_.ServerName = TUtilityString.FetchUTF(_loc5_);
            _loc9_ = _loc11_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc9_)
            {
               _loc11_.pop();
               _loc8_++;
            }
            _loc10_.Heros.Clear();
            _loc12_ = _loc5_.readUnsignedInt();
            if(_loc12_ != 0)
            {
               _loc10_.Level = _loc5_.readUnsignedInt();
               _loc10_.WingID = _loc5_.readUnsignedInt();
               _loc10_.TitleID = _loc5_.readUnsignedInt();
               _loc11_.push(_loc12_);
               this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,_loc10_.Heros,_loc11_);
               _loc4_.AddByIndex(_loc10_.RankIndex - 1,_loc10_);
            }
            _loc6_++;
         }
         _loc4_.RoleCurrentRank = _loc5_.readUnsignedInt();
      }
      
      protected function UnstreamizationPerformReportList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TFightReports = null;
         var _loc5_:TPalaceTop3Reports = null;
         var _loc6_:TPalaceTop3Report = null;
         var _loc7_:TCrossServerReports = null;
         var _loc8_:TCrossServerReport = null;
         var _loc9_:ByteArray = null;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         _loc9_ = param1 as ByteArray;
         _loc4_ = param2 as TFightReports;
         _loc5_ = _loc4_.PalaceTop3Reports;
         _loc7_ = _loc4_.PalaceCommonReports;
         _loc5_.Clear();
         _loc11_ = uint(_loc9_.readShort());
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc6_ = FPoolPalaceTop3Report.AcquirePalaceTop3Report();
            _loc6_.ChallengeName = TUtilityString.FetchUTF(_loc9_);
            _loc6_.TargetName = TUtilityString.FetchUTF(_loc9_);
            _loc6_.Time = _loc9_.readUnsignedInt();
            _loc6_.ReportID = TUtilityString.FetchUTF(_loc9_);
            _loc6_.IsWin = Boolean(_loc9_.readUnsignedInt());
            _loc5_.Add(_loc6_);
            _loc10_++;
         }
         _loc5_.SortByTime();
         while(_loc5_.Count > CONST_PALACE.CAPACITY_Top3Reports)
         {
            _loc5_.DeleteFirst();
         }
         _loc7_.Clear();
         _loc11_ = uint(_loc9_.readShort());
         _loc10_ = 0;
         while(_loc10_ < _loc11_)
         {
            _loc8_ = FPoolPalaceCommonReport.AcquireCrossServerReport();
            _loc8_.Name = TUtilityString.FetchUTF(_loc9_);
            _loc8_.Time = _loc9_.readUnsignedInt();
            _loc8_.ReportID = TUtilityString.FetchUTF(_loc9_);
            _loc8_.IsWin = Boolean(_loc9_.readUnsignedInt());
            _loc8_.IsFight = Boolean(_loc9_.readUnsignedInt());
            _loc7_.Add(_loc8_);
            _loc10_++;
         }
         _loc7_.SortByTime();
         while(_loc7_.Count > CONST_PALACE.CAPACITY_CommonReports)
         {
            _loc7_.DeleteFirst();
         }
      }
      
      protected function UnstreamizationPerformRankingList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TRankingPlayer = null;
         var _loc8_:TRankingPlayers = null;
         _loc4_ = param1 as ByteArray;
         _loc8_ = param2 as TRankingPlayers;
         _loc6_ = uint(_loc4_.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = new TRankingPlayer();
            _loc7_.PlayerName = TUtilityString.FetchUTF(_loc4_);
            _loc7_.ServerName = TUtilityString.FetchUTF(_loc4_);
            _loc7_.PlayerLevel = _loc4_.readUnsignedInt();
            _loc7_.RankIndex = _loc4_.readUnsignedInt();
            _loc4_.readUnsignedInt();
            _loc4_.readUnsignedInt();
            _loc8_.AddByIndex(_loc7_.RankIndex - 1,_loc7_);
            _loc5_++;
         }
      }
      
      protected function UnstreamizationPerformInquirePlayerInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TInquirePlayerInfo = null;
         var _loc8_:uint = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:uint = 0;
         var _loc11_:TBasePet = null;
         _loc4_ = param1 as ByteArray;
         _loc7_ = param2 as TInquirePlayerInfo;
         _loc7_.TargetHeros.Clear();
         _loc9_ = new Vector.<uint>();
         _loc7_.TargetRank = _loc4_.readUnsignedInt();
         _loc7_.PlayerName = TUtilityString.FetchUTF(_loc4_);
         _loc7_.ServerName = TUtilityString.FetchUTF(_loc4_);
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
         this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,_loc7_.TargetHeros,_loc9_);
      }
      
      public function UnstreamizeUserRecord(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformUserRecord(param1,param2,param3);
      }
      
      public function UnstreamizeTargetList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformTargetList(param1,param2,param3);
      }
      
      public function UnstreamizeReportList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformReportList(param1,param2,param3);
      }
      
      public function UnstreamizeRankingList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformRankingList(param1,param2,param3);
      }
      
      public function UnstreamizeInquirePlayerInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformInquirePlayerInfo(param1,param2,param3);
      }
   }
}

