package Processors.Game.Lobby.TheWorldTree.BigPanel
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class TiaoFreamSetValue
   {
      
      protected var FEffectMvc:MovieClip = null;
      
      protected var FAllFram:int;
      
      protected var FCurValue:int;
      
      protected var FBackFun:Function;
      
      public function TiaoFreamSetValue(param1:int)
      {
         super();
         this.FAllFram = param1;
      }
      
      public function SetEffectPanel(param1:MovieClip, param2:int) : void
      {
         this.FEffectMvc = param1;
         this.FCurValue = param2;
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
      
      public function EnterFunc(param1:Event) : void
      {
         var _loc2_:TextField = null;
         if(this.FEffectMvc.currentFrame == 1 || this.FEffectMvc.currentFrame == 2 || this.FEffectMvc.currentFrame == 10 || this.FEffectMvc.currentFrame == 12)
         {
            this.FEffectMvc.gotoAndStop(this.FEffectMvc.currentFrame);
            _loc2_ = this.FEffectMvc["TF_MainName"];
            if(_loc2_)
            {
               _loc2_.text = this.FCurValue.toString();
            }
            this.FEffectMvc.gotoAndPlay(this.FEffectMvc.currentFrame);
         }
         if(this.FEffectMvc.currentFrame >= this.FAllFram)
         {
            if(this.FEffectMvc.hasEventListener(Event.ENTER_FRAME))
            {
               this.FEffectMvc.removeEventListener(Event.ENTER_FRAME,this.EnterFunc);
            }
            this.FEffectMvc.gotoAndStop(this.FAllFram);
            _loc2_ = this.FEffectMvc["TF_MainName"];
            if(_loc2_)
            {
               _loc2_.text = this.FCurValue.toString();
            }
            if(this.FBackFun != null)
            {
               this.FBackFun();
            }
         }
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
   }
}

