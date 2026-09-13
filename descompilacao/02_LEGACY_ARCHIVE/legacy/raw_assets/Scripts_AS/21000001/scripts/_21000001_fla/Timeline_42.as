package _21000001_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol300")]
   public dynamic class Timeline_42 extends MovieClip
   {
      
      public var MC_OpeningState:MovieClip;
      
      public var Btn_OpenInfomation:MovieClip;
      
      public function Timeline_42()
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

