package Rendering.Overlayers.OhtsutsukiKaguya
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   
   public class TOverOhtsutsukiKaguya extends TOverlayer
   {
      
      protected static const COLOR_Context_YELLOW:uint = 4294967040;
      
      protected var FPainterName:TPainterTextEffect;
      
      protected var FPainterDec:TPainterTextEffect;
      
      protected var FBoundsName:TBounds;
      
      protected var FBoundsDec:TBounds;
      
      protected var Cur_Data:TNightPowerPrivilege;
      
      public function TOverOhtsutsukiKaguya(param1:TUIComponent)
      {
         super(param1);
         this.FPainterName = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBoundsName = new TBounds();
         this.FPainterDec = ConstructPainterTextEffect(COLOR_Context_YELLOW);
         this.FBoundsDec = new TBounds();
         FMarginLeft = 10;
         FMarginTop = 10;
         FMarginRight = 10;
         FMarginBottom = 10;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         this.Cur_Data = FContext as TNightPowerPrivilege;
         this.EvaluationPerform_Name();
         this.EvaluationPerform_Dec();
      }
      
      protected function EvaluationPerform_Dec() : void
      {
         BoundsAlignDown(this.FBoundsDec);
         var _loc1_:RegExp = /%%/g;
         var _loc2_:String = "";
         _loc2_ = this.Cur_Data.DescPrivilege;
         _loc2_ = _loc2_.replace(_loc1_,"\n");
         this.FPainterDec.Text = _loc2_;
         this.FPainterDec.Evaluate(this.FBoundsDec);
         BoundsContextUnion(this.FBoundsDec);
      }
      
      protected function EvaluationPerform_Name() : void
      {
         BoundsAlignDown(this.FBoundsName);
         this.FPainterName.Text = this.Cur_Data.Name;
         this.FPainterName.Evaluate(this.FBoundsName);
         BoundsContextUnion(this.FBoundsName);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterName.X = FBoundsRendering.X + this.FBoundsName.X;
         this.FPainterName.Y = FBoundsRendering.Y + this.FBoundsName.Y;
         this.FPainterDec.X = FBoundsRendering.X + this.FBoundsDec.X;
         this.FPainterDec.Y = FBoundsRendering.Y + this.FBoundsDec.Y;
      }
   }
}

