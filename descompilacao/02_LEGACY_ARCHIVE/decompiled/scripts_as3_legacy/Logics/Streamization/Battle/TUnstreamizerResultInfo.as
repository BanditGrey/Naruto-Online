package Logics.Streamization.Battle
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Battle.model.TResultInfo;
   import Logics.Battle.model.TTargetInfo;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerResultInfo extends TUnstreamizer
   {
      
      public function TUnstreamizerResultInfo()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TResultInfo = null;
         var _loc5_:int = 0;
         _loc4_ = param2 as TResultInfo;
         _loc5_ = param3 as int;
         _loc4_.CMD = _loc5_;
         if(_loc5_ == TTargetInfo.CMD_ATTACK || _loc5_ == TTargetInfo.CMD_ATTACKEX || _loc5_ == TTargetInfo.CMD_HurtHp)
         {
            _loc4_.HurtHp = Math.round(param1.readFloat());
            _loc4_.HurtAnger = param1.readInt();
         }
         else if(_loc5_ == TTargetInfo.CMD_HURTBUFF)
         {
            _loc4_.HurtHp = Math.round(param1.readFloat());
            _loc4_.HurtAnger = param1.readInt();
            _loc4_.BuffId = param1.readUnsignedInt();
            if(_loc4_.HurtHp == 0 && _loc4_.HurtAnger == 0 && _loc4_.BuffId == 0)
            {
               _loc4_.IsNull = true;
            }
            else
            {
               _loc4_.IsNull = false;
            }
         }
         else if(_loc5_ == TTargetInfo.CMD_CONTROLBUFF || _loc5_ == TTargetInfo.CMD_ATTRBUFF || _loc5_ == TTargetInfo.CMD_MIXRBUFF)
         {
            _loc4_.BuffId = param1.readUnsignedInt();
            _loc4_.BuffTurn = param1.readUnsignedInt();
         }
         else if(_loc5_ != TTargetInfo.CMD_POSITION)
         {
            if(_loc5_ != TTargetInfo.CMD_STATUS)
            {
               if(_loc5_ != TTargetInfo.CMD_NONE)
               {
                  if(_loc5_ == TTargetInfo.CMD_AllHertHp || _loc5_ == TTargetInfo.CMD_RELIVE)
                  {
                     _loc4_.CurHp = Math.round(param1.readFloat());
                     _loc4_.CurAllHp = Math.round(param1.readFloat());
                  }
                  else if(_loc5_ != TTargetInfo.CMD_NEW_SKILL)
                  {
                     if(_loc5_ == TTargetInfo.CMD_BUFF_TEXT)
                     {
                        _loc4_.BuffId = param1.readUnsignedInt();
                        _loc4_.BuffTurn = param1.readUnsignedInt();
                     }
                  }
               }
            }
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

