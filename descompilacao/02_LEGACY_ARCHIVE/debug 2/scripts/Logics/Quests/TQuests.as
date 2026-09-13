package Logics.Quests
{
   public class TQuests
   {
      
      protected var FQuests:Vector.<TQuest>;
      
      public function TQuests()
      {
         super();
         this.FQuests = new Vector.<TQuest>();
      }
      
      protected function Compare(param1:TQuest, param2:TQuest) : int
      {
         if(param1.Identifier < param2.Identifier)
         {
            return -1;
         }
         if(param1.Identifier > param2.Identifier)
         {
            return 1;
         }
         return 0;
      }
      
      protected function CompareState(param1:TQuest, param2:TQuest) : int
      {
         if(param1.TaskState < param2.TaskState)
         {
            return 1;
         }
         if(param1.TaskState > param2.TaskState)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FQuests.length;
      }
      
      public function GetQuestByIndex(param1:int) : TQuest
      {
         return this.FQuests[param1];
      }
      
      public function GetQuestByIdentifier(param1:uint) : TQuest
      {
         var _loc4_:TQuest = null;
         var _loc2_:int = int(this.FQuests.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FQuests[_loc3_];
            if(_loc4_.Identifier == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function DeleteQuestByIdentifier(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TQuest = null;
         _loc2_ = int(this.FQuests.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FQuests[_loc3_];
            if(_loc4_.Identifier == param1)
            {
               _loc4_.StubReferences.Dereference(this);
               this.FQuests.splice(_loc3_,1);
               return;
            }
            _loc3_++;
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TQuest = null;
         _loc1_ = int(this.FQuests.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FQuests[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FQuests.length = 0;
      }
      
      public function Add(param1:TQuest) : void
      {
         param1.StubReferences.Reference(this);
         this.FQuests.push(param1);
      }
      
      public function Sort() : void
      {
         this.FQuests.sort(this.Compare);
      }
      
      public function SortByQuestState() : void
      {
         this.FQuests.sort(this.CompareState);
      }
      
      public function MaxQuestID() : int
      {
         return this.FQuests[this.FQuests.length - 1].Identifier;
      }
      
      public function IfContainQuest(param1:TQuest) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TQuest = null;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FQuests[_loc2_];
            if(_loc4_.Identifier == param1.Identifier)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

