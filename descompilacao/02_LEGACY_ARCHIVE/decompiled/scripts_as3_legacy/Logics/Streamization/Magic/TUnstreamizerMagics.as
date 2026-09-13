package Logics.Streamization.Magic
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.Magic.TMagic;
   import Logics.Magic.TMagicLevels;
   import Logics.Magic.TMagics;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerMagics extends TUnstreamizer
   {
      
      protected var FUnstreamizerMagic:TUnstreamizerMagic;
      
      public function TUnstreamizerMagics()
      {
         super();
         this.FUnstreamizerMagic = new TUnstreamizerMagic();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TMagics = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TMagic = null;
         _loc4_ = param2 as TMagics;
         _loc4_.Clear();
         _loc6_ = uint(param1.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = new TMagic();
            this.FUnstreamizerMagic.Unstreamize(param1,_loc7_,null);
            _loc4_.Add(_loc7_);
            _loc5_++;
         }
      }
      
      protected function UnstreamizationPerformByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TBins = null;
         var _loc7_:TMewBattle = null;
         var _loc8_:TMagicLevels = null;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MewBattle) as TBins;
         _loc8_ = param2 as TMagicLevels;
         _loc5_ = uint(_loc6_.Count);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetDatebaseByIndex(_loc4_) as TMewBattle;
            _loc8_.Add(_loc7_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformByDatabase(param1,param2,param3);
      }
   }
}

