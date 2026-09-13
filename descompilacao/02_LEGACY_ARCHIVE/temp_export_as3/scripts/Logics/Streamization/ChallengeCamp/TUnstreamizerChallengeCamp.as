package Logics.Streamization.ChallengeCamp
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.ChallengeCamp.TChallengeCamp;
   import Logics.DatebaseVO.VO.TWeekBoss;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerChallengeCamp extends TUnstreamizer
   {
      
      protected var FWeekBossBins:TBins;
      
      public function TUnstreamizerChallengeCamp()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TChallengeCamp = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TWeekBoss = null;
         var _loc8_:int = 0;
         if(!this.FWeekBossBins)
         {
            this.FWeekBossBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WeekBoss);
         }
         _loc4_ = param2 as TChallengeCamp;
         _loc5_ = int(param1.readUnsignedShort());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = param1.readInt();
            _loc7_ = this.FWeekBossBins.GetDatebaseByIdentifier(_loc8_) as TWeekBoss;
            _loc7_.Status = param1.readInt();
            _loc7_.SpecialStatus = param1.readInt();
            _loc7_.BattleStatus = param1.readInt();
            _loc7_.LimitCount = param1.readInt();
            _loc7_.BuyCount = param1.readInt();
            _loc4_.BattleList[_loc6_] = _loc7_;
            _loc6_++;
         }
      }
   }
}

