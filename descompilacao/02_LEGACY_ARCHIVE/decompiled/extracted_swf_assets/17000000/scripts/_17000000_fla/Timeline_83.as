package _17000000_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol375")]
   public dynamic class Timeline_83 extends MovieClip
   {
      
      public var mc_head:MovieClip;
      
      public function Timeline_83()
      {
         super();
         addFrameScript(9,this.frame10);
      }
      
      internal function frame10() : *
      {
         stop();
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

