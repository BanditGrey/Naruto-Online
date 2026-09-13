package Logics.Kingwar
{
   public class TPVPKingReports
   {
      
      protected var FPVPKingReports:Vector.<TPVPKingReport>;
      
      public function TPVPKingReports()
      {
         super();
         this.FPVPKingReports = new Vector.<TPVPKingReport>();
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingReport = null;
         _loc1_ = int(this.FPVPKingReports.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FPVPKingReports[_loc2_];
            _loc2_++;
         }
         this.FPVPKingReports.length = 0;
      }
      
      public function Add(param1:TPVPKingReport) : void
      {
         this.FPVPKingReports.push(param1);
      }
      
      public function get Count() : int
      {
         return this.FPVPKingReports.length;
      }
      
      public function GetPVPKingReportByIndex(param1:int) : TPVPKingReport
      {
         if(param1 >= this.FPVPKingReports.length)
         {
            return null;
         }
         return this.FPVPKingReports[param1];
      }
      
      public function GetPVPKingReportsByFightType(param1:int) : Vector.<TPVPKingReport>
      {
         var _loc2_:TPVPKingReport = null;
         var _loc3_:Vector.<TPVPKingReport> = new Vector.<TPVPKingReport>();
         if(this.FPVPKingReports)
         {
            for each(_loc2_ in this.FPVPKingReports)
            {
               if(param1 == 0 && (_loc2_.FightType == 1 || _loc2_.FightType == 2))
               {
                  _loc3_.push(_loc2_);
               }
               else if(_loc2_.FightType == param1)
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         return _loc3_;
      }
   }
}

