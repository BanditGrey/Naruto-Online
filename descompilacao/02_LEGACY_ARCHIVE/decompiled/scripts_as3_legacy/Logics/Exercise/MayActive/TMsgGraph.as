package Logics.Exercise.MayActive
{
   import Logics.Exercise.TBaseBox;
   
   public class TMsgGraph
   {
      
      public static const MAX_COUNT:int = 15;
      
      protected var FTreasureBoxList:Vector.<TBaseBox>;
      
      protected var FTreasureIndex:int;
      
      protected var FGraphStatus:int;
      
      protected var FCurStep:int;
      
      public function TMsgGraph()
      {
         var _loc1_:int = 0;
         super();
         this.FTreasureBoxList = new Vector.<TBaseBox>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FTreasureBoxList[_loc1_] = new TBaseBox();
            _loc1_++;
         }
      }
      
      public function get CurStep() : int
      {
         return this.FCurStep;
      }
      
      public function set CurStep(param1:int) : void
      {
         this.FCurStep = param1;
      }
      
      public function get GraphStatus() : int
      {
         return this.FGraphStatus;
      }
      
      public function set GraphStatus(param1:int) : void
      {
         this.FGraphStatus = param1;
      }
      
      public function get TreasureIndex() : int
      {
         return this.FTreasureIndex;
      }
      
      public function set TreasureIndex(param1:int) : void
      {
         this.FTreasureIndex = param1;
      }
      
      public function get TreasureBoxList() : Vector.<TBaseBox>
      {
         return this.FTreasureBoxList;
      }
      
      public function set TreasureBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FTreasureBoxList = param1;
      }
   }
}

