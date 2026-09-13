package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8")]
   public dynamic class pop_talk extends MovieClip
   {
      
      public var mc_desc:MovieClip;
      
      public var mc_bg:MovieClip;
      
      public function pop_talk()
      {
         super();
         addFrameScript(8,this.frame9);
      }
      
      internal function frame9() : *
      {
         stop();
      }
   }
}

