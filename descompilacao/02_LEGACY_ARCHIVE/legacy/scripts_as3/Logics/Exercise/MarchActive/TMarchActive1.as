package Logics.Exercise.MarchActive
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TMarchActive1 extends TBaseActivity
   {
      
      public static const TYPE_NONE:int = 0;
      
      public static const TYPE_DOUBLE:int = 5;
      
      public var ScoreA:int;
      
      public var ScoreB:int;
      
      public var NeedScore:int;
      
      public var ConsumeScore:int;
      
      public var Double:int;
      
      public var AutoPrice:int;
      
      public var ScorePrice:int;
      
      public var Gift:TBaseBox;
      
      public var ShowItems:TInventories;
      
      public var EquipList:TInventories;
      
      public var TitleList:Vector.<uint>;
      
      public var IceList:Vector.<int>;
      
      public var ScoreList:Vector.<int>;
      
      public function TMarchActive1()
      {
         super();
         this.TitleList = new Vector.<uint>();
         this.IceList = new Vector.<int>();
         this.ScoreList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
      }
   }
}

