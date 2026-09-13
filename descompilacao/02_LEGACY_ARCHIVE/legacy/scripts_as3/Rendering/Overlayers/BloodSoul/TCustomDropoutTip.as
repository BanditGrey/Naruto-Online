package Rendering.Overlayers.BloodSoul
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Strings.STRING_TONGLING;
   
   public class TCustomDropoutTip extends TOverlayer
   {
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected var BigNameP:TPainterTextEffect;
      
      protected var BigNameB:TBounds;
      
      protected var NameP:TPainterTextEffect;
      
      protected var NameB:TBounds;
      
      protected var StrP:TPainterTextEffect;
      
      protected var StrB:TBounds;
      
      public function TCustomDropoutTip(param1:TUIComponent)
      {
         super(param1);
         this.BigNameP = ConstructPainterTextEffect(COLOR_Context_White);
         this.BigNameB = new TBounds();
         this.BigNameP.Font.Bold = true;
         this.BigNameP.Font.Color = 13421568;
         this.NameP = ConstructPainterTextEffect(COLOR_Context_White);
         this.NameP.Font.Color = 6710784;
         this.NameB = new TBounds();
         this.StrP = ConstructPainterTextEffect(COLOR_Context_White);
         this.StrB = new TBounds();
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 15;
         FMarginBottom = 15;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         _loc1_ = FContext as String;
         _loc2_ = _loc1_.split("&");
         BoundsAlignDown(this.BigNameB);
         this.BigNameP.Text = _loc2_[0];
         this.BigNameP.Evaluate(this.BigNameB);
         BoundsContextUnion(this.BigNameB);
         BoundsAlignDown(this.NameB);
         this.NameP.Text = STRING_TONGLING.TONGLING_43;
         this.NameP.Evaluate(this.NameB);
         BoundsContextUnion(this.NameB);
         BoundsAlignDown(this.StrB);
         this.StrP.Text = _loc2_[1];
         this.StrP.Evaluate(this.StrB);
         BoundsContextUnion(this.StrB);
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.BigNameP.X = FBoundsRendering.X + this.BigNameB.X;
         this.BigNameP.Y = FBoundsRendering.Y + this.BigNameB.Y;
         this.NameP.X = FBoundsRendering.X + this.NameB.X;
         this.NameP.Y = FBoundsRendering.Y + this.NameB.Y;
         this.StrP.X = FBoundsRendering.X + this.StrB.X;
         this.StrP.Y = FBoundsRendering.Y + this.StrB.Y;
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

