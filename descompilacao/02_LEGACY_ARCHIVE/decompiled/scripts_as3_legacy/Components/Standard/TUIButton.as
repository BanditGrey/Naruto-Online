package Components.Standard
{
   import Foundation.UI.TUIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIButton extends TUIComponent
   {
      
      protected static const RENDERINGSTATE_Normal:uint = 1;
      
      protected static const RENDERINGSTATE_Hovering:uint = 2;
      
      protected static const RENDERINGSTATE_Pressed:uint = 3;
      
      protected static const RENDERINGSTATE_Disabled:uint = 4;
      
      protected var FSubstrate:MovieClip;
      
      protected var FMousePressed:Boolean;
      
      protected var FIsEnabled:Boolean;
      
      protected var FInitialization:Boolean;
      
      protected var FOnClick:Function;
      
      public function TUIButton(param1:TUIComponent)
      {
         super(param1);
         this.FIsEnabled = true;
         this.FInitialization = false;
      }
      
      protected function Initialization() : void
      {
         this.AddButtonEventListener();
         this.FInitialization = true;
      }
      
      protected function AddButtonEventListener() : void
      {
         this.FSubstrate.buttonMode = true;
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_DOWN,this.ButtonOnDown,false,0,true);
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_UP,this.ButtonOnUp,false,0,true);
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonOnOver,false,0,true);
         this.FSubstrate.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonOnOut,false,0,true);
      }
      
      protected function RemoveButtonEventListener() : void
      {
         this.FSubstrate.buttonMode = false;
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_DOWN,this.ButtonOnDown);
         }
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_UP))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_UP,this.ButtonOnUp);
         }
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonOnOver);
         }
         if(this.FSubstrate.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this.FSubstrate.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonOnOut);
         }
      }
      
      protected function ButtonOnDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == RENDERINGSTATE_Disabled)
         {
            return;
         }
         _loc2_.gotoAndStop(RENDERINGSTATE_Pressed);
         this.FMousePressed = true;
      }
      
      protected function ButtonOnUp(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(this.FMousePressed)
         {
            if(this.FOnClick != null)
            {
               this.FOnClick(this);
            }
            if(this.FIsEnabled)
            {
               _loc2_.gotoAndStop(RENDERINGSTATE_Normal);
            }
         }
         this.FMousePressed = false;
      }
      
      protected function ButtonOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == RENDERINGSTATE_Disabled)
         {
            return;
         }
         if(_loc2_.currentFrame != RENDERINGSTATE_Hovering)
         {
            _loc2_.gotoAndStop(RENDERINGSTATE_Hovering);
         }
      }
      
      protected function ButtonOnOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == RENDERINGSTATE_Disabled)
         {
            return;
         }
         if(_loc2_.currentFrame != RENDERINGSTATE_Normal)
         {
            _loc2_.gotoAndStop(RENDERINGSTATE_Normal);
         }
         this.FMousePressed = false;
      }
      
      public function get Substrate() : MovieClip
      {
         return this.FSubstrate;
      }
      
      public function set Substrate(param1:MovieClip) : void
      {
         this.FSubstrate = param1;
      }
      
      public function SetButtonEnabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.AddButtonEventListener();
            this.FSubstrate.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else
         {
            this.RemoveButtonEventListener();
            this.FSubstrate.gotoAndStop(RENDERINGSTATE_Disabled);
         }
         this.FIsEnabled = param1;
      }
      
      public function get OnClick() : Function
      {
         return this.FOnClick;
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
      
      public function get IsEnabled() : Boolean
      {
         return this.FIsEnabled;
      }
      
      public function set IsEnabled(param1:Boolean) : void
      {
         this.FIsEnabled = param1;
      }
      
      public function Init() : void
      {
         if(this.FInitialization)
         {
            return;
         }
         this.Initialization();
      }
   }
}

