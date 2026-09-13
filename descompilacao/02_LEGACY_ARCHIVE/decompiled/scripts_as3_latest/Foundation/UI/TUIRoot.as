package Foundation.UI
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.Textures.TAnimationFrame;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.Spaces.UISpace;
   import Resources.Constants.CONST_CURSOR;
   import Resources.Constants.CONST_LOBBY;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Stage;
   
   use namespace UISpace;
   
   public class TUIRoot extends TUIComponent
   {
      
      public static const TEXTURESID_CURSOR:uint = CONST_LOBBY.RESOURCESID_Textures_CURSOR;
      
      protected var FBitmapCursor:Bitmap;
      
      protected var FBitmapData:BitmapData;
      
      protected var FQuerySequence:TQueryAnimationSequence;
      
      protected var FOnQuerySequenceCursor:Function;
      
      public function TUIRoot(param1:TUICore)
      {
         var _loc2_:Stage = null;
         super(null);
         FUICore = param1;
         this.FBitmapCursor = new Bitmap();
         this.FQuerySequence = new TQueryAnimationSequence();
         _loc2_ = FUICore.UIStage;
         _loc2_.addChild(this);
      }
      
      UISpace function RenderingProcess() : void
      {
         this.RenderCursor();
      }
      
      protected function RenderCursor() : void
      {
         var _loc1_:TUIComponent = null;
         var _loc2_:uint = 0;
         var _loc3_:TBounds = null;
         var _loc4_:TCoordinate = null;
         var _loc5_:TResourceRepositoryTexture = null;
         var _loc6_:TAnimationSequence = null;
         var _loc7_:TAnimationFrame = null;
         _loc1_ = FUICore.MouseCapturingComponent;
         if(_loc1_ == null)
         {
            _loc2_ = CONST_CURSOR.CURSORID_Default;
            this.FBitmapCursor.bitmapData = null;
            if(this.FBitmapCursor.parent != null)
            {
               this.FBitmapCursor.parent.removeChild(this.FBitmapCursor);
            }
            return;
         }
         _loc2_ = _loc1_.Cursor;
         this.FQuerySequence.Value = null;
         if(this.FOnQuerySequenceCursor != null)
         {
            this.FOnQuerySequenceCursor(this,TEXTURESID_CURSOR,_loc2_,this.FQuerySequence);
         }
         _loc6_ = this.FQuerySequence.Value;
         if(_loc6_ != null)
         {
            _loc3_ = new TBounds();
            _loc4_ = new TCoordinate();
            _loc6_.Evaluate(_loc4_,_loc3_);
            _loc7_ = _loc6_.GetAnimationFrameByTick(STimingCore.TickCount);
            if(this.FBitmapData != _loc7_.Surface)
            {
               this.FBitmapData = _loc7_.Surface;
               this.FBitmapCursor.bitmapData = this.FBitmapData;
            }
            if(this.FBitmapCursor.parent == null)
            {
               _loc1_.CursorDisplayObject.addChild(this.FBitmapCursor);
            }
            this.FBitmapCursor.x = FUICore.MouseCoordinate.X + _loc3_.X;
            this.FBitmapCursor.y = FUICore.MouseCoordinate.Y + _loc3_.Y;
         }
      }
      
      public function get OnQuerySequenceCursor() : Function
      {
         return this.FOnQuerySequenceCursor;
      }
      
      public function set OnQuerySequenceCursor(param1:Function) : void
      {
         this.FOnQuerySequenceCursor = param1;
      }
      
      public function Render() : void
      {
         this.RenderingProcess();
      }
   }
}

