package _21000000_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol128")]
   public dynamic class Timeline_28 extends MovieClip
   {
      
      public var TF_Caption:TextField;
      
      public function Timeline_28()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
   }
}

