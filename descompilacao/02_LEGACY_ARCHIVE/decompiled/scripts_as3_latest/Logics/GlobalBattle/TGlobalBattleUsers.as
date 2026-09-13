package Logics.GlobalBattle
{
   import flash.utils.Dictionary;
   
   public class TGlobalBattleUsers
   {
      
      public var HistoryUsersVec:Dictionary;
      
      public function TGlobalBattleUsers()
      {
         super();
         this.HistoryUsersVec = new Dictionary();
      }
      
      public function AddUser(param1:TGlobalBattleUser) : void
      {
         if(this.HistoryUsersVec[param1.YearMonth] == undefined)
         {
            this.HistoryUsersVec[param1.YearMonth] = [];
         }
         this.HistoryUsersVec[param1.YearMonth].push(param1);
      }
   }
}

