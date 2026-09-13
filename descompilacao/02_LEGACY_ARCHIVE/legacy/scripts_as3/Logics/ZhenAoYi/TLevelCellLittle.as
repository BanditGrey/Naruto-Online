package Logics.ZhenAoYi
{
   import Logics.DatebaseVO.VO.TSkillReform;
   
   public class TLevelCellLittle
   {
      
      protected var FAllLevelVector:Vector.<TSkillReform>;
      
      public function TLevelCellLittle()
      {
         super();
         this.FAllLevelVector = new Vector.<TSkillReform>();
      }
      
      public function add(param1:TSkillReform) : void
      {
         this.FAllLevelVector.push(param1);
      }
      
      public function get Count() : int
      {
         return this.FAllLevelVector.length;
      }
      
      public function get AllLevelVector() : Vector.<TSkillReform>
      {
         return this.FAllLevelVector;
      }
      
      public function get MaxDate() : TSkillReform
      {
         return this.FAllLevelVector[this.FAllLevelVector.length - 1];
      }
      
      public function get MinDate() : TSkillReform
      {
         return this.FAllLevelVector[0];
      }
      
      public function Clear() : void
      {
         this.FAllLevelVector.length = 0;
      }
   }
}

