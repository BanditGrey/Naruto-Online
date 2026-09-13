package Logics.Streamization.Tower
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.Tower.TTower;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTower extends TUnstreamizer
   {
      
      public function TUnstreamizerTower()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TTower = null;
         var _loc5_:TEnchantBattle = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         _loc4_ = param2 as TTower;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EnchantBattle,_loc4_.TowerID) as TEnchantBattle;
         if(_loc5_ != null)
         {
            _loc4_.Name = _loc5_.Name;
            _loc4_.Tower = _loc5_.Tower;
            _loc4_.Stageid = _loc5_.Stageid;
            _loc4_.StageClear = _loc5_.StageClear;
            _loc4_.Level = _loc5_.Level;
            _loc7_ = _loc5_.Awards.length;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_.Awards[_loc6_] = _loc5_.Awards[_loc6_];
               _loc6_++;
            }
            _loc7_ = _loc5_.Awardexs.length;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_.Awardexs[_loc6_] = _loc5_.Awards[_loc6_];
               _loc6_++;
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

