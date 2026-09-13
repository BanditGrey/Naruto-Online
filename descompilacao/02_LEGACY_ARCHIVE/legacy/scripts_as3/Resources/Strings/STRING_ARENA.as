package Resources.Strings
{
   public class STRING_ARENA
   {
      
      public static const RANKINT_BoxTip:String = "Top %count%";
      
      public static const ARENA_Report_WhenVect:Vector.<String> = Vector.<String>(["Hoy","Ayer","Anteayer","Hace tres días","Dentro de una semana","Hace mucho tiempo","Hace mucho tiempo","Hace una semana"]);
      
      public static const ARENA_Report_Fight:String = "%when%Has desafiado<font color=\'#ff6600\'>%who%</font>，";
      
      public static const ARENA_Report_BFight:String = "%when%<font color=\'#ff6600\'>%who%</font> te ha desafiado,";
      
      public static const ARENA_Report_Win:String = "<font color=\'#ffff00\'>Tú has ganado</font>";
      
      public static const ARENA_Report_Lost:String = "<font color=\'#0099ff\'>Tú has fallado</font>";
      
      public static const ARENA_Report_Ranking_Up:String = "<font color=\'#0099ff\'>Top sube al%ranking%</font>";
      
      public static const ARENA_Report_Ranking_Down:String = "<font color=\'#0099ff\'>Top baja al%ranking%</font>";
      
      public static const ARENA_Report_Ranking_None:String = "<font color=\'#0099ff\'>Top sin cambio</font>";
      
      public static const ARENA_Ranking_ListReward:String = "Top %from% hasta %to% que puede recibir";
      
      public static const ARENA_AddTimesCostTip:String = "Gastar%count%oros por tener una nueva oportunidad para desafiar";
      
      public function STRING_ARENA()
      {
         super();
      }
   }
}

