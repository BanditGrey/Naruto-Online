package Logics.Streamization.Talent
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Talent.TNinjaTalentData;
   import Logics.Talent.TNinjaTalentVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerNinjaTalent extends TUnstreamizer
   {
      
      public function TUnstreamizerNinjaTalent()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TNinjaTalentData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TNinjaTalentVO = null;
         _loc4_ = param2 as TNinjaTalentData;
         _loc4_.Clear();
         _loc4_.CurHeroId = param1.readUnsignedInt();
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = new TNinjaTalentVO();
            _loc7_.Identity = param1.readUnsignedInt();
            _loc4_.Add(_loc7_);
            _loc6_++;
         }
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = _loc4_.GetNinjaTalentVOByIndex(_loc6_);
            _loc7_.RefreshId = param1.readUnsignedInt();
            if(_loc7_.Identity != _loc7_.RefreshId && _loc7_.Identity > 0)
            {
               _loc4_.RefreshStatus = true;
               _loc7_.RefreshStatus = true;
            }
            _loc6_++;
         }
      }
      
      public function UnstreamizationPerformByRefresh(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TNinjaTalentData = null;
         var _loc5_:int = 0;
         var _loc6_:TNinjaTalentVO = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc7_ = int(param1.readUnsignedInt());
         _loc8_ = int(param1.readUnsignedInt());
         _loc9_ = int(param1.readUnsignedInt());
         _loc4_ = param2 as TNinjaTalentData;
         _loc6_ = _loc4_.GetNinjaTalentVOByIndex(_loc8_ - 1);
         if(_loc9_ == 1)
         {
            _loc6_.RefreshId = _loc7_;
            _loc4_.RefreshStatus = true;
            _loc6_.RefreshStatus = true;
         }
         if(_loc9_ == 2)
         {
            _loc6_.Identity = _loc7_;
            _loc4_.RefreshStatus = false;
            _loc6_.RefreshStatus = false;
         }
         if(_loc9_ == 3)
         {
            _loc6_.RefreshId = _loc7_;
            _loc4_.RefreshStatus = false;
            _loc6_.RefreshStatus = false;
         }
      }
   }
}

