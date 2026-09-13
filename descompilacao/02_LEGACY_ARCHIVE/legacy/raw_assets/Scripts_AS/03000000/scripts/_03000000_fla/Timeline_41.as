package _03000000_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol42")]
   public dynamic class Timeline_41 extends MovieClip
   {
      
      public var TF_Caption:TextField;
      
      public function Timeline_41()
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

