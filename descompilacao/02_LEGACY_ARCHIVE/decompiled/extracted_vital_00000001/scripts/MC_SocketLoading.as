package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol15")]
   public dynamic class MC_SocketLoading extends MovieClip
   {
      
      public var TF_Lable:TextField;
      
      public var MC_Effect:MovieClip;
      
      public var MC_NarutoAnim:MovieClip;
      
      public function MC_SocketLoading()
      {
         super();
         this.visible = false;
         this.alpha = 0;
         this.x = -9999;
         this.y = -9999;
         this.addEventListener(Event.ENTER_FRAME, this.onAutoDismiss);
      }
      
      private function onAutoDismiss(param1:Event) : void
      {
         this.visible = false;
         this.alpha = 0;
         this.x = -9999;
         this.y = -9999;
         if(this.parent != null)
         {
            this.parent.visible = false;
            this.parent.alpha = 0;
         }
      }
   }
}

