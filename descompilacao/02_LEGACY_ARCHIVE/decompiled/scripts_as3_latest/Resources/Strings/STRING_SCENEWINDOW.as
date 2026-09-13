package Resources.Strings
{
   import Resources.Constants.CONST_QUEST;
   
   public class STRING_SCENEWINDOW
   {
      
      public static const QUESTICON_STATE:Vector.<int> = Vector.<int>([CONST_QUEST.STATE_ACCEPT,CONST_QUEST.STATE_TASKING,CONST_QUEST.STATE_TASKBACK]);
      
      public static const QUESTICON_TEXTLAYER1:Vector.<String> = Vector.<String>(["(Acceptable)","(Accepted)","(Completed)"]);
      
      public static const QUESTICON_TEXTLAYER2:Vector.<String> = Vector.<String>(["Accepted","I\'ll do it now","Complete Quest"]);
      
      public static const FORMAT_QuestLable:String = "【Quest】%0%1";
      
      public function STRING_SCENEWINDOW()
      {
         super();
      }
   }
}

