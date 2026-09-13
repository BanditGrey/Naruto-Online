package Logics.Exercise.FebActive
{
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TFebActive3 extends TBaseActivity
   {
      
      public var FirecrackerTime:int;
      
      public var ScoreA:int;
      
      public var ResetTime:int;
      
      public var BossIndex:int;
      
      public var BossHp:int;
      
      public var BombCost:int;
      
      public var ScorePrice:int;
      
      public var KillGift:Vector.<TBaseBox>;
      
      public var BossList:Vector.<int>;
      
      public var ShowItems:TInventories;
      
      public var EquipList:TInventories;
      
      public var TitleList:Vector.<uint>;
      
      public var ActivityTaskData:TActivityTaskData;
      
      public function TFebActive3()
      {
         super();
         this.KillGift = new Vector.<TBaseBox>();
         this.BossList = new Vector.<int>();
         this.TitleList = new Vector.<uint>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

