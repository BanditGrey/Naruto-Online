package Rendering.Overlayers.Taboo
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   
   public class TOverTabooStringTip extends TOverlayer
   {
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected var Cur_Str:String = "";
      
      protected var FPainterDec:TPainterTextEffect;
      
      protected var FBoundsDec:TBounds;
      
      public function TOverTabooStringTip(param1:TUIComponent)
      {
         super(param1);
         this.FPainterDec = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBoundsDec = new TBounds();
         FMarginLeft = 10;
         FMarginTop = 10;
         FMarginRight = 10;
         FMarginBottom = 10;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.Cur_Str = FContext as String;
         this.EvaluationPerform_Dec();
      }
      
      protected function EvaluationPerform_Dec() : void
      {
         BoundsAlignDown(this.FBoundsDec);
         this.FPainterDec.Text = this.Cur_Str;
         this.FPainterDec.Evaluate(this.FBoundsDec);
         BoundsContextUnion(this.FBoundsDec);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterDec.X = FBoundsRendering.X + this.FBoundsDec.X;
         this.FPainterDec.Y = FBoundsRendering.Y + this.FBoundsDec.Y;
      }
      
      override public function Show() : void
      {
         this.visible = true;
      }
      
      override public function Hide() : void
      {
         this.visible = false;
      }
   }
}

