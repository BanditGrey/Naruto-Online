package Logics.Exercise.BrazilCarnival
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TBrazilCarnivalSign extends TBaseActivity
   {
      
      protected var FDayList:Vector.<TBaseBox>;
      
      protected var FCurDay:int;
      
      protected var FCurStatus:int;
      
      public function TBrazilCarnivalSign()
      {
         super();
         this.FDayList = new Vector.<TBaseBox>();
      }
      
      public function get DayList() : Vector.<TBaseBox>
      {
         return this.FDayList;
      }
      
      public function set DayList(param1:Vector.<TBaseBox>) : void
      {
         this.FDayList = param1;
      }
      
      public function get CurDay() : int
      {
         return this.FCurDay;
      }
      
      public function set CurDay(param1:int) : void
      {
         this.FCurDay = param1;
      }
      
      public function get CurStatus() : int
      {
         return this.FCurStatus;
      }
      
      public function set CurStatus(param1:int) : void
      {
         this.FCurStatus = param1;
      }
   }
}

