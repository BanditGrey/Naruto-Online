package Foundation.Utilities
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUtilityStandardBTN
   {
      
      public static const FRAME_ENABLE:String = "Enable";
      
      public static const FRAME_OVER:String = "Over";
      
      public static const FRAME_CLICK:String = "Click";
      
      public static const FRAME_DISABLE:String = "Disable";
      
      public function TUtilityStandardBTN()
      {
         super();
         throw new Error("TUtilityStandardBTN Class Is Static Class Only");
      }
      
      protected static function OnMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(param1.currentTarget);
         if(_loc2_.currentFrame != 4)
         {
            _loc2_.gotoAndStop(3);
         }
      }
      
      protected static function OnMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(param1.currentTarget);
         if(_loc2_.currentFrame != 4)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      protected static function OnMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(param1.currentTarget);
         if(_loc2_.currentFrame != 4)
         {
            _loc2_.gotoAndStop(2);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
         }
      }
      
      protected static function OnMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
         if(_loc2_.currentFrame != 4)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      public static function SetBtnEventListener(param1:MovieClip, param2:Function = null) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
         param1.addEventListener(MouseEvent.CLICK,param2);
         param1.addEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
         param1.addEventListener(MouseEvent.MOUSE_OVER,OnMouseOver);
      }
   }
}

