package Logics.ZhenAoYi
{
   public class TLevelCell
   {
      
      public static const SEVN:int = 7;
      
      protected var FLevelCellLittle:Vector.<TLevelCellLittle>;
      
      public function TLevelCell()
      {
         super();
         this.FLevelCellLittle = new Vector.<TLevelCellLittle>(SEVN);
      }
      
      public function GetCellLittleByType(param1:int) : TLevelCellLittle
      {
         if(!this.FLevelCellLittle[param1])
         {
            this.FLevelCellLittle[param1] = new TLevelCellLittle();
         }
         return this.FLevelCellLittle[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < SEVN)
         {
            if(this.FLevelCellLittle[_loc1_])
            {
               this.FLevelCellLittle[_loc1_].Clear();
            }
            _loc1_++;
         }
      }
      
      public function get OrgReplaceSkillID() : int
      {
         return this.FLevelCellLittle[0].MinDate.ReplaceSkillID;
      }
   }
}

