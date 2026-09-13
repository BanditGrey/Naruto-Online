package Logics.CrossServerWar
{
   public class TToastRecords
   {
      
      protected var FToastRecords:Vector.<TToastRecord>;
      
      public function TToastRecords()
      {
         super();
         this.FToastRecords = new Vector.<TToastRecord>();
      }
      
      public function get Count() : int
      {
         return this.FToastRecords.length;
      }
      
      public function GetToastRecordByIndex(param1:int) : TToastRecord
      {
         return this.FToastRecords[param1];
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TToastRecord = null;
         _loc1_ = int(this.FToastRecords.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FToastRecords[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FToastRecords.length = 0;
      }
      
      public function Add(param1:TToastRecord) : void
      {
         this.FToastRecords.push(param1);
         param1.StubReferences.Reference(this);
      }
      
      public function Delete(param1:TToastRecord) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TToastRecord = null;
         _loc3_ = this.FToastRecords.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FToastRecords[_loc2_];
            if(_loc4_ == param1)
            {
               param1.StubReferences.Dereference(this);
               this.FToastRecords.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
   }
}

