package Logics.Streamization.Quest
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TTask;
   import Logics.Quests.TQuest;
   import Logics.Quests.TQuests;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_QUEST;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerQuests extends TUnstreamizerQuestUnknown
   {
      
      protected var FUnstreamizerQuest:TUnstreamizerQuest;
      
      public function TUnstreamizerQuests()
      {
         super();
         this.FUnstreamizerQuest = new TUnstreamizerQuest();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TQuest = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:TQuests = null;
         var _loc11_:TQuests = null;
         var _loc12_:TQuests = null;
         _loc11_ = param2 as TQuests;
         _loc12_ = param3 as TQuests;
         _loc6_ = int(param1.readUnsignedShort());
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = param1.readUnsignedInt();
            _loc8_ = int(param1.readUnsignedShort());
            _loc4_ = _loc11_.GetQuestByIdentifier(_loc5_);
            if(_loc4_ == null)
            {
               _loc4_ = _loc12_.GetQuestByIdentifier(_loc5_);
            }
            if(_loc4_ != null)
            {
               _loc4_.CurrentfKillTime = _loc8_;
               _loc4_.TaskState = CONST_QUEST.STATE_TASKING;
            }
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerform_QuestsByDatabases(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBins = null;
         var _loc7_:TTask = null;
         var _loc8_:TQuests = null;
         var _loc9_:TQuests = null;
         var _loc10_:TQuest = null;
         var _loc11_:int = 0;
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Task);
         _loc8_ = param2 as TQuests;
         _loc9_ = param3 as TQuests;
         _loc5_ = _loc6_.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = _loc6_.GetDatebaseByIndex(_loc4_) as TTask;
            _loc10_ = FPoolQuest.AcquireQuest(_loc7_.Identifier);
            this.FUnstreamizerQuest.UnstreamizeQuestByDatabases(null,_loc10_,_loc7_);
            switch(_loc10_.Category)
            {
               case CONST_QUEST.QuestCategory_Main:
                  _loc8_.Add(_loc10_);
                  break;
               case CONST_QUEST.QuestCategory_Branch:
                  _loc9_.Add(_loc10_);
            }
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeQuestsByDatabases(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_QuestsByDatabases(param1,param2,param3);
      }
   }
}

