package Logics.Palace
{
   import Logics.CrossServerWar.TCrossServerReports;
   
   public class TFightReports
   {
      
      protected var FPalaceTop3Reports:TPalaceTop3Reports;
      
      protected var FPalaceCommonReports:TCrossServerReports;
      
      public function TFightReports()
      {
         super();
         this.FPalaceTop3Reports = new TPalaceTop3Reports();
         this.FPalaceCommonReports = new TCrossServerReports();
      }
      
      public function get PalaceTop3Reports() : TPalaceTop3Reports
      {
         return this.FPalaceTop3Reports;
      }
      
      public function set PalaceTop3Reports(param1:TPalaceTop3Reports) : void
      {
         this.FPalaceTop3Reports = param1;
      }
      
      public function get PalaceCommonReports() : TCrossServerReports
      {
         return this.FPalaceCommonReports;
      }
      
      public function set PalaceCommonReports(param1:TCrossServerReports) : void
      {
         this.FPalaceCommonReports = param1;
      }
   }
}

