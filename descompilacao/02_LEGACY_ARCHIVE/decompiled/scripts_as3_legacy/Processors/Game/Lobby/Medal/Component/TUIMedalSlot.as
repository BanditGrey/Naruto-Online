package Processors.Game.Lobby.Medal.Component
{
   import Foundation.Utilities.TGameUtil;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIMedalSlot
   {
      
      protected var FMovieClip:MovieClip;
      
      protected var FPicBmp:Bitmap;
      
      protected var FContext:Object;
      
      protected var FOnClick:Function;
      
      public function TUIMedalSlot(param1:MovieClip)
      {
         super();
         this.FMovieClip = param1;
         this.InitBitmap();
      }
      
      protected function InitBitmap() : void
      {
         this.FPicBmp = new Bitmap();
         this.FMovieClip.addChild(this.FPicBmp);
         this.FMovieClip.addEventListener(MouseEvent.CLICK,this.MouseClick);
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         if(this.FContext != param1)
         {
            this.FContext = param1;
         }
      }
      
      public function Update() : void
      {
         if(this.FContext == null)
         {
            this.FPicBmp.bitmapData = null;
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Rune,this.FPicBmp,CONST_MODULES.MODULE_Medal,this.FContext.IDTexture);
      }
      
      protected function MouseClick(param1:MouseEvent) : void
      {
         if(this.FOnClick != null)
         {
            this.FOnClick(this,this.FContext);
         }
      }
      
      public function set OnClick(param1:Function) : void
      {
         this.FOnClick = param1;
      }
   }
}

