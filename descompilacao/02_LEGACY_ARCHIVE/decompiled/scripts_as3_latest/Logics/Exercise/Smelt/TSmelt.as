package Logics.Exercise.Smelt
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   
   public class TSmelt extends TBaseActivity
   {
      
      public var SmeltSum:int;
      
      public var ShowList:Vector.<TBaseBox>;
      
      public var SmeltList:TInventories;
      
      public function TSmelt()
      {
         super();
         this.ShowList = new Vector.<TBaseBox>();
         this.SmeltList = new TInventories();
      }
   }
}

