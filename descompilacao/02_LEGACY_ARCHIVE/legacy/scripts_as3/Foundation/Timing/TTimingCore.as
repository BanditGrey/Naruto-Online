package Foundation.Timing
{
   import Foundation.Timing.Spaces.UITiming;
   import flash.utils.getTimer;
   
   use namespace UITiming;
   
   public class TTimingCore
   {
      
      protected var FTickCount:int;
      
      protected var FTimezoneOffset:int;
      
      protected var FServerTime:uint;
      
      protected var FServerStartTime:uint;
      
      protected var FServerTimeTick:int;
      
      protected var FClientTimezoneOffset:int;
      
      public function TTimingCore()
      {
         var _loc1_:Date = null;
         super();
         _loc1_ = new Date();
         this.FClientTimezoneOffset = _loc1_.timezoneOffset * 60;
      }
      
      UITiming function SetServerTime(param1:uint) : void
      {
         this.FServerTime = param1;
         this.FServerTimeTick = this.FTickCount;
      }
      
      UITiming function SetServerStartTime(param1:uint) : void
      {
         this.FServerStartTime = param1;
      }
      
      UITiming function SetServerTimezoneOffset(param1:int) : void
      {
         this.FTimezoneOffset = param1;
      }
      
      public function get TickCount() : int
      {
         return this.FTickCount;
      }
      
      public function get ServerStartTime() : uint
      {
         return this.FServerStartTime - this.FTimezoneOffset + this.FClientTimezoneOffset;
      }
      
      public function get ServerTime() : uint
      {
         return this.GetServerTick() - this.FTimezoneOffset + this.FClientTimezoneOffset;
      }
      
      public function Update() : void
      {
         this.FTickCount = getTimer();
      }
      
      public function GetServerTime() : uint
      {
         return this.FServerTime + (this.FTickCount - this.FServerTimeTick) / 1000 - this.FTimezoneOffset + this.FClientTimezoneOffset;
      }
      
      public function GetServerTick() : uint
      {
         return this.FServerTime + (this.FTickCount - this.FServerTimeTick) / 1000;
      }
      
      public function GetClientShowTime(param1:uint) : uint
      {
         return param1 - this.FTimezoneOffset + this.FClientTimezoneOffset;
      }
      
      public function GetServerStartTime() : uint
      {
         return this.FServerStartTime;
      }
      
      public function get TimezoneOffset() : int
      {
         return this.FTimezoneOffset;
      }
      
      public function get ClientTimezoneOffset() : int
      {
         return this.FClientTimezoneOffset;
      }
   }
}

