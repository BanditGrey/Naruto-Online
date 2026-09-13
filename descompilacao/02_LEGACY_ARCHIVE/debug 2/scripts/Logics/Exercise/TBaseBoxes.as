package Logics.Exercise
{
   public class TBaseBoxes
   {
      
      public var Price:int;
      
      public var Return:int;
      
      public var Items:Vector.<TBaseBox>;
      
      public function TBaseBoxes()
      {
         super();
         this.Items = new Vector.<TBaseBox>();
      }
   }
}

