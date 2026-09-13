package Logics.Streamization.TacticalDeployment
{
   import Foundation.Streamization.TUnstreamizer;
   import Processors.Game.Lobby.TacticalDeployment.TAutoChangeFormHeroInfo;
   import Processors.Game.Lobby.TacticalDeployment.TAutoChangeFormInfo;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTacticalDeployment extends TUnstreamizer
   {
      
      public function TUnstreamizerTacticalDeployment()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TAutoChangeFormInfo = null;
         var _loc5_:TAutoChangeFormHeroInfo = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc4_ = param2 as TAutoChangeFormInfo;
         _loc5_ = new TAutoChangeFormHeroInfo();
         _loc5_.heroId = param1.readUnsignedInt();
         _loc5_.Fightpos = param1.readUnsignedInt();
         _loc6_ = uint(param1.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            param1.readDouble();
            _loc8_ = uint(param1.readShort());
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               param1.readUnsignedInt();
               _loc9_++;
            }
            _loc7_++;
         }
         _loc6_ = uint(param1.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            param1.readDouble();
            _loc7_++;
         }
         _loc4_.Add(_loc5_);
      }
   }
}

