package Logics.ChallengeCamp
{
   import Logics.DatebaseVO.VO.TWeekBoss;
   
   public class TChallengeCamp
   {
      
      public var BattleList:Vector.<TWeekBoss>;
      
      public var LimitCount:int;
      
      public function TChallengeCamp()
      {
         super();
         this.BattleList = new Vector.<TWeekBoss>();
      }
      
      public function GetBattleByID(param1:int) : TWeekBoss
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.BattleList.length)
         {
            if(this.BattleList[_loc2_].Identifier == param1)
            {
               return this.BattleList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

