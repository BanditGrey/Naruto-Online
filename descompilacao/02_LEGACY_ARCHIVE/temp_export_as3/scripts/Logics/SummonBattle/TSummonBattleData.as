package Logics.SummonBattle
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TSummonBattle;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TSummonBattleData
   {
      
      public var FieldId:int;
      
      public var IDHigh:uint;
      
      public var IDLow:uint;
      
      public var Index:int;
      
      public var AgentId:int;
      
      public var UserName:String;
      
      public var UserLevel:int;
      
      public var PvpFightValue:UInt64 = new UInt64();
      
      public var OccupyTime:int;
      
      public var SummonBattle:TSummonBattle;
      
      public function TSummonBattleData(param1:int)
      {
         super();
         this.FieldId = param1;
         if(this.SummonBattle == null)
         {
            this.SummonBattle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SummonBattle,this.FieldId) as TSummonBattle;
         }
      }
      
      public function get SumonLevel() : int
      {
         if(this.SummonBattle)
         {
            return this.SummonBattle.LevelArr[this.Index - 1];
         }
         return 1;
      }
      
      public function get IsMyself() : Boolean
      {
         if(this.IDHigh != SLogicsCore.Character.Identifier0 || this.IDLow != SLogicsCore.Character.Identifier1)
         {
            return false;
         }
         return true;
      }
   }
}

