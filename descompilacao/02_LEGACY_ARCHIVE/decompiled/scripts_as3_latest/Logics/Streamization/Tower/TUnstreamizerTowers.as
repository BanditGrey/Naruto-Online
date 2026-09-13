package Logics.Streamization.Tower
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.Tower.TTower;
   import Logics.Tower.TTowerData;
   import Logics.Tower.TTowers;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTowers extends TUnstreamizer
   {
      
      protected var FUnstreamizerTower:TUnstreamizerTower;
      
      public function TUnstreamizerTowers()
      {
         super();
         this.FUnstreamizerTower = new TUnstreamizerTower();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TTower = null;
         var _loc7_:TTowerData = null;
         var _loc8_:ByteArray = null;
         var _loc9_:TEnchantBattle = null;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         _loc7_ = param2 as TTowerData;
         _loc8_ = param1 as ByteArray;
         _loc7_.PlayerHP = _loc8_.readUnsignedInt();
         _loc7_.FreeExploreTimes = _loc8_.readUnsignedInt();
         _loc7_.BuyHPTimes = _loc8_.readUnsignedInt();
         _loc5_ = uint(_loc8_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc11_ = int(_loc8_.readUnsignedInt());
            _loc6_ = new TTower();
            _loc6_.TowerID = _loc8_.readUnsignedInt();
            this.FUnstreamizerTower.Unstreamize(_loc8_,_loc6_,null);
            _loc7_.OpenTowers.SetTowerByIndex(_loc11_ - 1,_loc6_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerformByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TTowers = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TBins = null;
         var _loc8_:TEnchantBattle = null;
         _loc4_ = param2 as TTowers;
         _loc4_.Clear();
         _loc7_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantBattle) as TBins;
         _loc6_ = uint(_loc7_.Count);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc8_ = _loc7_.GetDatebaseByIndex(_loc5_) as TEnchantBattle;
            if(_loc8_.Identifier % 100 == 1)
            {
               _loc4_.Add(_loc8_);
            }
            _loc5_++;
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

