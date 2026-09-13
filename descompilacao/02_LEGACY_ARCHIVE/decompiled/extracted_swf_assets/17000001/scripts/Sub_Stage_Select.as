package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol85")]
   public dynamic class Sub_Stage_Select extends MovieClip
   {
      
      public var mc_ui:MovieClip;
      
      public function Sub_Stage_Select()
      {
         super();
         addFrameScript(18,this.frame19,39,this.frame40);
      }
      
      internal function frame19() : *
      {
         stop();
      }
      
      internal function frame40() : *
      {
         stop();
         this.visible = false;
      }
   }
}

