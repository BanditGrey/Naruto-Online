package Logics.Palace
{
   import Resources.Constants.CONST_PALACE;
   
   public class TPalaceTop3Reports
   {
      
      protected var FPalaceTop3Reports:Vector.<TPalaceTop3Report>;
      
      public function TPalaceTop3Reports()
      {
         super();
         this.FPalaceTop3Reports = new Vector.<TPalaceTop3Report>(CONST_PALACE.CAPACITY_Top3Reports);
      }
      
      protected function SortField(param1:TPalaceTop3Report, param2:TPalaceTop3Report) : int
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
         return this.FPalaceTop3Reports.length;
      }
      
      public function GetPalaceTop3ReportByIndex(param1:int) : TPalaceTop3Report
      {
         return this.FPalaceTop3Reports[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPalaceTop3Report = null;
         _loc1_ = int(this.FPalaceTop3Reports.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FPalaceTop3Reports[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_.StubReferences.Dereference(this);
            }
            _loc2_++;
         }
         this.FPalaceTop3Reports.length = 0;
      }
      
      public function Add(param1:TPalaceTop3Report) : void
      {
         this.FPalaceTop3Reports.push(param1);
         param1.StubReferences.Reference(this);
      }
      
      public function Delete(param1:TPalaceTop3Report) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TPalaceTop3Report = null;
         _loc3_ = this.FPalaceTop3Reports.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FPalaceTop3Reports[_loc2_];
            if(_loc4_ == param1)
            {
               param1.StubReferences.Dereference(this);
               this.FPalaceTop3Reports.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function DeleteFirst() : void
      {
         var _loc1_:TPalaceTop3Report = null;
         _loc1_ = this.FPalaceTop3Reports.shift();
         _loc1_.StubReferences.Dereference(this);
      }
      
      public function SortByTime() : void
      {
         this.FPalaceTop3Reports.sort(this.SortField);
      }
   }
}

