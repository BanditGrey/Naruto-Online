package Logics.Tavern
{
   public class TReportList
   {
      
      protected var FTime:uint;
      
      protected var FMoraType:uint;
      
      protected var FSoulType:uint;
      
      protected var FSoulCount:uint;
      
      public function TReportList()
      {
         super();
      }
      
      public function get Time() : uint
      {
         return this.FTime;
      }
      
      public function set Time(param1:uint) : void
      {
         this.FTime = param1;
      }
      
      public function get MoraType() : uint
      {
         return this.FMoraType;
      }
      
      public function set MoraType(param1:uint) : void
      {
         this.FMoraType = param1;
      }
      
      public function get SoulType() : uint
      {
         return this.FSoulType;
      }
      
      public function set SoulType(param1:uint) : void
      {
         this.FSoulType = param1;
      }
      
      public function get SoulCount() : uint
      {
         return this.FSoulCount;
      }
      
      public function set SoulCount(param1:uint) : void
      {
         this.FSoulCount = param1;
      }
   }
}

