package Foundation.System
{
   import Foundation.Timing.STimingCore;
   import flash.net.LocalConnection;
   
   public class TGarbageCollector
   {
      
      public static const TIME_UPDATE_INTERVAL:int = 2000;
      
      protected var FInterval:int;
      
      protected var FCurrentTick:int;
      
      protected var FPreviousTick:int;
      
      protected var FNextTick:int;
      
      public function TGarbageCollector()
      {
         super();
         this.FInterval = 30002;
         this.FCurrentTick = STimingCore.TickCount;
         this.FNextTick = this.FCurrentTick + this.FInterval;
      }
      
      protected function PerformGC() : void
      {
         try
         {
            new LocalConnection().connect("GC");
            new LocalConnection().connect("GC");
         }
         catch(E:Error)
         {
         }
      }
      
      public function get Interval() : int
      {
         return this.FInterval;
      }
      
      public function set Interval(param1:int) : void
      {
         if(param1 < 0)
         {
            this.FInterval = 0;
         }
         else
         {
            this.FInterval = param1;
         }
      }
      
      public function Process(param1:Boolean = false) : void
      {
         this.FCurrentTick = STimingCore.TickCount;
         if(param1 || this.FCurrentTick >= this.FNextTick)
         {
            if(this.FCurrentTick - this.FPreviousTick < TIME_UPDATE_INTERVAL)
            {
               return;
            }
            this.PerformGC();
            this.FNextTick += this.FInterval;
            if(this.FNextTick <= this.FCurrentTick)
            {
               this.FNextTick = this.FCurrentTick + this.FInterval;
            }
            this.FPreviousTick = this.FCurrentTick;
         }
      }
   }
}

