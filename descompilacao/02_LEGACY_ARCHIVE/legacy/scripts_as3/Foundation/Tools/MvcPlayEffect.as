package Foundation.Tools
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class MvcPlayEffect
   {
      
      protected var FEffectMvc:MovieClip = null;
      
      protected var FOverFunc:Function = null;
      
      protected var FAllFram:int;
      
      public function MvcPlayEffect(param1:Function, param2:int)
      {
         super();
         this.FOverFunc = param1;
         this.FAllFram = param2;
      }
      
      public function set CurFream(param1:int) : void
      {
         this.FAllFram = param1;
      }
      
      public function SetEffectPanel(param1:MovieClip) : void
      {
         this.FEffectMvc = param1;
      }
      
      public function playEffect() : void
      {
         if(!this.FEffectMvc)
         {
            return;
         }
         if(this.FEffectMvc.hasEventListener(Event.ENTER_FRAME))
         {
            this.FEffectMvc.removeEventListener(Event.ENTER_FRAME,this.EnterFunc);
         }
         this.FEffectMvc.addEventListener(Event.ENTER_FRAME,this.EnterFunc);
         this.FEffectMvc.gotoAndPlay(1);
      }
      
      protected function EnterFunc(param1:Event) : void
      {
         if(this.FEffectMvc.currentFrame >= this.FAllFram)
         {
            this.FEffectMvc.stop();
            if(this.FEffectMvc.hasEventListener(Event.ENTER_FRAME))
            {
               this.FEffectMvc.removeEventListener(Event.ENTER_FRAME,this.EnterFunc);
            }
            if(this.FOverFunc != null)
            {
               this.FOverFunc();
            }
         }
      }
   }
}

