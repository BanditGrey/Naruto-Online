package Logics.Exercise.MarchConsume
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TMarchConsumeBox extends TBaseActivity
   {
      
      public var Gold:int;
      
      public var Days:int;
      
      public var Boxes:Vector.<TBaseBox>;
      
      public function TMarchConsumeBox()
      {
         super();
         this.Boxes = new Vector.<TBaseBox>();
      }
   }
}

