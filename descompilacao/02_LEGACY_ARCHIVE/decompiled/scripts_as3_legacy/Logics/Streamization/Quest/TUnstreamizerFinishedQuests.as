package Logics.Streamization.Quest
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Quests.TQuest;
   import Logics.Quests.TQuests;
   import Resources.Constants.CONST_QUEST;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerFinishedQuests extends TUnstreamizer
   {
      
      public function TUnstreamizerFinishedQuests()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TQuests = null;
         var _loc9_:TQuest = null;
         var _loc10_:TQuests = null;
         var _loc11_:TQuests = null;
         _loc10_ = param2 as TQuests;
         _loc11_ = param3 as TQuests;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param1.readInt();
            _loc9_ = _loc10_.GetQuestByIdentifier(_loc4_);
            if(_loc9_ == null)
            {
               _loc9_ = _loc11_.GetQuestByIdentifier(_loc4_);
            }
            if(_loc9_ != null)
            {
               _loc9_.TaskState = CONST_QUEST.STATE_ALREADYBACK;
            }
            _loc6_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

