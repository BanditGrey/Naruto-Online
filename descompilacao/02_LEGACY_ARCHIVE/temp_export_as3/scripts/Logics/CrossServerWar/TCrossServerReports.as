package Logics.CrossServerWar
{
   public class TCrossServerReports
   {
      
      protected var FCrossServerReports:Vector.<TCrossServerReport>;
      
      public function TCrossServerReports()
      {
         super();
         this.FCrossServerReports = new Vector.<TCrossServerReport>();
      }
      
      protected function SortField(param1:TCrossServerReport, param2:TCrossServerReport) : int
      {
         if(param1.Time > param2.Time)
         {
            return 1;
         }
         if(param1.Time < param2.Time)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FCrossServerReports.length;
      }
      
      public function GetCrossServerReportByIndex(param1:int) : TCrossServerReport
      {
         if(param1 >= this.FCrossServerReports.length)
         {
            return null;
         }
         return this.FCrossServerReports[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TCrossServerReport = null;
         _loc1_ = int(this.FCrossServerReports.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FCrossServerReports[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FCrossServerReports.length = 0;
      }
      
      public function Add(param1:TCrossServerReport) : void
      {
         this.FCrossServerReports.push(param1);
         param1.StubReferences.Reference(this);
      }
      
      public function Delete(param1:TCrossServerReport) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TCrossServerReport = null;
         _loc3_ = this.FCrossServerReports.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FCrossServerReports[_loc2_];
            if(_loc4_ == param1)
            {
               param1.StubReferences.Dereference(this);
               this.FCrossServerReports.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function DeleteFirst() : void
      {
         var _loc1_:TCrossServerReport = null;
         _loc1_ = this.FCrossServerReports.shift();
         _loc1_.StubReferences.Dereference(this);
      }
      
      public function SortByTime() : void
      {
         this.FCrossServerReports.sort(this.SortField);
      }
   }
}

