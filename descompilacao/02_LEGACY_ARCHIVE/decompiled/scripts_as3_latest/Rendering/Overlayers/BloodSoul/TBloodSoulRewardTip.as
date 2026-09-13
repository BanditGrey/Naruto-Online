package Rendering.Overlayers.BloodSoul
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   
   public class TBloodSoulRewardTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var scrP:TPainterTextEffect;
      
      protected var scrB:TBounds;
      
      public function TBloodSoulRewardTip(param1:TUIComponent)
      {
         super(param1);
         this.scrP = ConstructPainterTextEffect(COLOR_Context_White);
         this.scrB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:String = null;
         _loc1_ = FContext as String;
         BoundsAlignDown(this.scrB);
         this.scrP.Text = _loc1_;
         this.scrP.Evaluate(this.scrB);
         BoundsContextUnion(this.scrB);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.scrP.X = FBoundsRendering.X + this.scrB.X;
         this.scrP.Y = FBoundsRendering.Y + this.scrB.Y;
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
   }
}

