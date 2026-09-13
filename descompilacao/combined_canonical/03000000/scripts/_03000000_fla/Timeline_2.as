package _03000000_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol250")]
   public dynamic class Timeline_2 extends MovieClip
   {
      
      public var TF_ItemQuantity:TextField;
      
      public var TF_ItemCaption:TextField;
      
      public function Timeline_2()
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

