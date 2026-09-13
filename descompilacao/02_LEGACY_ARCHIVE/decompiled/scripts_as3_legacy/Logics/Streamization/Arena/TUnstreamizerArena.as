package Logics.Streamization.Arena
{
   import Foundation.Resources.Repositories.TResourceRepositoryBin;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Timing.STimingCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.Arena.TArenaData;
   import Logics.Arena.TArenaHero;
   import Logics.Arena.TArenaHeros;
   import Logics.Arena.TArenaReport;
   import Logics.Arena.TArenaReports;
   import Logics.Arena.TPoolArena;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Spaces.LogicsSpace;
   import Resources.Constants.CONST_ARENA;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   use namespace LogicsSpace;
   
   public class TUnstreamizerArena extends TUnstreamizer
   {
      
      protected static var FPoolArena:TPoolArena;
      
      public function TUnstreamizerArena()
      {
         super();
      }
      
      LogicsSpace static function PoolsSetup(param1:TPoolArena) : void
      {
         FPoolArena = param1;
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TArenaData = null;
         _loc4_ = param2 as TArenaData;
         this.UnstreamizationBaseInfo(param1,_loc4_,param3);
         this.UnstreamizeArena_FightHero(param1,_loc4_.FightHeroList,param3);
         this.UnstreamizeArena_Report(param1,_loc4_.ReportList,param3);
      }
      
      protected function UnstreamizationBaseInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:Date = null;
         var _loc5_:TArenaData = null;
         var _loc6_:int = 0;
         var _loc7_:TResourceRepositoryBin = null;
         var _loc8_:TConfigValue = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc5_ = param2 as TArenaData;
         _loc7_ = param3 as TResourceRepositoryBin;
         _loc5_.BoxType = param1.readUnsignedByte();
         _loc5_.BoxRanking = param1.readUnsignedShort();
         _loc5_.BoxLevel = param1.readUnsignedInt();
         _loc5_.FightTimes = param1.readUnsignedByte();
         _loc5_.AddTimes = param1.readUnsignedByte();
         _loc5_.ColdDown = param1.readUnsignedInt();
         _loc5_.HighRanking = param1.readUnsignedShort();
         _loc5_.CurRanking = param1.readUnsignedShort();
         _loc5_.StreakWin = param1.readUnsignedShort();
         _loc6_ = int(STimingCore.GetServerTime());
         _loc4_ = new Date(_loc6_ * 1000);
         _loc8_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ARENA_RANK_REWARD_BOX_GET_HOUR) as TConfigValue;
         _loc9_ = uint(_loc8_.Value as int);
         _loc8_ = _loc7_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.ARENA_RANK_REWARD_BOX_GET_SECOND) as TConfigValue;
         _loc10_ = uint(_loc8_.Value as int);
         if(_loc4_.hours > _loc9_ || _loc4_.hours == _loc9_ && _loc4_.minutes > _loc10_)
         {
            _loc4_ = new Date((_loc6_ + CONST_ARENA.ColdDown_BoxMax) * 1000);
         }
         _loc4_.hours = _loc9_;
         _loc4_.minutes = _loc10_;
         _loc4_.seconds = 0;
         _loc5_.ColdDownBox = _loc4_.getTime() / 1000;
      }
      
      protected function UnstreamizeArena_FightHero(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TArenaHero = null;
         var _loc7_:TArenaHeros = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc7_ = param2 as TArenaHeros;
         _loc7_.Clear();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc6_ = FPoolArena.AcquireArenaHero(_loc8_,_loc9_);
            _loc6_.Country = param1.readUnsignedByte();
            _loc6_.Ranking = param1.readUnsignedShort();
            _loc6_.Military = param1.readUnsignedInt();
            _loc6_.HeroId = param1.readUnsignedInt();
            _loc6_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc6_.PlayerLevel = param1.readUnsignedInt();
            _loc7_.Add(_loc6_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizeArena_HeroPanel(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TArenaHero = null;
         var _loc7_:TArenaHeros = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc7_ = param2 as TArenaHeros;
         _loc7_.Clear();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc6_ = FPoolArena.AcquireArenaHero(_loc8_,_loc9_);
            _loc6_.Country = param1.readUnsignedByte();
            _loc6_.Ranking = param1.readUnsignedShort();
            _loc6_.Military = param1.readUnsignedInt();
            _loc6_.HeroId = param1.readUnsignedInt();
            _loc6_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc6_.PlayerLevel = param1.readUnsignedInt();
            _loc7_.Add(_loc6_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizeArena_Report(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TArenaReport = null;
         var _loc7_:TArenaReports = null;
         _loc7_ = param2 as TArenaReports;
         _loc7_.Clear();
         _loc5_ = int(param1.readUnsignedShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = FPoolArena.AcquireArenaReport();
            _loc6_.PlayerNick = TUtilityString.FetchUTF(param1);
            _loc6_.IsFight = !Boolean(param1.readUnsignedByte());
            _loc6_.ChgRanking = param1.readShort();
            _loc6_.When = param1.readUnsignedInt();
            _loc6_.ReportId = TUtilityString.FetchUTF(param1);
            _loc6_.IsWin = Boolean(_loc6_.ChgRanking > 0);
            if(_loc6_.ChgRanking >= 10000 || _loc6_.ChgRanking <= -10000)
            {
               _loc6_.ChgRanking = 0;
            }
            _loc7_.Add(_loc6_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeArenaFightHero(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizeArena_FightHero(param1,param2,param3);
      }
      
      public function UnstreamizeArenaHeroPanel(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizeArena_HeroPanel(param1,param2,param3);
      }
      
      public function UnstreamizeArenaReport(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizeArena_Report(param1,param2,param3);
      }
   }
}

