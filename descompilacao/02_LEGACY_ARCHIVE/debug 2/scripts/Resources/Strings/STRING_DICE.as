package Resources.Strings
{
   public class STRING_DICE
   {
      
      public static const FORMAT_Process:String = "%0/%1";
      
      public static const FORMAT_RankName:String = "%0. %1";
      
      public static const FORMAT_RankNameNonePoint:String = "    %0";
      
      public static const FORMAT_News_Item:Vector.<String> = Vector.<String>([FORMAT_News_White_Item,FORMAT_News_White_Item,FORMAT_News_Green_Item,FORMAT_News_Blue_Item,FORMAT_News_Purple_Item,FORMAT_News_Yellow_Item,FORMAT_News_Red_Item,FORMAT_News_Orange_Item]);
      
      public static const FORMAT_News_White_Item:String = "<font color=\"#ffffff\">%what%</font>";
      
      public static const FORMAT_News_Green_Item:String = "<font color=\"#68ff02\">%what%</font>";
      
      public static const FORMAT_News_Blue_Item:String = "<font color=\"#0096ff\">%what%</font>";
      
      public static const FORMAT_News_Purple_Item:String = "<font color=\"#9900cf\">%what%</font>";
      
      public static const FORMAT_News_Yellow_Item:String = "<font color=\"#ffff00\">%what%</font>";
      
      public static const FORMAT_News_Red_Item:String = "<font color=\"#fe0000\">%what%</font>";
      
      public static const FORMAT_News_Orange_Item:String = "<font color=\"#ff0080\">%what%</font>";
      
      public static const FORMAT_WIN_COUNT:String = "%0 Streaks";
      
      public static const FORMAT_WIN_COUNTS:String = "%0 times";
      
      public static const FORMAT_DESC:String = "Today\'s chances:\n  %0 free guessing\n  %1 free fault tolerance";
      
      public static const FORMAT_BUY_WRONG:String = "Are you sure to spend %0 gold for fault tolerance chance?";
      
      public static const FORMAT_FREE_WRONG:String = "Are you sure to use today\'s fault tolerance opportunity?";
      
      public static const FORMAT_GIVE_UP:String = "Give up the winning streak";
      
      public static const FORMAT_GET:String = "Received successfully!";
      
      public static const FORMAT_NEED_GET_REWARD:String = "Please get your reward before guessing again!";
      
      public static const FORMAT_WRONG_COST:String = "Use %0 gold for per Fault Tolerance";
      
      public static const FORMAT_News_When:String = "<font color=\"#ffffff\">%when% received </font>";
      
      public static const TEXT_NOT_BEGIN:String = "What\'s your guess, dude?";
      
      public static const TEXT_NEED_GET:String = "Take your rewards";
      
      public static const TEXT_WIN:String = "Don\'t get carried away. Let\'s try it again!";
      
      public static const TEXT_LOSE:String = "Today is not your day.";
      
      public static const FORMAT_TIME:String = "Countdown:\n%0";
      
      public function STRING_DICE()
      {
         super();
      }
   }
}

