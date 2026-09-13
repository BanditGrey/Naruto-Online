package Resources.Strings
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNPC;
   import Logics.Quests.TQuest;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_QUEST;
   
   public class STRING_QUEST
   {
      
      public static var FColorType:Array = ["","(Green)","(Blue)","(Orange)","(Yellow)"];
      
      public static var FQuestTypeName:Vector.<String> = Vector.<String>(["","[Main]","[Side]","[Challenge]"]);
      
      public static const RewardName:Vector.<String> = Vector.<String>(["Silver","Gold","Coupon"]);
      
      public static var FQuestNameStateComplete_formatString:String = "<font color=\'#ff00\' SIZE=\'12\'><u><a href=\'event:%0\'>%1(Complete)</a></u></font>\n";
      
      public static var FQuestNameStateUncomplete_formatString:String = "<font color=\'#ffffff\' SIZE=\'12\'>%0</font>\n";
      
      public static var FQuestNameStateUncompleteLoseLevel_formatString:String = "<font color=\'#ffffff\' SIZE=\'12\'>%0</font><font color=\'#ff0000\' SIZE=\'12\'>(Available to Lv.%1)</font>\n";
      
      public static var FQuestInforCanAcceptTask_formatString:String = "    <font color=\'#ffffff\' SIZE=\'12\'>Accept Quest From:</font><font color=\'#99ff\' SIZE=\'12\'><u><a href=\'event:%0\'> %1</a></u></font>";
      
      public static var FQuestInforAlreadyAcceptTask_formatString:String = "    %0<font color=\'#0099ff\' SIZE=\'12\'><u><a href=\'event:%1\'>%2</a></u></font>";
      
      public static var FQuestProgress_formatString:String = "<font color=\'#0099ff\' SIZE=\'12\'>(%0/%1)</font>";
      
      public function STRING_QUEST()
      {
         super();
      }
      
      public static function GetTaskNameString(param1:TQuest) : String
      {
         return FQuestTypeName[param1.Category] + param1.Name;
      }
      
      public static function GetTaskNameHtmlText(param1:TQuest) : String
      {
         var _loc2_:String = null;
         _loc2_ = GetTaskNameString(param1);
         if(param1.TaskState == CONST_QUEST.STATE_TASKBACK)
         {
            return TUtilityString.Format(FQuestNameStateComplete_formatString,param1.Identifier.toString(),_loc2_);
         }
         if(SLogicsCore.Character.GetMainLevel() < param1.RequirementLevelMin)
         {
            return TUtilityString.Format(FQuestNameStateUncompleteLoseLevel_formatString,_loc2_,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevelCopy(param1.RequirementLevelMin));
         }
         return TUtilityString.Format(FQuestNameStateUncomplete_formatString,_loc2_);
      }
      
      public static function GetTaskInfor(param1:TQuest) : String
      {
         var _loc2_:TNPC = null;
         var _loc3_:String = null;
         if(param1.TaskState == CONST_QUEST.STATE_ACCEPT)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_NPC,param1.AcceptTaskNpc) as TNPC;
            if(_loc2_.Cityid == 23100001)
            {
               _loc3_ = "(Newbie Village)";
            }
            else
            {
               _loc3_ = "(Konoha Village)";
            }
            return TUtilityString.Format(FQuestInforCanAcceptTask_formatString,param1.Identifier.toString(),_loc2_.Name + _loc3_);
         }
         if(param1.TaskState == CONST_QUEST.STATE_TASKING)
         {
            _loc3_ = GetTaskInfoAlreadyAcceptHtmlText(param1);
            if(param1.EventType == CONST_QUEST.QuestEventTypeKillMonster)
            {
               _loc3_ += GetTaskInfoProgress(param1);
            }
            return _loc3_ + "\n";
         }
         return "";
      }
      
      protected static function GetTaskInfoProgress(param1:TQuest) : String
      {
         return TUtilityString.Format(FQuestProgress_formatString,param1.CurrentfKillTime.toString(),param1.KillTime.toString());
      }
      
      protected static function GetTaskInfoAlreadyAcceptHtmlText(param1:TQuest) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         _loc4_ = param1.Guiding;
         _loc5_ = _loc4_.split("#");
         _loc3_ = TUtilityString.Format(FQuestInforAlreadyAcceptTask_formatString,_loc5_[0],param1.Identifier.toString(),_loc5_[1]);
         _loc2_ = 2;
         while(_loc2_ < _loc5_.length)
         {
            _loc3_ += _loc5_[_loc2_];
            _loc2_++;
         }
         return _loc3_;
      }
   }
}

