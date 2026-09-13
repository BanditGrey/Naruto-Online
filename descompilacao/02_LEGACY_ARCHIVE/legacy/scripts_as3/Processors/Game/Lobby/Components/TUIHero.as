package Processors.Game.Lobby.Components
{
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Textures.TAnimationFrame;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_CURSOR;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class TUIHero extends TUIComponent
   {
      
      public static const STATUS_Stand:int = CONST_CHARACTER.STATUS_Stand;
      
      protected var FTickReference:int;
      
      protected var FDefaultAction:uint;
      
      protected var FSequenceContext:TAnimationSequence;
      
      protected var FBitmap:Bitmap;
      
      protected var FCursorHovering:Boolean;
      
      protected var FTexture:TTexture;
      
      protected var FIndentifier:uint;
      
      protected var FContext:Object;
      
      protected var FDefaultRole:Sprite;
      
      protected var FQuerySequence:TQueryAnimationSequence;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FCurrentFrame:TAnimationFrame;
      
      public function TUIHero(param1:TUIComponent)
      {
         super(param1);
         this.FBitmap = new Bitmap();
         addChild(this.FBitmap);
         this.FQuerySequence = new TQueryAnimationSequence();
         this.FDefaultAction = STATUS_Stand;
         this.FCursorHovering = false;
      }
      
      protected function RenderingPerform() : void
      {
         if(this.Context != null)
         {
            this.RenderingPerform_Context();
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
               this.FOnQuerySequenceContext(this,this.FContext,this.FQuerySequence);
               this.FSequenceContext = this.FQuerySequence.Value;
               if(this.FDefaultRole.visible)
               {
                  this.FDefaultRole.visible = false;
               }
            }
         }
         if(this.FSequenceContext == null)
         {
            if(!this.FDefaultRole.visible)
            {
               this.FDefaultRole.visible = true;
            }
            return;
         }
         this.FCurrentFrame = this.FSequenceContext.GetAnimationFrameByTick(STimingCore.TickCount);
         if(this.FCurrentFrame == null)
         {
            return;
         }
         _loc2_ = this.FBitmap.bitmapData;
         _loc3_ = this.FCurrentFrame.Surface;
         if(_loc2_ != _loc3_)
         {
            this.FBitmap.bitmapData = _loc3_;
         }
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
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
      
      public function get DefaultRole() : Sprite
      {
         return this.FDefaultRole;
      }
      
      public function set DefaultRole(param1:Sprite) : void
      {
         this.FDefaultRole = param1;
         addChild(this.FDefaultRole);
         this.FDefaultRole.visible = false;
      }
      
      override public function get Cursor() : uint
      {
         if(this.FCursorHovering)
         {
            return CONST_CURSOR.CURSORID_Enemy;
         }
         return CONST_CURSOR.CURSORID_Default;
      }
      
      public function get CursorHovering() : Boolean
      {
         return this.FCursorHovering;
      }
      
      public function set CursorHovering(param1:Boolean) : void
      {
         this.FCursorHovering = param1;
      }
      
      override public function get CursorDisplayObject() : TUIComponent
      {
         return this.Parent.Parent.Parent;
      }
      
      public function Update() : void
      {
         this.RenderingPerform();
      }
   }
}

