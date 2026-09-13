package Logics.Exercise.Bejeweled
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TBejeweled extends TBaseActivity
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
      
      public var IceList:Vector.<int>;
      
      public var ScoreList:Vector.<int>;
      
      public function TBejeweled()
      {
         super();
         this.IceList = new Vector.<int>();
         this.ScoreList = new Vector.<int>();
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
   }
}

