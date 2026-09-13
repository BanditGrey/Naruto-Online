package Logics.ConsumeVip
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConsumeVip;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TConsumeVipData
   {
      
      public var ConsumeMoney:int;
      
      public var DailyAward:int;
      
      public var VipAward:Object = {};
      
      public var Daybuy:Object = {};
      
      public function TConsumeVipData()
      {
         super();
      }
      
      public function get VipLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:TConsumeVip = null;
         var _loc3_:TConsumeVip = null;
         var _loc4_:TBins = null;
         var _loc5_:int = 0;
         _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConsumeVip);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.Count)
         {
            _loc2_ = _loc4_.GetDatebaseByIndex(_loc5_) as TConsumeVip;
            _loc3_ = _loc2_.NextConsumeVip;
            if(this.ConsumeMoney >= _loc2_.ConsumeCount && this.ConsumeMoney < _loc3_.ConsumeCount)
            {
               _loc1_ = _loc2_.Identifier;
               break;
            }
            _loc1_ = _loc3_.Identifier;
            _loc5_++;
         }
         return _loc1_;
      }
   }
}

