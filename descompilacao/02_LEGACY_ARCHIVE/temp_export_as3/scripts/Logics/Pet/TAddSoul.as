package Logics.Pet
{
   import Logics.Exercise.TBaseBox;
   
   public class TAddSoul
   {
      
      public var StoneCount:int;
      
      public var DayItemLimit:int;
      
      public var GradeInfo:Vector.<TBaseBox>;
      
      public function TAddSoul()
      {
         super();
         this.GradeInfo = new Vector.<TBaseBox>();
      }
   }
}

