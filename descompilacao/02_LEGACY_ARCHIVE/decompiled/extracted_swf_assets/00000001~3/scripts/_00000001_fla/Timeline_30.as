package _00000001_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol10")]
   public dynamic class Timeline_30 extends MovieClip
   {
      
      public function Timeline_30()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

