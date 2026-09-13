package Processors.Game.Battle.Character
{
   import Foundation.UI.TUIComponent;
   import Logics.Battle.model.TRoleBattleInfo;
   import Processors.Game.Battle.TBattleStage;
   
   public class TPoolRole
   {
      
      protected static var FPoolActive:Vector.<TActive> = new Vector.<TActive>();
      
      protected static var FPoolRole:Vector.<TRole> = new Vector.<TRole>();
      
      public function TPoolRole()
      {
         super();
      }
      
      public static function GetActive(param1:TUIComponent, param2:uint, param3:uint, param4:Boolean = false, param5:Boolean = true, param6:Boolean = false) : TActive
      {
         var _loc7_:TActive = null;
         if(FPoolActive.length > 0)
         {
            _loc7_ = FPoolActive.pop();
            _loc7_.ResetActive(param1,param2,param3,param4,param5,param6);
         }
         else
         {
            _loc7_ = new TActive(param1,param2,param3,param4,param5,param6);
         }
         return _loc7_;
      }
      
      public static function SaveActive(param1:TActive) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(FPoolActive.indexOf(param1) >= 0)
         {
            return;
         }
         param1.Releasing();
         if(Boolean(param1) && Boolean(param1.parent))
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public static function GetRole(param1:TUIComponent, param2:TRoleBattleInfo, param3:uint, param4:TBattleStage, param5:Boolean = false, param6:Function = null, param7:int = 0) : TRole
      {
         var _loc8_:TRole = null;
         if(FPoolRole.length > 0)
         {
            _loc8_ = FPoolRole.pop();
            _loc8_.ResetRole(param1,param2,param3,param4,param5,param6,param7);
         }
         else
         {
            _loc8_ = new TRole(param1,param2,param3,param4,param5,param6,param7);
         }
         return _loc8_;
      }
      
      public static function SaveRole(param1:TRole) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(FPoolRole.indexOf(param1) >= 0)
         {
            return;
         }
         param1.Releasing();
         if(Boolean(param1) && Boolean(param1.parent))
         {
            param1.parent.removeChild(param1);
         }
      }
   }
}

