package Components.Controls.Skin
{
   import Components.Controls.Managers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   
   public class MotionSkinControl
   {
      
      public static var over:Array = [4,8,12,16,20];
      
      public static var out:Array = [2,4,6,8,10,12,14,16,18,20];
      
      public var resetAlpha:Boolean = true;
      
      public var filtersDown:Array;
      
      private var eventDis:InteractiveObject;
      
      private var view:DisplayObject;
      
      private var index:int;
      
      private var isOutViewHide:Boolean = false;
      
      public function MotionSkinControl(param1:InteractiveObject, param2:DisplayObject)
      {
         super();
         this.eventDis = param1;
         this.view = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.startShowOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.startShowOut);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.startShowDown);
         param1.addEventListener(MouseEvent.MOUSE_UP,this.startShowUp);
         var _loc3_:DropShadowFilter = new DropShadowFilter(0,90,0,0.2,4,4,1,1,true);
         this.filtersDown = DefaultStyle.filters.slice(0);
         this.filtersDown.push(_loc3_);
      }
      
      public function setOutViewHide(param1:Boolean) : void
      {
         this.isOutViewHide = param1;
      }
      
      private function startShowOver(param1:MouseEvent) : void
      {
         this.index = 0;
         this.eventDis.removeEventListener(Event.ENTER_FRAME,this.outMotion);
         this.eventDis.addEventListener(Event.ENTER_FRAME,this.overMotion);
      }
      
      private function startShowOut(param1:MouseEvent) : void
      {
         this.index = out.length - 1;
         this.view.filters = DefaultStyle.filters;
         this.eventDis.removeEventListener(Event.ENTER_FRAME,this.overMotion);
         this.eventDis.addEventListener(Event.ENTER_FRAME,this.outMotion);
      }
      
      private function startShowUp(param1:MouseEvent) : void
      {
         this.view.filters = DefaultStyle.filters;
         this.index = over.length - 1;
         this.view.transform.colorTransform = new ColorTransform(1,1,1,this.view.alpha,over[this.index] * 1.5,over[this.index] * 1.5,over[this.index] * 1.5,0);
      }
      
      private function startShowDown(param1:MouseEvent) : void
      {
         this.eventDis.removeEventListener(Event.ENTER_FRAME,this.outMotion);
         this.eventDis.removeEventListener(Event.ENTER_FRAME,this.overMotion);
         this.view.transform.colorTransform = new ColorTransform(1,1,1,this.view.alpha);
         this.view.filters = this.filtersDown;
      }
      
      private function overMotion(param1:Event) : void
      {
         if(this.index > over.length - 1)
         {
            this.eventDis.removeEventListener(Event.ENTER_FRAME,this.overMotion);
         }
         else
         {
            this.view.transform.colorTransform = new ColorTransform(1,1,1,this.view.alpha,over[this.index] * 1.5,over[this.index] * 1.5,over[this.index] * 1.5,0);
            if(this.isOutViewHide == true)
            {
               this.view.alpha = (this.index + 1) / over.length;
            }
            else if(this.resetAlpha == true)
            {
               this.view.alpha = 1;
            }
         }
         ++this.index;
      }
      
      private function outMotion(param1:Event) : void
      {
         if(this.index < 0)
         {
            this.eventDis.removeEventListener(Event.ENTER_FRAME,this.outMotion);
         }
         else
         {
            this.view.transform.colorTransform = new ColorTransform(1,1,1,this.view.alpha,out[this.index] * 1.5,out[this.index] * 1.5,out[this.index] * 1.5,0);
            if(this.isOutViewHide == true)
            {
               this.view.alpha = this.index / out.length;
            }
            else if(this.resetAlpha == true)
            {
               this.view.alpha = 1;
            }
         }
         --this.index;
      }
   }
}

