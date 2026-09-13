package Rendering.Overlayers.RebirthRealm
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_TONGLING;
   
   public class TurntableTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_Green:uint = 4288282368;
      
      protected var scrNameP:TPainterTextEffect;
      
      protected var scrNameB:TBounds;
      
      protected var scrAttrP:TPainterTextEffect;
      
      protected var scrAttrB:TBounds;
      
      public function TurntableTip(param1:TUIComponent)
      {
         super(param1);
         this.scrNameP = ConstructPainterTextEffect(COLOR_Context_White);
         this.scrNameB = new TBounds();
         this.scrAttrP = ConstructPainterTextEffect(COLOR_Context_Green);
         this.scrAttrB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:String = null;
         _loc1_ = FContext as String;
         BoundsAlignDown(this.scrNameB);
         this.scrNameP.Text = STRING_TONGLING.TONGLING_56;
         this.scrNameP.Evaluate(this.scrNameB);
         BoundsContextUnion(this.scrNameB);
         BoundsAlignDown(this.scrAttrB);
         this.scrAttrP.Text = _loc1_;
         this.scrAttrP.Evaluate(this.scrAttrB);
         BoundsContextUnion(this.scrAttrB);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.scrNameP.X = FBoundsRendering.X + this.scrNameB.X;
         this.scrNameP.Y = FBoundsRendering.Y + this.scrNameB.Y;
         this.scrAttrP.X = FBoundsRendering.X + this.scrAttrB.X;
         this.scrAttrP.Y = FBoundsRendering.Y + this.scrAttrB.Y;
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

