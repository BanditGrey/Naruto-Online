package Resources.Strings
{
   public class STRING_ARENA
   {
      
      public static const RANKINT_BoxTip:String = "Top %count%";
      
      public static const ARENA_Report_WhenVect:Vector.<String> = Vector.<String>(["Today","Yesterday","Two Days Ago","Three Days Ago","Within a Week","A Long Time Ago","A Long Time Ago","1 Week Ago"]);
      
      public static const ARENA_Report_Fight:String = "%when% You challenge <font color=\'#ff6600\'>%who%</font>，";
      
      public static const ARENA_Report_BFight:String = "<font color=\'#ff6600\'>%who%</font> challenged you %when%,";
      
      public static const ARENA_Report_Win:String = "<font color=\'#ffff00\'>You won,</font>";
      
      public static const ARENA_Report_Lost:String = "<font color=\'#0099ff\'>You lost,</font>";
      
      public static const ARENA_Report_Ranking_Up:String = "<font color=\'#0099ff\'>Your rank raise to %ranking%</font>";
      
      public static const ARENA_Report_Ranking_Down:String = "<font color=\'#0099ff\'>Your rank drop to %ranking%</font>";
      
      public static const ARENA_Report_Ranking_None:String = "<font color=\'#0099ff\'>Rank stays the same</font>";
      
      public static const ARENA_Ranking_ListReward:String = "Claimable for No.%from% to No.%to%";
      
      public static const ARENA_AddTimesCostTip:String = "Spend %count% Gold to get one Additional Chance";
      
      public static const ARENA_FastCostTip:String = "Are you sure to spend %count% Gold to clear cooldown?";
      
      public function STRING_ARENA()
      {
         super();
      }
   }
}

