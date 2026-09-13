package Logics.TopOrganization
{
   public class TGVG2BattleReports
   {
      
      protected var FGVG2BattleReports:Vector.<TGVG2BattleReport>;
      
      public function TGVG2BattleReports()
      {
         super();
         this.FGVG2BattleReports = new Vector.<TGVG2BattleReport>();
      }
      
      public function get Count() : uint
      {
         return this.FGVG2BattleReports.length;
      }
      
      public function Add(param1:TGVG2BattleReport) : void
      {
         this.FGVG2BattleReports.push(param1);
      }
      
      public function GetGVG2BattleReportByIndex(param1:int) : TGVG2BattleReport
      {
         if(param1 < 0 || param1 >= this.FGVG2BattleReports.length)
         {
            return null;
         }
         return this.FGVG2BattleReports[param1];
      }
      
      public function ShiftBattleReport() : TGVG2BattleReport
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGVG2BattleReport = null;
         return this.FGVG2BattleReports.shift();
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FGVG2BattleReports.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FGVG2BattleReports.pop();
            _loc2_++;
         }
         this.FGVG2BattleReports.length = 0;
      }
   }
}

