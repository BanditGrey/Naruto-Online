package Logics.Mentorship.Elements
{
   public class TInteractionLogInfo
   {
      
      protected var FPostID:uint;
      
      protected var FInteractionText:String;
      
      protected var FTextColor:uint;
      
      protected var FTextSize:uint;
      
      protected var FObj:Object;
      
      protected var FFightReportID0:uint;
      
      protected var FFightReportID1:uint;
      
      protected var FTime:uint;
      
      public function TInteractionLogInfo()
      {
         super();
      }
      
      public function get PostID() : uint
      {
         return this.FPostID;
      }
      
      public function set PostID(param1:uint) : void
      {
         this.FPostID = param1;
      }
      
      public function get Obj() : Object
      {
         return this.FObj;
      }
      
      public function set Obj(param1:Object) : void
      {
         this.FObj = param1;
      }
      
      public function get Time() : uint
      {
         return this.FTime;
      }
      
      public function set Time(param1:uint) : void
      {
         this.FTime = param1;
      }
      
      public function get FightReportID0() : uint
      {
         return this.FFightReportID0;
      }
      
      public function set FightReportID0(param1:uint) : void
      {
         this.FFightReportID0 = param1;
      }
      
      public function get FightReportID1() : uint
      {
         return this.FFightReportID1;
      }
      
      public function set FightReportID1(param1:uint) : void
      {
         this.FFightReportID1 = param1;
      }
      
      public function get InteractionText() : String
      {
         return this.FInteractionText;
      }
      
      public function set InteractionText(param1:String) : void
      {
         this.FInteractionText = param1;
      }
      
      public function get TextColor() : uint
      {
         return this.FTextColor;
      }
      
      public function set TextColor(param1:uint) : void
      {
         this.FTextColor = param1;
      }
      
      public function get TextSize() : uint
      {
         return this.FTextSize;
      }
      
      public function set TextSize(param1:uint) : void
      {
         this.FTextSize = param1;
      }
   }
}

