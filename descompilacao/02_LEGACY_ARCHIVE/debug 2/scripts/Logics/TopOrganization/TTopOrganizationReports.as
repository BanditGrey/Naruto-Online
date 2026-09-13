package Logics.TopOrganization
{
   public class TTopOrganizationReports
   {
      
      protected var FTopOrganizationReports:Vector.<TTopOrganizationReport>;
      
      public function TTopOrganizationReports()
      {
         super();
         this.FTopOrganizationReports = new Vector.<TTopOrganizationReport>();
      }
      
      public function get Count() : uint
      {
         return this.FTopOrganizationReports.length;
      }
      
      public function Add(param1:TTopOrganizationReport) : void
      {
         this.FTopOrganizationReports.push(param1);
      }
      
      public function GetTopOrganizationReportByIndex(param1:int) : TTopOrganizationReport
      {
         if(param1 < 0 || param1 >= this.FTopOrganizationReports.length)
         {
            return null;
         }
         return this.FTopOrganizationReports[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(this.FTopOrganizationReports.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FTopOrganizationReports.pop();
            _loc2_++;
         }
         this.FTopOrganizationReports.length = 0;
      }
   }
}

