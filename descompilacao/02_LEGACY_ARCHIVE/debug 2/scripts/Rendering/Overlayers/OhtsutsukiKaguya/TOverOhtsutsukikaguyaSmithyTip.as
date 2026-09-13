package Rendering.Overlayers.OhtsutsukiKaguya
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   
   public class TOverOhtsutsukikaguyaSmithyTip extends TOverlayer
   {
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected var FPainterName:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FCurStr:String;
      
      public function TOverOhtsutsukikaguyaSmithyTip(param1:TUIComponent)
      {
         super(param1);
         this.FPainterName = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBoundsName = new TBounds();
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         _loc1_ = FContext as int;
         this.EvaluationPerform_Caption();
      }
      
      public function set CurStr(param1:String) : void
      {
         this.FCurStr = param1;
      }
      
      protected function EvaluationPerform_Caption() : void
      {
         BoundsAlignDown(this.FBoundsName);
         if(FContext == 7)
         {
            this.FCurStr = STRING_OhtsutsukiKaguya.Icon_SmithyTip;
         }
         else
         {
            this.FCurStr = STRING_OhtsutsukiKaguya.Icon_SmithyTip1;
         }
         this.FPainterName.Text = this.FCurStr;
         this.FPainterName.Evaluate(this.FBoundsName);
         BoundsContextUnion(this.FBoundsName);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterName.X = FBoundsRendering.X + this.FBoundsName.X;
         this.FPainterName.Y = FBoundsRendering.Y + this.FBoundsName.Y;
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
   }
}

