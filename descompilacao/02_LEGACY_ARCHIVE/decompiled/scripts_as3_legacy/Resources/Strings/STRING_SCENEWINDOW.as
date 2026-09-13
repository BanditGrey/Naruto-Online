package Resources.Strings
{
   import Resources.Constants.CONST_QUEST;
   
   public class STRING_SCENEWINDOW
   {
      
      public static const QUESTICON_STATE:Vector.<int> = Vector.<int>([CONST_QUEST.STATE_ACCEPT,CONST_QUEST.STATE_TASKING,CONST_QUEST.STATE_TASKBACK]);
      
      public static const QUESTICON_TEXTLAYER1:Vector.<String> = Vector.<String>(["(Recibir)","(Recibido)","(Terminado)"]);
      
      public static const QUESTICON_TEXTLAYER2:Vector.<String> = Vector.<String>(["Aceprar","Ahora voy a hacer","Misión completa"]);
      
      public static const FORMAT_QuestLable:String = "【Misión】%0%1";
      
      public function STRING_SCENEWINDOW()
      {
         super();
      }
   }
}

