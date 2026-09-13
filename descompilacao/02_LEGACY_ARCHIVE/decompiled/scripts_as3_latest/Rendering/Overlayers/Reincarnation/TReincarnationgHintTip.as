package Rendering.Overlayers.Reincarnation
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   
   public class TReincarnationgHintTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var HintDecP:TPainterTextEffect;
      
      protected var HintDecB:TBounds;
      
      public function TReincarnationgHintTip(param1:TUIComponent)
      {
         super(param1);
         this.HintDecP = ConstructPainterTextEffect(COLOR_Context_White);
         this.HintDecB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:THint = null;
         _loc1_ = FContext as THint;
         BoundsAlignDown(this.HintDecB);
         this.HintDecP.Text = _loc1_.Caption;
         this.HintDecP.Evaluate(this.HintDecB);
         BoundsContextUnion(this.HintDecB);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.HintDecP.X = FBoundsRendering.X + this.HintDecB.X;
         this.HintDecP.Y = FBoundsRendering.Y + this.HintDecB.Y;
      }
   }
}

