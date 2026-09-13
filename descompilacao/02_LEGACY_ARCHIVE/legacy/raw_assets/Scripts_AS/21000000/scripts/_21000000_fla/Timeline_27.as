package _21000000_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol123")]
   public dynamic class Timeline_27 extends MovieClip
   {
      
      public var TF_Caption:TextField;
      
      public function Timeline_27()
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

