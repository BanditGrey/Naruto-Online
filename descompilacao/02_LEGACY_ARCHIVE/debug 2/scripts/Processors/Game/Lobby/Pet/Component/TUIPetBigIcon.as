package Processors.Game.Lobby.Pet.Component
{
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Textures.TAnimationFrame;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TUIPetBigIcon extends TUIComponent
   {
      
      protected static const FRAME_Index:uint = 1;
      
      protected var FQuerySequence:TQueryAnimationSequence;
      
      protected var FSequenceContext:TAnimationSequence;
      
      protected var FBitmap:Bitmap;
      
      protected var FMC_DefaultIcon:MovieClip;
      
      protected var FContext:Object;
      
      protected var FSubstrate:Sprite;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FFrame:uint;
      
      public function TUIPetBigIcon(param1:TUIComponent)
      {
         super(param1);
         this.FBitmap = new Bitmap();
         addChild(this.FBitmap);
         this.FQuerySequence = new TQueryAnimationSequence();
      }
      
      protected function RenderingPerform() : void
      {
         if(this.Context != null)
         {
            this.RenderingPerform_Context();
         }
         else if(this.FMC_DefaultIcon.visible)
         {
            this.FMC_DefaultIcon.visible = false;
            this.FMC_DefaultIcon.stop();
         }
      }
      
      protected function RenderingPerform_Context() : void
      {
         var _loc1_:TAnimationFrame = null;
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         if(this.FContext == null)
         {
            return;
         }
         if(this.FSequenceContext == null)
         {
            if(this.FOnQuerySequenceContext != null)
            {
               this.FQuerySequence.Value = null;
               this.FOnQuerySequenceContext(this,this.FContext,this.FQuerySequence,this.FFrame);
               this.FSequenceContext = this.FQuerySequence.Value;
               if(this.FMC_DefaultIcon.visible)
               {
                  this.FMC_DefaultIcon.visible = false;
                  this.FMC_DefaultIcon.stop();
               }
            }
         }
         if(this.FSequenceContext == null)
         {
            if(!this.FMC_DefaultIcon.visible)
            {
               this.FMC_DefaultIcon.visible = true;
               this.FMC_DefaultIcon.play();
            }
            if(this.FMC_DefaultIcon.currentFrame == FRAME_Index)
            {
               this.FMC_DefaultIcon.play();
            }
            return;
         }
         _loc1_ = this.FSequenceContext.GetAnimationFrameByTick(STimingCore.TickCount);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = this.FBitmap.bitmapData;
         _loc3_ = _loc1_.Surface;
         if(_loc2_ != _loc3_)
         {
            this.FBitmap.bitmapData = _loc3_;
         }
      }
      
      public function get Frame() : uint
      {
         return this.FFrame;
      }
      
      public function set Frame(param1:uint) : void
      {
         this.FFrame = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = null;
         if(param1 != this.FContext)
         {
            this.FSequenceContext = null;
            this.FBitmap.bitmapData = null;
            this.FContext = param1;
         }
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get MCDefaultIcon() : MovieClip
      {
         return this.FMC_DefaultIcon;
      }
      
      public function set MCDefaultIcon(param1:MovieClip) : void
      {
         this.FMC_DefaultIcon = param1;
         if(this.FMC_DefaultIcon != null)
         {
            this.FMC_DefaultIcon.mouseEnabled = false;
            addChild(this.FMC_DefaultIcon);
            this.FMC_DefaultIcon.visible = false;
         }
      }
      
      public function Update() : void
      {
         this.RenderingPerform();
      }
   }
}

