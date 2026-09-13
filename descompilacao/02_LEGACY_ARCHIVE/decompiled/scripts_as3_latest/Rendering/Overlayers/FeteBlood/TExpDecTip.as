package Rendering.Overlayers.FeteBlood
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   
   public class TExpDecTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var TPName:TPainterTextEffect;
      
      protected var FBName:TBounds;
      
      protected var FCur:String = "";
      
      public function TExpDecTip(param1:TUIComponent)
      {
         super(param1);
         this.TPName = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBName = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.FCur = FContext as String;
         this.FCur = this.FCur.split("%n").join("\n");
         BoundsAlignDown(this.FBName);
         this.TPName.Text = this.FCur;
         this.TPName.Evaluate(this.FBName);
         BoundsContextUnion(this.FBName);
      }
      
      override public function Show() : void
      {
         if(!this.visible)
         {
            this.visible = true;
         }
      }
      
      override public function Hide() : void
      {
         if(this.visible)
         {
            this.visible = false;
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.TPName.X = FBoundsRendering.X + this.FBName.X;
         this.TPName.Y = FBoundsRendering.Y + this.FBName.Y;
      }
   }
}

