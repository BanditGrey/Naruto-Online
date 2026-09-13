package Logics.Streamization.KillHero
{
   import Foundation.Resources.Repositories.TResourceRepositoryBin;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TRaidersDailyConfig;
   import Logics.KillHero.TSingleKillHero;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerSingleKillHero extends TUnstreamizer
   {
      
      public function TUnstreamizerSingleKillHero()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TSingleKillHero = null;
         var _loc6_:TResourceRepositoryBin = null;
         var _loc7_:uint = 0;
         var _loc8_:TRaidersDailyConfig = null;
         _loc5_ = param2 as TSingleKillHero;
         _loc6_ = param3 as TResourceRepositoryBin;
         _loc5_.EnterCount = param1.readByte();
         _loc5_.ResetCount = param1.readByte();
         _loc5_.IsPassed = true;
         _loc8_ = _loc6_.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RaidersDailyConfig,_loc5_.KillHeroId) as TRaidersDailyConfig;
         _loc5_.HeroIds = _loc8_.HeroVect;
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

