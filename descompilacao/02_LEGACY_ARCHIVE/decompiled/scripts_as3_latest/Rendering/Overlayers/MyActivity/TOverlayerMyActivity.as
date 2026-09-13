package Rendering.Overlayers.MyActivity
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import flash.text.TextFormat;
   
   public class TOverlayerMyActivity extends TOverlayer
   {
      
      protected static const COLOR_Context_01:uint = 4294958161;
      
      protected static const SIZE_WordWrapWidth:uint = 170;
      
      protected static const SIZE_Context_00:uint = 14;
      
      protected var FPainterCaption:TPainterTextEffect;
      
      protected var FBoundsCaption:TBounds;
      
      protected var FTextFormatCaption:TextFormat;
      
      public function TOverlayerMyActivity(param1:TUIComponent)
      {
         super(param1);
         this.FPainterCaption = ConstructPainterTextEffect(COLOR_Context_01);
         this.FPainterCaption.Font.Size = SIZE_Context_00;
         this.FPainterCaption.WordWrapWidth = SIZE_WordWrapWidth;
         this.FBoundsCaption = new TBounds();
         this.FPainterCaption.Evaluate(this.FBoundsCaption);
         this.FTextFormatCaption = new TextFormat();
         this.FPainterCaption.SetTextFormat(this.FTextFormatCaption);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterCaption.X = FBoundsRendering.X + this.FBoundsCaption.X;
         this.FPainterCaption.Y = FBoundsRendering.Y + this.FBoundsCaption.Y;
      }
      
      override public function set Context(param1:Object) : void
      {
         super.Context = param1;
      }
      
      override protected function ContextModified() : Boolean
      {
         return super.ContextModified();
      }
      
      override protected function ContextSynchronize() : void
      {
         super.ContextSynchronize();
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         BoundsAlignDown(this.FBoundsCaption);
         this.FPainterCaption.Text = Context.toString();
         this.FPainterCaption.Evaluate(this.FBoundsCaption);
         BoundsContextUnion(this.FBoundsCaption);
      }
   }
}

