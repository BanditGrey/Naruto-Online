package Logics.Mentorship
{
   import Logics.Mentorship.Elements.TInteractionLogInfo;
   
   public class TInteractionLog
   {
      
      protected var FInteractionLogList:Vector.<TInteractionLogInfo>;
      
      public function TInteractionLog()
      {
         super();
         this.FInteractionLogList = new Vector.<TInteractionLogInfo>();
      }
      
      protected function SortByTime(param1:TInteractionLogInfo, param2:TInteractionLogInfo) : int
      {
         if(param1.Time > param2.Time)
         {
            return 1;
         }
         if(param1.Time < param2.Time)
         {
            return -1;
         }
         return 0;
      }
      
      public function get InteractionLogList() : Vector.<TInteractionLogInfo>
      {
         return this.FInteractionLogList;
      }
      
      public function set InteractionLogList(param1:Vector.<TInteractionLogInfo>) : void
      {
         this.FInteractionLogList = param1;
      }
      
      public function Sort() : void
      {
         this.FInteractionLogList.sort(this.SortByTime);
      }
   }
}

