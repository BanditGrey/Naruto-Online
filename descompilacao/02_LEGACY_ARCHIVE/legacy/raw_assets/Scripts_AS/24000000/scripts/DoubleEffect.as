package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol190")]
   public dynamic class DoubleEffect extends MovieClip
   {
      
      public function DoubleEffect()
      {
         super();
         addFrameScript(35,this.frame36);
      }
      
      internal function frame36() : *
      {
         stop();
      }
   }
}

